#lang sicp

(define (compose f g) (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 1) f (compose f (repeated f (- n 1)))))

(define (square x) (* x x))

((repeated square 2) 5)


;;; owayss.kabtoul at void in ~/github/owayss/sicp-study-group/owayss/racket on master [?] using minikube:default
;;; $ racket '/Users/owayss.kabtoul/github/owayss/sicp-study-group/owayss/racket/ex1-43.rkt'
;;; 625