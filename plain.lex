%{
// c code here
#include <stdio.h>
%}

DIGIT [0-9]
ALPHA [a-zA-z]
%%

[ ]+    	{printf("#\n");}
{DIGIT}+	    {printf("NUM: %s\n", yytext);}
"+"		        {printf("PLUS:(+)\n");}
"-"             {printf("MINUS:(-)\n");}
"/"             {printf("DIVIDE:(/)\n");}	
"*"             {printf("MULTIPLY:(*)\n");}
"{"             {printf("L_CUR\n");}
"}"             {printf("R_CUR\n");}
"/[/"		{printf("L_SQR\n");}
"/]/"		{printf("R_SQR\n");}
"|"				{printf("CONTAIN\n");}
"="				{printf("EQ\n");}
'lt'				{printf("L_T\n";}
"/gt/"				{printf("G_T\n");}
"/leq/"			{printf("L_EQ\n");}
"/geq/"			{printf("G_EQ\n");}
"/AND/"			{printf("AND\n");}
"/OR/"			{printf("OR\n");}
"/NOT/"			{printf("NOT\n");}
"/same/"			{printf("EQUALS\n");}
"/diff/"			{printf("NOT_EQ\n");}
"("			{printf("L_PAR\n");}
")"			{printf("R_PAR\n");}
"/break/"		{printf("BREAK\n");}
"/contn/" {printf("CONT\n");}
"." {printf("PERIOD\n");}
"/loop/" {printf("LOOP\n");}
"/IF/" {printf("IF\n");}
"/ELSE/" {printf("ELSE\n");}
"/scan/" {printf("INPUT\n");}
"/print/" {printf("OUTPUT\n");}
"/printL/" {printf("OUTPUT_WITH_NEWLINE\n");}
"/ret/" {printf("RETURN\n");}
"/,/" {printf("COMMA\n");}
"/:/" {printf("COLON\n");}
{ALPHA}+            {printf("IDENTIFIER:%s\n", yytext);}

.		{printf("**Error. Unidentified token**  %s\n", yytext);}
%%

int main(void){
    printf("Ctrl+D to quit\n");
    yylex();
}
