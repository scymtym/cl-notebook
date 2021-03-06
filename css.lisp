(in-package #:cl-notebook)

(defparameter +css-input+
  `(:border "2px solid #ccc" :border-right-color "#aaa" :border-bottom-color "#aaa" :border-radius 4px :height 24px :font-weight bold))

(define-closing-handler (css/notebook.css :content-type "text/css") ()
  (cl-css:css
   `((body :font-family sans-serif)
     
     ("button" ,@+css-input+ :min-width 34px :font-size 1em :float left :margin-right 1% :color "#666" :cursor pointer)
     ("button.right" :float right)
     ("button.genericon" :font-size 1.4em)
     ("button .btn-text" :display inline-block)
     ("button:hover" :color "#000")

     (select ,@+css-input+ :color "#666" :margin-right 1%)
     ("select:hover" :color "#000" :background-color "#eee")

     (input.text ,@+css-input+ :padding 3px)

     (.book-title :margin "20px 10px 10px 5px" :padding 0px)
     (".book-title h1" :cursor pointer :margin 0px :padding 0px)

     (.main-controls 
      :background-color "#eee" :border "2px solid #ccc" :border-radius "0px 0px 5px 5px"
      :padding 1%
      :z-index 10 :position fixed :top -10% :height 8%
      :width 80% :left 10%)
     (".main-controls:hover" :top -2px)
     (".main-controls button" :visibility hidden :width 16% :min-height 32px)
     (".main-controls select" :visibility hidden :font-size 1em :width 28% :padding-top 4px :min-height 32px)
     (".main-controls:hover button, .main-controls:hover select" :visibility visible :height auto)

     (.footer :position fixed :bottom 1% :z-index 10 :padding 2px :border-radius "5px"
	      :font-weight bold :color "rgba(255, 255, 255, .6)" 
	      :width 80% :margin-left 10%
	      :background-color "rgba(50, 50, 200, .4)" :border "2px solid rgba(50, 50, 200, .6)")
     (".footer .notice" :padding-left 5px :display inline-block)
     (".footer img" :height 1.6em :opacity .6 :margin-bottom -.3em :margin-left -5px)
     (".footer button" :background-color "rgba(50, 50, 200, .4)" :font-size 1em
		       :color "rgba(255, 255, 255, .6)" :border-color "rgba(255, 255, 255, .6)")
     (".footer button:hover" :border-color white :color white :background-color "rgba(75, 75, 200, .4)")
     
     (.cells :list-style-type none :padding 0px :margin 0px)
     (".cells .cell" :padding 5px :margin-bottom 10px :border-top "3px solid transparent" :background-color "#fff")
     (".cells .cell.stale" :border "2px solid orange")
     (".cells .cell.code" :background-color "#eee")

     (".cell .controls"
      :display none :position absolute :margin-top -41px :padding 5px :padding-right 10px
      :background-color "#eee" :border "2px solid #ccc" :border-bottom none :border-radius "5px 5px 0px 0px" :z-index 8 :white-space nowrap)
     (".cell .controls button" :width 32px)
     (".cell .controls span"
      :height 19px :width 31px :font-size 1.4em :float left :margin-right 1% :color "#666"
      :padding-top 5px :padding-left 3px :cursor move)
     (".cell .controls span:hover" :color "#000")

     (".cell blockquote" :font-style oblique :border-left "2px solid #eee" :padding 10px)

     (".cell:hover" :border-top "3px solid #ccc" :z-index 15)
     (".cell:hover .controls" :display block)

     (.result :border "1px solid #ccc" :background-color "#fff" :list-style-type none :margin 0px :margin-top 5px :padding 0px)
     (.stdout :margin 0px :padding 5px :color "#8b2252" :background-color "#efefef")
     (".result li" :padding 5px)
     (".result .type" :color "#228b22")

     (".warnings .condition-contents" 
      :background-color "#fc6" :color "#c60" :border "1px solid #c60"
      :padding 5px :margin "5px 0px")

     (".result .error" :background-color "#fdd" :color "#933")
     (.condition-contents :list-style-type none :margin 0px :padding 0px)
     (".condition-contents .condition-type" :font-weight bolder)
     (".condition-contents .condition-property" :font-style oblique)
     (".condition-contents .condition-property .label" :display inline-block :margin-right 5px :font-size .4em))))
