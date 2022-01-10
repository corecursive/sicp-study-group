#lang sicp

(define (element-of-set? x set)
  (if (null? set) #f (or (eq? x (car set)) (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set) set (cons x set)))


(define (intersection-set s1 s2)
  (if (null? s1) (list)
     (if (element-of-set? (car s1) s2) (cons (car s1) (intersection-set (cdr s1) s2)) (intersection-set (cdr s1) s2))))

(define (union-set s1 s2)
  (if (null? s1) s2 (cons (car s1) (union-set (cdr s1) s2))))



(define s1 (list 1 2 3))
(define s2 (list 4 5 6))

(intersection-set s1 s2)
(union-set s1 s2)
