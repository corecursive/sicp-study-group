#lang sicp

(define (p) (p))

(define (test x y)
  (if (= x 0)
    0
    y))


; (test 0 (p))
;; applicative-order: the interpreter will try to evaluate the operator and the operands first. The
;; procedure evaluates to itself, which would lead to the intepreter getting stuck in recursively
;; trying to evaluate `(p)` which is passed as the formal parameter `y` in the procedure `test`.

;; In contrast, an interpreter using normal order evaluation would delay the evaluation of (p) until 
;; it is needed. It would first reduce the expression until all it has got are primitive operations:

; (test 0 (p))
; (if (= x 0)
;    0
;    y)
; (if (= 0 0)
;    0
;    (p))

; 0