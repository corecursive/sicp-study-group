#lang sicp


; (define (square-tree t)
;   (cond ((null? t) t)
;         ((not (pair? t)) (* t t))
;         (else (cons (square-tree (car t)) (square-tree (cdr t))))))


; (square-tree (list 1
;                    (list 2 (list 3 4) 5)
;                    (list 6 7)))


; Output:
; $ sicp ex2-30.rkt
; (1 (4 (9 16) 25) (36 49))


(define (square-tree t)
  (map (lambda (x) (if (not (pair? x)) (* x x) (square-tree x))) t))


(square-tree (list 1
                   (list 2 (list 3 4) 5)
                   (list 6 7)))

; Output:
; $ sicp ex2-30.rkt
; (1 (4 (9 16) 25) (36 49))

