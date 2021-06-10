;; *Exercise 2.57:* Extend the differentiation program to handle sums
;; and products of arbitrary numbers of (two or more) terms.  Then
;; the last example above could be expressed as

;;      (deriv '(* x y (+ x 3)) 'x)

;; Try to do this by changing only the representation for sums and
;; products, without changing the `deriv' procedure at all.  For
;; example, the `addend' of a sum would be the first term, and the
;; `augend' would be the sum of the rest of the terms.


(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        (else
         (error "unknown expression type -- DERIV" exp))))

;; Deriv tests
;; regression
(deriv '(+ x 3) 'x)
(deriv '(* x y) 'x)
(deriv '(* (* x y) (+ x 3)) 'x)
 
;; new
(deriv '(+ x 3) 'x)
(deriv '(* x y) 'x)
(deriv '(* (* x y) (+ x 3)) 'x)

;; NEW DEFINITIONS
(define (make-sum . rest)
    (let ((number-sum (reduce + 0 (filter number? rest)))
	(symbols (filter (lambda (e) (not (number? e))) rest)))
  (cond ((null? symbols) number-sum)
	((=number? number-sum 0)
	 (if (eq? (length symbols) 1)
	     (car symbols)
	     (cons '+ symbols)))
	(else (append (list '+ number-sum) symbols)))))

(define (addend s) (cadr s))
(define (augend s)
  (if (eq? (length s) 3)
      (caddr s)
      (apply make-sum (cddr s))))

(define (make-product . rest)
  (let ((number-sum (reduce * 1 (filter number? rest)))
	(symbols (filter (lambda (e) (not (number? e))) rest)))
    (cond ((null? symbols) number-sum)
	  ((=number? number-sum 0) 0)
	  ((=number? number-sum 1)
	   (if (eq? (length symbols) 1)
	       (car symbols)
	       (cons '* symbols)))
	  (else (append (list '* number-sum) symbols)))))

(define (multiplier p) (cadr p))
(define (multiplicand p)
  (if (eq? (length p) 3)
      (caddr p)
      (apply make-product (cddr p))))

;; unit tests
(make-sum 1 2)
(make-sum 'x 'y 'z)
(make-sum 'x 1 -1 'z)
(make-sum 1 2 3 '(* x 5) 'y 7)

(make-product 5)
(make-product 3 1)
(make-product 3 0)
(multiplicand (make-product 1 3 'x 'y 5 'z))

;; EXISTING DEFINITIONS
(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

