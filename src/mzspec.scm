(module mzspec scheme
  (require "examples/counting.scm")
  (require "examples/running.scm")
  (require "examples/printing.scm")
  (require "dsl.scm")

  (define-namespace-anchor a)

  (define mzscheme-run-files
    (lambda (file-list [print-fun print])
      (print-examples
       (apply collect-results
              (eval-files file-list))
       print-fun)))

  (define eval-files
    (lambda (file-list)
      (map
       (lambda (file)
         (let ((contents (open-input-file file)))
           (eval (read contents)
                 (namespace-anchor->namespace a))))
       file-list)))


  (provide describe
           it
           collect-results
           passed-example-counts
           failed-example-counts
           print-examples
           mzscheme-run-files)
)