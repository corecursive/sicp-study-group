;; We're going to build an embedded language in Lisp like Henderson
;; Escher language which builds up more and more procedures to
;; encapsulate the structure we want [1] but not like the pattern
;; match and substitution language which is interpreted by Lisp.
;;
;; [1] Instead of starting with mathematical functions, we start with
;; things that are electrical objects and build up more electrical
;; objects.

(load "agenda.scm")

;; Primitives and Means of Combination

;; (define a (make-wire))
;; (define b (make-wire))
;; (define c (make-wire))
;; (define d (make-wire))
;; (define e (make-wire))
;; (define s (make-wire))

;; Connect primitive objects together with wires
;; (or-gate a b d)
;; (and-gate a b c)
;; (inverter c e)
;; (and-gate d e s)

;; Means of Abstraction

(define (half-adder a b s c)
  (let ((d (make-wire))
        (e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)))

(define (full-adder a b c-in sum c-out)
  (let ((s (make-wire))
        (c1 (make-wire))
        (c2 (make-wire)))
    (half-adder b c-in s c1)
    (half-adder a s sum c2)
    (or-gate c1 c2 c-out)))

;; The inverter job is to do something with the output wire when the
;; input wire signal changes.
(define (inverter in out)
  (define (invert-in)
    (let ((new-value (logical-not (get-signal in))))
      (after-delay inverter-delay
                   (lambda () (set-signal! out new-value)))))
  ;; call invert-in when in gets changed
  (add-action! in invert-in))

(define (and-gate a1 a2 out)
  (define (and-action-procedure)
    (let ((new-value (logical-and (get-signal a1)
                                  (get-signal a2))))
      (after-delay and-gate-delay
                   (lambda () (set-signal! out new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure))

(define (or-gate o1 o2 out)
  (define (or-action-procedure)
    (let ((new-value (logical-or (get-signal o1)
                                 (get-signal o2))))
      (after-delay or-gate-delay
                   (lambda () (set-signal! out new-value)))))
  (add-action! o1 or-action-procedure)
  (add-action! o2 or-action-procedure))

(define (logical-not s)
  (cond ((= s 0) 1)
        ((= s 1) 0)
        (else
         (error "Invalid signal" s))))

(define (logical-and s1 s2)
  (if (and (= s1 1) (= s2 1))
      1
      0))

(define (logical-or s1 s2)
  (if (and (= s1 0) (= s2 0))
      0
      1))

;; What's the computation model? We have to assign every objects in
;; the world an object in the computer, and for every relationship
;; between them a relationship in the computer.

(define (make-wire)
  (let ((signal 0)
        (action-procedures '()))
    (define (set-signal! new-value)
      (cond ((= signal new-value) 'done)
            (else
             (set! signal new-value)
             (call-each action-procedures))))
    (define (add-action! procedure)
      (set! action-procedures
            (cons procedure action-procedures))
      (procedure))
    (define (dispatch m)
      (cond ((eq? m 'get-signal) signal)
            ((eq? m 'set-signal!) set-signal!)
            ((eq? m 'add-action!) add-action!)
            (else
             (error "Bad message" m))))
    dispatch))

(define (call-each procedures)
  (cond ((null? procedures) 'done)
        (else
         ((car procedures))
         (call-each (cdr procedures)))))

(define (get-signal wire)
  (wire 'get-signal))

(define (set-signal! wire new-value)
  ((wire 'set-signal!) new-value))

(define (add-action! wire procedure)
  ((wire 'add-action!) procedure))

(define (after-delay delay action)
  (add-to-agenda!
   (+ delay (current-time the-agenda))
   action
   the-agenda))

(define (propagate)
  (cond ((empty-agenda? the-agenda) 'done)
        (else
         ((first-item the-agenda))
         (remove-first-item! the-agenda)
         (propagate))))

;; A Sample Simulation

(define (probe name wire)
  (add-action! wire
               (lambda ()
                 (display name)
                 (display " ")
                 (display (current-time the-agenda))
                 (display "  new-value = ")
                 (display (get-signal wire))
                 (newline))))

(define the-agenda (make-agenda))
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)

(define a (make-wire))
(define b (make-wire))
(define sum (make-wire))
(define carry (make-wire))

(define (simulate)
  (probe 'sum sum)
  (probe 'carry carry)
  (half-adder a b sum carry)
  (set-signal! a 1)
  (propagate)
  (set-signal! b 1)
  (propagate))
