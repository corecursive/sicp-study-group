(load "type.scm")
(load "polynomial-package/install.scm")

;; re-define add and mul for easy testing
(define add +)
(define mul *)

(define p1 (make-polynomial 'x '((15 1) (7 2) (0 5)))) ; x^15 + 2x^7 + 5
(define p2 (make-polynomial 'x '((7 5) (0 2))))        ; 5x^7 + 2

(assert (eq? 'polynomial (type p1)))
(assert (eq? 'polynomial (type p2)))
(assert (eq? 'polynomial (type ((get 'polynomial 'add) (contents p1) (contents p2)))))
(assert (eq? 'polynomial (type ((get 'polynomial 'mul) (contents p1) (contents p2)))))
