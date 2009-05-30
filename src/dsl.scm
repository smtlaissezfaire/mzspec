(module dsl scheme
  (define (describe string . body)
    (cons string body))

  (define-syntax it
    (syntax-rules ()
      ((_ str body)
       (list str (lambda () body)))))

  (provide describe it)
)