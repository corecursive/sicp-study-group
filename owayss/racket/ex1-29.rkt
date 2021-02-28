#lang sicp

(define (sigma a b term next)
  (if (> a b)
    0
    (+ (term a) (sigma (next a) b term next))))

(define (cube x) (* x x x))

(define (inc x) (+ 1 x))

(define (simpson f a b n)
  (define (h) (/ (- b a) n))
  (define (y k)
    (f (+ a (* k (h)))))
  (define (term it)
      (cond ((= 0 (remainder it n)) (y it))
            (else (* (+ 2 (* 2 (remainder it 2))) (y it)))))
  (* (/ (h) 3) (sigma 0 n term inc)))

(simpson cube 0 1 100)
(simpson cube 0 1 1000)

; Output:

; $ racket ex1-29.rkt
; 1/4
; 1/4