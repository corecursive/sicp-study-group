#lang sicp

(define (_sqrt x guess previous)
  (if (good-enough? guess previous)
     guess
     (_sqrt x (improve-guess guess x) guess)
))

(define (good-enough? guess x)
  (< (abs (- x (* guess guess))) epsilon)
)

;; The previous defintion of `good-enough?` is not adequate for very small numbers: the difference
;; between the square of the guess and x is going to be smaller than our epsilon, and so the iteration
;; will stop prematurely.

;; A better approach is to base our approximation on the delta of change in our subsequent guesses:

(define (good-enough? guess previous)
  (< (abs (- guess previous)) epsilon)
)

(define epsilon 0.001)

(define (improve-guess guess x)
  (/ (+ guess (/ x guess)) 2)
)

(define (sqrt x)
  (_sqrt x 1.0 0)
)