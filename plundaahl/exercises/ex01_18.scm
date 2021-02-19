;;     *Exercise 1.18:* Using the results of *Note Exercise 1-16:: and
;;     *Note Exercise 1-17::, devise a procedure that generates an
;;     iterative process for multiplying two integers in terms of adding,
;;     doubling, and halving and uses a logarithmic number of steps.(4)

(define (double a) (* a 2))
(define (halve a) (/ a 2))

(define (mult a b)
  (define (even? a)
    (= (remainder a 2) 0))
  (define (iter a b sum)
    (cond ((= b 0) (+ sum))
	  ((even? b) (iter (double a) (halve b) sum))
	  (else (iter a (- b 1) (+ a sum)))))
  (iter a b 0))

(mult 5 10)
