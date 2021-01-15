;; Rewrite this with cond
(define (mag1-orig x)
  (if (< x 0)
      "negative"
      (if (= x 0)
          "zero"
          "positive")))

(define (mag1 x)
  (cond [(= x 0) "zero"]
        [(< x 0) "negative"]
        [else "positive"]))

(eq? (mag1 2) (mag1-orig 2))
(eq? (mag1 0) (mag1-orig 0))
(eq? (mag1 -3) (mag1-orig -3))
