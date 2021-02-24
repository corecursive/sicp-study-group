;;     *Exercise 1.29:* Simpson's Rule is a more accurate method of
;;     numerical integration than the method illustrated above.  Using
;;     Simpson's Rule, the integral of a function f between a and b is
;;     approximated as
;;
;;          h
;;          - (y_0 + 4y_1 + 2y_2 + 4y_3 + 2y_4 + ... + 2y_(n-2) + 4y_(n-1) + y_n)
;;          3
;;
;;     where h = (b - a)/n, for some even integer n, and y_k = f(a + kh).
;;     (Increasing n increases the accuracy of the approximation.)
;;     Define a procedure that takes as arguments f, a, b, and n and
;;     returns the value of the integral, computed using Simpson's Rule.

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (inc n) (+ n 1))

(define (simpsons-integral f a b n)
  (define h (/ (- b a) n))
  
  (define (term k)
    (define y (f (+ a (* k h))))
    (cond ((= k 0) y)
	  ((= k n) y)
	  ((= (remainder k 2) 1) (* 4 y))
	  (else (* 2 y))))
  
  (* (/ h 3.0) (sum term a inc (* b n))))

;;     Use your procedure to integrate `cube' between 0 and 1 (with n =
;;     100 and n = 1000), and compare the results to those of the
;;     `integral' procedure shown above.

;;     (integral cube 0 1 0.01)
;;     .24998750000000042
(simpsons-integral cube 0 1 100)

;;     (integral cube 0 1 0.001)
;;     .249999875000001
(simpsons-integral cube 0 1 1000)
