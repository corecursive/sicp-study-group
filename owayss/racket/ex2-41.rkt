#lang sicp


(define (triple-sums-s n s)
  (filter (lambda (triple) (= s (fold-right + 0 triple))) (ordered-triples n)))


(define (filter pred seq)
  (if (null? seq) nil
      (let ((head (car seq)))
        (if (pred head) (cons head (filter pred (cdr seq))) (filter pred (cdr seq))))))


(define (fold-right op initial seq)
  (if (null? seq) initial
      (op (car seq) (fold-right op initial (cdr seq)))))


(define (ordered-triples n)
  (fold-right append nil
              (map (lambda (i)
                     (fold-right append nil
                                 (map (lambda (j)
                                        (map (lambda (k) (list i j k))
                                             (enumerate-interval 1 j)))
                                      (enumerate-interval 1 i))))
                   (enumerate-interval 1 (+ 1 n)))))


(define (enumerate-interval a b)
  (define (iter n)
    (if (= n b) nil
        (cons n (iter (+ 1 n)))))
  (iter a))



(triple-sums-s 20 42)

; Output:
; $ sicp ex2-41.rkt
; ((15 14 13) (16 14 12) (16 15 11) (17 13 12) (17 14 11) (17 15 10) (17 16 9) (18 13 11) (18 14 10) (18 15 9) (18 16 8) (18 17 7) (19 12 11) (19 13 10) (19 14 9) (19 15 8) (19 16 7) (19 17 6) (19 18 5) (20 12 10) (20 13 9) (20 14 8) (20 15 7) (20 16 6) (20 17 5) (20 18 4) (20 19 3))


