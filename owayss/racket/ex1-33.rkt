#lang sicp

(define (filtered-accumulate predicate combiner null-value term a next b)
  (define (check-predicate x) (if (predicate x) (term x) null-value))
  (if (> a b)
    null-value
    (combiner (check-predicate a) (filtered-accumulate predicate combiner null-value term (next a) next b))
  ))

(define (even? x) (= 0 (remainder x 2)))
(define (identity x) x)
(define (inc x) (+ 1 x))
(define (t x) #t)
(define (sum a b) (filtered-accumulate t + 0 identity a inc b))
(define (square x) (* x x))

; Exercise 1.33 a

; From Exercise 1.28
(define (prime? n) (fast-prime? n miller-rabin-test (truncate (/ n 2))))

(define (fast-prime? n test times)
  (cond ((= 0 times) #t)
        ((test n) (fast-prime? n test (- times 1)))
        (else #f)))

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

(define (sum-squares-primes a b) (filtered-accumulate prime? + 0 square a inc b))


(sum-squares-primes 1 10)
; Output:

; $ racket ex1-33.rkt
; 88


; Exercise 1.33 b

; the product of all positive integers less than n that are relatively prime to n
; (i.e., all positive integers i < n such that GCD(i, n) = 1)

(define (gcd a b)
  (if (= 0 b) a (gcd b (remainder a b))))
(define (f n)
  (define (p x)
    (= 1 (gcd n x)))
  (filtered-accumulate p * 1 identity 2 inc (- n 1)))

(f 10)
; Output:

; $ racket ex1-33.rkt
; 189