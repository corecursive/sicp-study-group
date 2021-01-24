#lang sicp


(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))
  )
)

(define (f n) (A 0 n))
; f = 2n

(define (g n) (A 1 n))
; g = A(0, A(1, n-1))
;   = 2^n

(define (h n) (A 2 n))
; h = A(1, A(2, n-1))
; h = g(A(2, n-1))
; h = g(A(1, A(2, n-2)))
; h = g(g(A(2, n-2)))

(define (k n) (* 5 n n))
; k = 5n^2