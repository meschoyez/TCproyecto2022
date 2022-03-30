grammar compiladores;

@header {
package compiladores;
}

// DIGITO : '0' | '1' | '2' | ... | '9'
fragment DIGITO : [0-9] ;
fragment LETRA : [A-Za-z] ;
// SEQ : '3'[4-9] | '4'[0-5] ; ( [34-45] )
// SIGNOS : [-+*/];

PA : '(' ;
PC : ')' ;
SUMA : '+';
INT : 'int' ;
NUMERO : DIGITO+ ;
ID : (LETRA | '_')(LETRA | DIGITO | '_')* ;

WS : [ \t\n\r] -> skip;
OTRO : . ;

si : s EOF ;

s : PA s PC s
  |
  ;

// s : ID     { System.out.println("ID ->" + $ID.getText() + "<--"); }         s
//   | NUMERO { System.out.println("NUMERO ->" + $NUMERO.getText() + "<--"); } s
//   | OTRO   { System.out.println("Otro ->" + $OTRO.getText() + "<--"); }     s
//   | EOF
//   ;
