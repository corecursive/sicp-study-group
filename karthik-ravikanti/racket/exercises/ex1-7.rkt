#lang sicp

(define (sqrt-iter guess prev x)
  (if (good-enough? guess prev)
          guess
          (sqrt-iter (improve guess x)
                     guess
                     x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess prev)
  (< (/ (abs (- prev guess)) prev) 0.001))

(define (sqrt x)
  (sqrt-iter 1.0 x x))

(sqrt 2)
