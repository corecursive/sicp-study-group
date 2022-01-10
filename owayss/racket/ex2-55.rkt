#lang sicp

(car ''abracadabra)


; okabtoul at LUSC02DV5KQMD6R in ~/github/owayss/sicp-study-group/owayss/racket on master [?] using minikube:default
; $ sicp ex2-55.rkt
; quote

; ANSWER
; (car ''abracadabra) can be written as:
; (car (quote (quote abracadabra)))
; a pair whose first element is the special form `quote`

