#lang sicp

(define (iter-improve good-enough? improve)
  (define (iter guess)
    (let ((next (improve guess)))
           (if (good-enough? guess) guess (iter next))))
  iter)

;;; (define (sqrt x)
;;;   (define epsilon 0.00001)

;;;   ((iter-improve (lambda (y) (< (abs (- (* y y) x)) epsilon))
;;;                  (lambda (y) (/ (+ y (/ x y)) 2.0)))
;;;    1))

;;; (sqrt 144)

;;; $ racket '/Users/owayss.kabtoul/github/owayss/sicp-study-group/owayss/racket/ex1-46.rkt'
;;; 12.000000012408687

(define (fixed-point f)
  (define epsilon 0.00001)
  ((iter-improve (lambda (y) (< (abs (- y (f y))) epsilon))
                 (lambda (y) (f y)))
   1))

(define (average-damp f) (lambda (x) (/ (+ x (f x)) 2.0)))
(define (sqrt x) (fixed-point (average-damp (lambda (y) (/ x y)))))
(sqrt 144)

;;; $ racket '/Users/owayss.kabtoul/github/owayss/sicp-study-group/owayss/racket/ex1-46.rkt'
;;; 12.000000012408687
