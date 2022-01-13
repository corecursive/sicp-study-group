#lang sicp

(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right) (list entry left right))


(define t1 (make-tree 7
              (make-tree 3
                         (make-tree 1 nil nil)
                         (make-tree 5 nil nil))
              (make-tree 9
                         nil
                         (make-tree 11 nil nil))))
(define t2 (make-tree 3
              (make-tree 1 nil nil)
              (make-tree 7
                         (make-tree 5 nil nil)
                         (make-tree 9
                                    nil
                                    (make-tree 11 nil nil)))))
(define t3 (make-tree 5
              (make-tree 3
                         (make-tree 1 nil nil)
                         nil)
              (make-tree 9
                         (make-tree 7 nil nil)
                         (make-tree 11 nil nil))))


(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
    (cons '() elts)
    (let ((left-size (quotient (- n 1) 2)))
      (let ((left-result (partial-tree elts left-size)))
        (let ((left-tree (car left-result))
              (non-left-elts (cdr left-result))
              (right-size (- n (+ left-size 1))))
          (let ((this-entry (car non-left-elts))
                (right-result (partial-tree (cdr non-left-elts)
                                            right-size)))
            (let ((right-tree (car right-result))
                  (remaining-elts (cdr right-result)))
              (cons (make-tree this-entry left-tree right-tree)
                    remaining-elts))))))))


(list->tree (list 1 3 5 7 9 11))


; partial-tree works by starting at the first element (the left-most element
; in the tree), and recursing through the list, each time cutting n in half
; to go one level deeper into the tree:
; as the tree is required to be balanced, the number of nodes in subtree at depth
; k is 2^(floor(log_2(n)) - k)
; e.g. for the three in the diagram, the number of nodes for the subtree at node
; (9) where the level is k = 1:
; 2^(floor(log_2(7)) - 1) + 1
; = 2^(2 - 1) + 1
; = 3
;
; when the middle element, the entire left subtree would have been constructed,
; and the right subtree would be recursively constructed in just the same way
;
;
; The order of growth of the implementation given is O(n). As the procedure
; is recursively called twice for both halves of the list at each step, and each
; step cutting the size in half in turn. i.e. called once for each element in the
; list.
