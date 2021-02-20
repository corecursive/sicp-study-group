;;     *Exercise 1.24:* Modify the `timed-prime-test' procedure of *Note
;;     Exercise 1-22:: to use `fast-prime?' (the Fermat method)


;; `fast-prime?' procedure
(define (fast-prime? n times)
  (define (expmod base exp m)
    (sleep 1) ;; artificial sleep
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder (square (expmod base (/ exp 2) m))
                      m))
          (else
           (remainder (* base (expmod base (- exp 1) m))
                      m))))

  (define (fermat-test n)
    (define (try-it a)
      (= (expmod a n n) a))
    (try-it (+ 1 (random (- n 1)))))
  
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))



;; `search-for-primes' finds the first `count' primes starting at `start'
;; and prints the time taken for each.
(define (search-for-primes start count)
  (define (even? x)
    (= (remainder x 2) 0))
  
  (define (next n count)
    (cond ((= count 0))
	  ((timed-prime-test n) (next (+ n 2) (- count 1)))
	  (else (next (+ n 2) count))))
  
  (newline)
  (newline)
  (display "FINDING FIRST ")
  (display count)
  (display " PRIMES STARTING AT ")
  (display start)
  
  (if (even? start)
      (next (+ start 1) count)
      (next start count)))


;; I have nested the prime test functions, just because
(define (timed-prime-test n)
  ;; Note that this function will return #t/#f depending on the result of
  ;; prime?
  (define (start-prime-test n start-time)
    (if (fast-prime? n 10)
	(report-prime (- (runtime) start-time))
	#f))
  
  (define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time)
    #t)

  (newline)
  (display n)
  (start-prime-test n (runtime)))


;; Utility sleep function, because even my potato computer is too fast!
(define (sleep mu-s)
  (define (wait start)
    (if (< (* (- (runtime) start) 1000000) mu-s)
	(wait start)))
  (wait (runtime)))


;;     Test each of the 12 primes you found in that exercise.  Since the
;;     Fermat test has [theta](`log' n) growth, how would you expect the
;;     time to test primes near 1,000,000 to compare with the time needed
;;     to test primes near 1000?  Do your data bear this out?  Can you
;;     explain any discrepancy you find?

;; Previous results
;; (search-for-primes 1000 3)            ;; 0.31, 0.31, 0.31
;; (search-for-primes 10000 3)           ;; 1.00, 1.00, 1.00
;; (search-for-primes 100000 3)          ;; 3.16, 3.16, 3.16
;; (search-for-primes 1000000 3)         ;; 10.0, 10.0, 10.0

(search-for-primes 1000 3)            ;; 1.70, 1.80, 1.90
(search-for-primes 10000 3)           ;; 2.20, 2.10, 2.20
(search-for-primes 100000 3)          ;; 2.50, 2.60, 2.60
(search-for-primes 1000000 3)         ;; 2.90, 2.90, 3.00

;; ANSWER
;; I'm not sure I have an answer for this.
