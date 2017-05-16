type uniq_id = int64   (* dunno *)
type timestamp = int64 (* 8-byte unix timestamp *)
type hashcode = bytes  (* 256 bits = 32 bytes *)
type signature = bytes (* signature is a signed hashcode *)
type pubkey = bytes    (* N-bit key based on what algorithm?? *)
type chan_id = string  (* arbitrary identifier (max-length: 32 chars) *)

type art_data =
  | ArtRoot    of pubkey
  | ArtInvite  of (pubkey * signature * int)
  | ArtThread  of chan_id
  | ArtReply   of (uniq_id * bytes)

type artifact =
  { art_id : uniq_id;
    art_ts : timestamp;
    art_author : uniq_id;
    art_sign : signature;
    art_contents : art_data }

type block =
  { bl_prev : hashcode;
    bl_ts : timestamp;
    bl_author : uniq_id;
    bl_sign : signature;
    bl_arts : artifact list }
