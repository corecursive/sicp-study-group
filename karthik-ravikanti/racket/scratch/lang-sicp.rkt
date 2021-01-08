#lang sicp

(inc 42)
nil
(dec 43)
(stream-null? the-empty-stream)
(cons-stream 1 2)
(runtime)
(random 9999999)
(amb 1 2 3)
true
false
(identity 1)
;;(error "this is an error")

(#%require sicp-pict)
(paint einstein)

(vect? 1)
(make-vect 1 2)
(vect? (make-vect 1 2))
(vector-xcor (make-vect 1 2))
(vector-ycor (make-vect 1 2))
(vector-add (make-vect 1 2) (make-vect 1 2))
(vector-sub (make-vect 1 2) (make-vect 1 2))
(vector-scale 10 (make-vect 1 2))
(vect? zero-vector)
