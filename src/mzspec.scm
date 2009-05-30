(module mzspec scheme
  (require "pluralization.scm")
  (require "example-counting.scm")
  (require "example-running.scm")
  (require "dsl.scm")

  (define print-examples
    (lambda (results print-fun)
      (let ((passed-counts (passed-example-counts results))
            (failed-counts (failed-example-counts results)))
        (print-fun (pluralize (+ passed-counts failed-counts) "example")
                   ", "
                   (pluralize failed-counts "failure")))))

  (provide describe
           it
           collect-results
           passed-example-counts
           failed-example-counts
           print-examples)
)