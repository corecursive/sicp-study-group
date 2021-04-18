#lang sicp


(define (append l1 l2)
  (if (null? l1) l2 (cons (car l1) (append (cdr l1) l2))))

(define (reverse l)
  (if (null? l) l (append (reverse (cdr l)) (cons (car l) nil))))

(define (deep-reverse l)
  (cond ((null? l) l)
        ((not (pair? (car l))) (append (deep-reverse (cdr l)) (cons (car l) nil)))
        (else (append (deep-reverse (cdr l)) (list (deep-reverse (car l)))))))


(define x
  (list (list 1 2) (list 3 4)))

x
(reverse x)
(deep-reverse x)

; Output:
; $ sicp ex2-27.rkt
; ((1 2) (3 4))
; ((3 4) (1 2))
; ((4 3) (2 1))
