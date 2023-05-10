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
%token DIGIT LIST

%%
prog_start: %empty {printf("prog_start --> epsilon\n");}
            | functions {printf("prog_start --> functions\n");}
            ; 

functions:  function {printf("function --> functions\n");}
            | function functions {printf("function --> function functions\n");}
            ;

function:   FUNCNAME L_PAR arguments R_PAR NUM L_CUR statements R_CUR
            {printf("function --> FUNCNAME L_PAR arguments R_PAR NUM L_CUR statements R_CUR\n");}
            ;

arguments:  %empty {printf("arguments --> epsilon\n");}
            | argument COMMA arguments {printf("arguments --> arguments COMMA arguments\n");}
            | argument  {printf("arguments --> argument");}
            ;

argument:   NUM IDENTIFIER {printf("argument --> NUM IDENTIFIER\n");}
            ;

statements: %empty {printf("statements --> epsilon\n");}
            | statement statements {printf("statements --> statement statements\n");}
            ;

statement:  declarations {printf("statement --> declaration\n");}
            | ifstatement{printf("statement --> ifstatement\n");}
            | loop       {printf("statement --> loop\n");}
            | pstatements {printf("statement --> pstatements\n");}
            | rstatement {printf("statement --> rstatement\n");}
            | assign PERIOD {printf("statement --> assign\n");}
            | RETURN mathexp PERIOD {printf("statement --> return\n");}
            | array PERIOD {printf("statement --> array PERIOD\n");}
            | BREAK PERIOD {printf("statement --> BREAK PERIOd\n");}
            ;

array:      LIST IDENTIFIER L_SQR DIGIT R_SQR {printf("array --> LIST IDENTIFIER L_SQR DIGIT R_SQR\n");}
            | IDENTIFIER L_SQR DIGIT R_SQR EQ mathexp {printf("array --> IDENTIFIER L_SQR DIGIT R_SQR EQ mathexp\n");}
            ;

assign:      IDENTIFIER EQ mathexp  {printf("assign --> IDENTIFIER EQ mathexp\n");}
            | IDENTIFIER COMMA declaration {printf("assign --> IDENTIFIER COMMA declaration\n");}
            ;

ifstatement:   IF CONTAIN expressions CONTAIN L_CUR statements R_CUR elsestatement {printf("ifstatement --> IF CONTAIN expressions CONTAIN L_CUR statements R_CUR elsestatement\n");}
                ;
elsestatement: %empty {printf("elsestatement --> epsilon\n");}
                | ELSE L_CUR statements R_CUR {printf("elsestatement --> ELSE L_CUR statements R_CUR\n");}
                ;
loop:       LOOP CONTAIN expressions CONTAIN L_CUR statements R_CUR  {printf("loop --> CONTAIN expressions CONTAIN L_CUR statements R_CUR\n");}
            ;

expressions:    mathexp binop expressions {printf("expressions--> mathexp binop expressions\n");}
                | NOT mathexp  {printf("expressions--> NOT expression\n");}
                | CONTAIN expressions CONTAIN {printf("expressions--> CONTAIN expressions CONTAIN\n");} 
                | mathexp    {printf("expressions--> mathexp\n");}
                ;
binop :          AND {printf("binop--> AND\n");}
                | OR {printf("binop --> OR\n");}
                | EQUALS {printf("binop --> EQUALS\n");}
                | NOT_EQ {printf("binop --> NOT_EQ\n");}
                | L_T {printf("binop --> L_T\n");}
                | G_T {printf("binop --> G_T\n");}
                | L_EQ {printf("binop --> L_EQ\n");}
                | G_EQ {printf("binop --> G_EQ\n");}
                ;


paramaters:     %empty {printf("paramaters --> epsilon\n");}
                | IDENTIFIER COMMA paramaters {printf("paramaters --> IDENTIFIER COMMA paramaters\n");}
                | IDENTIFIER {printf("paramaters --> IDENTIFIER\n");}
                ;

mathexp:    mathexp addop term  {printf("mathexp --> mathexp addop term\n");}
            | term {printf("mathexp --> term\n");}
            ;

addop:      PLUS {printf("addop --> PLUS\n");}
            | MINUS {printf("addop --> MINUS\n");}
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
            | function_call {printf("factor --> function_call\n");}
            | IDENTIFIER L_SQR DIGIT R_SQR {printf("factor --> IDENTIFIER L_SQR DIGIT R_SQR\n");}
            ;


declarations:  NUM declist PERIOD {printf("declarations --> NUM declist PERIOD\n");}
            ;

declist:  declaration {printf("declist --> declaration\n");}
                | declaration COMMA declist {printf("declist --> declaration COMMA declist\n");}
                ;

declaration:  IDENTIFIER {printf("declaration --> IDENTIFIER\n");}
            | IDENTIFIER EQ mathexp {printf("declaration --> IDENTIFIER EQ mathexp\n");}
            ;

function_call:  IDENTIFIER L_PAR paramaters R_PAR {printf("function_call --> FUNCNAME L_PAR paramaters R_PAR\n");}
                ;

pstatements:  OUTPUT L_PAR mathexp R_PAR PERIOD {printf("pstatements --> OUTPUT L_PAR mathexp R_PAR PERIOD\n");}
              | OUTPUT_WITH_NEWLINE L_PAR mathexp R_PAR PERIOD {printf("pstatements --> OUTPUT_WITH_NEWLINE L_PAR mathexp R_PAR PERIOD\n");}
              ;


rstatement:  INPUT L_PAR IDENTIFIER R_PAR PERIOD {printf("rstatement --> INPUT L_PAR IDENTIFIER R_PAR PERIOD\n");}
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
      extern int col;

	  fprintf (stderr, "**Error at line %d:%d. %s\n", newLine, col, s);
}
