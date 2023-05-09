%{
#include <stdio.h>
#include "plain.y"
%}
%token NUM COLON IDENTIFIER L_SQR R_SQR L_CUR R_CUR L_PAR R_PAR
%token MODULUS PLUS MINUS DIVIDE MULTIPLY 
%token L_T G_T L_EQ G_EQ EQ AND OR NOT EQUALS NOT_EQ CONTAIN
%token BREAK PERIOD CONT LOOP IF ELSE INPUT OUTPUT OUTPUT_WITH_NEWLINE
%token RETURN COMMA FUNCNAME 
%token DIGIT

%%
prog_start: %empty {printf("prog_start --> epsilon\n");}
            | functions {printf("prog_start --> functions\n");}
            ; 

functions:  function {printf("function --> functions\n");}
            | function functions {printf("function --> function functions\n");}
            ;

function:   COLON FUNCNAME L_PAR arguments R_PAR NUM L_CUR statements R_CUR
            {printf("function -->   COLON FUNCNAME L_PAR arguments R_PAR NUM L_CUR statements R_CUR\n");}
            ;

arguments:  %empty {printf("arguments --> epsilon");}
            | argument COMMA arguments {printf("arguments --> arguments COMMA arguments");}
            | argument  {printf("arguments --> argument");}
            ;

argument:   %empty {printf("arguments --> epsilon");} 
            | NUM IDENTIFIER {printf("argument --> NUM IDENTIFIER");}
            ;

statements: %empty {printf("statements --> epsilon");}
            | statement statements {printf("statements --> statement");}
            ;

statement:  declarations {printf("statement --> declaration");}
            | ifstatement{printf("statement --> ifstatement");}
            | loop       {printf("statement --> loop");}
            | pstatements {printf("statement --> pstatements");}
            | rstatement {printf("statement --> rstatement");}
            ;

ifstatement:   IF CONTAIN expressions CONTAIN L_CUR statements R_CUR elsestatement {printf("ifstatement --> IF CONTAIN expressions CONTAIN L_CUR statements R_CUR elsestatement");}
                ;
elsestatement: %empty {printf("elsestatement --> epsilon");}
                | ELSE L_CUR statements R_CUR {printf("elsestatement --> ELSE L_CUR statements R_CUR");}
                ;
loop:       LOOP CONTAIN expressions CONTAIN L_CUR statements R_CUR  {printf("loop --> CONTAIN expressions CONTAIN L_CUR statements R_CUR");}
            ;

expressions:    mathexp binop expressions {printf("expressions--> expression binop expressions");}
                | NOT mathexp  {printf("expressions--> NOT expression");}
                | CONTAIN expressions CONTAIN {printf("expressions--> L_PAR expressions R_PAR");} 
                | mathexp    {printf("expressions--> expression");}
                ;
binop :          AND {printf("binop--> AND");}
                | OR {printf("binop --> OR");}
                | EQUALS {printf("binop --> EQUALS");}
                | NOT_EQ {printf("binop --> NOT_EQ");}
                | L_T 
                | G_T
                | L_EQ
                | G_EQ
                ;


paramaters:     %empty {printf("paramaters --> epsilon");}
                | IDENTIFIER COMMA paramaters {printf("paramaters --> IDENTIFIER COMMA paramaters");}
                | IDENTIFIER {printf("paramaters --> IDENTIFIER");}
                ;

mathexp:    mathexp addop term  {printf("mathexp --> mathexp addop term ");}
            | term {printf("mathexp --> term ");}
            ;

addop:      PLUS {printf("mathexp --> PLUS ");}
            | MINUS {printf("mathexp --> MINUS ");}
            ;

term:       term mulop factor  {printf("term --> term mulop factor ");}
            | factor {printf("term --> factor ");}
            ;

mulop:      MULTIPLY {printf("mulop --> MULTIPLY ");}
            | DIVIDE {printf("mulop --> DIVIDE ");}
            | MODULUS {printf("mulop --> MODULUS ");}
            ;

factor:     L_PAR mathexp R_PAR {printf("factor --> L_PAR mathexp R_PAR ");}
            | DIGIT {printf("factor --> DIGIT");}
            | IDENTIFIER {printf("factor --> IDENTIFIER");}
            ;

declarations:  NUM declaration PERIOD
              ;

declaration: IDENTIFIER
              |IDENTIFIER COMMA declaration
              | IDENTIFIER EQ declaration
              | IDENTIFIER EQ function_call {printf("declaration --> IDENTIFIER EQ function_call");}
              | IDENTIFIER EQ mathexp {printf("declaration --> IDENTIFIER EQ mathexp");}
              ;

function_call:  FUNCNAME L_PAR paramaters R_PAR
                ;

pstatements:  OUTPUT L_PAR printexpressions R_PAR PERIOD {printf("pstatements --> OUTPUT L_PAR printexpressions R_PAR");}
              | OUTPUT_WITH_NEWLINE L_PAR printexpressions R_PAR PERIOD {printf("pstatements --> OUTPUT L_PAR printexpressions R_PAR");}
              ;

printexpressions:   mathexp
                    | IDENTIFIER {{printf("printexpressions --> IDENTIFIER");}}
                    | function_call {printf("printexpressions --> function_call");}
                    | DIGIT {printf("printexpressions --> DIGIT");}
                    ;

rstatement:  INPUT L_PAR IDENTIFIER R_PAR PERIOD {printf("rstatement --> INPUT L_PAR IDENTIFIER R_PAR");}
             ;
                

//==============================================
// "....go onto define all features of your language..."
//==============================================
%%
void main(int argc, char** argv)
{
    if(argc >=2)
        yyin = fopen(argv[1], "r");
        if(yyin == NULL)
            yyin = stdin;
        else
            yyin=stdin;

        yyparse();
}