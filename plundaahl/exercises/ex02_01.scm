;;     *Exercise 2.1:* Define a better version of `make-rat' that handles
;;     both positive and negative arguments.  `Make-rat' should normalize
;;     the sign so that if the rational number is positive, both the
;;     numerator and denominator are positive, and if the rational number
;;     is negative, only the numerator is negative.

;; Given version
(define (make-rat-original n d)
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))))

;; Helpers / Library
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(define (numer x) (car x))

(define (denom x) (cdr x))

;;;;;;;;;;;;;;
;; SOLUTION ;;
;;;;;;;;;;;;;;

(define (make-rat n d)
  (let ((n-abs (abs n))
	(d-abs (abs d))
	(magnitude (if (< 0 (* n d)) 1 -1)))
    (let ((g (gcd n-abs d-abs)))
      (cons (* (/ n-abs g) magnitude)
	    (/ d-abs g)))))

(make-rat 25 5)
(make-rat -36 4)
(make-rat -1 -3)
