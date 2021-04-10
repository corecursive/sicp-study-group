lang sicp

;; *Exercise 2.18:* Define a procedure `reverse' that takes a list as
;; argument and returns a list of the same elements in reverse order:

(define (reverse elems)
  (if (null? elems)
      elems
      (cons (car elems) (reverse (cdr elems)))))

(reverse (list 1 4 9 16 25)) ;; (25 16 9 4 1)
