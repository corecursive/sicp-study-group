#lang sicp

(define (_sqrt x guess)
  (if (good-enough? guess x)
     guess
     (_sqrt x (improve-guess guess x))
))

(define (good-enough? guess x)
  (< (abs (- x (* guess guess))) epsilon)
)

(define epsilon 0.001)

(define (improve-guess guess x)
  (/ (+ guess (/ x guess)) 2)
)

(define (sqrt x)
  (_sqrt x 1.0)
)

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause))
)

(define (buggy-sqrt x guess)
  (new-if (good-enough? guess x) 
    guess
    (buggy-sqrt x (improve-guess guess x))
))

; (buggy-sqrt 9 1.0)

;; This is a consequence of `new-if` being a compound procedure and the Scheme interpreter being an
;; applicative order interpreter: the intepreter first tries to evaluate all three operands of the
;; `new-if` procedure, and in each evaluation, the recursive call in the `else-clause` would cause it
;; to again try and evaluate new-if, and so it goes into an infinite loop.