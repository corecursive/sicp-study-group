(load "vector.scm")
(load "segment.scm")

(define george
  (list
   (make-segment (make-vect .25   0) (make-vect .35 .50))
   (make-segment (make-vect .35 .50) (make-vect .30 .60))
   (make-segment (make-vect .30 .60) (make-vect .15 .40))
   (make-segment (make-vect .15 .40) (make-vect   0 .65))
   (make-segment (make-vect .40   0) (make-vect .50 .30))
   (make-segment (make-vect .50 .30) (make-vect .60   0))
   (make-segment (make-vect .75   0) (make-vect .60 .45))
   (make-segment (make-vect .60 .45) (make-vect   1 .15))
   (make-segment (make-vect   1 .35) (make-vect .75 .65))
   (make-segment (make-vect .75 .65) (make-vect .60 .65))
   (make-segment (make-vect .60 .65) (make-vect .65 .85))
   (make-segment (make-vect .65 .85) (make-vect .60   1))
   (make-segment (make-vect .40   1) (make-vect .35 .85))
   (make-segment (make-vect .35 .85) (make-vect .40 .65))
   (make-segment (make-vect .40 .65) (make-vect .30 .65))
   (make-segment (make-vect .30 .65) (make-vect .15 .60))
   (make-segment (make-vect .15 .60) (make-vect   0 .85))))

(define frame
  (list
   (make-segment (make-vect 0 1) (make-vect 1 1))
   (make-segment (make-vect 1 1) (make-vect 1 0))
   (make-segment (make-vect 1 0) (make-vect 0 0))
   (make-segment (make-vect 0 0) (make-vect 0 1))))

(define george-in-frame (append george frame))
