;; Exercise 3.4.
;;
;; Modify the make-account procedure of exercise 3.3 by adding another
;; local state variable so that, if an account is accessed more than
;; seven consecutive times with an incorrect password, it invokes the
;; procedure call-the-cops.

(define (make-account balance password)
  (define password-attempts 0)
  (define (incorrect-password amount)
    (set! password-attempts (1+ password-attempts))
    (if (> password-attempts 7)
        (call-the-cops)
        "Incorrect password"))
  (define (call-the-cops)
    "The police have been called")
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! password-attempts 0)
               (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! password-attempts 0)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch p m)
    (cond ((not (eq? p password)) incorrect-password)
          ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else
           (error "Unknown request -- MAKE-ACCOUNT"
                  m))))
  dispatch)


(define acc (make-account 100 'secret-password))

(assert (= 60 ((acc 'secret-password 'withdraw) 40)))
(assert (equal? "Incorrect password"
                ((acc 'some-other-password 'deposit) 50)))
(assert (equal? "Incorrect password"
                ((acc 'some-other-password 'deposit) 50)))
(assert (equal? "Incorrect password"
                ((acc 'some-other-password 'deposit) 50)))
(assert (equal? "Incorrect password"
                ((acc 'some-other-password 'deposit) 50)))
(assert (equal? "Incorrect password"
                ((acc 'some-other-password 'deposit) 50)))
(assert (equal? "Incorrect password"
                ((acc 'some-other-password 'deposit) 50)))
(assert (equal? "Incorrect password"
                ((acc 'some-other-password 'deposit) 50)))
(assert (equal? "The police have been called"
                ((acc 'some-other-password 'deposit) 50)))
