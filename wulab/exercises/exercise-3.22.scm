;; Exercise 3.22.
;;
;; Instead of representing a queue as a pair of pointers, we can build
;; a queue as a procedure with local state. The local state will
;; consist of pointers to the beginning and the end of an ordinary
;; list. Thus, the make-queue procedure will have the form
;;
;;   (define (make-queue)
;;     (let ((front-ptr ...)
;;           (rear-ptr ...))
;;       <definitions of internal procedures>
;;       (define (dispatch m) ...)
;;       dispatch))
;;
;; Complete the definition of make-queue and provide implementations
;; of the queue operations using this representation.

;; constructor

(define nil '())

(define (make-queue)
  (let ((front-ptr nil)
        (rear-ptr nil))
    (define (empty-queue?)
      (null? front-ptr))
    (define (front-queue)
      (car front-ptr))
    (define (insert-queue! item)
      (let ((new-pair (cons item nil)))
        (cond ((empty-queue?)
               (set! front-ptr new-pair)
               (set! rear-ptr new-pair)
               front-ptr)
              (else
               (set-cdr! rear-ptr new-pair)
               (set! rear-ptr new-pair)
               front-ptr))))
    (define (delete-queue!)
      (if (empty-queue?)
          (error "DELETE! called with an empty queue" front-ptr)
          (begin 
            (set! front-ptr (cdr front-ptr))
            front-ptr)))
    (define (dispatch m)
      (cond ((eq? m 'empty-queue?) empty-queue?)
            ((eq? m 'front-queue) front-queue)
            ((eq? m 'insert-queue!) insert-queue!)
            ((eq? m 'delete-queue!) delete-queue!)
            (else
             (error "Unknown request -- MAKE-QUEUE" m))))
    dispatch))

;; selectors

(define (empty-queue? queue)
  ((queue 'empty-queue?)))

(define (front-queue queue)
  ((queue 'front-queue)))

;; mutators

(define (insert-queue! queue item)
  ((queue 'insert-queue!) item))

(define (delete-queue! queue)
  ((queue 'delete-queue!)))

;; tests

(define q (make-queue))

(insert-queue! q 'a)
(insert-queue! q 'b)
(delete-queue! q)
(assert (eq? (front-queue q) 'b))

(insert-queue! q 'c)
(insert-queue! q 'd)
(delete-queue! q)
(assert (eq? (front-queue q) 'c))

(assert (not (empty-queue? q)))
(delete-queue! q)
(delete-queue! q)
(assert (empty-queue? q))
