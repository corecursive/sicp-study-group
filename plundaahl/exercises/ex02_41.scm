;;     *Exercise 2.41:* Write a procedure to find all ordered triples of
;;     distinct positive integers i, j, and k less than or equal to a
;;     given integer n that sum to a given integer s.

;; LIB
(define (enumerate-interval a b)
  (define (iter a b acc)
    (if (> a b)
	acc
	(iter (+ a 1) b (append acc (list a)))))
  (iter a b '()))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

;; i -> i,j -> i,j
(define (ordered-triples-sum-to-s n s)
  (filter (lambda (e) (= s (accumulate + 0 e)))
	  (flatmap
	   (lambda (i)
	     (flatmap
	      (lambda (j)
		(map (lambda (k) (list i j k))
		     (enumerate-interval 1 (- j 1))))
	      (enumerate-interval 1 (- i 1))))
	   (enumerate-interval 1 n))))

(ordered-triples-sum-to-s 7 9)
				 
