#lang sicp

;; *Exercise 1.23:* The `smallest-divisor' procedure shown at the
;; start of this section does lots of needless testing: After it
;; checks to see if the number is divisible by 2 there is no point in
;; checking to see if it is divisible by any larger even numbers.
;; This suggests that the values used for `test-divisor' should not be
;; 2, 3, 4, 5, 6, ..., but rather 2, 3, 5, 7, 9, ....  To implement
;; this change, define a procedure `next' that returns 3 if its input
;; is equal to 2 and otherwise returns its input plus 2.  Modify the
;; `smallest-divisor' procedure to use `(next test-divisor)' instead
;; of `(+ test-divisor 1)'.  With `timed-prime-test' incorporating
;; this modified version of `smallest-divisor', run the test for each
;; of the 12 primes found in *Note Exercise 1-22::.  Since this
;; modification halves the number of test steps, you should expect it
;; to run about twice as fast.  Is this expectation confirmed?  If
;; not, what is the observed ratio of the speeds of the two
;; algorithms, and how do you explain the fact that it is different
;; from 2?

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime n (- (runtime) start-time))
      nil))

(define (report-prime n elapsed-time)
  (display n)
  (display " *** ")
  (display elapsed-time)
  (newline))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (square x)
  (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

(define (next n)
  (if (= n 2)
      3
      (+ n 2)))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (even? n)
  (= (remainder n 2) 0))

(define (search-for-primes min max)
  (define (search-for-primes-helper o)
    (timed-prime-test o)
    (if (< o max)
        (search-for-primes-helper (+ o 2))
        nil))
  (if (even? min)
      (search-for-primes-helper (+ min 1))
      (search-for-primes-helper min)))

(search-for-primes 1000 1019)
(newline)
(search-for-primes 10000 10037)
(newline)
(search-for-primes 100000 100043)
(newline)
(search-for-primes 1000000 1000037)
(newline)
(search-for-primes 1000000000 1000000021)
(newline)
(search-for-primes 10000000000 10000000061)
(newline)
(search-for-primes 100000000000 100000000057)
(newline)
(search-for-primes 1000000000000 1000000000063)

;; 1009 *** 1
;; 1013 *** 1
;; 1019 *** 1

;; 10007 *** 3
;; 10009 *** 3
;; 10037 *** 2

;; 100003 *** 8
;; 100019 *** 7
;; 100043 *** 8

;; 1000003 *** 23
;; 1000033 *** 24
;; 1000037 *** 23

;; there's a drop, but not as large as 50%

;; 1000000007 *** 787
;; 1000000009 *** 988
;; 1000000021 *** 727

;; 10000000019 *** 1995
;; 10000000033 *** 2387
;; 10000000061 *** 2230

;; 100000000003 *** 6147
;; 100000000019 *** 5580
;; 100000000057 *** 6322

;; 1000000000039 *** 18623
;; 1000000000061 *** 18702
;; 1000000000063 *** 18773

;; here, the drop starts to approach 50%, but still not quite

;; The drop is less than 50%, probably because skipping the even
;; divisors comes at the cost of checking if each of them are 2
