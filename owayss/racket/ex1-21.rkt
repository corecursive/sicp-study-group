#lang sicp

(define (smallest-divisor n) (smallest-divisor-iter n 2))
(define (smallest-divisor-iter n a)
  (cond ((> (square a) n) n)
        ((divides? a n) a)
        (else (smallest-divisor-iter n (+ 1 a)))))

(define (divides? a n) (= 0 (remainder n a)))
(define (square n) (* n n))

(smallest-divisor 199)
(smallest-divisor 1999)
(smallest-divisor 19999)
