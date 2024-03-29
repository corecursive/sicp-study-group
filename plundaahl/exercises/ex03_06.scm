;; *Exercise 3.6:* It is useful to be able to reset a random-number
;; generator to produce a sequence starting from a given value.
;; Design a new `rand' procedure that is called with an argument that
;; is either the symbol `generate' or the symbol `reset' and behaves
;; as follows: `(rand 'generate)' produces a new random number;
;; `((rand 'reset) <NEW-VALUE>)' resets the internal state variable
;; to the designated <NEW-VALUE>.  Thus, by resetting the state, one
;; can generate repeatable sequences.  These are very handy to have
;; when testing and debugging programs that use random numbers.

;; a not-very-good random function
(define (rand-update prev-value)
  (modulo (+ (* prev-value 2153)
		8512)
	     100))

;; actual implementation
(define (rand x)
  (define (generate)
    (set! x (rand-update x))
    x)
  (define (reset seed)
    (set! x seed)
    #t)
  (define (dispatch m)
    (cond ((eq? m 'generate) (generate))
	  ((eq? m 'reset) reset)
	  (else (error "invalid message -- RAND" m))))
  dispatch)

;; tests
(define my-rand (rand 27))
(my-rand 'generate)
((my-rand 'reset) 27)
