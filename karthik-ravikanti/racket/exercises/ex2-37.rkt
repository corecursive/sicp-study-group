#lang sicp

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

;; Exercise 2.37
;; .............

;; Suppose we represent vectors v = (v_i) as sequences of numbers, and
;; matrices m = (m_(ij)) as sequences of vectors (the rows of the matrix).
;; For example, the matrix

;;      +-         -+
;;      |  1 2 3 4  |
;;      |  4 5 6 6  |
;;      |  6 7 8 9  |
;;      +-         -+

;; is represented as the sequence `((1 2 3 4) (4 5 6 6) (6 7 8 9))'.  With
;; this representation, we can use sequence operations to concisely
;; express the basic matrix and vector operations.  These operations
;; (which are described in any book on matrix algebra) are the following:

;;    We can define the dot product as(4)

(define v (list 1 2 3 4))

(define w (list 6 7 8 9))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(dot-product v w) ; 80

;;    Fill in the missing expressions in the following procedures for
;; computing the other matrix operations.  (The procedure `accumulate-n'
;; is defined in *Note Exercise 2-36::.)

(define m (list (list 1 2 3 4) (list 4 5 6 6) (list 6 7 8 9)))

(define (matrix-*-vector m v)
  (map (lambda (c) (dot-product c v)) m))

(matrix-*-vector m v)                   ; (30, 56, 80)

(define (transpose mat)
  (accumulate-n cons nil mat))

(transpose m)                      ; ((1 4 6) (2 5 7) (3 6 8) (4 6 9))

(define n (transpose m))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (c) (matrix-*-vector cols c)) m)))

(matrix-*-matrix m n)         ; ((30 56 80) (56 113 161) (80 161 230))
