(module test scheme

(require (planet schematics/schemeunit:3:4) "../src/mzspec.scm")

;; describe: test framework
"it runs"
(check-equal?
 #t
 #t)

;; describe "describe"
"uses the string given"
(check-equal?
 (car (describe "foo" #t))
 "foo")

"uses the correct string given"
(check-equal?
 (car (describe "bar" #t))
 "bar")

"has the expr"
(check-equal?
 (cadr (describe "bar" #t))
 #t)


;; describe "it"
"uses the string given"
(check-equal?
 (car (it "foo" (eq? #t #t)))
 "foo")

"uses the correct string"
(check-equal?
 (car (it "bar" (eq? #t #t)))
 "bar")

"wraps the body in a lambda"
(check-equal?
 ((car (cdr (it "bar" (eq? #t #t)))))
 #t)

"returns the correct value from the lambda"
(check-equal?
 ((car (cdr (it "bar" (eq? #t #f)))))
 #f)

"does not evaluate the body immediately"
(define tmp #f)
(it "should not set the var" (set! tmp #t))

(check-equal?
 tmp
 #f)


;; describe "the runner"
"runs an it inside the block"
(define called #f)
(run
 (describe "subject"
   (it "should run the block"
     (set! called #t))))

(check-equal? 
 called
 #t)

"returns a pair of ((#t, description + string)) when true"
(check-equal?
 (run
  (describe "foo"
    (it "bar" (eq? #t #t))))
 (list (list #t "foo bar")))
   
"returns the correct return value"
(check-equal?
 (run
  (describe "foo"
    (it "bar" (eq? #t #f))))
 (list (list #f "foo bar")))

"uses the correct description string"
(check-equal?
 (run
  (describe "describe string"
    (it "bar" (eq? #t #t))))
 (list (list #t "describe string bar")))

"uses the correct example name"
(check-equal?
 (run
  (describe "describe string"
    (it "example name" (eq? #t #t))))
 (list (list #t "describe string example name")))

"should handle multiple examples under the same describe"
(check-equal?
 (run
  (describe "describe"
    (it "should have a first example" (eq? #t #t))
    (it "should have a second example" (eq? #t #t))))
 (list
  (list #t "describe should have a first example")
  (list #t "describe should have a second example")))
  
)