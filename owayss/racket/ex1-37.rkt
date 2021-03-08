#lang sicp


(define (cont-frac n d k)
  (define (rec i)
    (if (= i k) (/ (n i) (d i))
                (/ (n i) (+ (d i) (rec (+ 1 i))))))
  (rec 1))


(define (one-over-golden-ratio k) (cont-frac-iter (lambda (y) 1.0) (lambda (y) 1.0) k))

(define answer (/ 1 1.6180))
(define tolerance 0.00001)

(define (find-k)
  (define (iter k)
    (if (< (abs (- (one-over-golden-ratio k) answer)) tolerance) k
                                                                (iter (+ 1 k))))
  (iter 1))


(cont-frac-iter (lambda (y) 1.0) (lambda (y) 1.0) 11)

(find-k)


;;; $ racket '/Users/owayss.kabtoul/github/owayss/sicp-study-group/owayss/racket/ex1-37.rkt'
;;; 11


;;; Exercise 1.37 b

(define (cont-frac-iter n d k)
  (define (iter i acc)
    (if (= i 0) acc
                (iter (- i 1) (+
                               (/
                                (n i) 
                                (+ 
                                  (d i) 
                                  acc))))))
  (iter k 0))