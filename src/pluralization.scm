(module pluralization scheme
  (define pluralize
    (lambda (num name)
      (cond
       ((eq? num 1) (string-append "1 " name))
       (else
        (string-append (number->string num) " " name "s")))))

  (provide pluralize)
)
