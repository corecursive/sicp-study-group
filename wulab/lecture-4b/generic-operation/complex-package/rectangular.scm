(load "type.scm")
(load "table.scm")

;; Representing complex numbers as pairs REAL-PART, IMAGINARY PART

(define (install-rectangular-package)
  ;; internal procedures
  ;; these definitions are now internal, so there is no name conflict
  (define (make-from-real-imag x y)
    (cons x y))

  (define (make-from-mag-ang r a)
    (cons (* r (cos a))
          (* r (sin a))))

  (define (real-part z)
    (car z))

  (define (imag-part z)
    (cdr z))

  (define (magnitude z)
    (sqrt (+ (square (car z))
             (square (cdr z)))))

  (define (angle z)
    (atan (cdr z)
          (car z)))

  (define (make-rectangular z)
    (attach-type 'rectangular z))

  (put 'rectangular
       'make-from-real-imag
       (lambda (x y) (make-rectangular (make-from-real-imag x y))))
  (put 'rectangular
       'make-from-mag-ang
       (lambda (r a) (make-rectangular (make-from-mag-ang r a))))
  (put 'rectangular 'make-from-mag-ang make-from-mag-ang)
  (put 'rectangular 'real-part real-part)
  (put 'rectangular 'imag-part imag-part)
  (put 'rectangular 'magnitude magnitude)
  (put 'rectangular 'angle angle)

  'done)

(define (make-from-real-imag x y)
  ((get 'rectangular 'make-from-real-imag) x y))
