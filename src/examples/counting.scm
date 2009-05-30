(module counting scheme
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

  (provide passed-example-counts
           failed-example-counts)
)