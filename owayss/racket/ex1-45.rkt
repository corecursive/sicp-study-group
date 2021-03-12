#lang sicp

(define tolerance 0.00001)

(define (fixed-point f guess)
  (define (close-enough? v1 v2) (< (abs (- v1 v2)) tolerance))
  (define (next x) (f x))
  (define (try guess)
    (let ((next (next guess)))
      (if (close-enough? next guess) guess (try next))))

  (try guess))

; (define (average-damp f) (lambda (x) (/ (+ x (f x)) 2.0)))
;;; (define (sqrt x) (fixed-point (average-damp (lambda (y) (/ x y))) 1))
;;; (define (cubert x) (fixed-point (average-damp (lambda (y) (/ x (* y y)))) 1))
; (define (4th-rt x) (fixed-point (average-damp (lambda (y) (/ x (* y y y)))) 1))

; (4th-rt 625)
;;; owayss.kabtoul at void in ~/github/owayss/sicp-study-group/owayss/racket on master [?] using minikube:default
;;; $ racket '/Users/owayss.kabtoul/github/owayss/sicp-study-group/owayss/racket/ex1-45.rkt'

; Does not converge.


(define (nth-root-search-with-limit x nth n-damps max-iters)
  (define (pow x n) (if (= n 1) x (* x (pow x (- n 1)))))
  (define (fixed-point f guess)
    (define (close-enough? v1 v2) (< (abs (- v1 v2)) tolerance))
    (define (next x) (f x))
    (define (try guess iter)
        (let ((next (next guess)))
        (cond ((close-enough? next guess) (display "found ") (display nth) (display " root for ") (display x) (display " = ") (display guess) (display " with ") (display n-damps) (display " damps\n") guess) 
              ((= iter max-iters) 0) ;;; TODO: raise error and check for it instead.
              (else (try next (+ 1 iter))))))
    
    (try guess 1))
  (fixed-point ((repeated average-damp n-damps) (lambda (y) (/ x (pow y (- nth 1))))) 1))

(define (repeated f n) (if (= n 1) f (compose f (repeated f (- n 1)))))
(define (compose f g) (lambda (x) (f (g x))))
(define (average-damp f) (lambda (x) (/ (+ x (f x)) 2.0)))

(define (experiment x max-n max-iters)
  (define (iter n n-damps)
    (if (not (> n max-n)) 
      (cond ((= 0 (nth-root-search-with-limit x n n-damps max-iters)) (iter n (+ 1 n-damps)))
            (else (iter (+ 1 n) n-damps)))))
  (iter 2 1))

; (experiment 8192 50 1000)
; 
; owayss.kabtoul at void in ~/github/owayss/sicp-study-group/owayss/racket on master [?] using minikube:default
; $ racket ex1-45.rkt
; found 2 root for 8192 = 90.50966801881592 with 1 damps
; found 3 root for 8192 = 20.158732582476723 with 1 damps
; found 4 root for 8192 = 9.51365721579771 with 2 damps
; found 5 root for 8192 = 6.062872627736596 with 2 damps
; found 6 root for 8192 = 4.489843320356826 with 2 damps
; found 7 root for 8192 = 3.6228991527955037 with 2 damps
; found 8 root for 8192 = 3.0844216644274614 with 3 damps
; found 9 root for 8192 = 2.7215847539940983 with 3 damps
; found 10 root for 8192 = 2.4622846055707006 with 3 damps
; found 11 root for 8192 = 2.2686200670969994 with 3 damps
; found 12 root for 8192 = 2.118922784998285 with 3 damps
; found 13 root for 8192 = 1.9999953464634772 with 3 damps
; found 14 root for 8192 = 1.9033851944795421 with 3 damps
; found 15 root for 8192 = 1.8234497199470403 with 3 damps
; found 16 root for 8192 = 1.7562530720240268 with 4 damps
; found 17 root for 8192 = 1.6990268524143668 with 4 damps
; found 18 root for 8192 = 1.6497159225976947 with 4 damps
; found 19 root for 8192 = 1.6068304810736938 with 4 damps
; found 20 root for 8192 = 1.5691704842801926 with 4 damps
; found 21 root for 8192 = 1.535867228373418 with 4 damps
; found 22 root for 8192 = 1.5061983030382846 with 4 damps
; found 23 root for 8192 = 1.4796066662952128 with 4 damps
; found 24 root for 8192 = 1.4556475283024009 with 4 damps
; found 25 root for 8192 = 1.4339595307880044 with 4 damps
; found 26 root for 8192 = 1.4142196034864607 with 4 damps
; found 27 root for 8192 = 1.3961723007011329 with 4 damps
; found 28 root for 8192 = 1.3796392557539794 with 4 damps
; found 29 root for 8192 = 1.364403626735308 with 4 damps
; found 30 root for 8192 = 1.3503446472177396 with 4 damps
; found 31 root for 8192 = 1.3373343956137607 with 4 damps
; found 32 root for 8192 = 1.325236895917959 with 5 damps
; found 33 root for 8192 = 1.3139711985158513 with 5 damps
; found 34 root for 8192 = 1.3034670301939066 with 5 damps
; found 35 root for 8192 = 1.2936375386585666 with 5 damps
; found 36 root for 8192 = 1.2844129008593608 with 5 damps
; found 37 root for 8192 = 1.2757489535045003 with 5 damps
; found 38 root for 8192 = 1.2676079865441139 with 5 damps
; found 39 root for 8192 = 1.259928331718057 with 5 damps
; found 40 root for 8192 = 1.252660885008963 with 5 damps
; found 41 root for 8192 = 1.2457943731850902 with 5 damps
; found 42 root for 8192 = 1.2393011072617433 with 5 damps
; found 43 root for 8192 = 1.233125010073781 with 5 damps
; found 44 root for 8192 = 1.2272688503888625 with 5 damps
; found 45 root for 8192 = 1.2217053182162219 with 5 damps
; found 46 root for 8192 = 1.2163958580061318 with 5 damps
; found 47 root for 8192 = 1.211329099989995 with 5 damps
; found 48 root for 8192 = 1.2065091185095187 with 5 damps
; found 49 root for 8192 = 1.2018860074125153 with 5 damps
; found 50 root for 8192 = 1.1974841903149323 with 5 damps

; From the experiment above, the required number of damps for the nth root equals the highest power
; of two smaller than n.

(define (log2 x) (/ (log x) (log 2)))

(define (pow x n)
  (define (square x) (* x x))
  (define (iter n acc)
    (if (= 0 n) acc
        (cond ((even? n) (square (iter (/ n 2) acc))) (else (* x (iter (- n 1) acc))))))
  (iter n 1))

(define (nth-root x nth) (fixed-point ((repeated average-damp (floor (log2 nth))) (lambda (y) (/ x (pow y (- nth 1))))) 1))

(experiment 8192 50 1000)
(nth-root 8192 50)


; owayss.kabtoul at void in ~/github/owayss/sicp-study-group/owayss/racket on master [?] using minikube:default
; $ racket ex1-45.rkt
; found 2 root for 8192 = 90.50966801881592 with 1 damps
; found 3 root for 8192 = 20.158732582476723 with 1 damps
; found 4 root for 8192 = 9.51365721579771 with 2 damps
; found 5 root for 8192 = 6.062872627736596 with 2 damps
; found 6 root for 8192 = 4.489843320356826 with 2 damps
; found 7 root for 8192 = 3.6228991527955037 with 2 damps
; found 8 root for 8192 = 3.0844216644274614 with 3 damps
; found 9 root for 8192 = 2.7215847539940983 with 3 damps
; found 10 root for 8192 = 2.4622846055707006 with 3 damps
; found 11 root for 8192 = 2.2686200670969994 with 3 damps
; found 12 root for 8192 = 2.118922784998285 with 3 damps
; found 13 root for 8192 = 1.9999953464634772 with 3 damps
; found 14 root for 8192 = 1.9033851944795421 with 3 damps
; found 15 root for 8192 = 1.8234497199470403 with 3 damps
; found 16 root for 8192 = 1.7562530720240268 with 4 damps
; found 17 root for 8192 = 1.6990268524143668 with 4 damps
; found 18 root for 8192 = 1.6497159225976947 with 4 damps
; found 19 root for 8192 = 1.6068304810736938 with 4 damps
; found 20 root for 8192 = 1.5691704842801926 with 4 damps
; found 21 root for 8192 = 1.535867228373418 with 4 damps
; found 22 root for 8192 = 1.5061983030382846 with 4 damps
; found 23 root for 8192 = 1.4796066662952128 with 4 damps
; found 24 root for 8192 = 1.4556475283024009 with 4 damps
; found 25 root for 8192 = 1.4339595307880044 with 4 damps
; found 26 root for 8192 = 1.4142196034864607 with 4 damps
; found 27 root for 8192 = 1.3961723007011329 with 4 damps
; found 28 root for 8192 = 1.3796392557539794 with 4 damps
; found 29 root for 8192 = 1.364403626735308 with 4 damps
; found 30 root for 8192 = 1.3503446472177396 with 4 damps
; found 31 root for 8192 = 1.3373343956137607 with 4 damps
; found 32 root for 8192 = 1.325236895917959 with 5 damps
; found 33 root for 8192 = 1.3139711985158513 with 5 damps
; found 34 root for 8192 = 1.3034670301939066 with 5 damps
; found 35 root for 8192 = 1.2936375386585666 with 5 damps
; found 36 root for 8192 = 1.2844129008593608 with 5 damps
; found 37 root for 8192 = 1.2757489535045003 with 5 damps
; found 38 root for 8192 = 1.2676079865441139 with 5 damps
; found 39 root for 8192 = 1.259928331718057 with 5 damps
; found 40 root for 8192 = 1.252660885008963 with 5 damps
; found 41 root for 8192 = 1.2457943731850902 with 5 damps
; found 42 root for 8192 = 1.2393011072617433 with 5 damps
; found 43 root for 8192 = 1.233125010073781 with 5 damps
; found 44 root for 8192 = 1.2272688503888625 with 5 damps
; found 45 root for 8192 = 1.2217053182162219 with 5 damps
; found 46 root for 8192 = 1.2163958580061318 with 5 damps
; found 47 root for 8192 = 1.211329099989995 with 5 damps
; found 48 root for 8192 = 1.2065091185095187 with 5 damps
; found 49 root for 8192 = 1.2018860074125153 with 5 damps
; found 50 root for 8192 = 1.1974841903149323 with 5 damps
; 1.1974841903149323