#lang sicp

(define (mag1 x)
  (if (< x 0)
      "negative"
      (if (= x 0)
          "zero"
          "positive")))

(define (mag1-cond x)
  (cond ((< x 0) "negative")
        ((= x 0) "zero")
        (else "positive")))

(mag1-cond -1)
(mag1-cond 0)
(mag1-cond 1)
