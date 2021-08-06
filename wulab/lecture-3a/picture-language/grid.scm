(load "vector.scm")
(load "segment.scm")

;; constructing a list of segments from lines
;; in an m x n grid – each line is represented
;; by 4 integers: x0, y0, x1, y1

(define (grid m n linelist)
  (define (line->seg line)
    (make-segment
     (make-vect (/ (car line) m)
                (/ (car (cdr line)) n))
     (make-vect (/ (car (cdr (cdr line))) m)
                (/ (car (cdr (cdr (cdr line)))) n))))
  (map line->seg linelist))
