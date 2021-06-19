;; *Exercise 2.70:* The following eight-symbol alphabet with
;; associated relative frequencies was designed to efficiently encode
;; the lyrics of 1950s rock songs.  (Note that the "symbols" of an
;; "alphabet" need not be individual letters.)

;;      A     2 NA   16
;;      BOOM  1 SHA  3
;;      GET   2 YIP  9
;;      JOB   2 WAH  1

;; Use `generate-huffman-tree' (*Note Exercise 2-69::) to generate a
;; corresponding Huffman tree, and use `encode' (*Note Exercise
;; 2-68::) to encode the following message:

;;      Get a job
;;      Sha na na na na na na na na
;;      Get a job
;;      Sha na na na na na na na na
;;      Wah yip yip yip yip yip yip yip yip yip
;;      Sha boom

;; (Continues below)

;; FUNCTIONS
;; Huffman tree generation
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaf-set)
  (cond ((null? leaf-set) (error "leaf-set is empty - SUCCESSIVE-MERGE"))
	((null? (cdr leaf-set)) (car leaf-set))
	(else (let ((a (car leaf-set))
		    (b (cadr leaf-set))
		    (rest-of-set (cddr leaf-set)))
		(let ((new-node (make-code-tree a b)))
		(successive-merge (adjoin-set new-node rest-of-set)))))))

;; Encoding
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (in-set? x set)
  (cond ((null? set) #f)
	((eq? (car set) x) #t)
	(else (in-set? x (cdr set)))))

(define (encode-symbol symbol tree)
  (cond ((leaf? tree) '())
	((in-set? symbol (symbols (left-branch tree)))
	 (cons 0 (encode-symbol symbol (left-branch tree))))
	((in-set? symbol (symbols (right-branch tree)))
	 (cons 1 (encode-symbol symbol (right-branch tree))))
	(else (error "symbol not in tree -- ENCODE-SYMBOL"))))

;; Leaf set and code tree
(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)    ; symbol
                               (cadr pair))  ; frequency
                    (make-leaf-set (cdr pairs))))))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

;; Leaf nodes
(define (make-leaf symbol weight) (list 'leaf symbol weight))
(define (leaf? object) (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

;; Intermediate nodes
(define (make-code-tree left right)
  (list left
	right
	(append (symbols left) (symbols right))
	(+ (weight left) (weight right))))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
	((< (weight x) (weight (car set))) (cons x set))
	(else (cons (car set)
		    (adjoin-set x (cdr set))))))


;;;;;;;;;;;;
;; ANSWER ;;
;;;;;;;;;;;;
(define sym-freq-list '((A 2) (NA 16) (BOOM 1) (SHA 3) (GET 2) (YIP 9) (JOB 2) (WAH 1)))
(define message
  '(Get a job
	Sha na na na na na na na na
	Get a job
	Sha na na na na na na na na
        Wah yip yip yip yip yip yip yip yip yip
        Sha boom))

(define tree (generate-huffman-tree sym-freq-list))
(define encoding (encode message tree))

;; How many bits are required for the encoding?
(length encoding) ;; 84

;; What is the smallest
;; number of bits that would be needed to encode this song if we used
;; a fixed-length code for the eight-symbol alphabet?
(* (length message) 3) ;; 108
