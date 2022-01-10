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


(define (union-set s1 s2)
  (cond ((null? s1) s2)
        ((null? s2) s1)
        (else (let ((x1 (car s1)) (x2 (car s2)))
                   (cond ((= x1 x2) (cons x1 (union-set (cdr s1) (cdr s2))))
                         ((< x1 x2) (cons x1 (union-set (cdr s1) s2)))
                         ((> x1 x2) (cons x2 (union-set s1 (cdr s2)))))))))



(union-set nil (list 1 2 3))
(union-set (list 1 2 3) nil)
(union-set (list 1) (list 1 2 3))
(union-set (list 1 2 5) (list 1 2 3))


; okabtoul at LUSC02DV5KQMD6R in ~/github/owayss/sicp-study-group/owayss/racket on master [?] using minikube:traffic-test
; $ sicp ex2-62.rkt
; (1 2 3)
; (1 2 3)
; (1 2 3)
; (1 2 3 5)



