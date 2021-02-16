#lang sicp

(define (cube x)
 (* (* x x) x))

(define (p x)
  (- (* 3 x) (* 4 (cube x))))

(define (sine angle)
  (cond ((< angle 0.1) angle)
        (else (p (sine (/ angle 3.0))))))


(sine 12.5)

; a. for (sine 12.5), the procedure p is called 5 times.
; b. order of growth:
;    - in time: each call to sine reduces angle to one third of its value.
;               it will take log base 3 of angle to get angle to "1".
;               the recursion stops when angle is < 0.1.
;               O(n) = log(3, angle) + 3
;                    = log(3, angle)
;    - in space: O(log(3, angle)) too.