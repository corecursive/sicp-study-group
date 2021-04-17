(define x
  (list (list (list 1 2) (list 3 4)) (list 5 6)))

;; Thanks @prsdta!
(define (deep-reverse orig-list)
  (define (iter lst acc)
    (cond ((null? lst) acc)
          ((not (pair? lst)) lst)
          (else (iter (cdr lst)
                      (cons (deep-reverse (car lst)) acc)))))
  (iter orig-list '()))

(deep-reverse x)
