#lang sicp

(define (make-interval a b) (cons a b))

(define (lower-bound i) (car i))

(define (upper-bound i) (cdr i))

(define (make-center-percent c p)
  (let ((w (* c p)))
    (make-interval
      (- c w)
      (+ c w))))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (percent i)
  (let ((w (/ (- (upper-bound i) (lower-bound i)) 2)))
    (/ w (center i))))

(make-interval 6.12 7.48)
(make-center-percent 6.8 0.10)
(center (make-center-percent 6.8 0.1))
(percent (make-center-percent 6.8 0.1))
