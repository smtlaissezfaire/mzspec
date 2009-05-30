(module mzspec scheme
  (require "example-counting.scm")
  (require "example-running.scm")
  (require "example-printing.scm")
  (require "dsl.scm")

  (provide describe
           it
           collect-results
           passed-example-counts
           failed-example-counts
           print-examples)
)