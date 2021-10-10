;; QUEUE
;; (MAKE-QUEUE) -> new queue
;; (INSERT-QUEUE! queue item)
;; (DELETE-QUEUE! queue)
;; (FRONT-QUEUE queue) -> item
;; (EMPTY-QUEUE? queue) -> true/false

(define nil '())

(define (make-queue)
  (cons nil nil))

(define (front-queue queue)
  (if (empty-queue? queue)
      (error "FRONT called with an empty queue" queue)
      (car (front-pointer queue))))

(define (empty-queue? queue)
  (null? (front-pointer queue)))

(define (front-pointer queue)
  (car queue))

(define (rear-pointer queue)
  (cdr queue))

(define (set-front-pointer! queue item)
  (set-car! queue item))

(define (set-rear-pointer! queue item)
  (set-cdr! queue item))

(define (insert-queue! queue item)
  (let ((new-pair (cons item nil)))
    (cond ((empty-queue? queue)
           (set-front-pointer! queue new-pair)
           (set-rear-pointer! queue new-pair)
           queue)
          (else
           (set-cdr! (rear-pointer queue) new-pair)
           (set-rear-pointer! queue new-pair)
           queue))))

(define (delete-queue! queue)
  (cond ((empty-queue? queue)
         (error "DELETE! called with an empty queue" queue))
        (else
         (set-front-pointer! queue
                             (cdr (front-pointer queue)))
         queue)))
