type token =
  | INT_CAST
  | FLOAT_CAST
  | INT of (int)
  | FLOAT of (float)
  | VAR of (string)
  | TRUE
  | FALSE
  | SEQ
  | SKIP
  | IF
  | THEN
  | ELSE
  | WHILE
  | DO
  | DONE
  | FOR
  | LT
  | LTE
  | EQ
  | ASGNOP
  | DEREF
  | PLUS
  | MINUS
  | MUL
  | DIV
  | LPAREN
  | RPAREN
  | LAC
  | RAC
  | FUN
  | COLON
  | LET
  | REC
  | IN
  | REF
  | TINT
  | TBOOL
  | TUNIT
  | TFLOAT
  | ARROW
  | PCT
  | EOF

open Parsing;;
let _ = parse_error;;
# 3 "parser.mly"
(* Open is used for importing another module. 
   Each file is organized as a module with the module name being the
   file name without extension where the first letter is capitalized
*)
open ImpAST  (* refer to definitions from ImpAST directly *)
open Lexing  (* Lexing is a predefined library used for lexing *)

(* Formats a string describing the location of the production being currently 
   parsed *)
let location () =  let start_pos = Parsing.symbol_start_pos () in
    let end_pos = Parsing.symbol_end_pos () in
    (start_pos.pos_fname,start_pos.pos_lnum, start_pos.pos_cnum - start_pos.pos_bol, end_pos.pos_lnum, end_pos.pos_cnum - end_pos.pos_bol)

(* Throws a ParseError with the specified location*)
let parseError loc = raise (Lexer.ParseError loc)

# 65 "parser.ml"
let yytransl_const = [|
  257 (* INT_CAST *);
  258 (* FLOAT_CAST *);
  262 (* TRUE *);
  263 (* FALSE *);
  264 (* SEQ *);
  265 (* SKIP *);
  266 (* IF *);
  267 (* THEN *);
  268 (* ELSE *);
  269 (* WHILE *);
  270 (* DO *);
  271 (* DONE *);
  272 (* FOR *);
  273 (* LT *);
  274 (* LTE *);
  275 (* EQ *);
  276 (* ASGNOP *);
  277 (* DEREF *);
  278 (* PLUS *);
  279 (* MINUS *);
  280 (* MUL *);
  281 (* DIV *);
  282 (* LPAREN *);
  283 (* RPAREN *);
  284 (* LAC *);
  285 (* RAC *);
  286 (* FUN *);
  287 (* COLON *);
  288 (* LET *);
  289 (* REC *);
  290 (* IN *);
  291 (* REF *);
  292 (* TINT *);
  293 (* TBOOL *);
  294 (* TUNIT *);
  295 (* TFLOAT *);
  296 (* ARROW *);
  297 (* PCT *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  259 (* INT *);
  260 (* FLOAT *);
  261 (* VAR *);
    0|]

let yylhs = "\255\255\
\001\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\004\000\004\000\004\000\004\000\
\004\000\004\000\004\000\004\000\004\000\004\000\004\000\000\000"

let yylen = "\002\000\
\002\000\001\000\001\000\001\000\001\000\003\000\003\000\003\000\
\002\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\006\000\005\000\009\000\008\000\009\000\006\000\
\010\000\002\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\003\000\002\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\028\000\035\000\036\000\029\000\030\000\034\000\
\031\000\032\000\033\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\040\000\000\000\027\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\001\000\026\000\000\000\000\000\000\000\037\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\020\000\000\000\000\000\
\000\000\000\000\002\000\003\000\004\000\005\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\009\000\
\000\000\000\000\000\000\000\000\000\000\007\000\008\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\025\000"

let yydgoto = "\002\000\
\021\000\053\000\079\000\023\000"

let yysindex = "\018\000\
\169\003\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\169\003\169\003\232\254\169\003\169\003\
\022\255\008\255\255\254\169\003\000\000\001\000\000\000\004\001\
\045\001\169\003\004\255\086\001\016\255\041\255\036\255\052\255\
\004\255\169\003\169\003\169\003\169\003\169\003\169\003\169\003\
\169\003\169\003\000\000\000\000\169\003\169\003\076\002\000\000\
\169\003\028\255\169\003\037\255\117\002\052\003\052\003\052\003\
\079\003\079\003\106\003\106\003\117\002\127\001\168\001\169\003\
\158\002\024\255\209\001\024\255\169\003\000\000\199\002\205\003\
\024\255\024\255\000\000\000\000\000\000\000\000\241\254\169\003\
\014\255\210\255\169\003\048\255\252\254\029\255\032\255\000\000\
\024\255\117\002\169\003\250\001\169\003\000\000\000\000\169\003\
\030\255\035\002\169\003\240\002\117\002\169\003\210\255\133\003\
\117\002\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\029\000\000\000\000\000\000\000\000\000\000\000\
\056\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\192\000\157\000\167\000\146\000\
\110\000\128\000\074\000\092\000\201\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\175\000\000\000\025\003\000\000\000\000\000\000\000\000\
\000\000\209\000\000\000\000\000\000\000\000\000\000\000\000\000\
\253\254\000\000\000\000\000\000\218\000\000\000\184\000\000\000\
\226\000\000\000"

let yygindex = "\000\000\
\000\000\002\000\188\255\078\000"

let yytablesize = 1264
let yytable = "\081\000\
\043\000\026\000\022\000\031\000\085\000\086\000\006\000\007\000\
\008\000\009\000\010\000\087\000\011\000\024\000\025\000\006\000\
\027\000\028\000\001\000\088\000\097\000\033\000\094\000\006\000\
\089\000\006\000\029\000\047\000\038\000\016\000\088\000\032\000\
\091\000\030\000\049\000\089\000\054\000\055\000\056\000\057\000\
\058\000\059\000\060\000\061\000\042\000\050\000\062\000\063\000\
\088\000\073\000\065\000\074\000\067\000\089\000\051\000\039\000\
\052\000\095\000\066\000\075\000\076\000\077\000\078\000\088\000\
\088\000\071\000\093\000\068\000\089\000\089\000\082\000\096\000\
\000\000\012\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\090\000\000\000\000\000\092\000\000\000\000\000\000\000\
\000\000\000\000\000\000\013\000\098\000\000\000\100\000\000\000\
\000\000\101\000\000\000\044\000\103\000\044\000\044\000\105\000\
\044\000\044\000\000\000\000\000\000\000\010\000\044\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\044\000\000\000\000\000\011\000\
\000\000\000\000\044\000\044\000\044\000\044\000\044\000\044\000\
\044\000\044\000\044\000\044\000\044\000\000\000\044\000\000\000\
\044\000\015\000\000\000\000\000\044\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\017\000\000\000\000\000\044\000\
\000\000\000\000\000\000\000\000\000\000\000\000\016\000\044\000\
\000\000\044\000\000\000\000\000\000\000\000\000\019\000\044\000\
\000\000\044\000\044\000\000\000\044\000\000\000\044\000\021\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\018\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\014\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\024\000\000\000\004\000\005\000\006\000\007\000\008\000\009\000\
\010\000\022\000\011\000\000\000\000\000\000\000\000\000\000\000\
\000\000\023\000\035\000\036\000\000\000\037\000\015\000\038\000\
\039\000\040\000\041\000\016\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\020\000\000\000\000\000\000\000\
\000\000\000\000\042\000\000\000\000\000\000\000\000\000\000\000\
\000\000\004\000\005\000\006\000\007\000\008\000\009\000\010\000\
\034\000\011\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\035\000\036\000\000\000\037\000\015\000\038\000\039\000\
\040\000\041\000\016\000\000\000\000\000\038\000\038\000\000\000\
\000\000\000\000\000\000\020\000\038\000\000\000\000\000\038\000\
\038\000\042\000\038\000\038\000\000\000\038\000\038\000\000\000\
\038\000\000\000\038\000\038\000\038\000\038\000\000\000\038\000\
\039\000\039\000\000\000\000\000\000\000\000\000\038\000\039\000\
\000\000\000\000\039\000\039\000\000\000\039\000\039\000\000\000\
\039\000\039\000\000\000\039\000\000\000\039\000\039\000\039\000\
\039\000\012\000\039\000\000\000\012\000\012\000\000\000\012\000\
\012\000\039\000\012\000\012\000\000\000\012\000\000\000\012\000\
\012\000\012\000\012\000\013\000\012\000\000\000\013\000\013\000\
\000\000\013\000\013\000\012\000\013\000\013\000\000\000\013\000\
\000\000\013\000\013\000\013\000\013\000\010\000\013\000\000\000\
\010\000\010\000\000\000\010\000\010\000\013\000\010\000\010\000\
\000\000\010\000\000\000\010\000\010\000\000\000\000\000\011\000\
\010\000\000\000\011\000\011\000\000\000\011\000\011\000\010\000\
\011\000\011\000\000\000\011\000\000\000\011\000\011\000\000\000\
\000\000\015\000\011\000\000\000\015\000\015\000\000\000\015\000\
\015\000\011\000\015\000\015\000\017\000\000\000\000\000\017\000\
\017\000\000\000\017\000\017\000\015\000\000\000\016\000\000\000\
\000\000\016\000\016\000\015\000\016\000\016\000\019\000\017\000\
\000\000\019\000\019\000\000\000\019\000\019\000\017\000\021\000\
\000\000\016\000\021\000\021\000\000\000\021\000\021\000\000\000\
\016\000\019\000\018\000\018\000\000\000\018\000\018\000\000\000\
\019\000\000\000\021\000\014\000\014\000\000\000\014\000\014\000\
\000\000\021\000\018\000\024\000\024\000\000\000\024\000\024\000\
\000\000\018\000\000\000\014\000\022\000\022\000\000\000\022\000\
\022\000\000\000\014\000\024\000\023\000\023\000\000\000\023\000\
\023\000\000\000\024\000\000\000\022\000\000\000\000\000\000\000\
\000\000\000\000\000\000\022\000\023\000\000\000\000\000\000\000\
\000\000\000\000\000\000\023\000\004\000\005\000\006\000\007\000\
\008\000\009\000\010\000\034\000\011\000\000\000\045\000\000\000\
\000\000\000\000\000\000\000\000\035\000\036\000\000\000\037\000\
\015\000\038\000\039\000\040\000\041\000\016\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\020\000\000\000\
\000\000\000\000\000\000\000\000\042\000\004\000\005\000\006\000\
\007\000\008\000\009\000\010\000\034\000\011\000\000\000\000\000\
\000\000\000\000\046\000\000\000\000\000\035\000\036\000\000\000\
\037\000\015\000\038\000\039\000\040\000\041\000\016\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\020\000\
\000\000\000\000\000\000\000\000\000\000\042\000\004\000\005\000\
\006\000\007\000\008\000\009\000\010\000\034\000\011\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\035\000\036\000\
\000\000\037\000\015\000\038\000\039\000\040\000\041\000\016\000\
\048\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\020\000\000\000\000\000\000\000\000\000\000\000\042\000\004\000\
\005\000\006\000\007\000\008\000\009\000\010\000\034\000\011\000\
\000\000\000\000\069\000\000\000\000\000\000\000\000\000\035\000\
\036\000\000\000\037\000\015\000\038\000\039\000\040\000\041\000\
\016\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\020\000\000\000\000\000\000\000\000\000\000\000\042\000\
\004\000\005\000\006\000\007\000\008\000\009\000\010\000\034\000\
\011\000\000\000\000\000\000\000\000\000\000\000\070\000\000\000\
\035\000\036\000\000\000\037\000\015\000\038\000\039\000\040\000\
\041\000\016\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\020\000\000\000\000\000\000\000\000\000\000\000\
\042\000\004\000\005\000\006\000\007\000\008\000\009\000\010\000\
\034\000\011\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\035\000\036\000\000\000\037\000\015\000\038\000\039\000\
\040\000\041\000\016\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\080\000\020\000\000\000\000\000\000\000\000\000\
\000\000\042\000\004\000\005\000\006\000\007\000\008\000\009\000\
\010\000\034\000\011\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\035\000\036\000\000\000\037\000\015\000\038\000\
\039\000\040\000\041\000\016\000\099\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\020\000\000\000\000\000\000\000\
\000\000\000\000\042\000\004\000\005\000\006\000\007\000\008\000\
\009\000\010\000\034\000\011\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\035\000\036\000\000\000\037\000\015\000\
\038\000\039\000\040\000\041\000\016\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\102\000\020\000\000\000\000\000\
\000\000\000\000\000\000\042\000\004\000\005\000\006\000\007\000\
\008\000\009\000\010\000\064\000\011\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\035\000\036\000\000\000\037\000\
\015\000\038\000\039\000\040\000\041\000\016\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\020\000\000\000\
\000\000\000\000\000\000\000\000\042\000\004\000\005\000\006\000\
\007\000\008\000\009\000\010\000\034\000\011\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\035\000\036\000\000\000\
\037\000\015\000\038\000\039\000\040\000\041\000\016\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\020\000\
\000\000\000\000\000\000\000\000\000\000\042\000\004\000\005\000\
\006\000\007\000\008\000\009\000\010\000\072\000\011\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\035\000\036\000\
\000\000\037\000\015\000\038\000\039\000\040\000\041\000\016\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\020\000\000\000\000\000\000\000\000\000\000\000\042\000\004\000\
\005\000\006\000\007\000\008\000\009\000\010\000\083\000\011\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\035\000\
\036\000\000\000\037\000\015\000\038\000\039\000\040\000\041\000\
\016\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\020\000\000\000\000\000\000\000\000\000\000\000\042\000\
\004\000\005\000\006\000\007\000\008\000\009\000\010\000\104\000\
\011\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\035\000\036\000\000\000\037\000\015\000\038\000\039\000\040\000\
\041\000\016\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\020\000\000\000\000\000\000\000\000\000\000\000\
\042\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
\034\000\034\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\034\000\034\000\000\000\034\000\034\000\034\000\034\000\
\034\000\034\000\034\000\000\000\004\000\005\000\006\000\007\000\
\008\000\009\000\010\000\034\000\011\000\000\000\000\000\000\000\
\000\000\034\000\000\000\000\000\000\000\000\000\000\000\037\000\
\015\000\038\000\039\000\040\000\041\000\016\000\000\000\004\000\
\005\000\006\000\007\000\008\000\009\000\010\000\020\000\011\000\
\000\000\000\000\000\000\000\000\042\000\000\000\000\000\000\000\
\000\000\000\000\000\000\015\000\000\000\000\000\040\000\041\000\
\016\000\000\000\004\000\005\000\006\000\007\000\008\000\009\000\
\010\000\020\000\011\000\000\000\000\000\000\000\000\000\042\000\
\000\000\000\000\000\000\000\000\000\000\000\000\015\000\000\000\
\000\000\000\000\000\000\016\000\003\000\004\000\005\000\006\000\
\007\000\008\000\009\000\010\000\020\000\011\000\012\000\000\000\
\000\000\013\000\042\000\000\000\014\000\000\000\000\000\000\000\
\000\000\015\000\000\000\000\000\000\000\000\000\016\000\000\000\
\017\000\106\000\018\000\000\000\019\000\000\000\000\000\020\000\
\003\000\004\000\005\000\006\000\007\000\008\000\009\000\010\000\
\000\000\011\000\012\000\000\000\000\000\013\000\000\000\000\000\
\014\000\000\000\000\000\000\000\000\000\015\000\000\000\000\000\
\000\000\000\000\016\000\000\000\017\000\000\000\018\000\000\000\
\019\000\000\000\000\000\020\000\003\000\004\000\005\000\006\000\
\007\000\084\000\009\000\010\000\000\000\011\000\012\000\000\000\
\000\000\013\000\000\000\000\000\014\000\000\000\000\000\000\000\
\000\000\015\000\000\000\000\000\000\000\000\000\016\000\000\000\
\017\000\000\000\018\000\000\000\019\000\000\000\000\000\020\000"

let yycheck = "\068\000\
\000\000\026\001\001\000\005\001\073\000\074\000\003\001\004\001\
\005\001\006\001\007\001\027\001\009\001\012\000\013\000\019\001\
\015\000\016\000\001\000\035\001\089\000\020\000\027\001\027\001\
\040\001\029\001\005\001\026\000\000\000\026\001\035\001\033\001\
\019\001\026\001\019\001\040\001\035\000\036\000\037\000\038\000\
\039\000\040\000\041\000\042\000\041\001\005\001\045\000\046\000\
\035\001\026\001\049\000\028\001\051\000\040\001\019\001\000\000\
\005\001\029\001\031\001\036\001\037\001\038\001\039\001\035\001\
\035\001\064\000\019\001\031\001\040\001\040\001\069\000\040\001\
\255\255\000\000\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\080\000\255\255\255\255\083\000\255\255\255\255\255\255\
\255\255\255\255\255\255\000\000\091\000\255\255\093\000\255\255\
\255\255\096\000\255\255\022\000\099\000\024\000\025\000\102\000\
\027\000\028\000\255\255\255\255\255\255\000\000\033\000\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\047\000\255\255\255\255\000\000\
\255\255\255\255\053\000\054\000\055\000\056\000\057\000\058\000\
\059\000\060\000\061\000\062\000\063\000\255\255\065\000\255\255\
\067\000\000\000\255\255\255\255\071\000\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\000\000\255\255\255\255\082\000\
\255\255\255\255\255\255\255\255\255\255\255\255\000\000\090\000\
\255\255\092\000\255\255\255\255\255\255\255\255\000\000\098\000\
\255\255\100\000\101\000\255\255\103\000\255\255\105\000\000\000\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\000\000\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\000\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\000\000\255\255\001\001\002\001\003\001\004\001\005\001\006\001\
\007\001\000\000\009\001\255\255\255\255\255\255\255\255\255\255\
\255\255\000\000\017\001\018\001\255\255\020\001\021\001\022\001\
\023\001\024\001\025\001\026\001\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\035\001\255\255\255\255\255\255\
\255\255\255\255\041\001\255\255\255\255\255\255\255\255\255\255\
\255\255\001\001\002\001\003\001\004\001\005\001\006\001\007\001\
\008\001\009\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\017\001\018\001\255\255\020\001\021\001\022\001\023\001\
\024\001\025\001\026\001\255\255\255\255\001\001\002\001\255\255\
\255\255\255\255\255\255\035\001\008\001\255\255\255\255\011\001\
\012\001\041\001\014\001\015\001\255\255\017\001\018\001\255\255\
\020\001\255\255\022\001\023\001\024\001\025\001\255\255\027\001\
\001\001\002\001\255\255\255\255\255\255\255\255\034\001\008\001\
\255\255\255\255\011\001\012\001\255\255\014\001\015\001\255\255\
\017\001\018\001\255\255\020\001\255\255\022\001\023\001\024\001\
\025\001\008\001\027\001\255\255\011\001\012\001\255\255\014\001\
\015\001\034\001\017\001\018\001\255\255\020\001\255\255\022\001\
\023\001\024\001\025\001\008\001\027\001\255\255\011\001\012\001\
\255\255\014\001\015\001\034\001\017\001\018\001\255\255\020\001\
\255\255\022\001\023\001\024\001\025\001\008\001\027\001\255\255\
\011\001\012\001\255\255\014\001\015\001\034\001\017\001\018\001\
\255\255\020\001\255\255\022\001\023\001\255\255\255\255\008\001\
\027\001\255\255\011\001\012\001\255\255\014\001\015\001\034\001\
\017\001\018\001\255\255\020\001\255\255\022\001\023\001\255\255\
\255\255\008\001\027\001\255\255\011\001\012\001\255\255\014\001\
\015\001\034\001\017\001\018\001\008\001\255\255\255\255\011\001\
\012\001\255\255\014\001\015\001\027\001\255\255\008\001\255\255\
\255\255\011\001\012\001\034\001\014\001\015\001\008\001\027\001\
\255\255\011\001\012\001\255\255\014\001\015\001\034\001\008\001\
\255\255\027\001\011\001\012\001\255\255\014\001\015\001\255\255\
\034\001\027\001\011\001\012\001\255\255\014\001\015\001\255\255\
\034\001\255\255\027\001\011\001\012\001\255\255\014\001\015\001\
\255\255\034\001\027\001\011\001\012\001\255\255\014\001\015\001\
\255\255\034\001\255\255\027\001\011\001\012\001\255\255\014\001\
\015\001\255\255\034\001\027\001\011\001\012\001\255\255\014\001\
\015\001\255\255\034\001\255\255\027\001\255\255\255\255\255\255\
\255\255\255\255\255\255\034\001\027\001\255\255\255\255\255\255\
\255\255\255\255\255\255\034\001\001\001\002\001\003\001\004\001\
\005\001\006\001\007\001\008\001\009\001\255\255\011\001\255\255\
\255\255\255\255\255\255\255\255\017\001\018\001\255\255\020\001\
\021\001\022\001\023\001\024\001\025\001\026\001\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\035\001\255\255\
\255\255\255\255\255\255\255\255\041\001\001\001\002\001\003\001\
\004\001\005\001\006\001\007\001\008\001\009\001\255\255\255\255\
\255\255\255\255\014\001\255\255\255\255\017\001\018\001\255\255\
\020\001\021\001\022\001\023\001\024\001\025\001\026\001\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\035\001\
\255\255\255\255\255\255\255\255\255\255\041\001\001\001\002\001\
\003\001\004\001\005\001\006\001\007\001\008\001\009\001\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\017\001\018\001\
\255\255\020\001\021\001\022\001\023\001\024\001\025\001\026\001\
\027\001\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\035\001\255\255\255\255\255\255\255\255\255\255\041\001\001\001\
\002\001\003\001\004\001\005\001\006\001\007\001\008\001\009\001\
\255\255\255\255\012\001\255\255\255\255\255\255\255\255\017\001\
\018\001\255\255\020\001\021\001\022\001\023\001\024\001\025\001\
\026\001\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\035\001\255\255\255\255\255\255\255\255\255\255\041\001\
\001\001\002\001\003\001\004\001\005\001\006\001\007\001\008\001\
\009\001\255\255\255\255\255\255\255\255\255\255\015\001\255\255\
\017\001\018\001\255\255\020\001\021\001\022\001\023\001\024\001\
\025\001\026\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\035\001\255\255\255\255\255\255\255\255\255\255\
\041\001\001\001\002\001\003\001\004\001\005\001\006\001\007\001\
\008\001\009\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\017\001\018\001\255\255\020\001\021\001\022\001\023\001\
\024\001\025\001\026\001\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\034\001\035\001\255\255\255\255\255\255\255\255\
\255\255\041\001\001\001\002\001\003\001\004\001\005\001\006\001\
\007\001\008\001\009\001\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\017\001\018\001\255\255\020\001\021\001\022\001\
\023\001\024\001\025\001\026\001\027\001\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\035\001\255\255\255\255\255\255\
\255\255\255\255\041\001\001\001\002\001\003\001\004\001\005\001\
\006\001\007\001\008\001\009\001\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\017\001\018\001\255\255\020\001\021\001\
\022\001\023\001\024\001\025\001\026\001\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\034\001\035\001\255\255\255\255\
\255\255\255\255\255\255\041\001\001\001\002\001\003\001\004\001\
\005\001\006\001\007\001\008\001\009\001\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\017\001\018\001\255\255\020\001\
\021\001\022\001\023\001\024\001\025\001\026\001\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\035\001\255\255\
\255\255\255\255\255\255\255\255\041\001\001\001\002\001\003\001\
\004\001\005\001\006\001\007\001\008\001\009\001\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\017\001\018\001\255\255\
\020\001\021\001\022\001\023\001\024\001\025\001\026\001\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\035\001\
\255\255\255\255\255\255\255\255\255\255\041\001\001\001\002\001\
\003\001\004\001\005\001\006\001\007\001\008\001\009\001\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\017\001\018\001\
\255\255\020\001\021\001\022\001\023\001\024\001\025\001\026\001\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\035\001\255\255\255\255\255\255\255\255\255\255\041\001\001\001\
\002\001\003\001\004\001\005\001\006\001\007\001\008\001\009\001\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\017\001\
\018\001\255\255\020\001\021\001\022\001\023\001\024\001\025\001\
\026\001\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\035\001\255\255\255\255\255\255\255\255\255\255\041\001\
\001\001\002\001\003\001\004\001\005\001\006\001\007\001\008\001\
\009\001\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\017\001\018\001\255\255\020\001\021\001\022\001\023\001\024\001\
\025\001\026\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\035\001\255\255\255\255\255\255\255\255\255\255\
\041\001\001\001\002\001\003\001\004\001\005\001\006\001\007\001\
\008\001\009\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\017\001\018\001\255\255\020\001\021\001\022\001\023\001\
\024\001\025\001\026\001\255\255\001\001\002\001\003\001\004\001\
\005\001\006\001\007\001\035\001\009\001\255\255\255\255\255\255\
\255\255\041\001\255\255\255\255\255\255\255\255\255\255\020\001\
\021\001\022\001\023\001\024\001\025\001\026\001\255\255\001\001\
\002\001\003\001\004\001\005\001\006\001\007\001\035\001\009\001\
\255\255\255\255\255\255\255\255\041\001\255\255\255\255\255\255\
\255\255\255\255\255\255\021\001\255\255\255\255\024\001\025\001\
\026\001\255\255\001\001\002\001\003\001\004\001\005\001\006\001\
\007\001\035\001\009\001\255\255\255\255\255\255\255\255\041\001\
\255\255\255\255\255\255\255\255\255\255\255\255\021\001\255\255\
\255\255\255\255\255\255\026\001\000\001\001\001\002\001\003\001\
\004\001\005\001\006\001\007\001\035\001\009\001\010\001\255\255\
\255\255\013\001\041\001\255\255\016\001\255\255\255\255\255\255\
\255\255\021\001\255\255\255\255\255\255\255\255\026\001\255\255\
\028\001\029\001\030\001\255\255\032\001\255\255\255\255\035\001\
\000\001\001\001\002\001\003\001\004\001\005\001\006\001\007\001\
\255\255\009\001\010\001\255\255\255\255\013\001\255\255\255\255\
\016\001\255\255\255\255\255\255\255\255\021\001\255\255\255\255\
\255\255\255\255\026\001\255\255\028\001\255\255\030\001\255\255\
\032\001\255\255\255\255\035\001\000\001\001\001\002\001\003\001\
\004\001\005\001\006\001\007\001\255\255\009\001\010\001\255\255\
\255\255\013\001\255\255\255\255\016\001\255\255\255\255\255\255\
\255\255\021\001\255\255\255\255\255\255\255\255\026\001\255\255\
\028\001\255\255\030\001\255\255\032\001\255\255\255\255\035\001"

let yynames_const = "\
  INT_CAST\000\
  FLOAT_CAST\000\
  TRUE\000\
  FALSE\000\
  SEQ\000\
  SKIP\000\
  IF\000\
  THEN\000\
  ELSE\000\
  WHILE\000\
  DO\000\
  DONE\000\
  FOR\000\
  LT\000\
  LTE\000\
  EQ\000\
  ASGNOP\000\
  DEREF\000\
  PLUS\000\
  MINUS\000\
  MUL\000\
  DIV\000\
  LPAREN\000\
  RPAREN\000\
  LAC\000\
  RAC\000\
  FUN\000\
  COLON\000\
  LET\000\
  REC\000\
  IN\000\
  REF\000\
  TINT\000\
  TBOOL\000\
  TUNIT\000\
  TFLOAT\000\
  ARROW\000\
  PCT\000\
  EOF\000\
  "

let yynames_block = "\
  INT\000\
  FLOAT\000\
  VAR\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 105 "parser.mly"
                            ( _1 )
# 558 "parser.ml"
               : ImpAST.expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 115 "parser.mly"
                               (TInt)
# 564 "parser.ml"
               : 'tip))
; (fun __caml_parser_env ->
    Obj.repr(
# 116 "parser.mly"
                               (TBool)
# 570 "parser.ml"
               : 'tip))
; (fun __caml_parser_env ->
    Obj.repr(
# 117 "parser.mly"
                               (TUnit)
# 576 "parser.ml"
               : 'tip))
; (fun __caml_parser_env ->
    Obj.repr(
# 118 "parser.mly"
                               (TFloat)
# 582 "parser.ml"
               : 'tip))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'tip) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'tip) in
    Obj.repr(
# 119 "parser.mly"
                               ( TArrow (_1, _3) )
# 590 "parser.ml"
               : 'tip))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'tip) in
    Obj.repr(
# 124 "parser.mly"
                               ( _2 )
# 597 "parser.ml"
               : 'tip))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'tip) in
    Obj.repr(
# 125 "parser.mly"
                               ( _2 )
# 604 "parser.ml"
               : 'tip))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'tip) in
    Obj.repr(
# 126 "parser.mly"
                               ( TRef _1 )
# 611 "parser.ml"
               : 'tip))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 129 "parser.mly"
                               ( Op (_1,Plus,_3, location()) )
# 619 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 132 "parser.mly"
                                ( Op (_1,Minus,_3, location()) )
# 627 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 133 "parser.mly"
                              ( Op (_1,Mul,_3, location()) )
# 635 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 134 "parser.mly"
                              ( Op (_1,Div,_3, location()) )
# 643 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 135 "parser.mly"
                               ( Op(_1,Pct,_3, location() ))
# 651 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 136 "parser.mly"
                                ( Atrib (_1,_3, location()) )
# 659 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 137 "parser.mly"
                               ( Op (_1, Mic, _3, location()) )
# 667 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 138 "parser.mly"
                              ( Op (_1, MicS, _3, location()) )
# 675 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 139 "parser.mly"
                               ( Secv (_1,_3, location()) )
# 683 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 141 "parser.mly"
                               ( If (_2, _4, _6, location()) )
# 692 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 159 "parser.mly"
                               ( While (_2, _4, location()) )
# 700 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 6 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _7 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _9 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 161 "parser.mly"
                               ( For (_3, _5, _7, _9, location()) )
# 710 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 5 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 3 : 'tip) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 163 "parser.mly"
                               ( Fun (_3, _5, _8, location()) )
# 719 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 6 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 4 : 'tip) in
    let _7 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _9 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 165 "parser.mly"
                               ( LetRec (_3, _5, _7, _9, location()) )
# 729 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 167 "parser.mly"
                               ( Let (_2, _4, _6, location()) )
# 738 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 8 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 6 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _8 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    Obj.repr(
# 168 "parser.mly"
                                             (Rec (_2, _4, _6, _8, location()))
# 748 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'funexpr) in
    Obj.repr(
# 169 "parser.mly"
                               ( App (_1, _2, location()) )
# 756 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'funexpr) in
    Obj.repr(
# 173 "parser.mly"
                               ( _1 )
# 763 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 176 "parser.mly"
                               ( parseError (location ()) )
# 769 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 180 "parser.mly"
                               ( Int (_1,location()) )
# 776 "parser.ml"
               : 'funexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 181 "parser.mly"
                               ( Float (_1,location()) )
# 783 "parser.ml"
               : 'funexpr))
; (fun __caml_parser_env ->
    Obj.repr(
# 182 "parser.mly"
                               ( Bool (true, location()) )
# 789 "parser.ml"
               : 'funexpr))
; (fun __caml_parser_env ->
    Obj.repr(
# 183 "parser.mly"
                               ( Bool (false, location()) )
# 795 "parser.ml"
               : 'funexpr))
; (fun __caml_parser_env ->
    Obj.repr(
# 184 "parser.mly"
                               ( Skip (location()) )
# 801 "parser.ml"
               : 'funexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 185 "parser.mly"
                               ( Var (_1,location()) )
# 808 "parser.ml"
               : 'funexpr))
; (fun __caml_parser_env ->
    Obj.repr(
# 186 "parser.mly"
                               ( IntOfFloat (location()) )
# 814 "parser.ml"
               : 'funexpr))
; (fun __caml_parser_env ->
    Obj.repr(
# 187 "parser.mly"
                               ( FloatOfInt (location()) )
# 820 "parser.ml"
               : 'funexpr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 188 "parser.mly"
                               ( _2 )
# 827 "parser.ml"
               : 'funexpr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 192 "parser.mly"
                               ( Deref (_2, location()) )
# 834 "parser.ml"
               : 'funexpr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 193 "parser.mly"
                               ( Ref (_2, location()) )
# 841 "parser.ml"
               : 'funexpr))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : ImpAST.expr)