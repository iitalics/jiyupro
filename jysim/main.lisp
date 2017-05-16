(load "packages.lisp")

(dolist (f (directory "blockchain/*.lisp"))
  (load f))

(in-package :jysim.main)
(format t "~%Hello, world~%")

(let ((my-block
       (make-instance 'jysim.chain:block%
                      :prev-hash 0
                      :timestamp 0
                      :author 0
                      :signature 0
                      :artifacts '()
                      :order 0
                      :artifacts-hash 0)))
  (declare (ignore my-block))
  nil)
