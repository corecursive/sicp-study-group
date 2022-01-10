#lang sicp

(define (deriv expr var)
  (cond ((number? expr) 0)
        ((symbol? expr) (if (eq? expr var) 1 0))
        ((exponentiation? expr)
           (make-product (exponent expr)
                         (make-product
                           (make-exponentiation (base expr) (- (exponent expr) 1))
                           (deriv (base expr) var))))
        ((sum? expr)
           (make-sum (deriv (addend expr) var)
                     (deriv (augend expr) var)))
        ((product? expr)
           (make-sum
             (make-product (multiplier expr) (deriv (multiplicand expr) var))
             (make-product (multiplicand expr) (deriv (multiplier expr) var))))
        (else error "unknown expression type DERIV -- " expr)))


(define (sum? expr)
  (and (pair? expr) (eq? '+ (car expr))))
(define (product? expr)
  (and (pair? expr) (eq? '* (car expr))))

(define (make-sum addend augend)
  (cond ((and (number? augend) (eq? 0 augend)) addend)
        ((and (number? addend) (eq? 0 addend)) augend)
        ((and (number? addend) (number? augend)) (+ addend augend))
        (else (list '+ addend augend))))

(define (addend sum)
  (car (cdr sum)))

(define (augend sum)
  (define aug (cdr (cdr sum)))
  (if (null? (cdr aug)) (car aug) (append (list '+ (car aug)) (cdr aug))))

(define (make-product multiplier multiplicand)
  (cond ((and (number? multiplier) (number? multiplicand)) (* multiplier multiplicand))
        ((and (number? multiplier) (eq? 0 multiplier)) 0)
        ((and (number? multiplier) (eq? 1 multiplier)) multiplicand)
        ((and (number? multiplicand) (eq? 0 multiplicand)) 0)
        ((and (number? multiplicand) (eq? 1 multiplicand)) multiplier)
        (else (list '* multiplier multiplicand))))

(define (multiplier product)
  (car (cdr product)))

(define (multiplicand product)
  (define mult (cdr (cdr product)))
  (if (null? (cdr mult)) (car mult) (append (list '* (car mult)) (cdr mult))))


(define (exponentiation? expr)
  (and (pair? expr) (eq? '** (car expr))))

(define (base exponentiation)
  (car (cdr exponentiation)))

(define (exponent exponentiation)
  (car (cdr (cdr exponentiation))))

(define (make-exponentiation base exponent)
  (cond ((= 0 exponent) 1)
        ((= 1 exponent) base)
        (else (list '** base exponent))))


(define (append l1 l2)
  (if (null? l1) l2
    (cons (car l1) (append (cdr l1) l2))))

(deriv '(* (* x y) (+ x 3)) 'x)
(deriv '(* x y (+ x 3)) 'x)

; $ sicp ex2-57.rkt
; (+ (* x y) (* (+ x 3) y))
; (+ (* x y) (* y (+ x 3)))
