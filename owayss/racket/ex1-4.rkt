#lang sicp

(define (a-plus-abs-b a b) ((if (> b 0) + -) a b))

;; our evaluation model allows for combinations whose operators are compound expressions. In this
;; case, the expression (if (> b 0) + -) is a compound expression that will evaluate to either + or
;; - depending on the sign of the argument b.