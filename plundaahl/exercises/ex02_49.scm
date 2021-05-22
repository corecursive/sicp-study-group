;;     *Exercise 2.49:* Use `segments->painter' to define the following
;;     primitive painters:
;;
;;       a. The painter that draws the outline of the designated frame.
;;
;;       b. The painter that draws an "X" by connecting opposite corners
;;          of the frame.
;;
;;       c. The painter that draws a diamond shape by connecting the
;;          midpoints of the sides of the frame.
;;
;;       d. The `wave' painter.

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

;; segments->painter
(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))

;;       a. The painter that draws the outline of the designated frame.

(define frame-painter
  (let ((origin (make-vect 0 0))
	(left (make-vect 0 1))
	(right (make-vect 1 0))
	(far (make-vect 1 1)))
    (segments->painter
     (list (make-segment origin left)
	   (make-segment left far)
	   (make-segment far right)
	   (make-segment right origin)))))

;;       b. The painter that draws an "X" by connecting opposite corners
;;          of the frame.

(define x-painter
  (let ((origin (make-vect 0 0))
	(left (make-vect 0 1))
	(right (make-vect 1 0))
	(far (make-vect 1 1)))
    (segments->painter
     (list (make-segment origin far)
	   (make-segment left right)))))

;;       c. The painter that draws a diamond shape by connecting the
;;          midpoints of the sides of the frame.

(define x-painter
  (let ((near-left (make-vect 0 0.5))
	(near-right (make-vect 0.5 0))
	(far-left (make-vect 1 0.5))
	(far-right (make-vect 0.5 1)))
    (segments->painter
     (list (make-segment near-left near-right)
	   (make-segment near-left far-left)
	   (make-segment far-left far-right)
	   (make-segment right-right far-right)
	   ))))

;;       d. The `wave' painter.
;; (I think I'll pass)
