;; *Exercise 1.18:* Using the results of *Note Exercise 1-16:: and
;; *Note Exercise 1-17::, devise a procedure that generates an
;; iterative process for multiplying two integers in terms of adding,
;; doubling, and halving and uses a logarithmic number of steps.(4)

(define (*-iter x y)
  (*-iter-inner x y 0))

(define (*-iter-inner x y a)
  (cond ((= y 0) a)
        ((even? y) (*-iter-inner (double x) (halve y) a))
        (else (*-iter-inner (double x) (halve (- y 1)) (+ x a)))))

(*-iter 49 49)
