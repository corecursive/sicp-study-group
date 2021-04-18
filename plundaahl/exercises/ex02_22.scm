;;     *Exercise 2.22:* Louis Reasoner tries to rewrite the first
;;     `square-list' procedure of *Note Exercise 2-21:: so that it
;;     evolves an iterative process:
;;
;;          (define (square-list items)
;;            (define (iter things answer)
;;              (if (null? things)
;;                  answer
;;                  (iter (cdr things)
;;                        (cons (square (car things))
;;                              answer))))
;;            (iter items nil))
;;
;;     Unfortunately, defining `square-list' this way produces the answer
;;     list in the reverse order of the one desired.  Why?
;;
;;     Louis then tries to fix his bug by interchanging the arguments to
;;     `cons':
;;
;;          (define (square-list items)
;;            (define (iter things answer)
;;              (if (null? things)
;;                  answer
;;                  (iter (cdr things)
;;                        (cons answer
;;                              (square (car things))))))
;;            (iter items nil))
;;
;;     This doesn't work either.  Explain.

;; ANSWER
;; In the first version, the iterative process begins consing up the list
;; starting with the first element. This means that the first element will
;; be the most deeply-nested item in the list, the second element will be
;; the second most-deeply-nested item, etc.

;; In the second version, the result is nested via the `car' of each pair,
;; not the `cdr'. E.g.:

(cons
 (cons
  (cons
   (cons '() 1)
   4)
  9)
 16)

;; The solution is to reverse the list after performing the map.
