#lang sicp

(define (same-parity par . l)
  (let ((parity (remainder par 2)))
    (define (cons-up l)
      (if (null? l) nil
        (if (= parity (remainder (car l) 2))
          (cons (car l) (cons-up (cdr l)))
          (cons-up (cdr l)))))
    (cons par (cons-up l))))


(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)

; Output:
; $ racket -I sicp ex2-20.rkt
; (1 3 5 7)
; (2 4 6)
