#lang sicp

(define (root-iter improve guess prev x)
  (if (good-enough? guess prev)
          guess
          (root-iter improve (improve guess x)
                     guess
                     x)))

(define (improve-sqrt guess x)
  (average guess (/ x guess)))

(define (improve-cbrt guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess prev)
  (< (/ (abs (- prev guess)) prev) 0.00000001))

(define (sqrt x)
  (root-iter improve-sqrt 1.0 x x))

(define (cbrt x)
  (root-iter improve-cbrt 1.0 x x))

(cbrt 27)
