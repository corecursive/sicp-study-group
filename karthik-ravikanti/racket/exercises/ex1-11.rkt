#lang sicp

;; f(n) = n if n<3
;; f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n>= 3

(define (f n)
  (cond ((< n 3) n)
        (else (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3)))))))

(f 34)                                  ; 1950203239787, takes a long time

(define (ff n)
  (ff-iter 2 1 0 n))

;; 0
;; 1
;; 2
;; ff-iter 2 1 0 4
;; ff-iter 4 4 3 3
;; 4
;; a + 2*b + 3*c
;; a + 2*b + 3*c + 2*a + 3*b

(define (ff-iter a b c count)
  (cond ((= count 0) c)
        (else (ff-iter (+ a (* 2 b) (* 3 c)) a b (- count 1)))))

(ff 34)                                  ; 1950203239787, instantaneous
