;; *Exercise 2.69:* The following procedure takes as its argument a
;; list of symbol-frequency pairs (where no symbol appears in more
;; than one pair) and generates a Huffman encoding tree according to
;; the Huffman algorithm.

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

;; `Make-leaf-set' is the procedure given above that transforms the
;; list of pairs into an ordered set of leaves.  `Successive-merge'
;; is the procedure you must write, using `make-code-tree' to
;; successively merge the smallest-weight elements of the set until
;; there is only one element left, which is the desired Huffman tree.
;; (This procedure is slightly tricky, but not really complicated.
;; If you find yourself designing a complex procedure, then you are
;; almost certainly doing something wrong.  You can take significant
;; advantage of the fact that we are using an ordered set
;; representation.)

;; HELPERS
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

;; IMPLEMENTATION
(define (successive-merge leaf-set)
  (cond ((null? leaf-set) (error "leaf-set is empty - SUCCESSIVE-MERGE"))
	((null? (cdr leaf-set)) (car leaf-set))
	(else (let ((a (car leaf-set))
		    (b (cadr leaf-set))
		    (rest-of-set (cddr leaf-set)))
		
		;; Because `adjoin-set' stores the set as a sorted list
		;; in ascending order, we know that the weight of `b' is
		;; greater than the weight of `a'. Therefore, we place
		;; the first retrieved element (`a') on the left.
		(let ((new-node (make-code-tree a b)))
		(successive-merge (adjoin-set new-node rest-of-set)))))))

;; FOR FUN
(define (encode-symbol symbol tree)
  (cond ((leaf? tree) '())
	((in-set? symbol (symbols (left-branch tree)))
	 (cons 0 (encode-symbol symbol (left-branch tree))))
	((in-set? symbol (symbols (right-branch tree)))
	 (cons 1 (encode-symbol symbol (right-branch tree))))
	(else (error "symbol not in tree -- ENCODE-SYMBOL"))))

(define (in-set? x set)
  (cond ((null? set) #f)
	((eq? (car set) x) #t)
	(else (in-set? x (cdr set)))))

(define (generate-dictionary sym-freq-pairs tree)
  (map (lambda (sym-freq-pair)
       (cons (car sym-freq-pair)
	     (encode-symbol (car sym-freq-pair)
			    tree)))
     sym-freq-pairs))

;; TESTS
(define sym-freq-pairs '((A 8) (B 3) (C 1) (D 1) (E 1) (F 1) (G 1) (H 1)))
(define tree (generate-huffman-tree sym-freq-pairs))

;; ((a 0)
;;  (b 1 1 1)
;;  (c 1 1 0 1)
;;  (d 1 1 0 0)
;;  (e 1 0 1 1)
;;  (f 1 0 1 0)
;;  (g 1 0 0 1)
;;  (h 1 0 0 0))
