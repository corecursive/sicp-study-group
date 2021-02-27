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
  (define (next n)
    (cond ((= 2 n) 3)
          (else (+ 2 n))))
  (define (smallest-divisor-iter n a)
    (cond ((> (square a) n) n)
          ((= 0 (remainder n a)) a)
          (else (smallest-divisor-iter n (next a)))))
  (smallest-divisor-iter n 2))

(define (square n) (* n n))



(search-for-primes 1000000000000)
(search-for-primes 10000000000000)

; Output:

; $ racket ex1-23.rkt
; searching for three smallest primes larger than 1000000000000
; 1000000000039 *** 2248
; 1000000000061 *** 2056
; 1000000000063 *** 2071

; searching for three smallest primes larger than 10000000000000
; 10000000000037 *** 6524
; 10000000000051 *** 7242
; 10000000000099 *** 6883

; The results we get are roughly twice as fast now after we have excluded all even numbers from our 
; factoring test.

; The results from the previous approach were:

; $ racket ex1-22.rkt
; searching for three smallest primes larger than 1000000000000
; 1000000000039 *** 4670
; 1000000000061 *** 3938
; 1000000000063 *** 4926

; searching for three smallest primes larger than 10000000000000
; 10000000000037 *** 13873
; 10000000000051 *** 15128
; 10000000000099 *** 21431