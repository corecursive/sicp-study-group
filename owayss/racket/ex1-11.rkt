#lang sicp

; f(n) = 
;        n                                 if n < 3
;        f(n-1) + 2f(n-2) + 3f(n-3)        otherwise


;;; (define (f n)
;;;   (cond ((< n 3) n)
;;;         (else (+ (f (- n 1))
;;;                  (* 2 (f (- n 2)))
;;;                  (* 3 (f (- n 3)))))))


(define (f n)
  (cond ((< n 3) n)
        (else (f-iter 2 1 0 (- n 3)))))

(define (f-iter a b c i)
  (cond ((< i 0) a)
        (else (f-iter (+
                       a
                       (* 2 b)
                       (* 3 c))
                       a
                       b
                       (- i 1)
                       ))))