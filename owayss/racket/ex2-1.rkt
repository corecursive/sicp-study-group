#lang sicp

(define (add-rat a b)
  (make-rat
    (+ (* (numer a) (denom b)) (* (denom a) (numer b)))
    (* (denom a) (denom b))))

(define (sub-rat a b)
  (make-rat
    (- (* (numer a) (denom b)) (* (denom a) (numer b)))
    (* (denom a) (denom b))))

(define (mul-rat a b) (make-rat (* (numer a) (numer b)) (* (denom a) (denom b))))

(define (div-rat a b) (make-rat (* (numer a) (denom b)) (* (denom a) (numer b))))

; (define (make-rat x y) (cons x y))

(define (numer a) (car a))

(define (denom a) (cdr a))


(define (gcd a b)
  (if (= a 0) b (gcd (remainder b a) a)))

(define (make-rat x y)
  (let ((g (abs (gcd x y))))
    (cond ((or 
             (and (< x 0) 
                  (< y 0))
             (< y 0)) (cons (* -1 (/ x g)) (* -1 (/ y g))))
          (else (cons (/ x g) (/ y g))))))

(define (print-rat a)
  (display (numer a))
  (display "/")
  (display (denom a))
  (newline))

(define one-half (make-rat 3 6))
(define one-quarter (make-rat -1 4))
(print-rat (add-rat one-half one-quarter))


; Output:
; $ racket '/Users/owayss.kabtoul/github/owayss/sicp-study-group/owayss/racket/ex2-1.rkt'
; 3/4