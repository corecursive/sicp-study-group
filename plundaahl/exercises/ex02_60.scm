;; *Exercise 2.60:* We specified that a set would be represented as a
;; list with no duplicates.  Now suppose we allow duplicates.  For
;; instance, the set {1,2,3} could be represented as the list `(2 3 2
;; 1 3 2 2)'.  Design procedures `element-of-set?', `adjoin-set',
;; `union-set', and `intersection-set' that operate on this
;; representation.  How does the efficiency of each compare with the
;; corresponding procedure for the non-duplicate representation?  Are
;; there applications for which you would use this representation in
;; preference to the non-duplicate one?

;; IMPLEMENTATIONS
(define (element-of-set? x set)
  (cond ((null? set) false)
	((equal? x (car set)) true)
	(else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cons x set))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
	((element-of-set? (car set1) set2)
	 (cons (car set1)
	       (intersection-set (cdr set1) set2)))
	(else (intersection-set (cdr set1) set2))))

(define (union-set set1 set2)
  (append set1 set2))

;; TESTS
(element-of-set? 3 '(1 2 4 3 2 3 2 2))
(element-of-set? 7 '(1 2 4 3 2 3 2 2))

(adjoin-set 7 '(1 2 7 5 3))
(adjoin-set 7 '())

(intersection-set '(1 4 3 2 5)
		  '(1 0 4))

(union-set '(1 4 3 2 5)
	   '(1 0 4))

;; EFFICIENCY
;; With the duplicate-permitting version, `adjoin-set' and `union-set'
;; become much simpler. Neither needs to use `element-of-set?'.
;; `adjoin-set' is a simple `cons', while `union-set' makes use of
;; `append'. In both cases, they are more efficient.

;; The downside is that `intersection-set' and `element-of-set' will,
;; in most cases, require more steps to complete (and never less). Also,
;; my `union-set' version does not preserve the duplicates repeatably
;; (you will get different results depending on which order you pass
;; the sets in).

;; The one case where this might be preferable is where you are running
;; `adjoin-set' or `intersection-set' very frequently, but hardly ever
;; using `element-of-set?' or `union-set'.
