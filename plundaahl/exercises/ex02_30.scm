;;     *Exercise 2.30:* Define a procedure `square-tree' analogous to the
;;     `square-list' procedure of *Note Exercise 2-21::.  That is,
;;     `square-list' should behave as follows:
;;
;;          (square-tree
;;           (list 1
;;                 (list 2 (list 3 4) 5)
;;                 (list 6 7)))
;;          (1 (4 (9 16) 25) (36 49))
;;
;;     Define `square-tree' both directly (i.e., without using any
;;     higher-order procedures) and also by using `map' and recursion.

(define (square x) (* x x))

(define (square-tree tree)
  (cond ((null? tree) tree)
	((not (pair? tree)) (square tree))
	(else (cons (square-tree (car tree))
		    (square-tree (cdr tree))))))

(define (square-tree tree)
  (map (lambda (sub-tree)
	 (if (pair? sub-tree)
	     (square-tree sub-tree)
	     (square sub-tree)))
       tree))

;; TEST
(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))
;;          (1 (4 (9 16) 25) (36 49))
