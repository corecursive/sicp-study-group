#lang sicp

;; *Exercise 2.55:* Eva Lu Ator types to the interpreter the
;; expression

(equal? (car ''abracadabra)
        (car '(quote abracadabra)))

(equal? (car '(quote abracadabra))
        'quote)
