(load "type.scm")
(load "rational-package/install.scm")

(define a (make-rational 1 2))
(define b (make-rational 2 3))

(assert (eq? 'rational (type a)))
(assert (eq? 'rational (type b)))
(assert (eq? 'rational (type ((get 'rational 'add) (contents a) (contents b)))))
(assert (eq? 'rational (type ((get 'rational 'sub) (contents a) (contents b)))))
(assert (eq? 'rational (type ((get 'rational 'mul) (contents a) (contents b)))))
(assert (eq? 'rational (type ((get 'rational 'div) (contents a) (contents b)))))
