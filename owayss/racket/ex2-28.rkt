#lang sicp


(define (fringe l)
  (cond ((null? l) l)
        ((not (pair? (car l))) (cons (car l) (fringe (cdr l))))
        (else (append (fringe (car l)) (fringe (cdr l))))))


(define x
  (list (list 1 2) (list 3 4)))

(fringe x)
(fringe (list x x))

; Output:
; $ sicp ex2-28.rkt
; (1 2 3 4)
; (1 2 3 4)
; (1 2 3 4 1 2 3 4)
