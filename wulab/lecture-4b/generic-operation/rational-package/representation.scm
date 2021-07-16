(define (make-rat n d)
  (define g (gcd n d))
  (cons (/ n g)
        (/ d g)))

(define (numer x)
  (car x))

(define (denom x)
  (cdr x))
