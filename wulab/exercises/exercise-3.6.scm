;; Exercise 3.6.
;;
;; It is useful to be able to reset a random-number generator to
;; produce a sequence starting from a given value. Design a new rand
;; procedure that is called with an argument that is either the symbol
;; generate or the symbol reset and behaves as follows: (rand
;; 'generate) produces a new random number; ((rand 'reset)
;; <new-value>) resets the internal state variable to the designated
;; <new-value>. Thus, by resetting the state, one can generate
;; repeatable sequences. These are very handy to have when testing and
;; debugging programs that use random numbers.

(define random-init (real-time-clock))

(define (rand-update x)
  (let ((a 1299817)
        (b 1299821)
        (m 1299827))
    (modulo (+ (* a x) b) m)))

(define (make-rand)
  (define x random-init)
  (define (generate)
    (set! x (rand-update x))
    x)
  (define (reset new-value)
    (set! x new-value)
    x)
  (define (dispatch m)
    (cond ((eq? m 'generate) (generate))
          ((eq? m 'reset) reset)
          (else (error "Unknown request"))))
  dispatch)

(define rand (make-rand))


(assert (= 100 ((rand 'reset) 100)))
(assert (= 1298821 (rand 'generate)))
(assert (= 10054 (rand 'generate)))
(assert (= 1199281 (rand 'generate)))
