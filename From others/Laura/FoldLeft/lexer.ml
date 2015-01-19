# 2 "lexer.mll"
 
open Parser        (* The type token is defined in parser.mli *)

(**
  Type of exception used for lexer errors.
  Parameter:  location in the file.
 *)
exception LexerError of ImpAST.locatie
(**
  Type of exception used for parser errors.
  Parameter:  location in the file
 *)
exception ParseError of ImpAST.locatie

(**  
  Incrementing line numbers (at line breaks) while tokenizing
  @param lexbuf lexer internal object of Lexing.lexbuf type
  @see Lexing#lexbuf and Lexing#position
 *)
let incr_linenum lexbuf =
      let pos = lexbuf.Lexing.lex_curr_p in
      lexbuf.Lexing.lex_curr_p <- { pos with
        (* incrementing line number *)
        Lexing.pos_lnum = pos.Lexing.pos_lnum + 1;
        (* setting offset for beggining of line *)
        Lexing.pos_bol = pos.Lexing.pos_cnum;
      }

(**
  Formats an error string at the location given by current tokenizing position.
  @param lexbuf lexer internal object of Lexing.lexbuf type
  @see Lexing#lexbuf and Lexing#position
 *)
let lex_error lexbuf =
         begin
           let curr = lexbuf.Lexing.lex_curr_p in
           let file = curr.Lexing.pos_fname
           and line = curr.Lexing.pos_lnum
           and cnum = curr.Lexing.pos_cnum - curr.Lexing.pos_bol in
              raise (LexerError (file,line,cnum,line,cnum))
         end

(**
  A hash table associating symbol constants to keywords.
  *)
let keyword_table = Hashtbl.create 20   
                   (* create an hashtable with initial capacity 20 *)
let _ =
    List.iter (fun (kwd, tok) -> Hashtbl.add keyword_table kwd tok)
    (* insert each keyyword-symbol pair in the list into the hashtable *)
  [
   ( "fun"          , FUN );
   ( "int"          , TINT );
   ( "bool"         , TBOOL );
   ( "float"        , TFLOAT );
   ( "unit"         , TUNIT );
   ( "int_of_float" , INT_CAST );
   ( "float_of_int" , FLOAT_CAST );
   ( "if"           , IF );
   ( "then"         , THEN );
   ( "else"         , ELSE );
   ( "while"        , WHILE );
   ( "do"           , DO );
   ( "done"         , DONE );
   ( "for"          , FOR );
   ( "true"         , TRUE );
   ( "false"        , FALSE );
   ( "let"          , LET );
   ( "rec"          , REC );
   ( "in"           , IN );
   ( "ref"          , REF );
]


# 77 "lexer.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base = 
   "\000\000\230\255\231\255\078\000\233\255\234\255\235\255\001\000\
    \238\255\239\255\240\255\241\255\002\000\246\255\247\255\249\255\
    \155\000\165\000\253\255\050\000\255\255\243\255\254\255\250\255\
    \180\000\244\255\237\255\054\000\251\255\252\255\253\255\002\000\
    \052\000\255\255\254\255";
  Lexing.lex_backtrk = 
   "\255\255\255\255\255\255\023\000\255\255\255\255\255\255\019\000\
    \255\255\255\255\255\255\255\255\010\000\255\255\255\255\255\255\
    \004\000\007\000\255\255\013\000\255\255\255\255\255\255\255\255\
    \003\000\255\255\255\255\255\255\255\255\255\255\255\255\003\000\
    \003\000\255\255\255\255";
  Lexing.lex_default = 
   "\001\000\000\000\000\000\255\255\000\000\000\000\000\000\255\255\
    \000\000\000\000\000\000\000\000\255\255\000\000\000\000\000\000\
    \255\255\255\255\000\000\255\255\000\000\000\000\000\000\000\000\
    \255\255\000\000\000\000\029\000\000\000\000\000\000\000\255\255\
    \255\255\000\000\000\000";
  Lexing.lex_trans = 
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\018\000\020\000\000\000\000\000\018\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \018\000\005\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \019\000\011\000\014\000\015\000\034\000\017\000\004\000\013\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\007\000\006\000\012\000\008\000\026\000\025\000\
    \030\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\021\000\022\000\033\000\031\000\000\000\
    \032\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\010\000\000\000\009\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\000\000\000\000\000\000\000\000\003\000\000\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\024\000\000\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\000\000\
    \000\000\000\000\000\000\023\000\024\000\024\000\024\000\024\000\
    \024\000\024\000\024\000\024\000\024\000\024\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\028\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000";
  Lexing.lex_check = 
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\255\255\255\255\000\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\000\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\000\000\000\000\000\000\031\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\007\000\012\000\
    \027\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\019\000\019\000\032\000\027\000\255\255\
    \027\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\255\255\000\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\255\255\255\255\255\255\255\255\003\000\255\255\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
    \003\000\016\000\255\255\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\255\255\
    \255\255\255\255\255\255\017\000\024\000\024\000\024\000\024\000\
    \024\000\024\000\024\000\024\000\024\000\024\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\027\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255";
  Lexing.lex_base_code = 
   "";
  Lexing.lex_backtrk_code = 
   "";
  Lexing.lex_default_code = 
   "";
  Lexing.lex_trans_code = 
   "";
  Lexing.lex_check_code = 
   "";
  Lexing.lex_code = 
   "";
}

let rec token lexbuf =
    __ocaml_lex_token_rec lexbuf 0
and __ocaml_lex_token_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 79 "lexer.mll"
             ( incr_linenum lexbuf ; token lexbuf )
# 230 "lexer.ml"

  | 1 ->
# 81 "lexer.mll"
                    ( comments 0 lexbuf )
# 235 "lexer.ml"

  | 2 ->
# 83 "lexer.mll"
                         ( token lexbuf )
# 240 "lexer.ml"

  | 3 ->
let
# 84 "lexer.mll"
                                       lxm
# 246 "lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 84 "lexer.mll"
                                           ( FLOAT(float_of_string lxm) )
# 250 "lexer.ml"

  | 4 ->
let
# 90 "lexer.mll"
                        lxm
# 256 "lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 90 "lexer.mll"
                            ( INT(int_of_string lxm) )
# 260 "lexer.ml"

  | 5 ->
# 94 "lexer.mll"
                   ( ARROW )
# 265 "lexer.ml"

  | 6 ->
# 95 "lexer.mll"
                   ( PLUS )
# 270 "lexer.ml"

  | 7 ->
# 96 "lexer.mll"
                   ( MINUS )
# 275 "lexer.ml"

  | 8 ->
# 97 "lexer.mll"
                   ( MUL )
# 280 "lexer.ml"

  | 9 ->
# 98 "lexer.mll"
                   ( DIV )
# 285 "lexer.ml"

  | 10 ->
# 99 "lexer.mll"
                   ( LT )
# 290 "lexer.ml"

  | 11 ->
# 100 "lexer.mll"
                   ( LTE )
# 295 "lexer.ml"

  | 12 ->
# 101 "lexer.mll"
                   ( SKIP )
# 300 "lexer.ml"

  | 13 ->
# 102 "lexer.mll"
                   ( LPAREN )
# 305 "lexer.ml"

  | 14 ->
# 103 "lexer.mll"
                   ( RPAREN )
# 310 "lexer.ml"

  | 15 ->
# 104 "lexer.mll"
                   ( LAC )
# 315 "lexer.ml"

  | 16 ->
# 105 "lexer.mll"
                   ( RAC )
# 320 "lexer.ml"

  | 17 ->
# 106 "lexer.mll"
                   ( EQ )
# 325 "lexer.ml"

  | 18 ->
# 107 "lexer.mll"
                   ( ASGNOP )
# 330 "lexer.ml"

  | 19 ->
# 108 "lexer.mll"
                   ( COLON )
# 335 "lexer.ml"

  | 20 ->
# 109 "lexer.mll"
                   ( SEQ )
# 340 "lexer.ml"

  | 21 ->
# 110 "lexer.mll"
                   ( DEREF )
# 345 "lexer.ml"

  | 22 ->
# 111 "lexer.mll"
                   ( PCT )
# 350 "lexer.ml"

  | 23 ->
let
# 113 "lexer.mll"
                                                         id
# 356 "lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 114 "lexer.mll"
                   ( try Hashtbl.find keyword_table id 
                        (* if it's a keyword, use the symbol from the table *)
                     with Not_found -> VAR(id) 
                        (* if not, consider it a variable *)
                   )
# 364 "lexer.ml"

  | 24 ->
# 119 "lexer.mll"
                   ( EOF )
# 369 "lexer.ml"

  | 25 ->
# 120 "lexer.mll"
                   ( lex_error lexbuf )
# 374 "lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; __ocaml_lex_token_rec lexbuf __ocaml_lex_state

and comments level lexbuf =
    __ocaml_lex_comments_rec level lexbuf 27
and __ocaml_lex_comments_rec level lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 124 "lexer.mll"
                ( if level = 0 then token lexbuf
                  else comments (level-1) lexbuf )
# 386 "lexer.ml"

  | 1 ->
# 127 "lexer.mll"
                ( comments (level+1) lexbuf )
# 391 "lexer.ml"

  | 2 ->
# 129 "lexer.mll"
                ( incr_linenum lexbuf ; comments level lexbuf )
# 396 "lexer.ml"

  | 3 ->
# 131 "lexer.mll"
                ( comments level lexbuf )
# 401 "lexer.ml"

  | 4 ->
# 133 "lexer.mll"
                ( raise End_of_file )
# 406 "lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; __ocaml_lex_comments_rec level lexbuf __ocaml_lex_state

;;
