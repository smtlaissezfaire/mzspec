(module mzspec scheme
  (define-syntax describe
    (syntax-rules ()
      ((_ string . body)
       (list string . body))))

  (define-syntax it
    (syntax-rules ()
      ((_ str body)
       (list str (lambda () body)))))

  (define run
    (lambda (pair)
      (let ((describe-name (car pair))
            (it-list       (cdr pair)))

        (cond
         ((list? (car it-list))
          (run-example-group describe-name it-list))
         (else
          (run-example-group describe-name (list it-list)))))))
    
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

  (provide describe it run)
)