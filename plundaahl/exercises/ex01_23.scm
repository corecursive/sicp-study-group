;;     *Exercise 1.23:* The `smallest-divisor' procedure shown at the
;;     start of this section does lots of needless testing: After it
;;     checks to see if the number is divisible by 2 there is no point in
;;     checking to see if it is divisible by any larger even numbers.
;;     This suggests that the values used for `test-divisor' should not
;;     be 2, 3, 4, 5, 6, ..., but rather 2, 3, 5, 7, 9, ....  To
;;     implement this change, define a procedure `next' that returns 3 if
;;     its input is equal to 2 and otherwise returns its input plus 2.
;;     Modify the `smallest-divisor' procedure to use `(next
;;     test-divisor)' instead of `(+ test-divisor 1)'.


;; Copied from first part of section 1.2.6
(define (prime? n)
  (define (smallest-divisor n)
    (find-divisor n 2))

  (define (next n)
    (if (= n 2)
	3
	(+ n 2)))
  
  (define (find-divisor n test-divisor)
    ;; Artificially sleep for 1 microsecond, so that we actually get useful
    ;; timing comparisons
    (sleep 1)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (next test-divisor)))))
  
  (define (divides? a b)
    (= (remainder b a) 0))
  
  (= n (smallest-divisor n)))


;;     With `timed-prime-test' incorporating this modified version of
;;     `smallest-divisor', run the test for each of the 12 primes found in
;;     *Note Exercise 1-22::.


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
    (if (prime? n)
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


;;     Since this modification halves the number
;;     of test steps, you should expect it to run about twice as fast.
;;     Is this expectation confirmed?  If not, what is the observed ratio
;;     of the speeds of the two algorithms, and how do you explain the
;;     fact that it is different from 2?


;; Previous values
;; (search-for-primes 1000 3)            ;; 0.31, 0.31, 0.31
;; (search-for-primes 10000 3)           ;; 1.00, 1.00, 1.00
;; (search-for-primes 100000 3)          ;; 3.16, 3.16, 3.16
;; (search-for-primes 1000000 3)         ;; 10.0, 10.0, 10.0

;; New Values
(search-for-primes 1000 3)            ;; 0.17, 0.17, 0.17
(search-for-primes 10000 3)           ;; 0.51, 0.51, 0.51
(search-for-primes 100000 3)          ;; 1.59, 1.59, 1.59
(search-for-primes 1000000 3)         ;; 5.01, 5.01, 5.01

;; ANSWER
;; The change is almost exactly 2. The fact that it is slightly over is probably
;; due to the additional check to see if the next value is 2, which  occurs at
;; the start of each test.
