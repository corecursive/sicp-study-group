;; Exercise 2.90.
;;
;; Suppose we want to have a polynomial system that is efficient for
;; both sparse and dense polynomials. One way to do this is to allow
;; both kinds of term-list representations in our system. The
;; situation is analogous to the complex-number example of section
;; 2.4, where we allowed both rectangular and polar
;; representations. To do this we must distinguish different types of
;; term lists and make the operations on term lists generic. Redesign
;; the polynomial system to implement this generalization. This is a
;; major effort, not a local change.

(load "exercise-2.37.scm")

;; Representing dense polynomials

(define (make-dense* var term-list)
  (cons var term-list))

(define var car)
(define term-list cdr)

(define (make-term-list term-list min-order)
  (if (>= (order term-list) min-order)
      term-list
      (append (make-list (- min-order (order term-list)) 0)
              term-list)))

(define (order term-list)
  (-1+ (length term-list)))


;; Dense polynomial operations

(define (same-var? p1 p2)
  (eq? (var p1)
       (var p2)))

(define (+dense p1 p2)
  (if (same-var? p1 p2)
      (make-dense*
       (var p1)
       (+terms (term-list p1)
               (term-list p2)))
      (error "Polys not in same var")))

(define (*dense p1 p2)
  (if (same-var? p1 p2)
      (make-dense*
       (var p1)
       (*terms (term-list p1)
               (term-list p2)))
      (error "Polys not in same var")))


;; Term list operations
;; https://www.le.ac.uk/users/dsgp1/COURSES/THIRDMET/MYLECTURES/9XMATRIPOL.pdf

(define (+terms L1 L2)
  (cond ((> (order L1) (order L2))
         (+terms L1 (make-term-list L2 (order L1))))
        ((< (order L1) (order L2))
         (+terms (make-term-list L1 (order L2)) L2))
        (else
         (sum-vector L1 L2))))

(define (*terms L1 L2)
  (convolution L1 L2))


;; Matrix operations

(define (sum-vector v w)
  (map + v w))

;; https://en.wikipedia.org/wiki/Toeplitz_matrix#Discrete_convolution
(define (convolution v w)
  (let ((T (make-toeplitz-matrix v (length w))))
    (matrix-*-vector T w)))

(define (make-toeplitz-matrix vect width)
  (define zero (make-list (-1+ width) 0))
  (define sequence (reverse (append zero vect zero)))
  (define (chunk seq size)
    (if (>= size (length seq))
        (list seq)
        (cons (take-right seq size)
              (chunk (drop-right seq 1) size))))
  (chunk sequence width))


;; Support mechanism for manifest types

(define (attach-type type contents)
  (cons type contents))

(define (type datum)
  (car datum))

(define (contents datum)
  (cdr datum))


;; A global two-dimensional association table provided by MIT/GNU
;; Scheme

(define (put key1 key2 value)
  (2d-put! key1 key2 value))

(define (get key1 key2)
  (2d-get key1 key2))


;; Dense package registration

(define (tag-dense p)
  (attach-type 'dense p))

(put 'dense 'make
      (lambda (v t) (tag-dense (make-dense* v t))))
(put 'dense 'add
      (lambda (p1 p2) (tag-dense (+dense p1 p2))))
(put 'dense 'mul
      (lambda (p1 p2) (tag-dense (*dense p1 p2))))


;; Generic operator

(define (operate-2 op obj1 obj2)
  (if (eq? (type obj1) (type obj2))
      (let ((proc (get (type obj1) op)))
        (if proc
            (proc (contents obj1)
                  (contents obj2))
            (error "Undefined OP")))
      (error "Args not same type")))


;; Generic operations

(define (make-dense var term-list)
  ((get 'dense 'make) var term-list))

(define (add x y)
  (operate-2 'add x y))

(define (mul x y)
  (operate-2 'mul x y))


;; Tests

(define p1 (make-dense 'x '(3 2 1)))
(define p2 (make-dense 'x '(1 2)))
(define p3 (add p1 p2))
(define p4 (mul p1 p2))

(assert (eq? (type p3) 'dense))
(assert (eq? (var (contents p3)) 'x))
(assert (equal? (term-list (contents p3)) '(3 3 3)))

(assert (eq? (type p4) 'dense))
(assert (eq? (var (contents p4)) 'x))
(assert (equal? (term-list (contents p4)) '(3 8 5 2)))
