open Printf

let generate_keypair ident bits ?(verbose=true) =
  let open Cryptokit in
  if verbose then (printf "generating key for %s (%d bit RSA)..." ident bits ;
                   flush stdout) ;
  let rsa_key = RSA.new_key bits in
  if verbose then printf "done!\n" ;
  (rsa_key.RSA.e, rsa_key.RSA.d)


let save_keys ident pubkey privkey =
  let save_key file label key =
    let open Cryptokit in
    let to_b64 = transform_string (Base64.encode_multiline ()) in
    let out = open_out file in
    fprintf out "RSA %s KEY:\n%s" label (to_b64 key) ;
    close_out out
  in
  save_key (ident ^ ".pub") "PUBLIC" pubkey ;
  save_key (ident         ) "PRIVATE" privkey


let generate_and_save ident ?(bits=4096) ?(verbose=true) =
  let (pub,priv) = generate_keypair ident bits ~verbose:verbose in
  save_keys ident pub priv
