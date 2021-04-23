;;     *Exercise 2.35:* Redefine `count-leaves' from section *Note
;;     2-2-2:: as an accumulation:
;;
;;          (define (count-leaves t)
;;            (accumulate <??> <??> (map <??> <??>)))

;; HELPERS
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

;; ANSWER
(define (count-leaves t)
  (accumulate +
	      0
	      (map (lambda (e) (if (list? e)
				   (count-leaves e)
				   1))
		   t)))

;; TEST
(count-leaves (list (list 1 2) (list 3 4)))
(count-leaves (list (list 1 (list 2 3)) (list 3)))
