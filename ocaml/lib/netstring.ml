(*
 * Copyright (c) 2003  Dustin Sallings <dustin@spy.net>
 *
 * arch-tag: D427C96F-2C1F-11D8-82B6-000393CFE6B8
 *)

(** A netstring implementation. *)

(** Encode a string into a netstring. *)
let encode s =
	(string_of_int (String.length s)) ^ ":" ^ s ^ ","
;;

let listiteri f lin =
	let rec loop x l =
		match l with
		  [] -> ()
		| _ -> f x (List.hd l); loop (x + 1) (List.tl l)
	in loop 0 lin
;;

let chars_to_string l =
	let str = String.create (List.length l) in
	listiteri (fun i c -> str.[i] <- c) l;
	str
;;

(** Get the next netstring from the given stream. *)
let decode in_stream =
	let rec loop l =
		if (List.length l > 10) then failwith "Size too long";
		let c = Stream.next in_stream in
		if (c = ':') then (
			int_of_string (chars_to_string l)
		) else (
			loop (l @ [c])
		) in
	let size = loop [] in
	let data = Stream.npeek size in_stream in
	List.iter (fun _ -> Stream.junk in_stream) data;
	let comma = Stream.next in_stream in
	if (comma != ',') then (
		failwith "Invalid netstring (didn't get a comma in the right place"
	);
	chars_to_string data
;;