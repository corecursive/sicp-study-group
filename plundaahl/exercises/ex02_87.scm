;; *Exercise 2.87:* Install `=zero?' for polynomials in the generic
;; arithmetic package.  This will allow `adjoin-term' to work for
;; polynomials with coefficients that are themselves polynomials.

(define (install-polynomial-package)
  ;; internal procedures
  (define (=zero-poly? p)
    (=zero-termlist (term-list p)))
  (define (=zero-termlist l)
    (cond ((empty-termlist? l) 't)
	  ((not (=zero-term (first-term l))) 'f)
	  (else (=zero-termlist? (rest-terms l)))))
  (define (=zero-term term)
    (=zero? (coeff term)))
  ;; install
  (put '=zero? '(polynomial) =zero-poly?)
  'done)
