(module mzspec scheme
  (require "pluralization.scm")
  (require "dsl.scm")

  (define passed-example-counts
    (lambda (lst)
      (sum-example-counts lst #t)))

  (define failed-example-counts
    (lambda (lst)
      (sum-example-counts lst #f)))

  (define sum-example-counts
    (lambda (lst match-value)
      (cond
       ((empty? lst) 0)
       ((eq? (car lst) match-value)
        (+ 1 (sum-example-counts (cdr lst) match-value)))
       (else
        (sum-example-counts (cdr lst) match-value)))))

  (define print-examples
    (lambda (results print-fun)
      (let ((passed-counts (passed-example-counts results))
            (failed-counts (failed-example-counts results)))
        (print-fun (pluralize (+ passed-counts failed-counts) "example")
                   ", "
                   (pluralize failed-counts "failure")))))


  (define (collect-results . blocks)
    (flatten (run-multiple-blocks blocks)))

  (define run-multiple-blocks
    (lambda (blocks)
      (cond
       ((empty? blocks) '())
       (else
        (cons
         (run-describe-block (car blocks))
         (run-multiple-blocks (cdr blocks)))))))

  (define (run-describe-block describe-block)
    (let ((describe-name (car describe-block))
          (it-list (cdr describe-block)))
      (run-example-group describe-name it-list)))
    
  (define run-example-group
    (lambda (describe-name it-list)
      (map (lambda (it-pair)
             (run-example describe-name it-pair))
           it-list)))

  (define run-example
    (lambda (description-name it-pair)
      (let ((example-name (car it-pair))
            (return-value ((cadr it-pair))))
         (list return-value
               (string-append
                description-name
                " "
                example-name)))))

  (provide describe
           it
           collect-results
           passed-example-counts
           failed-example-counts
           print-examples)
)