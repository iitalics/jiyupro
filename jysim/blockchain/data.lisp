(in-package :jysim.chain)

;; note about naming:
;;  'aid' = artifact id
;;  'art(s)' = artifact(s)

;; TODO: add type information


(defclass block% ()
  (;; protocol data
   (prev-hash   :initarg :prev-hash)
   (timestamp   :initarg :timestamp)
   (author-aid  :initarg :author)
   (sig         :initarg :signature)
   (arts        :initarg :artifacts)
   ;; extra data
   (ord         :initarg :order)
   (arts-hash   :initarg :artifacts-hash))

  (:documentation "A single block in the blockchain"))


(defclass artifact% ()
  (;; protocol data
   (id            :initarg :id)
   (type          :initarg :type)
   (timestamp     :initarg :timestamp)
   (author-aid    :initarg :author-aid)
   (sig           :initarg :signature)
   (contents      :initarg :contents)
   ;; extra data
   (contents-hash :initarg :contents-hash))

  (:documentation "A single artifact"))
