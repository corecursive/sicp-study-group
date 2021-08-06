(load "table.scm")
(load "type.scm")

;; installing polynomials

(define (install-polynomial-package)
  (load "polynomial-package/representation.scm")
  (load "polynomial-package/operation.scm")

  (define (make-polynomial p)
    (attach-type 'polynomial p))

  (define (+polynomial p1 p2)
    (make-polynomial (+poly p1 p2)))

  (define (*polynomial p1 p2)
    (make-polynomial (*poly p1 p2)))

  (put 'polynomial 'add +polynomial)
  (put 'polynomial 'mul *polynomial)
  (put 'polynomial
       'make
       (lambda (var term-list)
         (make-polynomial (make-poly var term-list))))

  'done)

(define (make-polynomial var term-list)
  ((get 'polynomial 'make) var term-list))

(install-polynomial-package)
