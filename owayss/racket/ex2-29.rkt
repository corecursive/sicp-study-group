#lang sicp

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch m) (car m))
(define (right-branch m) (car (cdr m)))
(define (branch-length b) (car b))
(define (branch-structure b) (car (cdr b)))


(define (total-weight mobile)
  (if (not (pair? mobile)) mobile (+
                                    (total-weight (branch-structure (left-branch mobile)))
                                    (total-weight (branch-structure (right-branch mobile))))))


;(define l (make-branch 1 3))
;(define r (make-branch 1 5))
;(define m (make-mobile l r))

; Output:
; $ sicp ex2-29.rkt
; 8


; This procedure short-circuits correctly when a sub-tree is not balanced,
; as it is recursively called on the subtrees first.
;
; However, the procedure `torque` does repeated work: after the sub-trees are evaluated
; each time we pop one call off the stack, torque will then have to calculate
; those same values again (traversing the sub-trees again).
;
(define (balanced? m)
  (define (torque b)
    (if (null? b) 0 (* (branch-length b) (if (not (pair? (branch-structure b))) (branch-structure b) (+ (torque (left-branch (branch-structure b)))
                                                                                                        (torque (right-branch (branch-structure b))))))))

  (if (or (null? m) (not (pair? m)) (null? (branch-structure m)) (not (pair? (branch-structure m)))) #t
      (let ((l (left-branch m)) (r (right-branch m)))
        (and (balanced? (branch-structure l))
             (balanced? (branch-structure r))
             (= (torque l) (torque r))))))



; A better approach would be to propogate the values of applying torque
; to each sub-tree the calls return.
; -1 to signal an unbalanced sub-tree to short-circuit the execution in order
; to avoid unnecessary calculations.
(define (efficient-balanced? m)
  (define (torque b)
    (if (not (pair? (branch-structure b)))
        (* (branch-length b) (branch-structure b))
        (let ((l (torque (left-branch (branch-structure b)))))
          (if (= l -1)
              -1
              (let ((r (torque (right-branch (branch-structure b)))))
                (if (or (= r -1) (not (= l r))) -1
                    (* (branch-length b) (+ l r))))))))

  (or (null? m)
      (let ((l (torque (left-branch m))))
        (if (= l -1)
            #f
            (let ((r (torque (right-branch m))))
              (if (= r -1) #f
                  (= l r)))))))



(define l (make-branch 1 8))
(define r (make-branch 2 4))
(define m (make-mobile l r))
(define rr (make-branch 2 m))
(define ll (make-branch 2 m))
(define mm (make-mobile ll rr))

(balanced? nil)
(balanced? m)
(balanced? mm)
(newline)
(efficient-balanced? nil)
(efficient-balanced? m)
(efficient-balanced? mm)
(newline)

; Output:
; $ sicp ex2-29.rkt
; #t
; #t
; #t
;
; #t
; #t
; #t
;



; We trace the calls made to each `torque` procedure to illustrate the difference:

(define (balanced-v1? m)
  (define (torque b)
    (display "(torque ")
    (display b)
    (display ")")
    (newline)
    (if (null? b) 0 (* (branch-length b) (if (not (pair? (branch-structure b))) (branch-structure b) (+ (torque (left-branch (branch-structure b)))
                                                                                                        (torque (right-branch (branch-structure b))))))))

  (if (or (null? m) (not (pair? m)) (null? (branch-structure m)) (not (pair? (branch-structure m)))) #t
      (let ((l (left-branch m)) (r (right-branch m)))
        (and (balanced-v1? (branch-structure l))
             (balanced-v1? (branch-structure r))
             (= (torque l) (torque r))))))


(define (balanced-v2? m)
  (define (torque b)
    (display "(torque ")
    (display b)
    (display ")")
    (newline)
    (if (not (pair? (branch-structure b)))
        (* (branch-length b) (branch-structure b))
        (let ((l (torque (left-branch (branch-structure b)))))
          (if (= l -1)
              -1
              (let ((r (torque (right-branch (branch-structure b)))))
                (if (or (= r -1) (not (= l r))) -1
                    (* (branch-length b) (+ l r))))))))

  (or (null? m)
      (let ((l (torque (left-branch m))))
        (if (= l -1)
            #f
            (let ((r (torque (right-branch m))))
              (if (= r -1) #f
                  (= l r)))))))


(display "(balanced-v1? mm)")
(newline)
(balanced-v1? mm)
(newline)
(display "(balanced-v2? mm)")
(newline)
(balanced-v2? mm)
(newline)


; Output:
; $ sicp ex2-29.rkt
; #t
; #t
; #t
;
; #t
; #t
; #t
;
; (balanced-v1? mm)
; (torque (1 8))
; (torque (2 4))
; (torque (1 8))
; (torque (2 4))
; (torque (2 ((1 8) (2 4))))
; (torque (1 8))
; (torque (2 4))
; (torque (2 ((1 8) (2 4))))
; (torque (1 8))
; (torque (2 4))
; #t
;
; (balanced-v2? mm)
; (torque (2 ((1 8) (2 4))))
; (torque (1 8))
; (torque (2 4))
; (torque (2 ((1 8) (2 4))))
; (torque (1 8))
; (torque (2 4))
; #t



; Exercise d
;
; If the representation is changed to:
;
; (define (make-mobile left right)
;   (cons left right))
; (define (make-branch length structure)
;   (cons length structure))

; Only the selectors for the cdr part of the pair need to be changed accordingly:
;
; (define (right-branch m) (cdr m))
; (define (branch-structure b) (cdr b))
