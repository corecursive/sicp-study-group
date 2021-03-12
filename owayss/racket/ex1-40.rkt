#lang sicp

(define (cubic a b c)
  (lambda (x) (+
              (* x x x)
              (* a x x)
              (* b x)
              c)))


(define (newtons-method f guess) (fixed-point-of-transform f newton-transofrm guess))
(define (fixed-point-of-transform f transofrm guess) (fixed-point (transofrm f) guess))
(define (newton-transofrm g)
  (lambda (x)
  (-
   x
   (/
    (g x)
    ((deriv g) x)))))

(define (deriv g)
  (lambda (x)
    (/
     (- (g (+ x dx)) (g x))
     dx)))

(define (fixed-point f guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) epsilon))
  (define (next guess)
    (if (close-enough? guess (f guess)) guess (next (f guess))))
  (next guess))

(define epsilon 0.00001)
(define dx 0.00001)

(newtons-method (cubic -5 3 -8) 1)

; $ racket '/Users/owayss.kabtoul/github/owayss/sicp-study-group/owayss/racket/ex1-40.rkt'
; 4.723440629802491