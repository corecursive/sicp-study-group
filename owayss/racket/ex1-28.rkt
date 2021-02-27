#lang sicp

(define (square n) (* n n))

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

(define (fast-prime? n test times)
  (cond ((= 0 times) #t)
        ((test n) (fast-prime? n test (- times 1)))
        (else #f)))

(define (fermat-test n)
  (define (expmod base exp mod)
    (cond ((= exp 0) 1)
          ((even? exp)
            (remainder (square (expmod base (/ exp 2) mod)) 
                      mod))
          (else
            (remainder (* base (expmod base (- exp 1) mod)) 
                      mod))))
  (define (expmod base exp mod) (remainder (fast-expt base exp) mod))

  (define (try-it a)
    (= (expmod a n n) a))

  (try-it (+ 1 (random (- n 1)))))

(define (miller-rabin-test n)
  (define (expmod base exp mod)
    (define (expmod-with-check x)
      (define (check-nontrivial-sqrt x square)
        (if (and
              (= square 1)
              (not (= x 1))
              (not (= x (- mod 1)))
            )
          0
          square))
      (check-nontrivial-sqrt x (remainder (square x) mod)))

    (cond ((= exp 0) 1)
          ((even? exp)
            (expmod-with-check (expmod base (/ exp 2) mod)))
          (else
            (remainder (* base (expmod base (- exp 1) mod)) 
                      mod))))

  (define (try-it a)
    (define (check-it x)
      (and (not (= 0 x)) (= x 1)))
    (check-it (expmod a (- n 1) n)))

  (try-it (+ 1 (random (- n 1)))))


(define (report-primality n)
  (display "number: ")
  (display n)
  (newline)
  (display "smallest divisor prime? ")
  (display (prime? n))
  (newline)
  (display "Fermat's test prime? ")
  (display (fast-prime? n fermat-test (truncate (/ n 2))))
  (newline)
  (display "Miller-Rabin test prime? ")
  (display (fast-prime? n miller-rabin-test (truncate (/ n 2))))
  (newline)
  (newline))

; Carmichael numbers
(report-primality  561)
(report-primality  1105)
(report-primality  1729)
(report-primality  2465)
(report-primality  2821)
(report-primality  6601)
; known primes
(report-primality 11)
(report-primality 10037)