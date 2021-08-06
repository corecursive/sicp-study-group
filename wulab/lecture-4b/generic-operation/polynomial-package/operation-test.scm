(load "polynomial-package/representation.scm")
(load "polynomial-package/operation.scm")

;; re-define add and mul for easy testing
(define add +)
(define mul *)

(define p1 (make-poly 'x '((15 1) (7 2) (0 5)))) ; x^15 + 2x^7 + 5
(define p2 (make-poly 'x '((7 5) (0 2))))        ; 5x^7 + 2
(define p3 (+poly p1 p2))
(define p4 (*poly p1 p2))

(assert (same-var? p3 p1))
(assert (equal? (term-list p3) '((15 1) (7 7) (0 7))))

(assert (same-var? p4 p1))
(assert (equal? (term-list p4) '((22 5) (15 2) (14 10) (7 29) (0 10))))
