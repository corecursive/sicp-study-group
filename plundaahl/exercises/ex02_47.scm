;;     *Exercise 2.47:* Here are two possible constructors for frames:
;;
;;          (define (make-frame origin edge1 edge2)
;;            (list origin edge1 edge2))
;;
;;          (define (make-frame origin edge1 edge2)
;;            (cons origin (cons edge1 edge2)))
;;
;;     For each constructor supply the appropriate selectors to produce an
;;     implementation for frames.

;; VERSION 1
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame) (car frame))
(define (edge1-frame frame) (cadr frame))
(define (edge2-frame frame) (cddr frame))

;; VERSION 1
(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (origin-frame frame) (car frame))
(define (edge1-frame frame) (cadr frame))
(define (edge2-frame frame) (cddr frame))

;; TESTS (same tests for both versions)
(define (make-vect xcor ycor) (cons xcor ycor))

(define test-frame (make-frame (make-vect 3 2)
			       (make-vect 2 0)
			       (make-vect 0 3)))

(origin-frame test-frame)
(edge1-frame test-frame)
(edge2-frame test-frame)
