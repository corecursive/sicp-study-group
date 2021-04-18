#lang sicp


(define (tree-map f tree)
  (map (lambda (x) (if (not (pair? x)) (f x) (tree-map f x))) tree))

(define (square x) (* x x))

(define (square-tree t) (tree-map square t))


(square-tree (list 1
                   (list 2 (list 3 4) 5)
                   (list 6 7)))


; Output:
; $ sicp ex2-31.rkt
; (1 (4 (9 16) 25) (36 49))

