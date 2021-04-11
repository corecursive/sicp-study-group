#lang sicp


(define (for-each proc items)
  (cond ((not (null? items)) (proc (car items)) (for-each proc (cdr items)))))


(for-each (lambda (x) (newline) (display x)) (list 57 321 88))


; Output:
; $ racket -I sicp ex2-23.rkt
;
; 57
; 321
; 88§
