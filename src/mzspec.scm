(module mzspec scheme
  (define (describe string . body)
    (cons string body))

  (define-syntax it
    (syntax-rules ()
      ((_ str body)
       (list str (lambda () body)))))

  (define passed-example-counts
    (lambda (lst)
      (cond
       ((empty? lst) 0)
       ((eq? (car lst) #t)
        (+ 1 (passed-example-counts (cdr lst))))
       (else
        (passed-example-counts (cdr lst))))))

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

  (provide describe it collect-results passed-example-counts)
)