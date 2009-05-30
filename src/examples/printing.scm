(module printing scheme
  (require "pluralization.scm")
  (require "counting.scm")

  (define print-examples
    (lambda (results [print-fun default-print-function])
      (let ((passed-counts (passed-example-counts results))
            (failed-counts (failed-example-counts results)))
        (print-fun
         (string-append
          (pluralize (+ passed-counts failed-counts) "example")
          ", "
          (pluralize failed-counts "failure"))))))

  (define default-print-function print)

  (provide print-examples default-print-function)
)

