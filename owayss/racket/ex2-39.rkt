#lang sicp

(define (fold-left op intitial seq)
  (define (iter result rest)
    (if (null? rest) result
        (iter (op result (car rest)) (cdr rest))))

  (iter intitial seq))

(define (fold-right op intitial seq)
  (if (null? seq) intitial
      (op (car seq) (fold-right op intitial (cdr seq)))))

(define (reverse-l seq)
  (fold-right
    (lambda (x y) (if (null? x) nil) (append y (list x)))
    nil
    seq))

(define (reverse-r seq)
  (fold-left
    (lambda (x y) (if (null? x) nil) (cons y x))
    nil
    seq))


(reverse-l nil)
(reverse-l (list 1))
(reverse-l (list 1 2 3))

(reverse-r nil)
(reverse-r (list 1))
(reverse-r (list 1 2 3))


; Output:

; $ sicp ex2-39.rkt
; ()
; (1)
; (3 2 1)
; ()
; (1)
; (3 2 1)
