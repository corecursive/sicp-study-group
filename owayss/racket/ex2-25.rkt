#lang sicp


(car (cdr (car (cdr (cdr
  (list 1 3 (list 5 7) 9))))))

(car (car
(list (list 7))))

(car (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr
(list 1 (list 2 (list 3 (list 4 (list 5 (list 6 (list 7))))))))))))))))))))

; Output:
; $ racket -I sicp ex2-25.rkt
; 7
; 7
; 7
