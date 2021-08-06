;; A global two-dimensional association table provided by MIT/GNU Scheme

(define (put key1 key2 value)
  (2d-put! key1 key2 value))

(define (get key1 key2)
  (2d-get key1 key2))
