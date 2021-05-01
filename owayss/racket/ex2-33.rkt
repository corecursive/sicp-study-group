#lang sicp

(define (accumulate op acc seq)
  (if (null? seq) acc
      (op (car seq) (accumulate op acc (cdr seq)))))

(define (append seq1 seq2)
  (accumulate cons seq2 (accumulate cons nil seq1)))

(append (list 1 2 3) (list 4 5 6))
(append nil (list 1 2 3))
(append (list 1 2 3) nil)

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y))
              nil sequence))

(map (lambda (x) (* 2 x)) nil)
(map (lambda (x) (* 2 x)) (list 1))
(map (lambda (x) (* 2 x)) (list 1 2 3))

(define (length sequence)
  (accumulate (lambda (x y) (inc y)) 0 sequence))

(length nil)
(length (list 1))
(length (list 1 2))

; Output:
;
; $ sicp ex2-33.rkt
; (1 2 3 4 5 6)
; (1 2 3)
; (1 2 3)
; ()
; (2)
; (2 4 6)
; 0
; 1
; 2
