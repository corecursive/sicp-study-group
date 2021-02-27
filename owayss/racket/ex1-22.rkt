#lang sicp

(define (search-for-primes interval-start)
(define (search-for-primes-iter n count-found primes)
  (if (< count-found primes)
      (cond ((timed-prime-test n) (search-for-primes-iter (+ 1 n) (+ 1 count-found) primes))
            (else (search-for-primes-iter (+ 1 n) count-found primes)))))
  (display "searching for three smallest primes larger than ")
  (display interval-start)
  (newline)
  (search-for-primes-iter interval-start 0 3)
  (newline))

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
    (if (prime? n) 
          (report-prime n (- (runtime) start-time))
        #f))

(define (report-prime n elapsed-time)
  (display n)
  (display " *** ")
  (display elapsed-time)
  (newline))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
  (define (smallest-divisor-iter n a)
    (cond ((> (square a) n) n)
          ((= 0 (remainder n a)) a)
          (else (smallest-divisor-iter n (+ 1 a)))))
  (smallest-divisor-iter n 2))

(define (square n) (* n n))


; (search-for-primes 1000)
; (search-for-primes 10000)
; (search-for-primes 100000)
; (search-for-primes 1000000)

; The numbers in the exercise are too small for the speed today's CPUs are clocked at to appreciate
; the difference in running time.

(search-for-primes 1000000000000)
(search-for-primes 10000000000000)
; Output:
; searching for three smallest primes larger than 1000000000000
; 1000000000039 *** 4029
; 1000000000061 *** 4080
; 1000000000063 *** 4329

; searching for three smallest primes larger than 10000000000000
; 10000000000037 *** 14253
; 10000000000051 *** 13379
; 10000000000099 *** 19380

;;
; from 10^12, to 10^13, we do see a differnce of roughly 3. The primality test algorithm is of order
; O(sqrt(n)). Our results of a perceived sqrt(10) ~ 3 confirm this.
