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


;; describe "the collect-resultsner"
"collect-resultss an it inside the block"
(define called #f)
(collect-results
 (describe "subject"
   (it "should collect-results the block"
     (set! called #t))))

(check-equal? called #t)

"returns a pair of (#t, description + string) when true"
(check-equal?
 (collect-results
  (describe "foo"
    (it "bar" (eq? #t #t))))
 (list #t "foo bar"))
   
"returns the correct return value"
(check-equal?
 (collect-results
  (describe "foo"
    (it "bar" (eq? #t #f))))
 (list #f "foo bar"))

"uses the correct description string"
(check-equal?
 (collect-results
  (describe "describe string"
    (it "bar" (eq? #t #t))))
 (list #t "describe string bar"))

"uses the correct example name"
(check-equal?
 (collect-results
  (describe "describe string"
    (it "example name" (eq? #t #t))))
 (list #t "describe string example name"))

"should handle multiple examples under the same describe"
(check-equal?
 (collect-results
  (describe "describe"
    (it "should have a first example" (eq? #t #t))
    (it "should have a second example" (eq? #t #t))))
  (list
   #t
   "describe should have a first example"
   #t
   "describe should have a second example"))

"should handle multiple describe blocks"
(check-equal?
 (collect-results
  (describe "describe1"
    (it "should have a first example" (eq? #t #t)))
  (describe "describe2"
    (it "should have a second example" (eq? #t #t))))

 (list
  #t
  "describe1 should have a first example"
  #t
  "describe2 should have a second example"))

;; printing results

;; passes
"should report the # of passes"
(check-equal?
  (passed-example-counts
   (collect-results
    (describe "foo"
      (it "should pass" (eq? #t #t)))))
  1)

"should report the correct # of passes"
(check-equal?
  (passed-example-counts
   (collect-results
    (describe "foo"
      (it "should pass" (eq? #t #t))
      (it "should pass" (eq? #t #t)))))
  2)

"should report 0 passes with one failure, and 0 passes"
(check-equal?
  (passed-example-counts
   (collect-results
    (describe "foo"
      (it "should fail" (eq? #t #f)))))
  0)
  
)