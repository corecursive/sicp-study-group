#lang sicp

(define (_cube-root x guess previous)
  (if (good-enough? guess previous)
     guess
     (_cube-root x (improve-guess-cube guess x) guess)
))

(define (good-enough? guess previous)
  (< (abs (- guess previous)) epsilon)
)

(define epsilon 0.001)

(define (improve-guess-cube guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess)) 3)
)

(define (cube-root x)
  (_cube-root x 1.0 0)
)