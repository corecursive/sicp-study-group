;; *Exercise 2.89:* Define procedures that implement the term-list
;; representation described above as appropriate for dense
;; polynomials.

;; NOTE: My implementation here is wrong. I should be storing the
;; termlist as simply a list of coefficients, and deriving order based
;; on position. This means we need to adjust adjoin-term to store just
;; the coefficients and derive the order (or store it in the
;; term-list; perhaps in a wrapper structure or something).

(define (adjoin-term term term-list)
  (if (=zero? (coeff term))
      term-list
      (let ((next-order (if (empty-termlist? term-list)
			    0
			    (order (car term-list)))))
	(cond ((eq 1 (- (order term) next-order))
	       (cons term term-list))
	      ((> 1 (- (order term) next-order))
	       (adjoin-term term
			    (cons (make-term (+ 1 next-order) 0)
				  term-list)))
	      (else (error "order already exists in term list" order))))))

(define (first-term term-list)
  (let ((next-term (car termlist)))
    (cond ((null? next-term) next-term)
	  ((=zero? (coeff next-term))
	   (first-term (cdr term-list)))
	  (else next-term))))

(define (rest-terms term-list)
  (strip-zero-coeffs
   (cdr (strip-zero-coeffs term-list))))

(define (strip-zero-coeffs term-list)
  (let ((next-term (car term-list)))
    (cond ((null? next-term) term-list)
	  ((=zero? (coeff next-term))
	   (strip-zero-coeffs (cdr term-list)))
	  (else term-list))))
