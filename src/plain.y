%{
#include <stdio.h>
#include "p.tab.h"
extern FILE* yyin;
void yyerror(char const *msg);
%}

%define parse.error verbose

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
            {printf("function -->   FUNCNAME L_PAR arguments R_PAR NUM L_CUR statements R_CUR\n");}
            ;

arguments:  %empty {printf("arguments --> epsilon\n");}
            | argument COMMA arguments {printf("arguments --> arguments COMMA arguments\n");}
            | argument  {printf("arguments --> argument");}
            ;

argument:   NUM IDENTIFIER {printf("argument --> NUM IDENTIFIER\n");}
            ;

statements: %empty {printf("statements --> epsilon\n");}
            | statement statements {printf("statements --> statement\n");}
            ;

statement:  declarations {printf("statement --> declaration\n");}
            | ifstatement{printf("statement --> ifstatement\n");}
            | loop       {printf("statement --> loop\n");}
            | pstatements {printf("statement --> pstatements\n");}
            | rstatement {printf("statement --> rstatement\n");}
            | assign PERIOD {printf("statement --> assign\n");}
            | RETURN mathexp PERIOD {printf("statement --> return\n");}
            | array PERIOD
            ;

array:      LIST IDENTIFIER L_SQR DIGIT R_SQR
            ;

assign:     IDENTIFIER EQ DIGIT 
            | NUM IDENTIFIER EQ DIGIT 
            | IDENTIFIER EQ mathexp 
            | IDENTIFIER COMMA declaration
            ;

ifstatement:   IF CONTAIN expressions CONTAIN L_CUR statements R_CUR elsestatement {printf("ifstatement --> IF CONTAIN expressions CONTAIN L_CUR statements R_CUR elsestatement\n");}
                ;
elsestatement: %empty {printf("elsestatement --> epsilon\n");}
                | ELSE L_CUR statements R_CUR {printf("elsestatement --> ELSE L_CUR statements R_CUR\n");}
                ;
loop:       LOOP CONTAIN expressions CONTAIN L_CUR statements R_CUR  {printf("loop --> CONTAIN expressions CONTAIN L_CUR statements R_CUR\n");}
            ;

expressions:    mathexp binop expressions {printf("expressions--> expression binop expressions\n");}
                | NOT mathexp  {printf("expressions--> NOT expression\n");}
                | CONTAIN expressions CONTAIN {printf("expressions--> L_PAR expressions R_PAR\n");} 
                | mathexp    {printf("expressions--> expression\n");}
                ;
binop :          AND {printf("binop--> AND\n");}
                | OR {printf("binop --> OR\n");}
                | EQUALS {printf("binop --> EQUALS\n");}
                | NOT_EQ {printf("binop --> NOT_EQ\n");}
                | L_T 
                | G_T
                | L_EQ
                | G_EQ
                ;


paramaters:     %empty {printf("paramaters --> epsilon\n");}
                | IDENTIFIER COMMA paramaters {printf("paramaters --> IDENTIFIER COMMA paramaters\n");}
                | IDENTIFIER {printf("paramaters --> IDENTIFIER\n");}
                ;

mathexp:    mathexp addop term  {printf("mathexp --> mathexp addop term\n");}
            | term {printf("mathexp --> term\n");}
            ;

addop:      PLUS {printf("mathexp --> PLUS\n");}
            | MINUS {printf("mathexp --> MINUS\n");}
            ;

term:       term mulop factor  {printf("term --> term mulop factor\n");}
            | factor {printf("term --> factor\n");}
            ;

mulop:      MULTIPLY {printf("mulop --> MULTIPLY\n");}
            | DIVIDE {printf("mulop --> DIVIDE\n");}
            | MODULUS {printf("mulop --> MODULUS\n");}
            ;

factor:     L_PAR mathexp R_PAR {printf("factor --> L_PAR mathexp R_PAR\n");}
            | DIGIT {printf("factor --> DIGIT\n");}
            | IDENTIFIER {printf("factor --> IDENTIFIER\n");}
            | function_call
            ;

declarations:  NUM declaration PERIOD
              ;

declaration:  IDENTIFIER
            | IDENTIFIER EQ mathexp
            | IDENTIFIER COMMA declaration
            ;


function_call:  FUNCNAME L_PAR paramaters R_PAR
                ;

pstatements:  OUTPUT L_PAR mathexp R_PAR PERIOD {printf("pstatements --> OUTPUT L_PAR printexpressions R_PAR\n");}
              | OUTPUT_WITH_NEWLINE L_PAR mathexp R_PAR PERIOD {printf("pstatements --> OUTPUT L_PAR printexpressions R_PAR\n");}
              ;


rstatement:  INPUT L_PAR IDENTIFIER R_PAR PERIOD {printf("rstatement --> INPUT L_PAR IDENTIFIER R_PAR\n");}
             ;
                


%%
void main(int argc, char** argv){
	if(argc >= 2){
		yyin = fopen(argv[1], "r");
		if(yyin == NULL)
			yyin = stdin;
	}else{
		yyin = stdin;
	}
	yyparse();
}

/* Called by yyparse on error. */
void
yyerror (char const *s)
{
      extern int newLine;
	  fprintf (stderr, "**Error at line %d. %s\n", newLine, s);
}
