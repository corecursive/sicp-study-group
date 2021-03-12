#lang sicp

;; *Exercise 1.39:* A continued fraction representation of the
;; tangent function was published in 1770 by the German mathematician
;; J.H. Lambert:

;;                    x
;;      tan x = ---------------
;;                      x^2
;;              1 - -----------
;;                        x^2
;;                  3 - -------
;;                      5 - ...

;; where x is in radians.  Define a procedure `(tan-cf x k)' that
;; computes an approximation to the tangent function based on
;; Lambert's formula.  `K' specifies the number of terms to compute,
;; as in *Note Exercise 1-37::.

(define (cont-frac-rec n d k)
  (define (helper k-rec)
    (if (<= k k-rec)
        (/ (n k-rec) (d k-rec))
        (/ (n k-rec) (+ (d k-rec) (helper (+ k-rec 1))))))
  (helper 1))

(define (tan-cf-rec x k)
  (cont-frac-rec (lambda (i) (if (<= i 1) x (- (* x x))))
                 (lambda (i) (- (* 2 i) 1))
                 k))

(define (cont-frac-iter n d k)
  (define (helper count k-iter result)
    (if (> count k)
        result
        (helper (+ count 1) (- k-iter 1) (/ (n k-iter) (+ (d k-iter) result)))))
  (helper 1 k 0.0))

(define (tan-cf-iter x k)
  (cont-frac-iter (lambda (i) (if (<= i 1) x (- (* x x))))
                  (lambda (i) (- (* 2 i) 1))
                  k))

(tan-cf-rec (/ 3.1416 4) 4)
(tan-cf-iter (/ 3.1416 4) 4)
