open Core.Std
open Async.Std
open Cohttp
open Cohttp_async

type region =
  | Ap_northeast_1
  | Ap_southeast_1
  | Ap_southeast_2
  | Eu_central_1
  | Eu_west_1
  | Sa_east_1
  | Us_east_1
  | Us_west_1
  | Us_west_2

val region_of_string : string -> region
val gzip_data : ?level:int -> String.t -> string
val make_request :
  ?body:String.t ->
  ?region:region ->
  ?credentials:Credentials.t ->
  headers:(string * string) List.t ->
  meth:Code.meth ->
  path:string ->
  query:(string * string) List.t ->
  unit ->
  (Response.t * Body.t) Deferred.t

val yojson_of_xml :
  Xml.xml -> Yojson.Safe.json

module Test : sig
  val async : ('a -> 'b Deferred.t) -> 'a -> 'b
  val gunzip : string -> string Or_error.t Deferred.t
  val test_gzip : 'a -> unit Deferred.t
  val unit_test : OUnit2.test
end