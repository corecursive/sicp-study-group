;;     *Exercise 2.29:* A binary mobile consists of two branches, a left
;;     branch and a right branch.  Each branch is a rod of a certain
;;     length, from which hangs either a weight or another binary mobile.
;;     We can represent a binary mobile using compound data by
;;     constructing it from two branches (for example, using `list'):

(define (make-mobile left right)
  (list left right))

;;     A branch is constructed from a `length' (which must be a number)
;;     together with a `structure', which may be either a number
;;     (representing a simple weight) or another mobile:

(define (make-branch length structure)
  (list length structure))

;;       a. Write the corresponding selectors `left-branch' and
;;          `right-branch', which return the branches of a mobile, and
;;          `branch-length' and `branch-structure', which return the
;;          components of a branch.

(define (left-branch m) (car m))
(define (right-branch m) (car (cdr m)))
(define (branch-length b) (car b))
(define (branch-structure b) (car (cdr b)))

;;       b. Using your selectors, define a procedure `total-weight' that
;;          returns the total weight of a mobile.

(define (branch-weight b)
  (let ((structure (branch-structure b)))
    (if (pair? structure)
	(total-weight structure)
	structure)))

(define (total-weight m)
  (+ (branch-weight (left-branch m))
     (branch-weight (right-branch m))))

;; test
(total-weight
 (make-mobile (make-branch 0 1)
	      (make-branch 0 (make-mobile (make-branch 0 2)
					  (make-branch 0 4)))))

;;       c. A mobile is said to be "balanced" if the torque applied by
;;          its top-left branch is equal to that applied by its top-right
;;          branch (that is, if the length of the left rod multiplied by
;;          the weight hanging from that rod is equal to the
;;          corresponding product for the right side) and if each of the
;;          submobiles hanging off its branches is balanced. Design a
;;          predicate that tests whether a binary mobile is balanced.

(define (branch-torque b)
  (* (branch-length b)
     (branch-weight b)))

(define (balanced? m)
  (if (not (pair? m))
      #t
      (and (eq? (branch-torque (left-branch m))
		(branch-torque (right-branch m)))
	   (balanced? (branch-structure (left-branch m)))
	   (balanced? (branch-structure (right-branch m))))))

;; tests
(branch-torque (make-branch 2 3))

(define left-br (make-branch 6 1))
(define right-br (make-branch 1
			   (make-mobile (make-branch 1 4)
					(make-branch 2 2))))

(branch-torque right-br)
(branch-torque left-br)
(balanced? (make-mobile left-br right-br))
  
;;       d. Suppose we change the representation of mobiles so that the
;;          constructors are

(define (make-mobile left right)
                 (cons left right))

(define (make-branch length structure)
                 (cons length structure))

;;          How much do you need to change your programs to convert to
;;          the new representation?

;; ANS: All I need to do is update the following procedures:

(define (right-branch m) (cdr m))
(define (branch-structure b) (cdr b))
