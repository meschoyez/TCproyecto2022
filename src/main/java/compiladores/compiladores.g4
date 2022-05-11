grammar compiladores;

@header {
package compiladores;
}

fragment DIGITO : [0-9] ;
fragment LETRA : [A-Za-z] ;

//NUMEROS
ENTERO : DIGITO+;
DECIMAL : ENTERO'.'ENTERO;

// CARACTER
CARACTER: '\''LETRA'\'';

// TIPOS DE DATOS
INT     : 'int' ;
CHAR    : 'char' ;
DOUBLE  : 'double' ;
VOID    : 'void' ;

PA   : '(' ;
PC   : ')' ;
CA   : '[' ;
CC   : ']' ;
LA   : '{' ;
LC   : '}' ;

PYC  : ';' ;
COMA : ',' ;
EQ   : '=' ;

// COMPARADORES
MAY  : '>' ;
MAYEQ: '>=';
MEN  : '<' ;
MENEQ: '<=';
EQL  : '==';
DST  : '!=';

// SIMBOLOS MATEMATICOS
SUM  : '+' ;
RES  : '-' ;
MUL  : '*' ;
DIV  : '/' ;
MOD  : '%' ;

// OPERACIONES LOGICAS
OR   : '||' ;
AND  : '&&' ;
NOT  : '!'  ;

// BUCLES
FOR  : 'for';
WHILE: 'while';

// CONDICIONES
IF   : 'if' ;
ELSE : 'else' ;

// VARIABLES
ID : (LETRA | '_') (LETRA | DIGITO | '_')*;

WS : [ \t\n\r] -> skip;

prog: instrucciones ; 

//DEFINIMOS INSTRUCCION
instrucciones : instruccion instrucciones 
              |
              ;
//DEFINIMOS UN BLOQUE DE CODIGO { }
bloque : LA instrucciones LC 
       ;
//TIPOS DE INSTRUCCIONES
instruccion : declaracion PYC //LA LINEA DEBE TERMINAR CON UN ;
            | asignacion PYC //LA LINEA DEBE TERMINAR CON UN ;
            | ciclofor
            | ciclowhile
            | condif
            | funcion
            | llamada_funcion PYC //LA LINEA DEBE TERMINAR CON UN ;
            | bloque
            ;

//DEFINIMOS COMO SE DECLARA UNA VARIABLE ejem int num 
declaracion : tipodato ID 
            | tipodato ID asign
            ;

asign : EQ llamada_funcion // VARIABLE = A RESULTADO DE UNA FUNCION
      | EQ operacion
      ;

//DEFINIMOS TIPO DE DATOS
tipodato : INT
         | CHAR
         | DOUBLE
         | VOID
         ;

//DEFINIMOS DE ASIGNACION  
asignacion  : ID asign
            ;

//DEFINIMOS BUCLE FOR for ( int a = 0 ; a < 5 ; a ++) instruccion 
ciclofor : FOR PA asignacion PYC operacion PYC ID asign PC instruccion
         ;
//DEFINIMOS BUCLE WHILE while ( a < 5 ) instruccion 
ciclowhile : WHILE PA operacion PC instruccion
           ;

// DEFINICION DE IF if (a < 5 ) instruccion
condif : IF PA operacion PC instruccion
       | IF PA operacion PC instruccion ELSE instruccion
       ;

// DEFINICION DE FUNCION  int calcularSuma ( int x, int y ){ ... }
funcion : tipodato ID PA parametros PC bloque
        ;

// DEFINICION DE PARAMETROS int x
parametros :  declaracion parametros
           |  COMA parametros
           |
           ;
// calcularSuma(5,4)
llamada_funcion : ID PA argumentos PC
                ;
// DEFINICION DE ARGUMETO PARA FUNCION
argumentos: ID argumentos
          | COMA argumentos
          |
          ;

// Operaciones aritmeticas-logicas
operacion : opal ;

opal : disyuncion 
     |
     ;

disyuncion : conjuncion disy
           ;

disy : OR conjuncion disy
     |
     ;

conjuncion : comparaciones conj
           ;

conj : AND comparaciones conj
     |
     ;

comparaciones : expresion comp
              ;

comp : opcomp expresion comp
     |
     ;

opcomp : MAY   
       | MAYEQ
       | MEN  
       | MENEQ
       | EQL  
       | DST  
       ;

// EXPRESIONES
expresion : termino exp;

//EXPRESIONES
exp : SUM termino exp
    | RES termino exp
    |
    ;

// TERMINOS
termino : factor term ;

term : MUL factor term
     | DIV factor term
     | MOD factor term
     |
     ;

// FACTORES
factor : f PA opal PC
       | f ENTERO
       | f DECIMAL
       | f CARACTER
       | f ID
       ;

f : SUM
  | RES
  | NOT
  |
  ;
