(load "operation.scm")
(load "complex-package/install.scm")
(load "number-package/install.scm")
(load "rational-package/install.scm")
(load "polynomial-package/install.scm")

(define n1 (make-number 1))
(define n2 (make-number 2))
(define r1 (make-rational 1 2))
(define r2 (make-rational 2 1))
(define z1 (make-from-real-imag-complex 1 2))
(define z2 (make-from-real-imag-complex 2 1))

(assert (eq? 'number (type (add n1 n2))))
(assert (eq? 'rational (type (add r1 r2))))
(assert (eq? 'complex (type (add z1 z2))))

;; 2/3x^2 + 5/17x + 11/4
(define p1
  (make-polynomial 'x
                   (list (make-term 2 (make-rational 2 3))
                         (make-term 1 (make-rational 5 17))
                         (make-term 0 (make-rational 11 4)))))

;; 2/17x + 3/2
(define p2
  (make-polynomial 'x
                   (list (make-term 1 (make-rational 2 17))
                         (make-term 0 (make-rational 3 2)))))

;; (x^2 + 1)y^2 + (x^3 - 2x)y + (x^4 - 7)
(define p3
  (make-polynomial
   'y
   (list
    (make-term 2
               (make-polynomial 'x
                                (list
                                 (make-term 2 (make-number 1))
                                 (make-term 0 (make-number 1)))))
    (make-term 1
               (make-polynomial 'x
                                (list
                                 (make-term 3 (make-number 1))
                                 (make-term 1 (make-number -2)))))
    (make-term 0
               (make-polynomial 'x
                                (list
                                 (make-term 4 (make-number 1))
                                 (make-term 0 (make-number -7))))))))

;; (-x - 3)y + (2x^4 + 4)
(define p4
  (make-polynomial
   'y
   (list
    (make-term 1
               (make-polynomial 'x
                                (list
                                 (make-term 1 (make-number -1))
                                 (make-term 0 (make-number -3)))))
    (make-term 0
               (make-polynomial 'x
                                (list
                                 (make-term 4 (make-number 2))
                                 (make-term 0 (make-number 4))))))))

(assert (eq? 'polynomial (type (add p1 p2))))
(assert (eq? 'polynomial (type (add p3 p4))))
