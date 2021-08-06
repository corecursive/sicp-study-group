(load "vector.scm")
(load "segment.scm")

;; representing rectangles

;; A rectangle can be described by 3 vectors - an origin vector and 2 edge vectors.
;; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-15.html#%_fig_2.15
(define (make-rect origin horiz vert)
  (list origin horiz vert))

(define (origin rect)
  (car rect))

(define (horiz rect)
  (car (cdr rect)))

(define (vert rect)
  (car (cdr (cdr rect))))

;; transforming a point in a unit square to a point in the rectangle

(define (coord-map rect)
  (lambda (point)
    (+vect
     (+vect (scale (xcor point)
                   (horiz rect))
            (scale (ycor point)
                   (vert rect)))
     (origin rect))))
