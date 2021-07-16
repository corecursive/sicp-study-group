(load "type.scm")
(load "table.scm")

;; Representing complex numbers as pairs MAGNITUDE, ANGLE

(define (install-polar-package)
  ;; internal procedures
  ;; these definitions are now internal, so there is no name conflict
  (define (make-from-mag-ang r a)
    (cons r a))

  (define (make-from-real-imag x y)
    (cons (sqrt (+ (square x)
                   (square y)))
          (atan y x)))

  (define (magnitude z)
    (car z))

  (define (angle z)
    (cdr z))

  (define (real-part z)
    (* (car z)
       (cos (cdr z))))

  (define (imag-part)
    (* (car z)
       (sin (cdr z))))

  (define (make-polar z)
    (attach-type 'polar z))

  (put 'polar
       'make-from-mag-ang
       (lambda (r a) (make-polar (make-from-mag-ang r a))))
  (put 'polar
       'make-from-real-imag
       (lambda (x y) (make-polar (make-from-real-imag x y))))
  (put 'polar 'magnitude magnitude)
  (put 'polar 'angle angle)
  (put 'polar 'real-part real-part)
  (put 'polar 'imag-part imag-part)

  'done)

(define (make-from-mag-ang r a)
  ((get 'polar 'make-from-mag-ang) r a))
