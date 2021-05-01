#lang sicp

(define (accumulate op acc seq)
  (if (null? seq) acc
      (op (car seq) (accumulate op acc (cdr seq)))))

(define (count-leaves t)
  (accumulate + 0 (map (lambda (x) (if (not (pair? x)) 1 (count-leaves x))) t)))

(define x (cons (list 1 2) (list 3 4)))
(define xx (cons x x))
(count-leaves xx)


; Output:
; $ sicp ex2-35.rkt
; 8

