(load "table.scm")
(load "type.scm")

;; installing ordinary numbers

(define (install-number-package)
  (define (make-number n)
    (attach-type 'number n))

  (define (+number x y)
    (make-number (+ x y)))

  (define (-number x y)
    (make-number (- x y)))

  (define (*number x y)
    (make-number (* x y)))

  (define (/number x y)
    (make-number (/ x y)))

  (put 'number 'add +number)
  (put 'number 'sub -number)
  (put 'number 'mul *number)
  (put 'number 'div /number)

  'done)

(define (make-number n)
  (attach-type 'number n))

(install-number-package)
