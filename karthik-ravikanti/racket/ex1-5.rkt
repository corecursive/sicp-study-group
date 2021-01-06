#lang sicp

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

(test 0 (p))

;; Applicative-order evaluation

;; (#eval-> test 0 (p))
;; ((if (= x 0) 0 y) #eval-> 0 (p))
;; ((if (= x 0) 0 y) 0 #eval-> (p))
;; ((if (= x 0) 0 y) 0 #eval-> (p))
;; ((if (= x 0) 0 y) 0 #eval-> (p))
;; ..
;; ..
;; ad infinitum

;; Normal-order evaluation
;; (#eval-> test 0 (p))
;; #subst-> ((if (= x 0) 0 y) 0 (p))
;; (if #eval-> (= 0 0) 0 (p))
;;(if #t  #eval-> 0 (p))
;; 0
