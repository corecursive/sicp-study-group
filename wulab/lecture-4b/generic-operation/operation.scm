(load "operator.scm")

(define (add x y)
  (operate-2 'add x y))

(define (sub x y)
  (operate-2 'sub x y))

(define (mul x y)
  (operate-2 'mul x y))

(define (div x y)
  (operate-2 'div x y))
