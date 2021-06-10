;; *Exercise 2.66:* Implement the `lookup' procedure for the case
;; where the set of records is structured as a binary tree, ordered
;; by the numerical values of the keys.

(define (lookup k set)
  (if (null? set)
      false
      (let ((record (entry set)))
	(cond ((= k (key record)) record)
	      ((< k (key record)) (lookup k (left-branch set)))
	      ((> k (key record)) (lookup k (right-branch set)))))))
