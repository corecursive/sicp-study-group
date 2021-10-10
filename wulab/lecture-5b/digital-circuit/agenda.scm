;; AGENDA
;; The agenda is a one-dimensional table of time segments. The
;; segments will be sorted in order of increasing time.
;;
;; (MAKE-AGENDA) -> new agenda
;; (CURRENT-TIME agenda) -> time
;; (EMPTY-AGENDA? agenda) -> true/false
;; (ADD-TO-AGENDA! time action agenda)
;; (FIRST-ITEM agenda) -> action
;; (REMOVE-FIRST-ITEM! agenda)

(load "queue.scm")

(define (make-agenda)
  (let ((new-segment
         (make-time-segment 0 (make-queue))))
    (cons '*agenda* (cons new-segment nil))))

(define (segments agenda)
  (cdr agenda))

(define (first-segment agenda)
  (car (segments agenda)))

(define (rest-segments agenda)
  (cdr (segments agenda)))

(define (set-segments! agenda segments)
  (set-cdr! agenda segments))

;; The current time will always be the time associated with the first
;; time segment on the agenda.
(define (current-time agenda)
  (segment-time (first-segment agenda)))

;; The agenda is empty when the first segment has an empty queue and
;; there are no more segments to be executed.
(define (empty-agenda? agenda)
  (and (empty-queue? (segment-queue (first-segment agenda)))
       (null? (rest-segments agenda))))

;; To add an item to the agenda, we scan the agenda looking at the
;; time of each segment. If we find a segment for our appointed time,
;; we add our action to the associated queue. If we hit the end of the
;; agenda, we must create a new time segment at the end. If we hit a
;; time later than the one we are appointed to, we must insert a new
;; time segment into the agenda just before it. Otherwise we continue
;; scanning. Note that the appointed time can never be earlier than
;; the time of the first agenda segment (the current time).
(define (add-to-agenda! time action agenda)
  (if (= time (segment-time (first-segment agenda)))
      (insert-queue! (segment-queue (first-segment agenda))
                     action)
      (cond ((null? (rest-segments agenda))
             (insert-new-time! time action (segments agenda)))
            ((< time (segment-time (car (rest-segments agenda))))
             (insert-new-time! time action (segments agenda)))
            (else
             (let ((rest-agenda (cons '*agenda*
                                      (rest-segments agenda))))
               (add-to-agenda! time action rest-agenda))))))

;; Insert a new time segment between the first segment and the rest.
(define (insert-new-time! time action segments)
  (let ((q (make-queue)))
    (insert-queue! q action)
    (set-cdr! segments
              (cons (make-time-segment time q)
                    (cdr segments)))))

(define (first-item agenda)
  (let ((q (segment-queue (first-segment agenda))))
    (if (empty-queue? q)
        (begin (set-segments! agenda (rest-segments agenda))
               (first-item agenda))
        (front-queue q))))

(define (remove-first-item! agenda)
  (delete-queue! (segment-queue (first-segment agenda))))

;; TIME SEGMENT
;; Each time segment is a pair consisting of a number (the time) and
;; an associated queue that holds the procedures that are scheduled to
;; be run during that time segment.
;;
;; (MAKE-TIME-SEGMENT time queue) -> new time segment
;; (SEGMENT-TIME s) -> time
;; (SEGMENT-QUEUE s) -> queue

(define (make-time-segment time queue)
  (cons time queue))

(define (segment-time s)
  (car s))

(define (segment-queue s)
  (cdr s))
