#lang sicp

(define (double n) (* 2 n))
(define (halve n) (/ n 2))

(define (fast-mul-iter a b acc)
  (cond ((= b 0) acc)
        ((even? b) (fast-mul-iter (double a) (halve b) acc))
        (else (fast-mul-iter a (- b 1) (+ acc a)))))

(define (fast-mul a b) (fast-mul-iter a b 0))