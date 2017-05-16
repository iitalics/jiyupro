(load "packages.lisp")

(dolist (f (directory "blockchain/*"))
  (load f))

(in-package :jysim.main)
(format t "Hello, world~%")
