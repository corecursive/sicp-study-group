;; Exercise 1.31.
;;
;; b. If your product procedure generates a recursive process, write
;; one that generates an iterative process. If it generates an
;; iterative process, write one that generates a recursive process.

(load "exercise-1.31a.scm")

(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))


(assert (= 120 (product identity 1 1+ 5)))
(assert (= 120 (factorial 5)))
(display (* 4.0 (pi-product 3 1000)))
