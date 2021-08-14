;; Exercise 1.3.
;;
;; Define a procedure that takes three numbers as arguments and
;; returns the sum of the squares of the two larger numbers.

(define (square x) (* x x))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (max x y)
  (if (> x y) x y))

(define (min x y)
  (if (< x y) x y))

(define (ex13 x y z)
  (sum-of-squares (max x y)
                  (max z (min x y))))

(= (ex13 1 2 3) 13)
(= (ex13 1 3 2) 13)
(= (ex13 2 1 3) 13)
(= (ex13 2 3 1) 13)
(= (ex13 3 1 2) 13)
(= (ex13 3 2 1) 13)

(= (ex13 1 1 1) 2)
(= (ex13 1 1 2) 5)
(= (ex13 1 2 2) 8)
