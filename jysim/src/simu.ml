(*************)

(*** pipe utilities ***)
type 'a pipe = 'a list ref

let send x p =
  p := x :: !p
let recv1 p = match !p with
    [] -> None
  | x :: xs -> p := xs ; Some x
let recvall f p =
  let l = !p in p := [] ; List.iter f l


(*** nodes and messages ***)
type nodeid = int

type msg
  = M_knownhost of nodeid
  | M_ping

class type node =
  object
    method step : unit
    method on_connect : nodeid -> msg pipe -> msg pipe -> unit
  end


(*** global node lookup ***)
let node_to_id : (node, nodeid) Hashtbl.t = Hashtbl.create 99
let id_to_node : (nodeid, node) Hashtbl.t = Hashtbl.create 99

(* register the given node; adds it to the global table and returns its new ID *)
let register_node =
  let nextid = ref 0 in
  fun node -> nextid := 1 + !nextid ;
              let id = !nextid in
              Hashtbl.add node_to_id node id ;
              Hashtbl.add id_to_node id node ;
              id


(* create a connection between two nodes, by their IDs *)
let connect_node aid bid =
  let a_to_b = ref [] in
  let b_to_a = ref [] in
  let a = Hashtbl.find id_to_node aid in
  let b = Hashtbl.find id_to_node bid in
  a#on_connect bid b_to_a a_to_b ;
  b#on_connect aid a_to_b b_to_a


(*** Full-node implementation ***)
module Fullnode =
  struct
    type conn = { conn_id : int;
                  inpipe : msg pipe;
                  outpipe : msg pipe }

    class type t =
      object
        method init : unit
        method add_known_host : nodeid -> unit
        method step : unit
      end

    let process_con (node : t) con =
      recvall (function
               | M_knownhost id -> node#add_known_host id
               | M_ping -> ())
              con.inpipe

    class im max_conns =
    object (self)
      val myid = ref 0
      val known : (nodeid, unit) Hashtbl.t = Hashtbl.create ~random:true 32
      val conns = ref []

      (* intialize this node (automatically called) *)
      method init =
        myid := register_node (self :> node)

      (* add a host to the list of known hosts *)
      method add_known_host id =
        Hashtbl.add known id ()

      (* called when another node connects to this node *)
      method on_connect id inpipe outpipe =
        if List.length !conns < max_conns then
          conns := { conn_id = id;
                     inpipe = inpipe;
                     outpipe = outpipe } :: !conns

      (* advance the simulation *)
      method step =
        List.iter (process_con (self :> t)) !conns
    end

  end
