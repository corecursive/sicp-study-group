#lang sicp

(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (expt x n)
  (cond ((= 0 n) 1)
        (else (* x (expt x (- n 1))))))

(define (factor x n)
  (cond ((= 0 n) 0)
        ((not (= 0 (remainder n x))) 0)
        (else (+ 1 (factor x (/ n x))))))

(define (car z)
  (factor 2 z))

(define (cdr z)
  (let ((a (car z)))
       (cond ((= 0 a) (factor 3 z))
             (else (factor 3 (/ z a))))))


(car (cons 2 3))
(cdr (cons 2 3))

(car (cons 0 3))
(cdr (cons 0 3))

(car (cons 4 3))
(cdr (cons 4 3))

(car (cons 4 0))
(cdr (cons 4 0))

;$ racket ex2-5.rkt
; 2
; 3
; 0
; 3
; 4
; 3
; 4
; 0
