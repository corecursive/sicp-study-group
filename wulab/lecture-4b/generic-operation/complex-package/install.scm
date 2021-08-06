(load "table.scm")
(load "type.scm")

;; installing complex numbers

(define (install-complex-package)
  (load "complex-package/rectangular.scm")
  (load "complex-package/polar.scm")
  (load "complex-package/operation.scm")

  (install-rectangular-package)
  (install-polar-package)

  (define (make-complex z)
    (attach-type 'complex z))

  (define (+complex z1 z2)
    (make-complex (+c z1 z2)))

  (define (-complex z1 z2)
    (make-complex (-c z1 z2)))

  (define (*complex z1 z2)
    (make-complex (*c z1 z2)))

  (define (/complex z1 z2)
    (make-complex (/c z1 z2)))

  (put 'complex 'add +complex)
  (put 'complex 'sub -complex)
  (put 'complex 'mul *complex)
  (put 'complex 'div /complex)
  (put 'complex
       'make-from-real-imag
       (lambda (x y) (make-complex (make-from-real-imag x y))))
  (put 'complex
       'make-from-mag-ang
       (lambda (r a) (make-complex (make-from-mag-ang r a))))

  'done)

(define (make-from-real-imag-complex x y)
  ((get 'complex 'make-from-real-imag) x y))

(define (make-from-mag-ang-complex r a)
  ((get 'complex 'make-from-mag-ang) r a))

(install-complex-package)
