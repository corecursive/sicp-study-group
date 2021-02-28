#lang sicp


(define (product term a next b)
  (if (> a b)
    1
    (* (term a) (product term (next a) next b))))


(define (identity x) x)
(define (inc x) (+ x 1))
(define (factorial n) (product identity 1 n inc))

(define (even? x) (= 0 (remainder x 2)))

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

; $ racket ex1-31.rkt
; 3.1263793980429817
; 3.140026946105016
; 3.1414356249917024

; Exercise 1.31 b
(define (product-iter term a next b)
  (define (iter it result)
    (if (> it b)
      result
      (iter (next it) (* result (term it)))))

  (iter a 1))