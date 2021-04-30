#lang sicp

(define (square x) (* x x))

(define (tree-map func tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map func sub-tree)
             (func sub-tree)))
       tree))

;; *Exercise 2.31:* Abstract your answer to *Note Exercise 2-30:: to
;; produce a procedure `tree-map' with the property that `square-tree'
;; could be defined as

(define (square-tree tree) (tree-map square tree))

(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))
;; (1 (4 (9 16) 25) (36 49))
