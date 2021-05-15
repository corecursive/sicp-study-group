#lang sicp

(define (prime-sum-pairs n)
  (filter (lambda (pair) (prime? (+ (car pair) (cdr pair)))) (unique-pairs n)))

(define (unique-pairs n)
  (accumulate append nil
              (map (lambda (i)
                     (map (lambda (j) (cons i j)) (enumerate-interval 1 i))) (enumerate-interval 1 (+ n 1)))))

(define (enumerate-interval a b)
  (define (iter n)
    (if (= n b) nil (cons n (iter (+ n 1)))))
  (iter a))


(define (fold-right op initial seq)
  (if (null? seq) initial
      (op (car seq) (fold-right op initial (cdr seq)))))

(define accumulate fold-right)

(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
  (define (next n)
    (cond ((= 2 n) 3)
          (else (+ 2 n))))
  (define (smallest-divisor-iter n a)
    (cond ((> (square a) n) n)
          ((= 0 (remainder n a)) a)
          (else (smallest-divisor-iter n (next a)))))
  (smallest-divisor-iter n 2))

(define (square x) (* x x))

(define (filter pred seq)
  (if (null? seq) nil
      (let ((head (car seq)))
        (if (pred head) (cons head (filter pred (cdr seq)))
            (filter pred (cdr seq))))))


(prime-sum-pairs 10)

; Output:
; $ sicp ex2-40.rkt
; ((2 . 1) (3 . 2) (4 . 1) (4 . 3) (5 . 2) (6 . 1) (6 . 5) (7 . 4) (7 . 6) (8 . 3) (8 . 5) (9 . 2) (9 . 4) (9 . 8) (10 . 1) (10 . 3) (10 . 7) (10 . 9))

