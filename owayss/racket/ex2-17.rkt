#lang sicp

(define (last-pair l)
  (if (null? (cdr l)) (car l) (last-pair (cdr l))))


(last-pair (list 1 2 3))
(last-pair (list 1))
(last-pair (list nil))

; Output:
; $ racket -I sicp ex2-17.rkt
; 3
; 1
; ()
