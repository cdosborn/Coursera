#lang racket
(provide (all-defined-out))
(require "hw4.rkt")

(print "sequence")
(newline)
(equal? (sequence 0 5 1) (list 0 1 2 3 4 5))
(equal? (sequence 3 2 1) null) 
(equal? (sequence 0 5 6) (list 0))
(equal? (sequence 0 5 4) (list 0 4))

(print "string-append")
(newline)
(equal? (string-append-map (list "suf" "suf" "suf") "fix") (list "suffix" "suffix" "suffix"))

(print "list-nth-mod")
(newline)
(equal? (list-nth-mod (list 0 1 2 3 4) 2) 1)
(equal? (list-nth-mod (list 0 1 2 3 4) 5) 0)

(print "stream-for-n-steps")
(newline)
(equal? (stream-for-n-steps ones 0) null)
(equal? (stream-for-n-steps funny-number-stream 5) (list 1 2 3 4 -5))

(print "funny-number-stream")
(newline)
(equal? (car ((cdr (funny-number-stream)))) 2)

(print "dan-then-dog")
(newline)
(equal? (stream-for-n-steps dan-then-dog 2) (list "dan.jpg" "dog.jpg"))

(print "stream-add-zero")
(newline)
(equal? (stream-for-n-steps (stream-add-zero ones) 5) (list '(0 . 1) '(0 . 1) '(0 . 1) '(0 . 1) '(0 . 1)))

(print "cycle-lists")
(newline)
(equal? (stream-for-n-steps (cycle-lists (list "f*ck" "the" "D&D")(list "and" "tiffany")) 3) (list '("f*ck" . "and") '("the" . "tiffany") '("D&D" . "and")))

(print "vector-assoc")
(newline)  
(equal? (vector-assoc 1 (vector '(0 . 3) '(1 . 1))) '(1 . 1))
(equal? (vector-assoc 1 (vector '(0 . 3) '(4 . 1))) #f)

(print "cached-assoc")
(newline)
(equal? ((cached-assoc (list '(1 . 1) '(2 . 2)) 10) 1) '(1 . 1))
(equal? ((cached-assoc (list '(1 . 1) '(2 . 2)) 10) 4) #f)

