;; using vectors

(define (+vect v1 v2)
  (make-vect
   (+ (xcor v1) (xcor v2))
   (+ (ycor v1) (ycor v2))))

(define (scale s v)
  (make-vect (* (xcor v) s)
               (* (ycor v) s)))

;; representing vectors

(define make-vect cons)
(define xcor car)
(define ycor cdr)
