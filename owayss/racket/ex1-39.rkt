#lang sicp

(define (cont-frac n d k)
  (define (rec i)
    (if (= i k) (/ (n i) (d i))
                (/ (n i) (+ (d i) (rec (+ 1 i))))))
  (rec 1))


(define (tan-cf x k) (cont-frac (lambda (i) (if (= 1 i) x (- (* x x)))) (lambda (i) (- (* 2 i) 1.0)) k))

(tan-cf 3.14 10)