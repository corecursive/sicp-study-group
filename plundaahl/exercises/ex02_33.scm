;;     *Exercise 2.33:* Fill in the missing expressions to complete the
;;     following definitions of some basic list-manipulation operations
;;     as accumulations:
;;
;;          (define (map p sequence)
;;            (accumulate (lambda (x y) <??>) nil sequence))
;;
;;          (define (append seq1 seq2)
;;            (accumulate cons <??> <??>))
;;
;;          (define (length sequence)
;;            (accumulate <??> 0 sequence))


;; HELPER DEFINITIONS
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))


;; ANS: MAP
(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y))
		'()
		sequence))
;; Test
(map (lambda (x) (* x x)) (list 1 2 3))


;; ANS: APPEND
(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

;; Test
(append (list 1 2 3) (list 4 5 6))
(append '() (list 4 5 6))
(append (list 1 2 3) '())


;; ANS: LENGTH
(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

;; Test
(length '())
(length (list 1))
(length (list 1 2 3 4 5))
