#lang sicp

(define (make-interval a b) (cons a b))

(define (lower-bound i) (car i))

(define (upper-bound i) (cdr i))

(define (sign x) (if (> 0 x) -1 1))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4) (max p1 p2 p3 p4))))

(define (mul-interval-rewrite x y)
  (let ((sx1 (sign (lower-bound x)))
        (sx2 (sign (upper-bound x)))
        (sy1 (sign (lower-bound y)))
        (sy2 (sign (upper-bound y))))
    (cond ((and (= -1 sx1) (= -1 sx2) (= -1 sy1) (= -1 sy2))
           (make-interval (* (upper-bound x) (upper-bound y)) (* (lower-bound x) (lower-bound y))))
          ((and (= -1 sx1) (= -1 sx2) (= -1 sy1) (= 1 sy2))
           (make-interval (* (lower-bound x) (upper-bound y)) (* (lower-bound x) (lower-bound y))))
          ((and (= -1 sx1) (= -1 sx2) (= 1 sy1) (= 1 sy2))
           (make-interval (* (lower-bound x) (upper-bound y)) (* (upper-bound x) (lower-bound y))))
          ((and (= -1 sx1) (= 1 sx2) (= -1 sy1) (= -1 sy2))
           (make-interval (* (upper-bound x) (upper-bound y)) (* (lower-bound x) (upper-bound y))))
          ((and (= -1 sx1) (= 1 sx2) (= -1 sy1) (= 1 sy2))
           (let ((p1 (* (lower-bound x) (lower-bound y)))
                 (p2 (* (lower-bound x) (upper-bound y)))
                 (p3 (* (upper-bound x) (lower-bound y)))
                 (p4 (* (upper-bound x) (upper-bound y))))
             (make-interval (min p3 p4) (max (p1 p2)))))
          ((and (= -1 sx1) (= 1 sx2) (= 1 sy1) (= 1 sy2))
           (make-interval (* (lower-bound x) (upper-bound y)) (* (upper-bound x) (upper-bound y))))
          ((and (= 1 sx1) (= 1 sx2) (= -1 sy1) (= -1 sy2))
           (make-interval (* (lower-bound y) (upper-bound x)) (* (upper-bound y) (lower-bound x))))
          ((and (= 1 sx1) (= 1 sx2) (= -1 sy1) (= 1 sy2))
           (make-interval (* (lower-bound y) (upper-bound x)) (* (upper-bound x) (lower-bound y))))
          ((and (= 1 sx1) (= 1 sx2) (= 1 sy1) (= 1 sy2))
           (make-interval (* (lower-bound x) (lower-bound y)) (* (upper-bound x) (upper-bound y))))
          (else (error "sign should return either -1 or 1")))))



(define (eq x y) (and (= (lower-bound x) (lower-bound y)) (= (upper-bound x) (upper-bound y))))
(eq (mul-interval (make-interval -3 -1) (make-interval -4 -2)) (mul-interval-rewrite (make-interval -3 -1) (make-interval -4 -2)))
(eq (mul-interval (make-interval -3 -1) (make-interval -4 2)) (mul-interval-rewrite (make-interval -3 -1) (make-interval -4 2)))
(eq (mul-interval (make-interval -3 -1) (make-interval 2 4)) (mul-interval-rewrite (make-interval -3 -1) (make-interval 2 4)))
(eq (mul-interval (make-interval -3 1) (make-interval -4 -2)) (mul-interval (make-interval -3 1) (make-interval -4 -2)))
(eq (mul-interval (make-interval -3 1) (make-interval -4 2)) (mul-interval (make-interval -3 1) (make-interval -4 2)))
(eq (mul-interval (make-interval -3 1) (make-interval 2 4)) (mul-interval (make-interval -3 1) (make-interval 2 4)))
(eq (mul-interval (make-interval 1 3) (make-interval -4 -2)) (mul-interval (make-interval 1 3) (make-interval -4 -2)))
(eq (mul-interval (make-interval 1 3) (make-interval -4 2)) (mul-interval (make-interval 1 3) (make-interval -4 2)))
(eq (mul-interval (make-interval 1 3) (make-interval 2 4)) (mul-interval (make-interval 1 3) (make-interval 2 4)))

; Output:
; $ racket -I sicp ex2-11.rkt
; #t
; #t
; #t
; #t
; #t
; #t
; #t
; #t
; #t
