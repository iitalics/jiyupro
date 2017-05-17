(* NOTE:
 * ocaml 'string' = immutable byte array
 * ocaml 'bytes'  =   mutable byte array
 *)
type uniq_id = string   (* dunno *)
type timestamp = int64  (* 8-byte unix timestamp *)
type hashcode = string  (* 256 bits = 32 bytes *)
type signature = string (* signature is a signed hashcode *)
type pubkey = string

type art_data =
  | ArtRoot    of pubkey
  | ArtInvite  of (pubkey * signature * int)
  | ArtThread  of string
  | ArtReply   of (uniq_id * string)

type artifact =
  { art_id : uniq_id;
    art_ts : timestamp;
    art_author : uniq_id;
    art_sign : signature;
    art_kind : int;
    art_contents : bytes }

type block =
  { bl_prev : hashcode;
    bl_ts : timestamp;
    bl_author : uniq_id;
    bl_sign : signature;
    bl_arts : artifact list }
