#lang sicp

(define (f g)
  (g 2))

(f (lambda (x) (* 2 x)))

(define (square x) (* x x))

(f square)

;;; (f 2)

;;; It will result in an evaluation error: the interpreter will complain about
;;; not being apply to evaluate (2 2), as `2` is not a procedure, and the evaluation of `f`
;;; expects a procedure of arity 1.