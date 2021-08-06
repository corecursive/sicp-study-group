;; *Exercise 3.4:* Modify the `make-account' procedure of *Note
;; Exercise 3-3:: by adding another local state variable so that, if
;; an account is accessed more than seven consecutive times with an
;; incorrect password, it invokes the procedure `call-the-cops'.

;; IMPL
(define (call-the-cops) (error "Weeooweeooweeooo!"))

(define (make-account balance password)
  ;; Same internal methods
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  ;; Add `pass' to dispatch
  (let ((num-failed-attempts 0))
    (define (dispatch pass m)
      (if (eq? password pass) ;; check password
	  ;; Same dispatch
	  (begin
	    (set! num-failed-attempts 0)
            (cond ((eq? m 'withdraw) withdraw)
		  ((eq? m 'deposit) deposit)
		  (else (error "Unknown request -- MAKE-ACCOUNT"
                               m))))
	  ;; error for incorrect passwords
	  (begin
	    (set! num-failed-attempts (+ 1 num-failed-attempts))
	    (if (< num-failed-attempts 8)
		(error "Incorrect password")
		(call-the-cops)))))
    dispatch))

;; Tests
(define acc (make-account 50 'password))
((acc 'password 'withdraw) 10)
((acc 'wrong-pass 'withdraw) 10)
