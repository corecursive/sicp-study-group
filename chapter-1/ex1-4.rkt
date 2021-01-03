#lang sicp

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

(a-plus-abs-b 3 -3)                     ; 6

;; The if expression evaluates to either + or - depending on the sign
;; of b, and then the outer expression is evaluated with the resultant
;; operator
