;; *Exercise 3.24:* In the table implementations above, the keys are
;; tested for equality using `equal?' (called by `assoc').  This is
;; not always the appropriate test.  For instance, we might have a
;; table with numeric keys in which we don't need an exact match to
;; the number we're looking up, but only a number within some
;; tolerance of it.  Design a table constructor `make-table' that
;; takes as an argument a `same-key?' procedure that will be used to
;; test "equality" of keys.  `Make-table' should return a `dispatch'
;; procedure that can be used to access appropriate `lookup' and
;; `insert!' procedures for a local table.

;; IMPL
(define (make-table same-key?)
  (let ((table (list '*table*)))

    (define (assoc key records)
      (cond ((null? records) false)
	    ;; Replace `equal?' with `same-key?'
            ((same-key? key (caar records)) (car records))
            (else (assoc key (cdr records)))))

    (define (lookup key)
      (let ((record (assoc key (cdr table))))
        (if record
            (cdr record)
            false)))

    (define (insert! key value)
      (let ((record (assoc key (cdr table))))
        (if record
            (set-cdr! record value)
            (set-cdr! table
                      (cons (cons key value) (cdr table)))))
      'ok)

    (define (dispatch m)
      ;; Updated externally-facing method names
      (cond ((eq? m 'lookup) lookup)
            ((eq? m 'insert!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

;; TESTS
(define tbl (make-table (lambda (key1 key2) (< (abs (- key1 key2)) 1))))
((tbl 'insert!) 12 'hello)
((tbl 'lookup) 12.2)
((tbl 'lookup) 13)
((tbl 'insert!) 12.7 'goodbye)
((tbl 'lookup) 12)
