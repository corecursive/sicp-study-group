#lang sicp

(define (fold-right op initial seq)
  (if (null? seq) initial
      (op (car seq) (fold-right op initial (cdr seq)))))


(define (remove x seq)
  (cond ((null? seq) nil)
        ((= x (car seq)) (cdr seq))
        (else (cons (car seq) (remove x (cdr seq))))))


(define (permutations l)
  (if (null? l) (list nil)
      (fold-right append nil
                  (map (lambda (x)
                         (map (lambda (p) (cons x p)) (permutations (remove x l)))) l))))


(permutations nil)
(permutations (list 1))
(permutations (list 1 2))
(permutations (list 1 2 3))

; Output:
; $ sicp ex2-40.rkt
; (())
; ((1))
; ((1 2) (2 1))
; ((1 2 3) (1 3 2) (2 1 3) (2 3 1) (3 1 2) (3 2 1))

