(load "vector.scm")
(load "rectangle.scm")

;; rotate pict 90 clockwise
;; (rectangle does not rotate)

(define (rotate pict)
  (lambda (rect)
    (pict (make-rect (+vect (origin rect)
                            (horiz rect))
                     (vert rect)
                     (scale -1 (horiz rect))))))

(define (flip pict)
  (lambda (rect)
    (pict (make-rect (+vect (origin rect)
                            (horiz rect))
                     (scale -1 (horiz rect))
                     (vert rect)))))

;; means of combination

(define (beside m n p q)
  (lambda (rect)
    (define a (/ m (+ m n)))
    (define b (/ n (+ m n)))
    (p (make-rect (origin rect)
                  (scale a (horiz rect))
                  (vert rect)))
    (q (make-rect (+vect (origin rect)
                         (scale a (horiz rect)))
                  (scale b (horiz rect))
                  (vert rect)))))

(define (above m n p q)
  (lambda (rect)
    (define a (/ m (+ m n)))
    (define b (/ n (+ m n)))
    (p (make-rect (+vect (origin rect)
                         (scale b (vert rect)))
                  (horiz rect)
                  (scale a (vert rect))))
    (q (make-rect (origin rect)
                  (horiz rect)
                  (scale b (vert rect))))))

(define (quartet p1 p2 p3 p4)
  (above 1
         1
         (beside 1 1 p1 p2)
         (beside 1 1 p3 p4)))

(define (cycle pict)
  (quartet pict
           (rotate (rotate (rotate pict)))
           (rotate pict)
           (rotate (rotate pict))))

(define (nonet p q r s t u v w x)
  (above 1
         2
         (beside 1
                 2
                 p
                 (beside 1 1 q r))
         (above 1
                1
                (beside 1
                        2
                        s
                        (beside 1 1 t u))
                (beside 1
                        2
                        v
                        (beside 1 1 w x)))))
