#lang sicp

(define tolearance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolearance))
  
  (define (next x) (f x))

  (define (try guess)
    (let ((next (f guess)))
           (cond ((close-enough? next guess) (display "\nfound fixed point: ") (display guess) guess)
                 (else (display "\ntrying guess: ") (display guess) (try next)))))
  (try first-guess))

; x^x = 1000
(define (sol) (fixed-point (lambda (y) (/ (log 1000) (log y))) 3))
(sol)

(define (average x y) (/ (+ x y) 2.0))
(define (damped-sol) (fixed-point (lambda (y) (average y (/ (log 1000) (log y)))) 3))
(damped-sol)

;;; (define compare )
;;; $ racket '/Users/owayss.kabtoul/github/owayss/sicp-study-group/owayss/racket/ex1-36.rkt'

;;; trying guess: 3
;;; trying guess: 6.287709822868153
;;; trying guess: 3.757079790200296
;;; trying guess: 5.218748919675315
;;; trying guess: 4.180797746063314
;;; trying guess: 4.828902657081293
;;; trying guess: 4.386936895811029
;;; trying guess: 4.671722808746095
;;; trying guess: 4.481109436117821
;;; trying guess: 4.605567315585735
;;; trying guess: 4.522955348093164
;;; trying guess: 4.577201597629606
;;; trying guess: 4.541325786357399
;;; trying guess: 4.564940905198754
;;; trying guess: 4.549347961475409
;;; trying guess: 4.5596228442307565
;;; trying guess: 4.552843114094703
;;; trying guess: 4.55731263660315
;;; trying guess: 4.554364381825887
;;; trying guess: 4.556308401465587
;;; trying guess: 4.555026226620339
;;; trying guess: 4.55587174038325
;;; trying guess: 4.555314115211184
;;; trying guess: 4.555681847896976
;;; trying guess: 4.555439330395129
;;; trying guess: 4.555599264136406
;;; trying guess: 4.555493789937456
;;; trying guess: 4.555563347820309
;;; trying guess: 4.555517475527901
;;; trying guess: 4.555547727376273
;;; trying guess: 4.555527776815261
;;; found fixed point: 4.555540933824255
;;; trying guess: 3
;;; trying guess: 4.643854911434076
;;; trying guess: 4.571212264484558
;;; trying guess: 4.558225323866829
;;; trying guess: 4.555994244552759
;;; trying guess: 4.555613793442989
;;; trying guess: 4.5555490009596555
;;; found fixed point: 4.55553796893792654.555540933824255
;;; 4.5555379689379265