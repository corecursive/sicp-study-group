#lang sicp

; (define (expmod base exp mod)
;   (cond ((= exp 0) 1)
;         ((even? exp)
;           (remainder (square (expmod base (/ exp 2) mod)) 
;                      mod))
;         (else
;           (remainder (* base (expmod base (- exp 1) mod)) 
;                      mod))))

; (define (even? n) (= 0 (remainder n 2)))

; (define (square n) (* n n))

; Exercise 1-26 

(define (expmod base exp mod)
  (cond ((= exp 0) 1)
        ((even? exp)
          (remainder (* (expmod base (/ exp 2) mod)
                        (expmod base (/ exp 2) mod)) 
                     mod))
        (else
          (remainder (* base (expmod base (- exp 1) mod)) 
                     mod))))

(define (even? n) (= 0 (remainder n 2)))

(define (square n) (* n n))

; The reason this transford the procedure expmod from O(log(n)) to O(n) is that now the problem
; is no longer being reduced by half in the case of an even exponent: the same procedure (both halves
; of it) will be evalutaed separately. Transforming it back to a linear time running procedure.
; In other words, it will be equivalent in running time to:

; (define (expmod base exp mod)
;   (cond ((= exp 0) 1)
;         ((even? exp)
;         (else
;           (remainder (* base (expmod base (- exp 1) mod)) 
;                      mod)))))