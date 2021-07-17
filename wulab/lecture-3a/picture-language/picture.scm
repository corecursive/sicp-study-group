(load "graphics.scm")
(load "segment.scm")
(load "rectangle.scm")

;; constructing primitive pictures from lists of segments

(define (make-picture seglist)
  (lambda (rect)
    (for-each
     (lambda (s)
       (drawline
        ((coord-map rect) (seg-start s))
        ((coord-map rect) (seg-end s))))
     seglist)))
