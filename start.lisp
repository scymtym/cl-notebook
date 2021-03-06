(in-package :cl-notebook)
; System initialization and related functions

(defun read-statics ()
  "Used to read the cl-notebook static files into memory.
Only useful during the build process, where its called with an --eval flag."
  (setf *static-files* (make-hash-table :test #'equal))
  (let ((root (asdf:system-source-directory :cl-notebook)))
    (cl-fad:walk-directory 
     (sys-dir (merge-pathnames "static" root))
     (lambda (filename)
       (unless (eql #\~ (last-char filename))
	 (setf (gethash filename *static-files*) 
	       (with-open-file (stream filename :element-type '(unsigned-byte 8))
		 (let ((data (make-array (list (file-length stream)))))
		   (read-sequence data stream)
		   data))))))))

(defun write-statics (&key force?)
  (when *static-files*
    (loop for k being the hash-keys of *static-files*
       for v being the hash-values of *static-files*
       for file = (merge-pathnames (stem-path k "static") *storage*)
       unless (and (cl-fad:file-exists-p file) (not force?))
       do (progn 
	    (format t "   Writing ~a ...~%" file)
	    (ensure-directories-exist file)
	    (with-open-file (stream file :direction :output :element-type '(unsigned-byte 8) :if-exists :supersede :if-does-not-exist :create)
	      (write-sequence v stream))))
    (setf *static-files* nil)))

(defun main (&optional argv)
  (multiple-value-bind (params) (parse-args! argv)
    (let ((port (or (get-param '(:p :port) params) 4242)))
      (format t "Initializing storage directories...~%")
      (setf *storage* (sys-dir (merge-pathnames ".cl-notebook" (user-homedir-pathname)))
	    *books* (sys-dir (merge-pathnames "books" *storage*))
	    *trash* (sys-dir (merge-pathnames "trash" *storage*)))
      (unless *static*
	(format t "Initializing static files...~%")
	(setf *static* (sys-dir (merge-pathnames "static" *storage*)))
	(write-statics :force? (get-param '(:f :force) params)))

      (in-package :cl-notebook)
      (format t "Loading books...~%")
      (dolist (book (cl-fad:list-directory *books*))
	(format t "   Loading ~a...~%" book)
	(load-notebook! book))
      (define-file-handler *static* :stem-from "static")

      (when (get-param '(:d :debug) params)
	(format t "Starting in debug mode...~%")
	(house::debug!))
      
      (format t "Listening on '~s'...~%" port)
      #+ccl (setf ccl:*break-hook*
		  (lambda (cond hook)
		    (declare (ignore cond hook))
		    (ccl:quit)))
      #-sbcl(start port)
      #+sbcl(handler-case
		(start port)
	      (sb-sys:interactive-interrupt (e)
		(cl-user::exit))))))

(defun main-dev ()
  (house::debug!)
  (setf *static* (sys-dir (merge-pathnames "static" (asdf:system-source-directory :cl-notebook))))
  (bt:make-thread 
   (lambda () (main))))
