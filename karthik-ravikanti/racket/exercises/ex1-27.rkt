#lang sicp

;; *Exercise 1.27:* Demonstrate that the Carmichael numbers listed in
;; *Note Footnote 1-47:: really do fool the Fermat test.  That is,
;; write a procedure that takes an integer n and tests whether a^n is
;; congruent to a modulo n for every a<n, and try your procedure on
;; the given Carmichael numbers.

(define (square x)
  (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (if (= a n)
        true
        (if (= (expmod a n n) a)
            (try-it (+ a 1))
            false)))
  (try-it 1))

(define (even? n)
  (= (remainder n 2) 0))

;; All these numbers pass Fermat's test, but aren't prime
(fermat-test 561)                       ; #t
(fermat-test 1105)                      ; #t
(fermat-test 1729)                      ; #t
(fermat-test 2465)                      ; #t
(fermat-test 2821)                      ; #t
(fermat-test 6601)                      ; #t
