;; Exercise 2.34.
;;
;; Evaluating a polynomial in x at a given value of x can be
;; formulated as an accumulation. Fill in the following template to
;; produce a procedure that evaluates a polynomial using Horner's
;; rule. Assume that the coefficients of the polynomial are arranged
;; in a sequence, from a0 through an.
;;
;;   (define (horner-eval x coefficient-sequence)
;;     (accumulate (lambda (this-coeff higher-terms) <??>)
;;                 0
;;                 coefficient-sequence))
;;
;; For example, to compute 1 + 3x + 5x^3 + x^5 at x = 2 you would
;; evaluate
;;
;;   (horner-eval 2 (list 1 3 0 5 0 1))
;;

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
                (+ (* higher-terms x) this-coeff))
              0
              coefficient-sequence))


(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(assert (= 79 (horner-eval 2 '(1 3 0 5 0 1))))
