(load "type.scm")
(load "complex-package/install.scm")

(define z1 (make-from-real-imag-complex 1 2))
(define z2 (make-from-real-imag-complex 2 1))

(assert (eq? 'complex (type z1)))
(assert (eq? 'complex (type z2)))
(assert (eq? 'complex (type ((get 'complex 'add) (contents z1) (contents z2)))))
(assert (eq? 'complex (type ((get 'complex 'sub) (contents z1) (contents z2)))))
(assert (eq? 'complex (type ((get 'complex 'mul) (contents z1) (contents z2)))))
(assert (eq? 'complex (type ((get 'complex 'div) (contents z1) (contents z2)))))
