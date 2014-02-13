#lang racket

(require "hw5.rkt")

; a test case that uses problems 1, 2, and 4
; should produce (list (int 10) (int 11) (int 16))
(define test1
  (mupllist->racketlist
   (eval-exp (call (call mupl-mapAddN (int 7))
                   (racketlist->mupllist 
                    (list (int 3) (int 4) (int 9)))))))
(define test2
  (eval-exp (mlet "f1" (fun "f1" "a" 
						(mlet "x" (var "a") (fun "f2" "z" (add (var "x") (int 1)))))
		  (mlet "f3" (fun "f3" "f" (mlet "x" (int 1729) (call (var "f") (aunit))))
				  (call (var "f3") (call (var "f1") (int 1)))))))
(define test3
  (ifeq (int 3) (int 4) (var "FAIL") (var "PASS")))

(mlet "x" (int 21) 
      (mlet "f" (fun #f "y" (add (var "x") (var "y")))
            (mlet "x" (int 1) 
                  (call (var "f") (int 21)))))

