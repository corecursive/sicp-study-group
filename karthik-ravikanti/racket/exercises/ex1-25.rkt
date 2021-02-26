#lang sicp

;; *Exercise 1.25:* Alyssa P. Hacker complains that we went to a lot
;; of extra work in writing `expmod'.  After all, she says, since we
;; already know how to compute exponentials, we could have simply
;; written

(define (expmod base exp m)
  (remainder (fast-expt base exp) m))

;; Is she correct?  Would this procedure serve as well for our fast
;; prime tester?  Explain.

(define (fast-expt b n)
  (fast-expt-iter b n 1))

(define (fast-expt-iter b counter product)
  (cond ((= counter 0) product)
        ((even? counter) (fast-expt-iter (square b)
                                         (/ counter 2)
                                         product))
        (else (fast-expt-iter (square b)
                              (/ (- counter 1) 2)
                              (* b product)))))

(define (square n)
  (* n n))

;; Answer: This isn't faster because the original expmod uses modulo
;; arithmetic to limit the value to base. The version here will have
;; to go all the way to base ^ exp. If there are precision limits,
;; that number won't even fit in a variable.
