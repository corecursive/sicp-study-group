;;     *Exercise 1.22:* Most Lisp implementations include a primitive
;;     called `runtime' that returns an integer that specifies the amount
;;     of time the system has been running (measured, for example, in
;;     microseconds).  The following `timed-prime-test' procedure, when
;;     called with an integer n, prints n and checks to see if n is
;;     prime.  If n is prime, the procedure prints three asterisks
;;     followed by the amount of time used in performing the test.
;;
;;          (define (timed-prime-test n)
;;            (newline)
;;            (display n)
;;            (start-prime-test n (runtime)))
;;
;;          (define (start-prime-test n start-time)
;;            (if (prime? n)
;;                (report-prime (- (runtime) start-time))))
;;
;;          (define (report-prime elapsed-time)
;;            (display " *** ")
;;            (display elapsed-time))
;;
;;     Using this procedure, write a procedure `search-for-primes' that
;;     checks the primality of consecutive odd integers in a specified
;;     range.


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


;; Copied from first part of section 1.2.6
(define (prime? n)
  (define (smallest-divisor n)
    (find-divisor n 2))
  
  (define (find-divisor n test-divisor)
    ;; Artificially sleep for 1 microsecond, so that we actually get useful
    ;; timing comparisons
    (sleep 1)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (+ test-divisor 1)))))
  
  (define (divides? a b)
    (= (remainder b a) 0))
  
  (= n (smallest-divisor n)))


;; Utility sleep function, because even my potato computer is too fast!
(define (sleep mu-s)
  (define (wait start)
    (if (< (* (- (runtime) start) 1000000) mu-s)
	(wait start)))
  (wait (runtime)))


;;     Use your procedure to find the three smallest primes
;;     larger than 1000; larger than 10,000; larger than 100,000; larger
;;     than 1,000,000.  Note the time needed to test each prime.  Since
;;     the testing algorithm has order of growth of [theta](_[sqrt]_(n)),
;;     you should expect that testing for primes around 10,000 should
;;     take about _[sqrt]_(10) times as long as testing for primes around
;;     1000.  Do your timing data bear this out?  How well do the data
;;     for 100,000 and 1,000,000 support the _[sqrt]_(n) prediction?  Is
;;     your result compatible with the notion that programs on your
;;     machine run in time proportional to the number of steps required
;;     for the computation?


(search-for-primes 1000 3)            ;; 0.31, 0.31, 0.31
(search-for-primes 10000 3)           ;; 1.00, 1.00, 1.00
(search-for-primes 100000 3)          ;; 3.16, 3.16, 3.16
(search-for-primes 1000000 3)         ;; 10.0, 10.0, 10.0


;; Each 10x multipliaction of n increase the time required to find primes
;; by almost exactly (sqrt 10). However, because I am manually sleeping,
;; it's hard to tell whether or not there are additional optimizations
;; being done.
