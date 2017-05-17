open Printf

let helptext =
  String.concat "\n"
                [ "usage: ./jy <identity> [options]";
                  "";
                  "  -h, --help               show this help text";
                  "  -k, --keygen             run the keygenerator";
                ]

let help_and_quit () =
  print_string helptext ; print_newline () ; exit 0




let () =
  let id_ref = ref "" in
  let run_keygen () =
    match !id_ref with
      "" -> raise (Failure "no identity specified")
    | ident ->
       Keygen.generate_and_save ident ~bits:1024 ~verbose:true ;
       exit 0
  in
  let options =
    [ ('h', "help", Some help_and_quit, None) ;
      ('k', "keygen", Some run_keygen, None) ]
  in
  Getopt.parse_cmdline options (fun s ->
                         match !id_ref with
                           "" -> id_ref := s
                         | _ -> raise (Invalid_argument "identity")) ;
  help_and_quit ()
