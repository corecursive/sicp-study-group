;     *Exercise 1.3:* Define a procedure that takes three numbers as
;     arguments and returns the sum of the squares of the two larger
;     numbers.

(define (sum-of-largest-squares a b c)
  (define (square x)
    (* x x))
  (define (sum-of-squares x y)
    (+ (square x) (square y)))
  (cond ((and (<= a b) (<= a c)) (sum-of-squares b c))
	((and (<= b a) (<= b c)) (sum-of-squares a c))
	(else (sum-of-squares a b))))

(sum-of-largest-squares 2 2 2)
