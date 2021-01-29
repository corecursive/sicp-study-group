#lang sicp

(define x 1)

(define (square x) (* x x))

(define (sum-of-squares x y) (+ (square x) (square y)))
(sum-of-squares 5 5)

(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))
(f 5)

(define (myabs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
        ((< x 0) (- x))))

(myabs 0)

(+ (* 2 4) (- 4 6))

(define a 3)

;; Tree recursive
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

;; Iterative
(define (fib1 n)
  (fib-iter 1 0 n))

(define (fib-iter a b count)
  (if (= count 0)
      b
      (fib-iter (+ a b) a (- count 1))))

;; Recursive
(define (count-change amount)
  (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination kinds-of-coins))
                     kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

(count-change 100)                  ; 292

(cc 10 5)
(+ (cc 10 4) (cc -40 5))
(+ (+ (cc 10 3) (cc -15 4))) 0)
(+ (+ (+ (cc 10 2) (cc 0 3)) 0) 0)
((+ (+ (+ (+ (cc 10 1) (cc 5 2)) 1) 0)) 0)
((+ (+ (+ (+ (+ (cc 10 0) (cc 9 1)) (+ (cc 5 1) (cc 4 2))) 1) 0)) 0)
((+ (+ (+ (+ (+ (cc 10 0) (cc 9 1)) (+ (cc 5 1) (cc 4 2))) 1) 0)) 0)

(cc 3 5)
(+ (cc 3 4) (cc -47 4))
(+ (+ (cc 3 3) (cc -22 3)) 0)
