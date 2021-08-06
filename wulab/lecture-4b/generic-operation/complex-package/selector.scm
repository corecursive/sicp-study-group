(load "operator.scm")

;; Defining the selectors using operate

(define (real-part z)
  (operate 'real-part z))

(define (imag-part z)
  (operate 'imag-part z))

(define (magnitude z)
  (operate 'magnitude z))

(define (angle z)
  (operate 'angle z))
