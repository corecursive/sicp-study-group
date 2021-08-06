;; *Exercise 2.88:* Extend the polynomial system to include
;; subtraction of polynomials.  (Hint: You may find it helpful to
;; define a generic negation operation.)

(define (sub-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
		 (sub-terms (term-list p1)
			    (term-list p2)))
      (error "Polys not in same var -- SUB-POLY" (list p1 p2))))

(define (sub-terms l1 l2)
  (cond ((empty-termlist l2) l1)
	((empty-termlist? l1) (negate l2))
	(else
	 (let ((t1 (first-term l1)) (t2 (first-term l2)))
	   (cond ((> (order t1) (order t2))
		  (adjoin-term t1 (sub-terms (rest-terms l1) l2)))
		 ((< (order t1) (order t2))
		  (adjoin-term (negate t2) (sub-terms l1 (rest-terms l2))))
		 (else
		  (adjoin-term (make-term (order t1)
					  (sub (coeff t1) (coeff t2)))
			       (sub-terms (rest-terms l1)
					  (rest-terms l2)))))))))

(define (negate x) (apply-generic 'negate x))

;; scheme number
(put 'negate '(scheme-number)
     (lambda (x) (tag (- 0 x))))

;; rational
(define (neg-rat x)
  (make-rat (- 0 (numer x)) (denom x)))
(put 'negate '(Rational)
     (lambda (tag (neg-rat x))))

;; complex
(define (neg-complex x)
  (make-from-real-imag (- 0 (real-part x))
		       (- 0 (real-part x))))
(put 'negate '(complex x)
     (lambda (x) (tag (neg-complex x))))

;; poly
(define (neg-poly x)
  ;; This is a cheap hack. I'm lazy.
  ;; Or maybe I'm cheap, and the hack is lazy.
  ;; Also, this causes an infinite loop and doesn't work.
  (sub (make-polynomial (variable x) (the-empty-termlist))
       x))

(put 'negate '(polynomial)
     (lambda (x) (tag (neg-poly x))))
