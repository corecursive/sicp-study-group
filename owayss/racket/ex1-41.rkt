#lang sicp

(define (double f) (lambda (x) (f (f x))))

(((double (double double)) inc) 5)

; $ racket '/Users/owayss.kabtoul/github/owayss/sicp-study-group/owayss/racket/ex1-41.rkt'
; 21