;; *Exercise 3.25:* Generalizing one- and two-dimensional tables,
;; show how to implement a table in which values are stored under an
;; arbitrary number of keys and different values may be stored under
;; different numbers of keys.  The `lookup' and `insert!' procedures
;; should take as input a list of keys used to access the table.

;; IMPL
(define (make-table #!optional name . values)
  (cons (if (default-object? name) '*table* name) values))

(define (lookup keys table)
  (cond ((or (not table) (null? table)) false)
	((null? keys) (cdr table))
	(else (lookup (cdr keys)
		      (assoc (car keys) (cdr table))))))

(define (insert! keys value table)
  ;; ASSUME: table exists
  (let ((key (car keys))
	(rest-keys (cdr keys)))
    (let ((record (assoc key (cdr table))))
      (if record
	  (if (null? rest-keys)
	      (set-cdr! record value)
	      (insert! rest-keys value record))
	  (if (null? rest-keys)
	      (let ((new-record (cons key value)))
		(set-cdr! table (cons new-record (cdr table))))
	      (let ((new-record (cons key '())))
		(set-cdr! table (cons new-record (cdr table)))
		(insert! rest-keys value new-record))))))
  'ok)

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

;; TESTS
(define test-table (make-table '*table*))

((lambda (table)
   (insert! '('locales 'english 'hello) "hello" table)
   (insert! '('locales 'spanish 'hello) "hola" table)
   (insert! '('locales 'english 'goodbye) "goodbye" table)
   (insert! '('locales 'spanish 'goodbye) "adiós" table)
   ) test-table)

(lookup '('locales 'english 'hello) test-table)

;; print table
((lambda () test-table))
