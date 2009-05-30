(module runner-test scheme

(require (planet schematics/schemeunit:3:4) "../src/mzspec.scm")

;; desc "running files"

(define print-fun
  (lambda (x) x))

"should allow reading from a file name given"
(check-equal?
 (mzscheme-run-files
  (list "test/describe-fixture.scm")
  print-fun)
 "1 example, 0 failures")

"should use the correct results"
(check-equal?
 (mzscheme-run-files
  (list "test/describe-fixture-failure.scm")
  print-fun)
 "1 example, 1 failure")

"should use multiple files"
(check-equal?
 (mzscheme-run-files
  (list "test/describe-fixture-failure.scm" "test/describe-fixture.scm")
  print-fun)
 "2 examples, 1 failure")


)
