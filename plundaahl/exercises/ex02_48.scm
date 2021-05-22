;;     *Exercise 2.48:* A directed line segment in the plane can be
;;     represented as a pair of vectors--the vector running from the
;;     origin to the start-point of the segment, and the vector running
;;     from the origin to the end-point of the segment.  Use your vector
;;     representation from *Note Exercise 2-46:: to define a
;;     representation for segments with a constructor `make-segment' and
;;     selectors `start-segment' and `end-segment'.

;; Vector Implementation
(define (make-vect xcor ycor) (cons xcor ycor))
(define (xcor-vect vec) (car vec))
(define (ycor-vect vec) (cdr vec))

(define (combine op vec1 vec2)
  (make-vect (op (xcor-vect vec1) (xcor-vect vec2))
             (op (ycor-vect vec1) (ycor-vect vec2))))

(define (add-vect vec1 vec2) (combine + vec1 vec2))
(define (sub-vect vec1 vec2) (combine - vec1 vec2))
(define (scale-vect vec scalar) (combine * vec (make-vect scalar scalar)))

;; Line Segment Implemetation
(define (make-segment start end) (cons start end))
(define (start-segment vec) (car vec))
(define (end-segment vec) (cdr vec))

;; Tests
(define start (make-vect 1 2))
(define end (make-vect 4 3))
(define segment (make-segment start end))

(= (xcor-vect
    (start-segment
     segment))
   (xcor-vect start))

(= (ycor-vect
    (start-segment
     segment))
   (ycor-vect start))

(= (xcor-vect
    (end-segment
     segment))
   (xcor-vect end))

(= (xcor-vect
    (end-segment
     segment))
   (xcor-vect end))
