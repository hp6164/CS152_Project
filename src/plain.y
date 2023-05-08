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
function:   FUNCNAME L_PAR arguments R_PAR NUM L_CUR statements R_CUR
            {printf("function -->   NUM IDENTIFIER L_PAR arguments R_PAR L_CUR statements R_CUR\n");}

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
            | if-statement
            | loops
            | function_call {printf("statement --> function_call");}
            | pstatements {printf("statement --> pstatements");}
            | rstatement {printf("statement --> rstatement");}
            ;

if-statement:   IF CONTAIN expressions CONTAIN L_CUR statements R_CUR else-statement {printf("if-statement --> IF CONTAIN expressions CONTAIN L_CUR statements R_CUR else-statement");}
                ;
else-statement: %empty {printf("else-statement --> epsilon");}
                | ELSE L_CUR statements R_CUR {printf("else-statement --> ELSE L_CUR statements R_CUR");}
                ;
expressions:    expression AND expressions {printf("expressions--> expression AND expressions");}
                | expression OR expressions {printf("expressions--> expression OR expressions");}
                | NOT expressions   {printf("expressions--> NOT expressions");}
                | expression    {printf("expressions--> expression");}
                ;

expression:  declaration {printf("expressions--> declaration");}
            | function_call {printf("expressions--> function_call");}
            | mathexp   {printf("expressions--> mathexp")}
            | expression EQUALS expression    {printf("expressions--> expression same expression");}
            | expression NOT_EQ expression    {printf("expressions--> expression diff expression");}
            ;

function_call:  function_call PERIOD {printf("fuction_call --> function_call PERIOD");}
                | FUNCNAME L_PAR paramaters R_PAR {printf("function_call--> FUNCNAME L_PAR paramaters R_PAR");}
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
            | NUM {printf("factor --> NUM");}
            ;

loops:      %empty {printf("loops --> epsilon");}
            | loop loops {printf("loop --> loop loops\n");}
            ;

loop:       CONTAIN expressions CONTAIN L_CUR statements R_CUR  {printf("loop --> CONTAIN expressions CONTAIN L_CUR statements R_CUR");}
            ;


declarations:   %empty {printf("declarations --> epsilon");}
                | NUM declaration COMMA declarations {printf("declarations --> NUM declaration COMMA declarations");}
                | NUM declaration PERIOD {printf("declarations --> NUM declaration PERIOD");}
                ;

declaration:    IDENTIFIER {printf("declaration --> IDENTIFIER");}
                | IDENTIFIER EQ IDENTIFIER {printf("declaration --> IDENTIFIER EQ IDENTIFIER");}
                | IDENTIFIER EQ function_call {printf("declaration --> IDENTIFIER EQ function_call");}
                | IDENTIFIER EQ mathexp {printf("declaration --> IDENTIFIER EQ mathexp");}
                ;

pstatements:  OUTPUT L_PAR printexpressions R_PAR {printf("pstatements --> OUTPUT L_PAR printexpressions R_PAR");}
              | OUTPUT_WITH_NEWLINE L_PAR printexpressions R_PAR {printf("pstatements --> OUTPUT L_PAR printexpressions R_PAR");}
              ;

printexpressions:   expressions  {printf("printexpressions --> expressions");}
                    | IDENTIFIER {{printf("printexpressions --> IDENTIFIER");}}
                    | mathexp {printf("printexpressions --> mathexp");}
                    | function_call {printf("printexpressions --> function_call");}
                    | DIGIT {printf("printexpressions --> DIGIT");}
                    ;

rstatement:  INPUT L_PAR IDENTIFIER R_PAR {printf("rstatement --> INPUT L_PAR IDENTIFIER R_PAR");}
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