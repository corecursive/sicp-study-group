;; *Exercise 2.77:* Louis Reasoner tries to evaluate the expression
;; `(magnitude z)' where `z' is the object shown in *Note Figure
;; 2-24::.  To his surprise, instead of the answer 5 he gets an error
;; message from `apply-generic', saying there is no method for the
;; operation `magnitude' on the types `(complex)'.  He shows this
;; interaction to Alyssa P. Hacker, who says "The problem is that the
;; complex-number selectors were never defined for `complex' numbers,
;; just for `polar' and `rectangular' numbers.  All you have to do to
;; make this work is add the following to the `complex' package:"

;;      (put 'real-part '(complex) real-part)
;;      (put 'imag-part '(complex) imag-part)
;;      (put 'magnitude '(complex) magnitude)
;;      (put 'angle '(complex) angle)

;; Describe in detail why this works.  As an example, trace through
;; all the procedures called in evaluating the expression `(magnitude
;; z)' where `z' is the object shown in *Note Figure 2-24::.  In
;; particular, how many times is `apply-generic' invoked?  What
;; procedure is dispatched to in each case?

(define z '(complex '(rectangular '(3 4))))

;; BEFORE MODIFYING THE COMPLEX PACKAGE
;; (magnitude z)
;;   (apply-generic 'magnitude z)
;;     (map type-tag z)
;;       (type-tag z)
;;         (car z)                      ;; '(complex)
;;     (get 'magnitude '(complex))      ;; This fails

;; At this point, we have installed `magnitude' procedures for type-tags
;; '(polar) and '(rectangular). However, we have not installed a
;; `magnitude' procedure for the type '(complex)'. Our lookup table
;; contains:
;;
;;                | 'magnitude
;; ---------------+------------------------
;; '(rectangular) | magnitude  ;; defined internally to install-rectangular-package
;; '(polar)       | magnitude  ;; defined internally to install-polar-package

;; AFTER ADDING PROCEDURES TO THE MAGNITUDE PACKAGE
;; (magnitude z)
;;   (apply-generic 'magnitude z)
;;     (map type-tag z)
;;       (type-tag z)
;;         (car z)                      ;; '(complex)
;;     (get 'magnitude '(complex))      ;; magnitude (using this name to differentiate)
;;     (apply magnitude (map contents z))
;;       (magnitude '(rectangular (3 4)))
;;         (apply-generic 'magnitude '(rectangular (3 4)))
;;           (map type-tag '(rectangular (3 4)))
;;             (type-tag '(rectangular (3 4)))
;;               (car '(rectangular (3 4)))    ;; '(rectangular)
;;           (get 'magntiude '(rectangular))   ;; magnitude-rect
;;           (apply magnitude-rect '(3 . 4))
;;             (sqrt (+ (square (real-part '(3 . 4)))
;;                      (square (real-part '(3 . 4)))))
