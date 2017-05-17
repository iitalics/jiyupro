
type 'a pipe = 'a list ref

let send p x =
  p := x :: !p
let recv1 p = match !p with
    [] -> None
  | x :: xs -> p := xs ; Some x
let recvall p f =
  let l = !p in p := [] ; List.iter f l


type nodeid = int

type msg
  = M_knownhost  of nodeid
  | M_ping       of nodeid


class type node =
  object
    method step : unit
    method connect : nodeid -> msg pipe -> msg pipe -> unit
  end

let node_to_id : (node, nodeid) Hashtbl.t = Hashtbl.create 99
let id_to_node : (nodeid, node) Hashtbl.t = Hashtbl.create 99

let register_node =
  let nextid = ref 0 in
  function
  | node ->
     nextid := 1 + !nextid ;
     let id = !nextid in
     Hashtbl.add node_to_id node id ;
     Hashtbl.add id_to_node id node ;
     id


let make_fullnode node =
  let node =
    object (self)
      val myid = ref 0
      method init =
        myid := register_node (self :> node)

      val known = Hashtbl.create 32

      method connect id inpipe outpipe =
        ()

      method step =
        myid := 1

    end
  in node#init ; node
