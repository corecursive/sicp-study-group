#lang sicp

;; *Exercise 1.38:* In 1737, the Swiss mathematician Leonhard Euler
;; published a memoir `De Fractionibus Continuis', which included a
;; continued fraction expansion for e - 2, where e is the base of the
;; natural logarithms.  In this fraction, the n_i are all 1, and the
;; D_i are successively 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, ....  Write
;; a program that uses your `cont-frac' procedure from *Note Exercise
;; 1-37:: to approximate e, based on Euler's expansion.


(define (cont-frac-rec n d k)
  (define (helper k-rec)
    (if (<= k k-rec)
        (/ (n k-rec) (d k-rec))
        (/ (n k-rec) (+ (d k-rec) (helper (+ k-rec 1))))))
  (helper 1))

(define e-const 2.7182)

(+ 2
   (cont-frac-rec (lambda (i) 1.0)
                  (lambda (i)
                    (if (= (remainder i 3) 2)
                        (/ (+ i 1) (/ 3 2))
                        1))
                  8))


(define (cont-frac-iter n d k)
  (define (helper count k-iter result)
    (if (> count k)
        result
        (helper (+ count 1) (- k-iter 1) (/ (n k-iter) (+ (d k-iter) result)))))
  (helper 1 k 0.0))

(+ 2
   (cont-frac-iter (lambda (i) 1.0)
                   (lambda (i)
                     (if (= (remainder i 3) 2)
                         (/ (+ i 1) (/ 3 2))
                         1))
                   8))
