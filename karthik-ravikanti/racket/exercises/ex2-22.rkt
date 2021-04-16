#lang sicp

(define (square x) (* x x))

;; *Exercise 2.22:* Louis Reasoner tries to rewrite the first
;; `square-list' procedure of *Note Exercise 2-21:: so that it
;; evolves an iterative process:

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items nil))

(square-list (list 1 2 3 4))

;; Unfortunately, defining `square-list' this way produces the answer
;; list in the reverse order of the one desired.  Why?

;; Answer: It's reversed because the intermediate results are _stacked_ on to
;; nil.

;; Louis then tries to fix his bug by interchanging the arguments to
;; `cons':

     (define (square-list items)
       (define (iter things answer)
         (if (null? things)
             answer
             (iter (cdr things)
                   (cons answer
                         (square (car things))))))
       (iter items nil))

(square-list (list 1 2 3 4))

;; This doesn't work either.  Explain.

;; Answer: Now he's creating pairs of pairs of pairs ...
