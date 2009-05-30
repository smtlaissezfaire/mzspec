(module printing-test scheme

(require (planet schematics/schemeunit:3:4) "../src/examples/printing.scm")

"should use print as the default printing function when none is given"
(check-equal?
 default-print-function
 print)

)
