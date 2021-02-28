#lang sicp

(define (accumulate combiner null-value term a next b)
  (if (> a b)
    null-value
    (combiner (term a) (accumulate combiner null-value term (next a) next b))))

(define (even? x) (= 0 (remainder x 2)))

(define (inc x) (+ x 1))

(define (sum term a next b) (accumulate + 0 term a next b))

(define (product term a next b) (accumulate * 1 term a next b))

(define (pi n)
  (define (term it)
    (cond ((even? it) (/ it (+ 1 it)))
          (else (/ (+ 1 it) it))))
  (define (next it) (inc it))

  (* 4.0 (product term 2 next (+ n 2))))


(pi 100)
(pi 1000)
(pi 10000)
; Output:

; $ racket ex1-32.rkt
; 3.1263793980429817
; 3.140026946105016
; 3.1414356249917024

; Exercise 1.32 b

(define (accumulate-iter combiner null-value term a next b)
  (define (iter it result)
    (if (> it b)
      result
      (iter (next it) (combiner result (term it)))))
  (iter a null-value))

