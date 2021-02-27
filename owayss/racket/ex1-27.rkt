#lang sicp

(define (is-carmichael-num? n)
  (define (test-iter count)
    (define (try-it a)
      (= (expmod a n n) a))
    (cond ((= 1 count) #t)
          ((try-it count) (test-iter (- count 1)))
          (else #f)))

  (test-iter (- n 1)))

(define (expmod base exp mod)
  (cond ((= exp 0) 1)
        ((even? exp)
          (remainder (square (expmod base (/ exp 2) mod)) 
                     mod))
        (else
          (remainder (* base (expmod base (- exp 1) mod)) 
                     mod))))

(define (square n) (* n n))

(define (report-carmichael n)
  (display "number: ")
  (display n)
  (newline)
  (display "is-carmichael-num? ")
  (display (is-carmichael-num? n))
  (newline)
  (newline))

(report-carmichael 561)
(report-carmichael 1105)
(report-carmichael 1729)
(report-carmichael 2465)
(report-carmichael 2821)
(report-carmichael 6601)