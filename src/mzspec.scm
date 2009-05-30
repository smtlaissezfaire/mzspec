(module mzspec scheme
  (require "examples/counting.scm")
  (require "examples/running.scm")
  (require "examples/printing.scm")
  (require "dsl.scm")

  (provide describe
           it
           collect-results
           passed-example-counts
           failed-example-counts
           print-examples)
)