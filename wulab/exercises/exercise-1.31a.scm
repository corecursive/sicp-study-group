;; Exercise 1.31.
;;
;; a. The sum procedure is only the simplest of a vast number of
;; similar abstractions that can be captured as higher-order
;; procedures. Write an analogous procedure called product that
;; returns the product of the values of a function at points over a
;; given range. Show how to define factorial in terms of product. Also
;; use product to compute approximations to π using the formula
;;
;;   \frac{\pi}{4} = \frac{2 \cdot 4 \cdot 4 \cdot 6 \cdot 6 \cdot 8 \cdot\cdot\cdot}{3 \cdot 3 \cdot 5 \cdot 5 \cdot 7 \cdot 7 \cdot\cdot\cdot}
;;

(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (factorial n)
  (product identity 1 1+ n))

(define (pi-product a b)
  (define (pi-term x) (/ (* (-1+ x) (1+ x)) (* x x)))
  (define (pi-next x) (+ x 2))
  (product pi-term a pi-next b))


(define (identity x) x)

(assert (= 120 (product identity 1 1+ 5)))
(assert (= 120 (factorial 5)))
(display (* 4.0 (pi-product 3 1000)))
