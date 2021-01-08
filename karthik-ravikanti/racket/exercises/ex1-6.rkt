(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(new-if (= 2 3) 0 5)

(new-if (= 1 1) 0 5)

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))
(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (square x) (* x x))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(sqrt 2)

;; Applicative-order evaluation

;; (sqrt 2)
;; (sqrt-iter 1.0 2)
;; (new-if (good-enough? 1.0 2)
;;         guess
;;         (sqrt-iter (improve 1.0 2)
;;                    x))
;; (new-if #f
;;         guess
;;         (sqrt-iter (improve 1.0 2)
;;                    x))
;; (new-if #f
;;         1.0
;;         (sqrt-iter (improve 1.0 2)
;;                    x))
;; (new-if #f
;;         1.0
;;         (sqrt-iter 1.5
;;                    2))
;; (new-if #f
;;         1.0
;;         (new-if (good-enough? 1.5 2)
;;                 1.5
;;                 (sqrt-iter (improve 1.5 2)
;;                            2)))
;; (new-if #f
;;         1.0
;;         (new-if #f
;;                 1.5
;;                 (sqrt-iter (improve 1.5 2)
;;                            2)))
;; (new-if #f
;;         1.0
;;         (new-if #f
;;                 1.5
;;                 (new-if (good-enough? (improve 1.5 2) 2)
;;                         (improve 1.5 2)
;;                         (sqrt-iter (improve (improve 1.5 2) 2)
;;                                    2))
;; (new-if #f
;;         1.0
;;         (new-if #f
;;                 1.5
;;                 (new-if (good-enough? 1.4167 2)
;;                         1.4167
;;                         (sqrt-iter (improve 1.4167 2)
;;                                    2))
;; (new-if #f
;;         1.0
;;         (new-if #f
;;                 1.5
;;                 (new-if #f
;;                         1.4167
;;                         (sqrt-iter (improve 1.4167 2)
;;                                    2))
;;                 .....
;;                 .....
;;                 .....
                
