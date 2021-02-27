#lang sicp

(define (search-for-primes interval-start expmod)
(define (search-for-primes-iter n count-found primes)
  (if (< count-found primes)
      (cond ((timed-prime-test n expmod) (search-for-primes-iter (+ 1 n) (+ 1 count-found) primes))
            (else (search-for-primes-iter (+ 1 n) count-found primes)))))
  (display "searching for three smallest primes larger than ")
  (display interval-start)
  (search-for-primes-iter interval-start 0 3)
  (newline))

(define (timed-prime-test n expmod)
  (newline)
  (display n)
  (start-prime-test n (runtime) expmod))

(define (start-prime-test n start-time expmod)
    (if (prime? n expmod) 
          (report-prime n (- (runtime) start-time))
        #f))

(define (report-prime n elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (prime? n expmod) (fast-prime? n 10 expmod))

(define (fast-prime? n times expmod)
  (cond ((= 0 times) #t)
        ((fermat-test n expmod) (fast-prime? n (- times 1) expmod))
        (else #f)))

(define (fermat-test n expmod)
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

; Exercise 1-25: is the following version of expmod correct?
(define (fast-expt base exp)
  (cond ((= exp 0) 1)
        ((even? exp)
          (square (fast-expt base (/ exp 2))))
        (else
          (* base (fast-expt base (- exp 1))))))
(define (expmod-slow base exp mod) (remainder (fast-expt base exp) mod))

(define (even? n) (= 0 (remainder n 2)))

(define (square n) (* n n))


(search-for-primes 1000000 expmod)
(search-for-primes 1000000 expmod-slow)

; The modified version of expmod, expmod-slow is correct. However, it is considerably slower than
; the original version, which would keep the numbers smaller by reducing them modulo n, whereas the 
; modified version only applies modulo n after all the exponentiation is done, causing it to work
; with some very big numbers in the process.
