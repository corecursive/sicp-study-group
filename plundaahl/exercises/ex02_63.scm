;; *Exercise 2.63:* Each of the following two procedures converts a
;; binary tree to a list.

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

;;   a. Do the two procedures produce the same result for every tree?
;;      If not, how do the results differ?  What lists do the two
;;      procedures produce for the trees in *Note Figure 2-16::?

;; *Figure 2.16:* Various binary trees that represent the set
;; {1,3,5,7,9,11}.
;;         7          3             5
;;         /\         /\            /\
;;        3  9       1  7          3  9
;;       /\   \         /\        /   /\
;;      1  5  11       5  9      1   7  11
;;                         \
;;                         11

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right) (list entry left right))

(define tree-1
  (make-tree 7
	     (make-tree 3
			(make-tree 1 '() '())
			(make-tree 5 '() '()))
	     (make-tree 9
			'()
			(make-tree 11 '() '()))))

(tree->list-1 tree-1) ;; (1 3 5 7 9 11)
(tree->list-2 tree-1) ;; (1 3 5 7 9 11)

(define tree-2
  (make-tree 3
	     (make-tree 1 '() '())
	     (make-tree 7
			(make-tree 5 '() '())
			(make-tree 9
				   '()
				   (make-tree 11 '() '())))))

(tree->list-1 tree-2) ;; (1 3 5 7 9 11)
(tree->list-2 tree-2) ;; (1 3 5 7 9 11)

(define tree-3
  (make-tree 5
	     (make-tree 3
			(make-tree 1 '() '())
			'())
	     (make-tree 9
			(make-tree 7 '() '())
			(make-tree 11 '() '()))))

(tree->list-1 tree-3) ;; (1 3 5 7 9 11)
(tree->list-2 tree-3) ;; (1 3 5 7 9 11)

;;   b. Do the two procedures have the same order of growth in the
;;      number of steps required to convert a balanced tree with n
;;      elements to a list?  If not, which one grows more slowly?

;; According to http://community.schemewiki.org/?sicp-ex-2.63 : no
;; I'm too lazy to expand everything out by hand, though.
