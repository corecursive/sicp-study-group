;; *Exercise 1.19:* There is a clever algorithm for computing the
;; Fibonacci numbers in a logarithmic number of steps.  Recall the
;; transformation of the state variables a and b in the `fib-iter'
;; process of section *Note 1-2-2::: a <- a + b and b <- a.  Call this
;; transformation T, and observe that applying T over and over again n
;; times, starting with 1 and 0, produces the pair _Fib_(n + 1) and
;; _Fib_(n).  In other words, the Fibonacci numbers are produced by
;; applying T^n, the nth power of the transformation T, starting with
;; the pair (1,0).  Now consider T to be the special case of p = 0 and
;; q = 1 in a family of transformations T_(pq), where T_(pq)
;; transforms the pair (a,b) according to a <- bq + aq + ap and b <-
;; bp + aq.  Show that if we apply such a transformation T_(pq) twice,
;; the effect is the same as using a single transformation T_(p'q') of
;; the same form, and compute p' and q' in terms of p and q.  This
;; gives us an explicit way to square these transformations, and thus
;; we can compute T^n using successive squaring, as in the `fast-expt'
;; procedure.  Put this all together to complete the following
;; procedure, which runs in a logarithmic number of steps:(5)

;; T_(pq)^0: a, b
;; T_(pq)^1: bq + aq + ap, bp + aq
;; T_(pq)^2: (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p, (bp + aq)p + (bq + aq + ap)q
;;           bpq + aq^2 + bq^2 + aq^2 + apq + bpq + apq + ap^2, bp^2 + apq + bq^2 + aq^2 + apq
;;           2bpq + 2aq^2 + bq^2 + 2apq + ap^2, bp^2 + 2apq + bq^2 + aq^2
;;           b(2pq + q^2) + a(2pq + q^2) + a(p^2 + q^2), b(p^2 + q^2) + a(2pq + q^2)
;; T_(p'q'): bq' + aq' + ap', bp' + aq', where p' = p^2 + q^2, q' = 2pq + q^2


(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* p p) (* q q))      ; compute p'
                   (+ (* 2 p q) (* q q))    ; compute q'
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))
