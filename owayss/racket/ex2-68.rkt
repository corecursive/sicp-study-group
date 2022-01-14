#lang sicp

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

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

(define (symbol-leaf x) (cadr x))

(define (weight-leaf x) (caddr x))

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                    (make-leaf 'B 2)
                    (make-code-tree (make-leaf 'D 1)
                                    (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))


(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
      '()
      (let ((next-branch
              (choose-branch (car bits) current-branch)))
        (if (leaf? next-branch)
          (cons (symbol-leaf next-branch)
                (decode-1 (cdr bits) tree))
          (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))


(define (encode message tree)
  (if (null? message)
    '()
    (append (encode-symbol (car message) tree)
            (encode (cdr message) tree))))


(define (encode-symbol symbol tree)
  (define (contains set x)
    (if (null? set)
      #f
      (if (eq? (car set) x) #t
        (contains (cdr set) x))))

  (if (null? tree)
    (error "no encoding found for -- ENCODE-SYMBOL" symbol)
    (cond ((leaf? tree) nil)
          ((contains (symbols (left-branch tree)) symbol) (cons 0 (encode-symbol symbol (left-branch tree))))
          ((contains (symbols (right-branch tree)) symbol) (cons 1 (encode-symbol symbol (right-branch tree))))
          (else (error "no encoding found for -- ENCODE-SYMBOL" symbol)))))


(encode (decode sample-message sample-tree) sample-tree)
sample-message


; $ sicp ex2-68.rkt
; (0 1 1 0 0 1 0 1 0 1 1 1 0)
; (0 1 1 0 0 1 0 1 0 1 1 1 0)

