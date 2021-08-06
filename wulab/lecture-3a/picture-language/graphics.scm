(#%require graphics/graphics)

(load "vector.scm")

(define canvas 'canvas)
(define viewport 'viewport)

(define (vect->posn v)
  (make-posn (xcor v)
             (- (posn-y canvas)
                (ycor v))))

(define (drawline v1 v2)
  ((draw-line viewport) (vect->posn v1)
                        (vect->posn v2)))

(define (make-viewport name w h)
  (if (graphics-open?)
      'opened
      (open-graphics))
  (set! canvas (make-posn w h))
  (set! viewport (open-viewport name canvas))
  viewport)
