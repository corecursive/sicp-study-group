(load "type.scm")
(load "complex-package/rectangular.scm")
(load "complex-package/polar.scm")
(load "complex-package/operation.scm")

(install-rectangular-package)
(install-polar-package)

(define z1 (make-from-real-imag 1 2))
(define z2 (make-from-real-imag 2 1))

(assert (eq? 'rectangular (type z1)))
(assert (eq? 'rectangular (type z2)))
(assert (eq? 'rectangular (type (+c z1 z2))))
(assert (eq? 'rectangular (type (-c z1 z2))))
(assert (eq? 'polar (type (*c z1 z2))))
(assert (eq? 'polar (type (/c z1 z2))))
