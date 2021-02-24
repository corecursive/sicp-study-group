;;     *Exercise 1.31:*
;;       a. The `sum' procedure is only the simplest of a vast number of
;;          similar abstractions that can be captured as higher-order
;;          procedures.(3)  Write an analogous procedure called `product'
;;          that returns the product of the values of a function at
;;          points over a given range.

(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
	 (product term (next a) next b))))

(define (test a b)
  (define (inc n) (+ n 1))
  (define (identity n) n)
  (product identity a inc b))

(test 1 1)
(test 1 2)
(test 1 3)
(test 1 4)

;;          Show how to define `factorial' in
;;          terms of `product'.

(define (factorial n)
  (define (inc n) (+ n 1))
  (define (identity n) n)
  (product identity 1 inc n))

(factorial 3)
(factorial 4)

;;          Also use `product' to compute
;;          approximations to [pi] using the formula(4)
;;
;;               pi   2 * 4 * 4 * 6 * 6 * 8 ...
;;               -- = -------------------------
;;                4   3 * 3 * 5 * 5 * 7 * 7 ...

(define (top-term k)
  (* (ceiling (/ (+ k 2) 2)) 2))

(top-term 0)
(top-term 1)
(top-term 2)
(top-term 3)
(top-term 4)
(top-term 5)

(define (bottom-term k)
  (+ (* (floor (/ (+ k 2) 2)) 2) 1))

(bottom-term 0)
(bottom-term 1)
(bottom-term 2)
(bottom-term 3)
(bottom-term 4)
(bottom-term 5)

(define (approx-pi n)
  (define (inc n) (+ n 1))
  (define (term k)
    (/ (top-term k) (bottom-term k)))
  (* 4.0 (product term 0 inc n)))

(approx-pi 10)
(approx-pi 100)
(approx-pi 1000)

;;       b. If your `product' procedure generates a recursive process,
;;          write one that generates an iterative process.  If it
;;          generates an iterative process, write one that generates a
;;          recursive process.

(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
	(iter (next a) (* result (term a)))))
  (iter a (term a)))
