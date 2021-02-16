#lang sicp

(define (expt b n)
  (cond ((= 0 n) 1)
        ((even? n) (square (expt b (/ n 2))))
        (else (* b (expt b (- n 1))))))

(define (even? x)
  (cond ((= (remainder x 2) 0) #t)
        (else #f)))

(define (square x) (* x x))

(define (fast-expt-iter b n prod)
  (cond ((= n 0) prod)
        ((even? n) (fast-expt-iter (square b) (/ n 2) prod))
        (else (fast-expt-iter b (- n 1) (* prod b)))))

(define (fast-expt b n) (fast-expt-iter b n 1))