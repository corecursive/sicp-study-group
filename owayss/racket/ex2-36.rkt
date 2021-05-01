#lang sicp

(define (accumulate op initial seq)
  (if (null? seq) initial
      (op (car seq) (accumulate op initial (cdr seq)))))


(define (accumulate-n op initial seqs)
  (if (null? (car seqs)) nil
      (cons (accumulate op initial (map (lambda (seq) (car seq)) seqs)) (accumulate-n op initial (map (lambda (seq) (cdr seq)) seqs)))))


(define x (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))
(accumulate-n + 0 x)

; Output:
;
; $ sicp ex2-36.rkt
; (22 26 30)

