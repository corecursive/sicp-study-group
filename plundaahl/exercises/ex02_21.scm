;;     *Exercise 2.21:* The procedure `square-list' takes a list of
;;     numbers as argument and returns a list of the squares of those
;;     numbers.
;;
;;          (square-list (list 1 2 3 4))
;;          (1 4 9 16)
;;
;;     Here are two different definitions of `square-list'.  Complete
;;     both of them by filling in the missing expressions:
;;
;; VERSION 1
;;
;;          (define (square-list items)
;;            (if (null? items)
;;                nil
;;                (cons <??> <??>)))

(define (square x) (* x x))
(define l (list 1 2 3 4))

(define (square-list-explicit items)
  (if (null? items)
      items
      (cons (square (car items)) (square-list-v1 (cdr items)))))

(square-list-explicit l)

;; VERSION 2
;;
;;          (define (square-list items)
;;            (map <??> <??>))

(define (square-list-map items)
  (map square items))

(square-list-map l)
