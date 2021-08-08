;; Exercise 1.32.
;;
;; a. Show that sum and product (exercise 1.31) are both special cases
;; of a still more general notion called accumulate that combines a
;; collection of terms, using some general accumulation function:
;;
;;   (accumulate combiner null-value term a next b)
;;

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))


(define (identity x) x)

(assert (= 15 (sum identity 1 1+ 5)))
(assert (= 120 (product identity 1 1+ 5)))
