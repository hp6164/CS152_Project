%{
// c code here
#include <stdio.h>
%}

DIGIT [0-9]
ALPHA [a-zA-z]
%%

"\s"            //ignore whitespace
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
"<"				{printf("L_T:(<)\n", yytext);}
">"				{printf("G_T:(>)\n", yytext);}
"/<=/"			{printf("L_EQ:(<=)\n", yytext);}
"/>=/"			{printf("G_EQ:(>=)\n", yytext);}
"/AND/"			{printf("AND\n", yytext);}
"/OR/"			{printf("OR\n", yytext);}
"/NOT/"			{printf("NOT\n", yytext);}
"/==/"			{printf("EQUALS\n", yytext);}
"/!=/"			{printf("NOT_EQ\n", yytext);}

//---------_HARSH SHARMA ABOVE_-------------//

{"contn"} {printf("CONT")}
{"."} {printf("PERIOD")}
{"loop"} {printf("LOOP")}
{"IF"} {printf("IF")}
{"ELSE"} {printf("ELSE")}
{"scan"} {printf("INPUT")}
{"print"} {printf("OUTPUT")}
{"printL"} {printf("OUTPUT_WITH_NEWLINE")}
{"ret"} {printf("RETURN")}
{","} {printf("COMMA")}
{":"} {printf("COLON")}
{" "} {printf("#")}

.		{printf("**Error. Unidentified token**  %s\n", yytext);}
%%

int main(void){
    printf("Ctrl+D to quit\n");
    yylex();
}
