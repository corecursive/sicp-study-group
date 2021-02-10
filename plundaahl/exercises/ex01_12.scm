(define (pascal-tri col row)
  (cond ((< row 0) 0)
	((> col row) 0)
	((< col 0) 0)
	
	((<= row 1) 1)
	((= col 0) 1)
	((= col row) 1)
	
	(else (+
	       (pascal-tri col (- row 1))
	       (pascal-tri (- col 1) (- row 1))))))

(pascal-tri 2 4)
