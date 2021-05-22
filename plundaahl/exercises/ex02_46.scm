;;     *Exercise 2.46:* A two-dimensional vector v running from the
;;     origin to a point can be represented as a pair consisting of an
;;     x-coordinate and a y-coordinate.  Implement a data abstraction for
;;     vectors by giving a constructor `make-vect' and corresponding
;;     selectors `xcor-vect' and `ycor-vect'.  In terms of your selectors
;;     and constructor, implement procedures `add-vect', `sub-vect', and
;;     `scale-vect' that perform the operations vector addition, vector
;;     subtraction, and multiplying a vector by a scalar:
;;
;;          (x_1, y_1) + (x_2, y_2) = (x_1 + x_2, y_1 + y_2)
;;          (x_1, y_1) - (x_2, y_2) = (x_1 - x_2, y_1 - y_2)
;;                       s * (x, y) = (sx, sy)

(define (make-vect xcor ycor) (cons xcor ycor))

(define (xcor-vect vec) (car vec))

(define (ycor-vect vec) (cdr vec))

(define (add-vect vec1 vec2)
  (cons (+ (car vec1) (car vec2))
	(+ (cdr vec1) (cdr vec2))))

(define (scale-vect vec scalar)
  (cons (* scalar (car vec))
	(* scalar (cdr vec))))

(define (sub-vect vec1 vec2)
  (add-vect vec1
	    (scale-vect vec2 -1)))


;; TESTS
(= (xcor-vect (make-vect 5 3)) 5)

(= (ycor-vect (make-vect 5 3)) 3)

(let ((sum (add-vect (make-vect 5 3)
		     (make-vect -2 4))))
  (and (= (xcor-vect sum) 3)
       (= (ycor-vect sum) 7)))

(let ((scaled (scale-vect (make-vect 3 7) 3)))
  (and (= (xcor-vect scaled) 9)
       (= (ycor-vect scaled) 21)))

(let ((subbed (sub-vect (make-vect 4 3)
			(make-vect 7 2))))
  (and (= (xcor-vect subbed) -3)
       (= (ycor-vect subbed) 1)))
