#lang sicp

(define (cont-frac n d k)
  (define (rec i)
    (if (= i k) (/ (n i) (d i))
                (/ (n i) (+ (d i) (rec (+ 1 i))))))
  (rec 1))

(define k 100)
(define (e-2) (cont-frac (lambda (x) 1) (lambda (x) (if (= 0 (remainder (+ 1 x) 3)) (* 2 (/ (+ 1 x) 3)) 1.0)) k))
(define e (+ 2 (e-2)))
e

;;; $ racket '/Users/owayss.kabtoul/github/owayss/sicp-study-group/owayss/racket/ex1-38.rkt'
;;; 2.7182818284590455