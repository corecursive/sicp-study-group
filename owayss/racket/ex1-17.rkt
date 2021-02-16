#lang sicp

(define (double n) (* 2 n))
(define (half n) (/ n 2))

(define (fast-mul a b)
  (cond ((= b 0) 0)
        ((even? b) (fast-mul (double a) (half b)))
        (else (+ a (fast-mul a (- b 1))))))