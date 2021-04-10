#lang sicp

(define (reverse l)
  (if (null? l) l (append (reverse (cdr l)) (list (car l)))))

(define (append l1 l2)
  (if (null? l1) l2 (cons (car l1) (append (cdr l1) l2))))

(reverse nil)
(reverse (list 1))
(reverse (list 1 2))
(reverse (list 1 2 3))

; Output:
; $ racket -I sicp owayss/racket/ex2-18.rkt
; ()
; (1)
; (2 1)
; (3 2 1)
