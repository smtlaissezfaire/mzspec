(module example-running scheme
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

  (provide run-multiple-blocks)
)
