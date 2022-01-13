#lang sicp

(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right) (list entry left right))

(define (lookup tree elem)
  (if (null? tree) #f
    (cond ((= elem (car tree)) (car tree))
          ((< elem (car tree)) (lookup (left-branch tree) elem))
          (else (lookup (right-branch tree) elem)))))

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




(lookup t1 1)
(lookup t1 3)
(lookup t1 11)
(lookup t1 12)

; $ sicp ex2-66.rkt
; 1
; 3
; 11
; #f

