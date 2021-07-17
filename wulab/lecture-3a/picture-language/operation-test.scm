(load "vector.scm")
(load "rectangle.scm")
(load "graphics.scm")
(load "picture.scm")
(load "operation.scm")
(load "escher.scm")

;; Based on Functional Geometry by Peter Henderson
;; http://pmh-systems.co.uk/phAcademic/papers/funcgeo.pdf

(define (draw pict name)
  (define rectangle
    (make-rect
     (make-vect 0 0)
     (make-vect 1000 0)
     (make-vect 0 1000)))
  (make-viewport name 1000 1000)
  (pict rectangle))

(define E (make-picture '()))
(define P (make-picture p))
(define Q (make-picture q))
(define R (make-picture r))
(define S (make-picture s))

(define T  (quartet P Q R S))
(define U  (cycle (rotate Q)))
(define S1 (quartet E E (rotate T) T))
(define S2 (quartet S1 S1 (rotate T) T))
(define C1 (quartet E E E U))
(define C2 (quartet C1 S1 (rotate S1) U))
(define C3 (quartet C2 S2 (rotate S2) U))
(define PC (quartet C2 S2 (rotate S2) (rotate T)))
(define PL (cycle PC))
(define C  (nonet
            C2 S2 S2
            (rotate S2) U (rotate T)
            (rotate S2) (rotate T) (rotate Q)))
(define SL (cycle C))

(draw PL "pseudo limit")
(draw SL "square limit")
