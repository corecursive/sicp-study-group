#lang sicp


(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x) (append (list (car s)) x)) rest)))))


(subsets (list 1 2 3))


; Output:
; $ sicp ex2-32.rkt
; (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))

; Explanation:
; An empty list has exactly one subset (the empty set `()`)
; Otherwise, the result should be a list of all the subsets of the tail of list (i.e. `(cdr list)`) combined with the subsets that are formed by adding the head of the list (i.e `(car list)`) to each one of the subsets from the tail.
