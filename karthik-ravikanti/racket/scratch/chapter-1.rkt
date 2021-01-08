#lang sicp

(define x 1)

(define (square x) (* x x))

(define (sum-of-squares x y) (+ (square x) (square y)))
(sum-of-squares 5 5)

(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))
(f 5)

(define (myabs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
        ((< x 0) (- x))))

(myabs 0)

(+ (* 2 4) (- 4 6))

(define a 3)
