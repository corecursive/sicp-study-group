;; Exercise 3.1.
;;
;; An accumulator is a procedure that is called repeatedly with a
;; single numeric argument and accumulates its arguments into a
;; sum. Each time it is called, it returns the currently accumulated
;; sum. Write a procedure make-accumulator that generates
;; accumulators, each maintaining an independent sum. The input to
;; make-accumulator should specify the initial value of the sum; for
;; example
;;
;;   (define A (make-accumulator 5))
;;   (A 10)
;;   15
;;   (A 10)
;;   25
;;

(define (make-accumulator init)
  (let ((memo init))
    (lambda (value)
      (set! memo (+ memo value))
      memo)))


(define A (make-accumulator 5))
(define B (make-accumulator 5))

(assert (= 15 (A 10)))
(assert (= 25 (A 10)))
(assert (= 15 (B 10)))
