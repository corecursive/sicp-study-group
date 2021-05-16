;;     *Exercise 2.40:* Define a procedure `unique-pairs' that, given an
;;     integer n, generates the sequence of pairs (i,j) with 1 <= j< i <=
;;     n.  Use `unique-pairs' to simplify the definition of
;;     `prime-sum-pairs' given above.


;; GIVEN DEFINITIONS
(define (remove item sequence)
  (filter (lambda (x) (not (= x item)))
          sequence))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime? n)
  (define (smallest-divisor n) (find-divisor n 2))
  (define (divides? a b) (= (remainder b a) 0))
  (define (next n) (if (= n 2) 3 (+ n 2)))
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (next test-divisor)))))
  (= n (smallest-divisor n)))

;; ANSWER
(define (enumerate-interval a b)
  (define (iter a b acc)
    (if (> a b)
	acc
	(iter (+ a 1) b (append acc (list a)))))
  (iter a b '()))

(define (unique-pairs n)
  (flatmap
   (lambda (i)
     (map (lambda (j) (list i j))
	  (enumerate-interval 1 (- i 1))))
   (enumerate-interval 1 n)))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
	       (unique-pairs n))))

(unique-pairs 4)
(prime-sum-pairs 7)
