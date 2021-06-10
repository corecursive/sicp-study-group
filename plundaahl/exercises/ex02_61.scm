;; *Exercise 2.61:* Give an implementation of `adjoin-set' using the
;; ordered representation.  By analogy with `element-of-set?' show
;; how to take advantage of the ordering to produce a procedure that
;; requires on the average about half as many steps as with the
;; unordered representation.

(define (element-of-set? x set)
  (cond ((null? set) false)
	((= x (car set)) true)
	((< x (car set)) false)
	(else (element-of-set? x (cdr set)))))

(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
	(cond ((= x1 x2)
	       (cons x1
		     (intersection-set (cdr set1)
				       (cdr set2))))
	      ((< x1 x2)
	       (intersection-set (cdr set1) set2))
	      ((< x2 x1)
	       (intersection-set set1 (cdr set2)))))))

;; IMPLEMENTATION
(define (adjoin-set x set)
  (cond ((null? set) (list x))
	((= x (car set)) set)
	((< x (car set)) (cons x set))
	(else (cons (car set)
		    (adjoin-set x (cdr set))))))

;; TESTS
(adjoin-set 5 '(1 3 7 6))
(adjoin-set 5 '(7 6))
(adjoin-set 5 '(1 3))
(adjoin-set 5 '(2 4 5 6))

;; WRITE-UP
;; Follows the same pattern as `element-of-set?': as soon as we find
;; an element in the set that is larger than the element we are adding,
;; we can stop. If the range of values we are adding to the set follows
;; an even distribution across a given range, numbers added will, on
;; average, be added to the middle of any given set, saving us half the
;; steps.
