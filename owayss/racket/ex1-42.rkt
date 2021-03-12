#lang sicp


(define (compose f g) (lambda (x) (f (g x))))

(define (square x) (* x x))

((compose square inc) 6)

;;; owayss.kabtoul at void in ~/github/owayss/sicp-study-group/owayss/racket on master [?] using minikube:default
;;; $ racket '/Users/owayss.kabtoul/github/owayss/sicp-study-group/owayss/racket/ex1-42.rkt'
;;; 49
