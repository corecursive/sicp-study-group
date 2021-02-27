#lang sicp
; the original `random` procedure from Scheme is limited to:
; random: contract violation
;   expected: (or/c (integer-in 1 4294967087) pseudo-random-generator?)
;   given: 999999999999

; lib27.ss from Dr.Racket includes a random-integer procedure that work with arbitrarily large
; numbers.
(#%require (lib "27.ss" "srfi"))
(define (random n) (random-integer n))

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

(define (prime? n) (fast-prime? n 100))

(define (fast-prime? n times)
  (cond ((= 0 times) #t)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else #f)))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (expmod base exp mod)
  (cond ((= exp 0) 1)
        ((even? exp)
          (remainder (square (expmod base (/ exp 2) mod)) 
                     mod))
        (else
          (remainder (* base (expmod base (- exp 1) mod)) 
                     mod))))

(define (even? n) (= 0 (remainder n 2)))

(define (square n) (* n n))

(search-for-primes 100000000000000000000)
(search-for-primes 1000000000000000000000)

; Output:
; $ racket ex1-24.rkt
; searching for three smallest primes larger than 100000000000000000000
; 100000000000000000039 *** 9264
; 100000000000000000129 *** 24517
; 100000000000000000151 *** 4320

; searching for three smallest primes larger than 1000000000000000000000
; 1000000000000000000117 *** 4819
; 1000000000000000000193 *** 5114
; 1000000000000000000213 *** 5445

; Our algorithm now, fermat-test, is logarithmic in the size of _the random number a choosen at each
; test_. The reason the benchmarks we get when running this are not consistent because it depends on
; the random numbers chosen: (random n) will pick a random number in the range [0, n-1], and the random
; numbers we get in the second run (10x lower bound) will not necessairly be 10x larger than the ones
; picked randomly in the first test.