;; *Exercise 2.79:* Define a generic equality predicate `equ?' that
;; tests the equality of two numbers, and install it in the generic
;; arithmetic package.  This operation should work for ordinary
;; numbers, rational numbers, and complex numbers.

(define (equ? x y) (apply-generic 'equ? x y))

;; In `install-scheme-number-package'
(define (install-scheme-number-package)
  (put 'equ? '(scheme-number scheme-number) eq?)
  'done)

;; In `install-rational-package'
(define (install-rational-package)
  ;; internal procedures
  (define (equ-rat? x y)
    (and (eq? (numer x) (numer y))
         (eq? (denom x) (denom y))))

  ;; interface to rest of the system
  (put 'equ? '(rational rational) equ-rat?)
  'done)


;; In `install-complex-package'
(define (install-complex-package)
  ;; imported procedures from rectangular and polar packages

  ;; internal procedures
  (define (equ-complex? z1 z2)
    (and (eq? (magnitude z1) (magnitude z2))
         (eq? (angle z1) (angle z2))))

  ;; interface to rest of the system
  (put 'add '(complex complex) equ-complex?)
  'done)
