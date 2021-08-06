(load "table.scm")
(load "type.scm")

;; installing rational numbers in the
;; generic arithmetic system

(define (install-rational-package)
  (load "rational-package/representation.scm")
  (load "rational-package/operation.scm")

  (define (make-rational x)
    (attach-type 'rational x))

  (define (+rational x y)
    (make-rational (+rat x y)))

  (define (-rational x y)
    (make-rational (-rat x y)))

  (define (*rational x y)
    (make-rational (*rat x y)))

  (define (/rational x y)
    (make-rational (/rat x y)))

  (put 'rational 'add  +rational)
  (put 'rational 'sub  -rational)
  (put 'rational 'mul  *rational)
  (put 'rational 'div  /rational)
  (put 'rational 'make (lambda (n d) (make-rational (make-rat n d))))

  'done)

(define (make-rational n d)
  ((get 'rational 'make) n d))

(install-rational-package)
