open Printf

let helptext =
  (String.concat "\n"
                 ["usage: ./jy [options] <output-file>";
                  "Generates a public/private keypair using RSA";
                  "";
                  "  -h, --help           show this help text";
                  "  -b, --bits <N>       number of bits (must be a power of 2)";
                  "  -o, --output <file>  output file"])


let show_help () =
  printf "%s\n" helptext ; exit 0


let generate_keypair ~bits =
  let open Cryptokit in
  printf "generating key..." ;
  flush stdout ;
  let rsa_key = RSA.new_key bits in
  printf "done!\n" ;
  (rsa_key.RSA.e, rsa_key.RSA.d)


let save_key file label key =
  let open Cryptokit in
  let b64 = Base64.encode_multiline () |> transform_string in
  let out = open_out file in
  fprintf out
          "RSA %s KEY:\n%s" label
          (b64 key) ;
  close_out out


let save_keys destfile ~pubkey ~privkey =
  save_key (destfile ^ ".pub") "PUBLIC" pubkey ;
  save_key (destfile)          "PRIVATE" privkey


let rec is_pow_2 = function
  | 1 -> true
  | k when k <= 0 -> false
  | k -> (k mod 2 = 0) && is_pow_2 (k / 2)


let main () =
  let bits_r = ref 0 in
  let destfile_r = ref None in
  let set_destfile s =
    match !destfile_r with
    | Some _ -> raise (Failure "output file specified more than once")
    | None -> destfile_r := Some s
  in

  let rec options =
    [ ('b', "bits", None, Some (fun s -> bits_r := (int_of_string s))) ;
      ('o', "output", None, Some set_destfile) ;
      ('h', "help", Some show_help, None) ]
  in

  Getopt.parse_cmdline options set_destfile ;
  match (!destfile_r, !bits_r) with
  | (None, _) ->
     raise (Failure "no output file specified")

  | (_, n) when not (is_pow_2 n) ->
     raise (Failure (sprintf "invalid RSA bits: %d" n))

  | (Some destfile, bits) ->
     let (pubkey, privkey) =
       try
         generate_keypair bits
       with
         e -> raise (Failure "failed to generate key")
     in
     try
       save_keys destfile pubkey privkey
     with e -> raise (Failure "failed to write file")


let _ =
  try
    main ()
  with
  | Failure msg -> printf "error: %s\n" msg
  | Getopt.Error msg -> printf "%s\n" msg ; show_help ()
