(* TODO: change these to int types with more bits *)
type hashcode = int
type timestamp = int
type art_id = int
type sign = int

type art_type = Root

type artifact = { art_id : art_id
                ; art_ts : timestamp
                ; art_author : art_id
                ; art_sign : sign
                ; art_type : art_type
                ; art_contents : string }

type block = { bl_prev : hashcode
             ; bl_ts : timestamp
             ; bl_author : art_id
             ; bl_sign : sign
             ; bl_arts : artifact list }
