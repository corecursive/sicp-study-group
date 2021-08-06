(load "type.scm")
(load "table.scm")

;; Generic operator

(define (operate op obj)
  (let ((proc (get (type obj) op)))
    (if proc
        (proc (contents obj))
        (error "Undefined OP"))))

(define (operate-2 op obj1 obj2)
  (if (eq? (type obj1) (type obj2))
      (let ((proc (get (type obj1) op)))
           (if proc
               (proc (contents obj1)
                     (contents obj2))
               (error "Undefined OP")))
      (error "Args not same type")))
