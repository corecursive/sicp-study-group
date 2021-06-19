;; *Exercise 2.71:* Suppose we have a Huffman tree for an alphabet of
;; n symbols, and that the relative frequencies of the symbols are 1,
;; 2, 4, ..., 2^(n-1).  Sketch the tree for n=5; for n=10.

;; ANSWER FOR n=5
;; *-- 16
;;  \
;;   * -- 8
;;    \
;;     * -- 4
;;      \
;;       * -- 2
;;        \
;;         1

(define sym-freq-pairs '((A 1) (B 2) (C 4) (D 8) (E 16)))
(define tree (generate-huffman-tree sym-freq-pairs))
(generate-dictionary sym-freq-pairs tree)

;; ANSWER FOR n=10
;; It's the same thing, just longer

(define sym-freq-pairs '((A 1) (B 2) (C 4) (D 8) (E 16) (F 32) (G 64) (H 128) (I 256) (J 512)))
(define tree (generate-huffman-tree sym-freq-pairs))
(generate-dictionary sym-freq-pairs tree)

;; In such a
;; tree (for general n) how may bits are required to encode the most
;; frequent symbol? the least frequent symbol?

;; ANSWER
;; Bits required for most frequent symbol = 1
;; Bits required for least frequent symbol = n-1
