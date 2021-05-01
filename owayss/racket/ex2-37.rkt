#lang sicp

(define (accumulate op initial seq)
  (if (null? seq) initial
      (op (car seq) (accumulate op initial (cdr seq)))))

(define (dot-product v w)
  ; (define (comb op l1 l2)
  ;   (if (null? l2) l1
  ;       (cons (op (car l1) (car l2)) (comb op (cdr l1) (cdr l2)))))

  ; (accumulate + 0 (comb * v w)))
  (accumulate + 0 (map * v w)))

(dot-product (list 1 2 3) (list 4 -5 6))

; Output:
; $ sicp ex2-37.rkt
; 12

(define (matrix-*-vector m v)
  (map (lambda (row) (dot-product row v)) m))


(define A (list (list 1 2 3) (list 4 5 6) (list 7 8 9)))
(define y (list 2 1 3))
(matrix-*-vector A y)

; Output:
; $ sicp ex2-37.rkt
; 12
; (13 31 49)

(define (accumulate-n op initial seqs)
  (if (null? (car seqs)) nil
      (cons (accumulate op initial (map (lambda (seq) (car seq)) seqs)) (accumulate-n op initial (map (lambda (seq) (cdr seq)) seqs)))))


(define (matrix-*-matrix m n)
  ; (map (lambda (m-row)
  ;        (map (lambda (n-col) (dot-product m-row n-col))
  ;             (accumulate-n cons nil n)))
  ;      m))
  (define (transpose-mat m)
    (accumulate-n cons nil m))

  (let ((n-transposed (transpose-mat n)))
    (map (lambda (row) (map (lambda (col) (dot-product row col)) n-transposed)) m)))



(define M (list (list 1 2 3) (list 4 5 6)))
(define N (list (list 7 8) (list 9 10) (list 11 12)))
(matrix-*-matrix M N)

; Output:
; $ sicp ex2-37.rkt
; 12
; (13 31 49)
; ((58 64) (139 154))

