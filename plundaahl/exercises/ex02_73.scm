;; *Exercise 2.73:* Section *Note 2-3-2:: described a program that
;; performs symbolic differentiation:

;; (define (deriv exp var)
;;   (cond ((number? exp) 0)
;;         ((variable? exp) (if (same-variable? exp var) 1 0))
;;         ((sum? exp)
;;          (make-sum (deriv (addend exp) var)
;;                    (deriv (augend exp) var)))
;;         ((product? exp)
;;          (make-sum
;;           (make-product (multiplier exp)
;;                         (deriv (multiplicand exp) var))
;;           (make-product (deriv (multiplier exp) var)
;;                         (multiplicand exp))))
;;         ;; <MORE RULES CAN BE ADDED HERE>
;;         (else (error "unknown expression type -- DERIV" exp))))
 
;; We can regard this program as performing a dispatch on the type of
;; the expression to be differentiated.  In this situation the "type
;; tag" of the datum is the algebraic operator symbol (such as `+')
;; and the operation being performed is `deriv'.  We can transform
;; this program into data-directed style by rewriting the basic
;; derivative procedure as

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp)) (operands exp)
               var))))

(define (operator exp) (car exp))

(define (operands exp) (cdr exp))

;; a. Explain what was done above.  Why can't we assimilate the
;;    predicates `number?' and `same-variable?' into the
;;    data-directed dispatch?

;; ANSWER
;; Rather than manually using `cond' to dispatch, we are now using
;; the contents of the operation lookup table.
;;
;; The reason we cannot add operations for `number?' and `same-variable?'
;; into the table is that they do not have an associate symbol. In order
;; for this to work, we would need to add entries for every possible
;; value of `exp' that was a number or a variable.

;; b. Write the procedures for derivatives of sums and products,
;;    and the auxiliary code required to install them in the table
;;    used by the program above.

(define (install-deriv-sum)
  ;; internal procedures
  (define (deriv-sum operands var)
    (make-sum (deriv (addend operands) var)
              (deriv (augend operands) var)))
  (define (addend s) (car s))
  (define (augend s) (cadr s))
  (define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2))))
  ;; interface to the rest of the system
  (put 'deriv '(+) deriv-sum))

(define (install-deriv-product)
  ;; internal procedures
  (define (deriv-prod operands var)
    (make-prod (deriv (addend operands) var)
               (deriv (augend operands) var)))
  (define (multiplier p) (car p))
  (define (multiplicand p) (cadr p))
  (define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list '* m1 m2))))
  ;; interface to the rest of the system
  (put 'deriv '(*) deriv-prod))

;; c. Choose any additional differentiation rule that you like,
;;    such as the one for exponents (*Note Exercise 2-56::), and
;;    install it in this data-directed system.

;; SKIPPED

;; d. In this simple algebraic manipulator the type of an
;;    expression is the algebraic operator that binds it together.
;;    Suppose, however, we indexed the procedures in the opposite
;;    way, so that the dispatch line in `deriv' looked like
;;
;;         ((get (operator exp) 'deriv) (operands exp) var)
;;
;;    What corresponding changes to the derivative system are
;;    required?

;; ANSWER
;; Each of the `put' calls in the package installers would need
;; to be updated to swap the type and operation symbols (e.g,
;; 'deriv and '(+)). Everything else could stay the same.
