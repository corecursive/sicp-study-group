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


(define (par1 r1 r2)
  (div-interval
    (mul-interval r1 r2)
    (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval
      one
      (add-interval
        (div-interval one r1)
        (div-interval one r2)))))

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

(define (div-interval x y)
  (define (spans-zero? i) (and (>= 0 (lower-bound i)) (<= 0 (upper-bound i))))
  (if (spans-zero? y) (error "divisor spans zero")
                       (mul-interval x (make-interval (/ 1 (upper-bound y)) (/ 1 (lower-bound y))))))



(define r1 (make-center-percent 8 0.5))
(define r2 (make-center-percent 12 0.25))
(define (display-interval i)
  (display (center i))
  (display " ± ")
  (display (percent i)))

(display "r1: ")
(display-interval r1)
(newline)
(display "r2: ")
(display-interval r2)
(newline)

(display "par1 (r1 | r1) = ")
(display-interval (par1 r1 r1))
(newline)

(display "par2 (r1 | r1) = ")
(display-interval (par2 r1 r1))
(newline)

(display "par1 (r1 | r2) = ")
(display-interval (par1 r1 r2))
(newline)

(display "par2 (r1 | r2) = ")
(display-interval (par2 r1 r2))
(newline)

; Output:
; $ racket -I sicp ex2-14.rkt
; r1: 8.0 ± 0.5
; r2: 12.0 ± 0.25
; par1 (r1 | r1) = 9.333333333333334 ± 0.9285714285714285
; par2 (r1 | r1) = 4.0 ± 0.5
; par1 (r1 | r2) = 7.58974358974359 ± 0.8243243243243242
; par2 (r1 | r2) = 4.717948717948718 ± 0.41304347826086957

; We observe that the algerbaically-equivalent expressions par1 and par2 compute
; different results for the same quantities r1 and r2.
