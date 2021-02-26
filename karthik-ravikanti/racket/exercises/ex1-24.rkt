#lang sicp

;; *Exercise 1.24:* Modify the `timed-prime-test' procedure of *Note
;; Exercise 1-22:: to use `fast-prime?' (the Fermat method), and test
;; each of the 12 primes you found in that exercise.  Since the
;; Fermat test has [theta](`log' n) growth, how would you expect the
;; time to test primes near 1,000,000 to compare with the time needed
;; to test primes near 1000?  Do your data bear this out?  Can you
;; explain any discrepancy you find?

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 100)
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
        (else (find-divisor n (+ test-divisor 1)))))

(define (square x)
  (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

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
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

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

;; 1009 *** 59
;; 1013 *** 61
;; 1019 *** 62

;; 10007 *** 76
;; 10009 *** 71
;; 10037 *** 72

;; 100003 *** 83
;; 100019 *** 85
;; 100043 *** 85

;; 1000003 *** 95
;; 1000033 *** 94
;; 1000037 *** 96

;; The growth looks almost linear, which means that it's increasing
;; logarithmically for n
