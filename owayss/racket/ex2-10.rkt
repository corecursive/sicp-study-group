#lang sicp

(define (make-interval a b) (cons a b))

(define (lower-bound i) (car i))

(define (upper-bound i) (cdr i))

(define (add-interval x y)
  (make-interval
    (+ (lower-bound x) (lower-bound y))
    (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval
    (- (lower-bound x) (lower-bound y))
    (- (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4) (max p1 p2 p3 p4))))

(define (spans-zero? i) (and (>= 0 (lower-bound i)) (<= 0 (upper-bound i))))

(define (div-interval x y)
  (if (spans-zero? y) (error "divisor spans zero")
                       (mul-interval x (make-interval (/ 1 (upper-bound y)) (/ 1 (lower-bound y))))))



(div-interval (make-interval 1 3) (make-interval 2 5))
(div-interval (make-interval 1 3) (make-interval -2 5))


; Output:
; $ racket -I sicp ex2-10.rkt
; (1/5 . 3/2)
; divisor spans zero
;   context...:
;    "/Users/owayss.kabtoul/github/owayss/sicp-study-group/owayss/racket/ex2-10.rkt": [running body]
