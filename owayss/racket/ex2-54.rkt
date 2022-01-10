#lang sicp

(define (equal? a b)
  (cond ((not (pair? a)) (if (pair? b) #f (eq? a b)))
        ((not (pair? b)) #f)
        (else (and (eq? (car a) (car b)) (equal? (cdr a) (cdr b))))))


(equal? 'a '(b)) ;#f
(equal? '(a) 'b) ;#f
(equal? 'a 'b) ;#f
(equal? 'a 'a) ;#t
(equal? '(a) '(a b)) ;#f
(equal? '(a b) '(a b)) ;#t

(equal? '(this is a list) '(this is a list)) ; #t
(equal? '(this is a list) '(this (is a) list)) ; #f


; okabtoul at LUSC02DV5KQMD6R in ~/github/owayss/sicp-study-group/owayss/racket on master [?] using minikube:default
; $ sicp ex2-54.rkt
; #f
; #f
; #f
; #t
; #f
; #t
; #t
; #f

