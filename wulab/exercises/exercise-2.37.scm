;; Exercise 2.37.
;;
;; Suppose we represent vectors v = (vi) as sequences of numbers, and
;; matrices m = (mij) as sequences of vectors (the rows of the
;; matrix). For example, the matrix
;;
;;   | 1 2 3 4 |
;;   | 4 5 6 6 |
;;   | 6 7 8 9 |
;;
;; is represented as the sequence ((1 2 3 4) (4 5 6 6) (6 7 8
;; 9)). With this representation, we can use sequence operations to
;; concisely express the basic matrix and vector operations. These
;; operations (which are described in any book on matrix algebra) are
;; the following:
;;
;;   (dot-product v w)      returns the sum sigma v(i) w(i)
;;   (matrix-*-vector m v)  returns the vector t where t(i) = sigma m(i,j) v(j,i)
;;   (matrix-*-matrix m n)  returns the matrix p where p(i,j) = sigma m(i,k) n(k,j)
;;   (transpose m)          returns the matrix n where n(i,j) = m(j,i)
;;
;; We can define the dot product as
;;
;;   (define (dot-product v w)
;;     (accumulate + 0 (map * v w)))
;;
;; Fill in the missing expressions in the following procedures for
;; computing the other matrix operations. (The procedure accumulate-n
;; is defined in exercise 2.36.)
;;
;;   (define (matrix-*-vector m v)
;;     (map <??> m))
;;
;;   (define (transpose mat)
;;     (accumulate-n <??> <??> mat))
;;
;;   (define (matrix-*-matrix m n)
;;     (let ((cols (transpose n)))
;;       (map <??> m)))
;;

(load "exercise-2.36.scm")

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (u) (dot-product u v)) m))

;; (define (transpose m)
;;   (if (null? (car m))
;;       nil
;;       (cons (map car m)
;;         (transpose (map cdr m)))))

(define (transpose m)
  (accumulate-n cons nil m))

;; (define (matrix-*-matrix m n)
;;   (transpose
;;    (map (lambda (v)
;;           (matrix-*-vector m v))
;;         (transpose n))))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row)
           (matrix-*-vector cols row))
         m)))


(define m '((1 2 3 4) (4 5 6 6) (6 7 8 9)))
(define n '((1 1) (1 1) (1 1) (1 1)))
(define v '(1 1 1 1))

(assert (= 10 (dot-product (car m) v)))
(assert (equal? '(10 21 30) (matrix-*-vector m v)))
(assert (equal? '((1 4 6) (2 5 7) (3 6 8) (4 6 9)) (transpose m)))
(assert (equal? '((10 10) (21 21) (30 30)) (matrix-*-matrix m n)))

;; https://www.mathsisfun.com/algebra/matrix-multiplying.html
(define a '((1 2 3)))
(define b '((4) (5) (6)))
(define c '((3 4 2)))
(define d '((13 9 7 15) (8 7 4 6) (6 4 0 3)))

(assert (equal? '((32)) (matrix-*-matrix a b)))
(assert (equal? '((4 8 12) (5 10 15) (6 12 18)) (matrix-*-matrix b a)))
(assert (equal? '((83 63 37 75)) (matrix-*-matrix c d)))
