open Printf

let () =
  let open Cryptokit in
  let to_b64 = Base64.encode_compact () |> Cryptokit.transform_string in

  printf "generating key..." ; flush stdout ;
  let key = RSA.new_key 1024 in
  printf "done.\n" ; flush stdout ;

  let plain = String.init 300 (fun x -> if x mod 2 = 0 then 'a' else 'b') in
  let ciph = RSA.encrypt key plain in
  let decr = (RSA.decrypt_CRT key ciph) in
  printf "key: %s\n" (to_b64 key.RSA.q) ;
  printf "ciphertext: %s (%d)\n" (to_b64 ciph) (String.length ciph) ;
  printf "decrypted:  %s (%d)\n" decr (String.length decr) ;
