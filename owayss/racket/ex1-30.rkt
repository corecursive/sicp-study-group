#lang sicp

(define (sum term a next b)
  (define (iter it result)
    (if (> it b)
      result
      (iter (next it) (+ result (term it)))))
  (iter a 0))