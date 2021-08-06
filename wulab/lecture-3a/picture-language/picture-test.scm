(load "vector.scm")
(load "rectangle.scm")
(load "graphics.scm")
(load "picture.scm")
(load "george.scm")

(define rectangle
  (make-rect
   (make-vect 50 50)
   (make-vect 400 0)
   (make-vect 0 400)))

(make-viewport "george" 500 500)
((make-picture george) rectangle)
