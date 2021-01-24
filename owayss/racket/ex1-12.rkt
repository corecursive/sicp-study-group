#lang sicp

(define (pascal k)
  (define l (row-col k))
  (_pascal (car l) (car (cdr l))))

(define (_pascal i j)
  (cond ((and (= j 0) (= i 0)) 1)
        ((or (< j 0) (> j i)) 0)
        (else (+ (_pascal (- i 1) (- j 1)) (_pascal (- i 1) j)))))

(define (row-col k)
  (define (row-col-iter k i j n)
    (cond ((= k 0) (list i j))
          (else (cond ((= j (- n 1)) (row-col-iter (- k 1) (+ i 1) 0 (+ n 1)))
                    (else (row-col-iter (- k 1) i (+ j 1) n))))))
                    
  (row-col-iter k 0 0 1))