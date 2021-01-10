#lang sicp

(define (sum-squares-largest-two a b c) 
    (cond ((and (<= a b) (<= a c)) (+ (square b) (square c)))
          ((and (<= b a) (<= b c)) (+ (square a) (square c)))
          (#t (+ (square a) (square b)))
    )
)

(define (square x) (* x x))