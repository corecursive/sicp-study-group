(load "operation.scm")
(load "polynomial-package/representation.scm")

(define (+poly p1 p2)
  (if (same-var? p1 p2)
      (make-poly
        (var p1)
        (+terms (term-list p1)
                (term-list p2)))
      (error "Polys not in same var")))

(define (*poly p1 p2)
  (if (same-var? p1 p2)
      (make-poly
        (var p1)
        (*terms (term-list p1)
                (term-list p2)))
      (error "Polys not in same var")))

(define (+terms L1 L2)
  (cond ((empty-term-list? L1) L2)
        ((empty-term-list? L2) L1)
        (else
          (let ((t1 (first-term L1))
                (t2 (first-term L2)))
            (cond ((> (order t1) (order t2))
                   (adjoin-term
                    t1
                    (+terms (rest-terms L1) L2)))
                  ((< (order t1) (order t2))
                   (adjoin-term
                    t2
                    (+terms L1 (rest-terms L2))))
                  (else
                   (adjoin-term
                    (make-term (order t1)
                               (add (coeff t1) ; note the use of the generic add here
                                    (coeff t2)))
                    (+terms (rest-terms L1)
                            (rest-terms L2)))))))))

(define (*terms L1 L2)
  (if (empty-term-list? L1)
      (empty-term-list)
      (+terms (*term-by-terms (first-term L1)
                              L2)
              (*terms (rest-terms L1)
                      L2))))

(define (*term-by-terms t1 L)
  (if (empty-term-list? L)
      (empty-term-list)
      (let ((t2 (first-term L)))
        (adjoin-term
         (make-term (+ (order t1)
                       (order t2))
                    (mul (coeff t1) ; note the use of the generic mul here
                         (coeff t2)))
         (*term-by-terms t1
                         (rest-terms L))))))

(define (adjoin-term term term-list)
  (cons term term-list))

(define (first-term term-list)
  (car term-list))

(define (rest-terms term-list)
  (cdr term-list))

(define (empty-term-list? term-list)
  (null? term-list))

(define (empty-term-list)
  '())