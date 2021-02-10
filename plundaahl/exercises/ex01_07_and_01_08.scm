; Exercise 1.8

(define (root-iter guess prev-guess x improve)
  (define (good-enough? guess prev-guess)
    (< (/ (abs (- guess prev-guess) ) prev-guess) 0.0000001))
  (if (good-enough? guess prev-guess)
      guess
      (root-iter (improve guess x)
		 guess
                 x
		 improve)))

(define (square-root x)
  (define (average x y) (/ (+ x y) 2))
  (define (improve-sqrt guess x) (average guess (/ x guess)))
  (root-iter 1.0 x x improve-sqrt))

(define (cube-root x)
  (define (square x) (* x x))
  (define (improve-cube guess x)
    (/
     (+ (/ x (square guess)) (* guess 2))
     3))
  (root-iter 1.0 x x improve-cube))

(square-root 4)
