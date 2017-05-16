#lang racket/base
(require racket/contract)

(provide
 (struct-out block)

(struct block (; protocol data
               prev-hash
               timestamp
               auth-id
               sig
               artifacts

               ; extraneous
               arts-hash))


(struct artifact (; protocol data
                  id
                  type
                  auth-id
                  sig
                  contents

                  ; extraneous
                  contents-hash))
