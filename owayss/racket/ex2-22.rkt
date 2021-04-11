#lang sicp

;(define (square-list items)
;  (define (square x) (* x x))
;  (define (iter things answer)
;    (if (null? things) answer
;      (iter (cdr things) (cons (square (car things)) answer))))
;  (iter items nil))
;
;
;(square-list (list 1 2 3))

; Output:
; $ racket -I sicp ex2-22.rkt
; (9 4 1)

; The above iterative procedure procudes the anwer in reverse because each time
; an element is considered, it is _car_ed to the answer list (inserted at the beginning of the list).
;
;

;(define (square-list items)
;  (define (square x) (* x x))
;  (define (iter things answer)
;    (if (null? things) answer
;      (iter (cdr things) (cons answer (square (car things))))))
;  (iter items nil))
;
;
;(square-list (list 1 2 3))
; Output:
; $ racket -I sicp ex2-22.rkt
; (((() . 1) . 4) . 9)


; Now this produces a structure where the elements are nested to the left, which
; is opposite to what Lisp's representation of a list is.
;
; In order to produce an ordinary list with an iterative procedure, we would need
; to apply a procedure that each time an element is evaluated, it will turn it into
; a pair, e.g. it would transform each:
; ((x) . y)
; into (x . list(y))

; This can be achieved using the `append` procedure that would take two lists and
; combine them into one:
;

(define (square-list items)
  (define (square x) (* x x))
  (define (append l1 l2)
    (if (null? l1) l2
      (cons (car l1) (append (cdr l1) l2))))
  (define (iter things answer)
    (if (null? things) answer
      (iter (cdr things) (append answer (list (square (car things)))))))
  (iter items nil))


(square-list (list 1 2 3))

; Output:
; $ racket -I sicp ex2-22.rkt
; (1 4 9)
