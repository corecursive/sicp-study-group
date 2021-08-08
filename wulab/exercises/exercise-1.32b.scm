;; Exercise 1.32.
;;
;; b. If your accumulate procedure generates a recursive process,
;; write one that generates an iterative process. If it generates an
;; iterative process, write one that generates a recursive process.

(load "exercise-1.32a.scm")

(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a)
              (combiner result (term a)))))
  (iter a null-value))


(assert (= 15 (sum identity 1 1+ 5)))
(assert (= 120 (product identity 1 1+ 5)))
