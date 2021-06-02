;; *Exercise 2.55:* Eva Lu Ator types to the interpreter the
;; expression

;;      (car ''abracadabra)

;; To her surprise, the interpreter prints back `quote'.  Explain.

;; (car ''abracadabra) is the same as (car (quote (quote abracadabra)))
;; Evaluating this returns the first cell in (quote (quote abracadabra)),
;; which is `quote'
