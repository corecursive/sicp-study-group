;; x^15 + 2x^7 + 5
;; (make-poly 'x '((15 1) (7 2) (0 5)))
(define (make-poly var term-list)
  (cons var term-list))

(define var car)
(define term-list cdr)

(define (same-var? p1 p2)
  (eq? (var p1)
       (var p2)))

;; use list instead of cons so a term-list can be
;; made quickly with quote '((4 3) (2 1))
(define (make-term order coeff)
  (list order coeff))

(define order car)
(define coeff cadr)
