;; *Exercise 2.56:* Show how to extend the basic differentiator to
;; handle more kinds of expressions.  For instance, implement the
;; differentiation rule

;;      n_1   n_2
;;      --- = ---  if and only if n_1 d_2 = n_2 d_1
;;      d_1   d_2

;; by adding a new clause to the `deriv' program and defining
;; appropriate procedures `exponentiation?', `base', `exponent', and
;; `make-exponentiation'.  (You may use the symbol `**' to denote
;; exponentiation.)  Build in the rules that anything raised to the
;; power 0 is 1 and anything raised to the power 1 is the thing
;; itself.


;; REVISED `deriv'
(define (deriv exp var)
  (cond ((number? exp) 0)
	((variable? exp)
	 (if (same-variable? exp var) 1 0))
	((sum? exp)
	 (make-sum (deriv (addend exp) var)
		   (deriv (augend exp) var)))
	((exponentiation? exp)
	 (make-product (make-product (exponent exp)
				     (make-exponentiation (base exp)
							  (make-sum (exponent exp) '-1)))
		       (deriv (base exp) var)))
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
(deriv '(** x 3) 'x)
(deriv '(** x 1) 'x)
(deriv '(** x 0) 'x)
(deriv '(+ x (** x 5)) 'x)

;; NEW DEFINITIONS
(define (exponentiation? x)
  (and (pair? x) (eq? (car x) '**)))

(define (base x) (cadr x))

(define (exponent x) (caddr x))

(define (make-exponentiation base exponent)
  (cond ((=number? exponent 0) 1)
	((=number? exponent 1) base)
        (else (list '** base exponent))))

;; Unit tests
(make-exponentiation 5 3)
(make-exponentiation 5 1)
(make-exponentiation 5 0)

;; EXISTING DEFINITIONS
(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
	((=number? a2 0) a1)
	((and (number? a1) (number? a2)) (+ a1 a2))
	(else (list '+ a1 a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
	((=number? m1 1) m2)
	((=number? m2 1) m1)
	((and (number? m1) (number? m2)) (* m1 m2))
	(else (list '* m1 m2))))

(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

(define (addend s) (cadr s))

(define (augend s) (caddr s))

(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))

(define (multiplicand p) (caddr p))

