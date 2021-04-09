#lang sicp

;; *Exercise 2.17:* Define a procedure `last-pair' that returns the
;; list that contains only the last element of a given (nonempty)
;; list:

(define (last-pair elems)
  (define the-rest (cdr elems))
  (if (null? the-rest)
      (car elems)
      (last-pair the-rest)))

(last-pair (list 23 72 149 34))         ; (34)
