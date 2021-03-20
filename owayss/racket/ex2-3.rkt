#lang sicp

(define (make-segment start-segment end-segment) (cons start-segment end-segment))
(define (midpoint-segment segment)
  (let ((p1 (start-segment segment)) (p2 (end-segment segment)))
    (make-segment (/ (+ (x-point p1) (x-point p2)) 2) 
                  (/ (+ (y-point p1) (y-point p2)) 2))))

(define (start-segment segment) (car segment))
(define (end-segment segment) (cdr segment))
(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))


(define (print-point p)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")")
  (newline))


; (define (make-rectangle segment-1 segment-2) (cons segment-1 segment-2))

(define (area rect) (* (length rect) (width rect)))
(define (perimeter rect) (/ (+ (length rect) (width rect) 2)))

(define (length rect) 
  (let ((p1 (start-segment (car rect))) (p2 (end-segment (car rect))))
     (+ (abs (- (x-point p1) (x-point p2)))
        (abs (- (y-point p1) (y-point p2))))))

(define (width rect) 
  (let ((p1 (start-segment (cdr rect))) (p2 (end-segment (cdr rect))))
     (+ (abs (- (x-point p1) (x-point p2)))
        (abs (- (y-point p1) (y-point p2))))))

; (area (make-rectangle (make-segment (make-point 0 0) (make-point 3 0)) (make-segment (make-point 0 0) (make-point 0 1))))
; Output:
; $ racket '/Users/owayss.kabtoul/github/owayss/sicp-study-group/owayss/racket/ex2-3.rkt'
; 3


;; A different representatio of a rectangle via its four points:

(define (make-rectangle p1 p2 p3 p4) (cons (cons p1 p2) (cons p3 p4)))

(area (make-rectangle (make-point 0 0) (make-point 3 0) (make-point 0 0) (make-point 0 1)))

; Output:
; $ racket '/Users/owayss.kabtoul/github/owayss/sicp-study-group/owayss/racket/ex2-3.rkt'
; 3