%{
// c code here
#include <stdio.h>
%}

DIGIT [0-9]
ALPHA [a-zA-z]
WHITESPACE [\s\t\n]
%%

{WHITESPACE}+    //ignore whitespace
{DIGIT}+	    {printf("NUM: %s\n", yytext);}
{ALPHA}+	    {printf("IDENTIFIER:	%s\n", yytext);}
"+"		        {printf("PLUS:(+)\n", yytext);}
"-"             {printf("MINUS:(-)\n", yytext);}
"/"             {printf("DIVIDE:(/)\n", yytext);}	
"*"             {printf("MULTIPLY:(*)\n", yytext);}
"["             {printf("L_SQR:([)\n", yytext);}
"]"             {printf("L_SQR:(])\n", yytext);}
"{"             {printf("L_CUR:({)\n", yytext);}
"}"             {printf("L_CUR:(})\n", yytext);}
"|"				{printf("CONTAIN:(|)\n", yytext);}
"="				{printf("EQ:(=)\n", yytext);}
"/lt/"				{printf("L_T:(<)\n", yytext);}
"/gt/"				{printf("G_T:(>)\n", yytext);}
"/leq/"			{printf("L_EQ:(<=)\n", yytext);}
"/geq/"			{printf("G_EQ:(>=)\n", yytext);}
"/AND/"			{printf("AND\n", yytext);}
"/OR/"			{printf("OR\n", yytext);}
"/NOT/"			{printf("NOT\n", yytext);}
"/same/"			{printf("EQUALS\n", yytext);}
"/diff/"			{printf("NOT_EQ\n", yytext);}

//---------_HARSH SHARMA ABOVE_-------------//
"("			{printf("L_PAR\n");}
")"			{printf("R_PAR\n");}
"/break/"		{printf("BREAK\n");}
{"/contn/"} {printf("CONT\n")}
{"."} {printf("PERIOD\n")}
{"/loop/"} {printf("LOOP\n")}
{"/IF/"} {printf("IF\n")}
{"/ELSE/"} {printf("ELSE\n")}
{"/scan/"} {printf("INPUT\n")}
{"/print/"} {printf("OUTPUT\n")}
{"/printL/"} {printf("OUTPUT_WITH_NEWLINE\n")}
{"/ret/"} {printf("RETURN\n")}
{"/,/"} {printf("COMMA\n")}
{"/:/"} {printf("COLON\n")}

.		{printf("**Error. Unidentified token**  %s\n", yytext);}
%%

int main(void){
    printf("Ctrl+D to quit\n");
    yylex();
}
