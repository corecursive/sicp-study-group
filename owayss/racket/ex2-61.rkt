#lang sicp

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))



(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
    '()
    (let ((x1 (car set1)) (x2 (car set2)))
      (cond ((= x1 x2)
             (cons x1
                   (intersection-set (cdr set1)
                                     (cdr set2))))
            ((< x1 x2)
             (intersection-set (cdr set1) set2))
            ((< x2 x1)
             (intersection-set set1 (cdr set2)))))))



(define (adjoin-set x set)
  (cond ((or (null? set) (< x (car set))) (cons x set))
        (else (cons (car set) (adjoin-set x (cdr set))))))



(define s (adjoin-set 2 nil))
(define a (adjoin-set 3 s))
(define b (adjoin-set 1 a))
(define c (adjoin-set 0 b))
c

; okabtoul at LUSC02DV5KQMD6R in ~/github/owayss/sicp-study-group/owayss/racket on master [?] using minikube:traffic-test
; $ sicp ex2-61.rkt
; (0 1 2 3)


