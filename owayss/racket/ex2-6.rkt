#lang sicp

(define zero
  (lambda (f) (lambda (x) x)))

(define (add-one n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

; (defone one (add-one zero))
; Using the substitution method:
; (define one
; (lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x))) f) x)))))
; (lambda (f) (lambda (x) (f ((lambda (x) x) x))))
; (lambda (f) (lambda (x) (f x)))
(define one
  (lambda (f) (lambda (x) (f x))))


; (define two (add-one one))
; Using the substitution method:
; (define two
; (lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f x))) f) x)))))
; (lambda (f) (lambda (x) (f ((lambda (x) (f x)) x))))
; (lambda (f) (lambda (x) (f (f x))))
(define two
  (lambda (f) (lambda (x) (f (f x)))))

(define (add a b)
  (lambda (f) (lambda (x) ((a f) ((b f) x)))))

(define (church->num c)
  ((c inc) 0))

;(church->num zero)
;(church->num one)
;(church->num (add-one zero))
;(church->num two)
;(church->num (add-one (add-one zero)))
;(church->num (add-one (add-one (add-one zero))))
;(church->num (add one two))
; $ racket ex2-6.rkt
; 0
; 1
; 1
; 2
; 2
; 3
; 3
