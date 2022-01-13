#lang sicp

(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right) (list entry left right))

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

(define tree->list tree->list-1)

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



(define (intersection-sets s1 s2)
  (define (intersection-lists l1 l2)
    (if (or (null? l1) (null? l2)) '()
      (cond ((< (car l1) (car l2)) (intersection-lists (cdr l1) l2))
            ((= (car l1) (car l2)) (cons (car l1) (intersection-lists (cdr l1) (cdr l2))))
            (else (intersection-lists l1 (cdr l2))))))
  (let ((common-elts (intersection-lists (tree->list s1) (tree->list s2))))
    (list->tree common-elts)))

(define (union-sets s1 s2)
  (define (union-lists l1 l2)
    (cond ((null? l1) l2)
          ((null? l2) l1)
          ((< (car l1) (car l2)) (cons (car l1) (union-lists (cdr l1) l2)))
          ((= (car l1) (car l2)) (cons (car l1) (union-lists (cdr l1) (cdr l2))))
          (else (cons (car l2) (union-lists l1 (cdr l2))))))

  (let ((all-elts (union-lists (tree->list s1) (tree->list s2))))
    (list->tree all-elts)))


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

(intersection-sets t1 t2)
(union-sets t1 t2)

; $ sicp ex2-65.rkt
; (5 (1 () (3 () ())) (9 (7 () ()) (11 () ())))
; (5 (1 () (3 () ())) (9 (7 () ()) (11 () ())))

