#lang sicp

(define tolearance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolearance))
  
  (define (next x) (f x))

  (define (try guess)
    (let ((next (f guess)))
           (cond ((close-enough? next guess) guess)
                 (else (try next)))))
  (try first-guess))


(fixed-point (lambda (x) (* x x)) 1)
(fixed-point (lambda (y) (+ (sin y) (cos y))) 1)
(fixed-point cos 1)

;;; (define (sqrt x)
;;;   (fixed-point (lambda (y) (/ x y)) 1))
;;; does not converge, as the subsequent guesses will just oscillate between x and first-guess.

(define (sqrt x)
  (fixed-point (lambda (y) (/ (+ y (/ x y)) 2.0)) 1))

(sqrt 25)

;;; finding the golden-ratio is finding an x such that:
;;; x = x^2 + 1
;;; => finding the fixed-point to either x: x^2 - 1 ir x: x^2 + 1
(define golden-ratio (fixed-point (lambda (y) (- (/ 1 y) 1)) 1.0))
golden-ratio