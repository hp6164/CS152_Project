%{
#include <stdio.h>
%}
%token NUM COLON IDENTIFIER L_SQR R_SQR L_CUR R_CUR L_PAR R_PAR
%token MODULUS NUM PLUS MINUS DIVIDE MULTIPLY 
%token L_T G_T L_EQ G_EQ EQ AND OR NOT EQUALS NOT_EQ CONTAIN
%token BREAK PERIOD CONT LOOP IF ELSE INPUT OUTPUT OUTPUT_WITH_NEWLINE
%token RETURN COMMA COLON FUNCNAME 

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
            | NUM argument COMMA NUM arguments {printf("arguments --> arguments COMMA arguments");}
            ;

argument:   %empty {printf("arguments --> epsilon");} 
            | NUM IDENTIFIER {printf("argument --> NUM IDENTIFIER");}
            ;
IF:   %empty {printf("if --> contain");} 
            | CONTAIN expressions CONTAIN L_CUR statements R_CUR
            ;
ELSE:    
            | L_CUR statements R_CUR
            ;
expressions:
            | expression AND expressions
            | expression OR expressions
            | NOT expressions
            ;
expression:  declaration
            | function_call
            | mathexp
            | expression same expression
            | expression diff expression
            ;
mathexp:  
            | mathexp addop term | term
            ;
addop:    
            | PLUS 
            | MINUS
            ;
term:    
            | term mulop factor  
            | factor
            ;
mulop:    
            | MULTIPLY
            | DIVIDE
            | MODULUS
            ;
factor:    
            | L_PAR exp R_PAR 
            | NUM
            ;

loops:  
            | loop loops {printf("loop --> loop loops\n");}
            ;

loop:   
            | CONTAIN expressions CONTAIN L_CUR statements R_CUR
            ;

statements: %empty {printf("statements --> epsilon")}
            | statement PERIOD statements
            ;
               
statement:  declaration
            | function_call
            | pstatements
            | rstatement
            ;

declaration: 

pstatements:  OUTPUT L_PAR IDENTIFIER R_PAR
             | OUTPUT_WITH_NEWLINE L_PAR IDENTIFIER R_PAR
             ;

rstatement:  INPUT L_PAR IDENTIFIER R_PAR
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