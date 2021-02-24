#lang sicp

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))


; using normal-order evaluation:

; (gcd 206 40)
; (if (= 40 0) 206 (gcd 40 (remainder 206 40)))
; (if (= (remainder 206 40) 0) 40 (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))))
(remainder 206 40)                                                                                              ; 1
; (if (= (remainder 40 (remainder 206 40)) 0) (remainder 206 40) (gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
(remainder 40 (remainder 206 40))                                                                               ; 2
; (if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0) (remainder 40 (remainder 206 40)) (gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))))
(remainder (remainder 206 40) (remainder 40 (remainder 206 40)))                                                ; 4
; (if (= (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))) 0) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (gcd (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))) (remainder (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))))))
(remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))  ; 7
(remainder (remainder 206 40) (remainder 40 (remainder 206 40)))                                                ; 4
2                                                                                                               ; 1 + 2 + 4 + 7 + 4 = 18 calls to remainder.


; using applicative-order:

; (gcd 206 40)
; (if (= 40 0) 260 (gcd 40 (remainder 206 40)))       ; (remainder 206 40)
; (if (= 40 0) 260 (gcd 40 6))
; (gcd 40 6)
; (if (= 6 0) 40 (gcd 6 (remainder 40 6)))            ; (remainder 40 60)
; (if (= 6 0) 40 (gcd 6 4))
; (gcd 6 4)
; (if (= 4 0) 6 (gcd 4 (remainder 6 4)))              ; (remainder 6 4)
; (if (= 4 0) 6 (gcd 4 2))
; (gcd 4 2)
; (if (= 2 0) 4 (gcd 2 (remainder 4 2)))              ; (remainder 4 2)
; (if (= 2 0) 4 (gcd 2 0))
; (gcd 2 0)
; (if (= 0 0) 2 (gcd 0 (remainder 2 0)))
; 2

                                                      ; 1 + 1 + 1 + 1 = 4 calls to remainder.