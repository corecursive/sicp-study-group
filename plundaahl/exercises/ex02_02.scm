;;     *Exercise 2.2:* Consider the problem of representing line segments
;;     in a plane.  Each segment is represented as a pair of points: a
;;     starting point and an ending point.  Define a constructor
;;     `make-segment' and selectors `start-segment' and `end-segment'
;;     that define the representation of segments in terms of points.
;;     Furthermore, a point can be represented as a pair of numbers: the
;;     x coordinate and the y coordinate.  Accordingly, specify a
;;     constructor `make-point' and selectors `x-point' and `y-point'
;;     that define this representation.  Finally, using your selectors
;;     and constructors, define a procedure `midpoint-segment' that takes
;;     a line segment as argument and returns its midpoint (the point
;;     whose coordinates are the average of the coordinates of the
;;     endpoints).  To try your procedures, you'll need a way to print
;;     points:

;; Helpers

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

;;;;;;;;;;;;;;
;; SOLUTION ;;
;;;;;;;;;;;;;;

(define (make-segment a b) (cons a b))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (midpoint-segment s)
  (let ((start (start-segment s))
	(end (end-segment s)))
    (make-point
     (/ (+ (x-point start) (x-point end)) 2)
     (/ (+ (y-point start) (y-point end)) 2))))

;; Tests

(midpoint-segment (make-segment (make-point 0 0)
				(make-point 10 0)))

(midpoint-segment (make-segment (make-point -10 -10)
				(make-point -5 -5)))
