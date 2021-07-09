;; *Exercise 2.80:* Define a generic predicate `=zero?' that tests if
;; its argument is zero, and install it in the generic arithmetic
;; package.  This operation should work for ordinary numbers, rational
;; numbers, and complex numbers.

(define (=zero? x) (apply-generic 'equ? x))

;; In `install-scheme-number-package'
(define (install-scheme-number-package)
  (put '=zero? '(scheme-number)
       (lambda (x) (eq? 0 x)))
  'done)

;; In `install-rational-package'
(define (install-rational-package)
  ;; internal procedures
  (define (=zero-rat? x)
    (and (eq? (numer x) 0)
         (eq? (denom x) 0)))

  ;; interface to rest of the system
  (put 'equ? '(rational) =zero-rat?)
  'done)


;; In `install-complex-package'
(define (install-complex-package)
  ;; imported procedures from rectangular and polar packages

  ;; internal procedures
  (define (=zero-complex? z1)
    (and (eq? (magnitude z1) 0)
         (eq? (angle z1) 0)))

  ;; interface to rest of the system
  (put 'add '(complex) =zero-complex?)
  'done)
