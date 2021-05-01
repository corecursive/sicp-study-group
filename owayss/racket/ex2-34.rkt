#lang sicp

(define (accumulate op acc seq)
  (if (null? seq) acc
      (op (car seq) (accumulate op acc (cdr seq)))))

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coefficient higher-terms)
                (+ this-coefficient (* x higher-terms)))
              0 coefficient-sequence))

(horner-eval 2 (list 1 3 0 5 0 1))
