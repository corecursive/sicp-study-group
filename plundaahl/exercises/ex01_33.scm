;;     *Exercise 1.33:* You can obtain an even more general version of
;;     `accumulate' (*Note Exercise 1-32::) by introducing the notion of
;;     a "filter" on the terms to be combined.  That is, combine only
;;     those terms derived from values in the range that satisfy a
;;     specified condition.  The resulting `filtered-accumulate'
;;     abstraction takes the same arguments as accumulate, together with
;;     an additional predicate of one argument that specifies the filter.
;;     Write `filtered-accumulate' as a procedure.

(define (filtered-accumulate filter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
	result
	(iter (next a)
	      (if (filter a)
		  (combiner result (term a))
		  result))))
  (iter a null-value))

(define (sum-evens a b)
  (define (inc n) (+ n 1))
  (define (identity n) n)
  (define (even? n) (= (remainder n 2) 0))
  (filtered-accumulate even? + 0 identity a inc b))

(sum-evens 0 3)
(sum-evens 0 4)
(sum-evens 0 5)
(sum-evens 0 8)
(sum-evens 0 12)

;;     Show how to express the following using `filtered-accumulate':
;;
;;       a. the sum of the squares of the prime numbers in the interval a
;;          to b (assuming that you have a `prime?' predicate already
;;          written)

(define (sum-square-primes a b)
  (define (inc n) (+ n 1))
  (filtered-accumulate prime? + 0 square a inc b))

(define (prime? n)
  (define (smallest-divisor n) (find-divisor n 2))
  (define (divides? a b) (= (remainder b a) 0))
  (define (next n) (if (= n 2) 3 (+ n 2)))
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (next test-divisor)))))
  (= n (smallest-divisor n)))

(sum-square-primes 3 3)
(sum-square-primes 5 5)
(sum-square-primes 7 7)
(sum-square-primes 3 7)

;;       b. the product of all the positive integers less than n that are
;;          relatively prime to n (i.e., all positive integers i < n such
;;          that GCD(i,n) = 1).
