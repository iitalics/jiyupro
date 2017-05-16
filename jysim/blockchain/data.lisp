(in-package :jiyu.chain)

;; note about naming:
;;  'aid' = artifact id
;;  'art(s)' = artifact(s)

;; TODO: add type information


(defstruct block
  ;; protocol data
  pred-hash
  timestamp
  author-aid
  sig
  arts

  ;; extra/cached data
  ord-number
  arts-hash
  )


(defstruct artifact
  ;; protocol data
  id
  type
  timestamp
  author-aid
  sig
  contents

  ;; extra data
  contents-hash)
