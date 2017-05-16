;; packages are declared here using defpackage
;; the main file loads this first, then subsequent package implementation files

(defpackage :jysim.main
  (:use :common-lisp)
  (:export )
  )

(defpackage :jysim.test
  (:use :common-lisp)
  (:export )
  )

(defpackage :jysim.chain
  (:use :common-lisp)
  (:export block%
           artifact%)

  )
