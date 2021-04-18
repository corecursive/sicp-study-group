;;     *Exercise 2.27:* Modify your `reverse' procedure of *Note Exercise
;;     2-18:: to produce a `deep-reverse' procedure that takes a list as
;;     argument and returns as its value the list with its elements
;;     reversed and with all sublists deep-reversed as well.

;; Original reverse function
(define (reverse l)
  (define (iter l acc)
    (if (null? l)
	acc
	(iter (cdr l) (cons (car l) acc))))
  (iter l '()))

;; Deep reverse
(define (deep-reverse l)
  (define (iter l acc)
    (cond ((null? l) acc)
	  ((pair? (car l)) (iter (cdr l)
				 (cons (deep-reverse (car l)) acc)))
	  (else (iter (cdr l) (cons (car l) acc)))))
  (iter l '()))

;;     TESTS
(define x (list (list 1 2) (list 3 4)))
x					; Should print ((1 2) (3 4))
(reverse x)				; Should print ((3 4) (1 2))
(deep-reverse x)			; Should print ((4 3) (2 1))
