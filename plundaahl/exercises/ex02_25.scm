;;     *Exercise 2.25:* Give combinations of `car's and `cdr's that will
;;     pick 7 from each of the following lists:
;;
;;          (1 3 (5 7) 9)

(car (cdr (car (cdr (cdr
		     (list 1 3 (list 5 7) 9))))))

;;          ((7))

(car (car
      (list (list 7))))

;;          (1 (2 (3 (4 (5 (6 7))))))

(define l3 (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))

(car (cdr
      (car (cdr
	    (car (cdr
		  (car (cdr
			(car (cdr
			      (car (cdr
				    l3))))))))))))
