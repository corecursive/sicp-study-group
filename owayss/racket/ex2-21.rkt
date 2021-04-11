#lang sicp


;(define (square-list items)
;  (if (null? items) items (cons (* (car items) (car items)) (square-list (cdr items)))))


(define (square-list items)
  (map (lambda (x) (* x x)) items))

(square-list (list 1 2 3))

; Output:
;
; $ racket -I sicp ex2-21.rkt
; (1 4 9)

