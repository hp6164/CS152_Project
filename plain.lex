%{
// c code here
#include <stdio.h>
int newLine = 1;
int col = 1;
%}

DIGIT [0-9]
ALPHA [a-zA-z]
%%

[\n]+      {newLine++; col = 1;}
[ ]+    	{printf("#\n"); col++;}
{DIGIT}+	    {printf("NUM: %s\n", yytext); col++;}
"+"		        {printf("PLUS\n"); col++;}
"-"             {printf("MINUS\n"); col++;}
"/"             {printf("DIVIDE\n"); col++;}	
"*"             {printf("MULTIPLY\n"); col++;}
"{"             {printf("L_CUR\n"); col++;}
"}"             {printf("R_CUR\n"); col++;}
"/[/"		{printf("L_SQR\n"); col++;}
"/]/"		{printf("R_SQR\n"); col++;}
"|"				{printf("CONTAIN\n"); col++;}
"="				{printf("EQ\n"); col++;}
lt				{printf("L_T\n"); col += 2;}
gt				{printf("G_T\n"); col += 2;}
leq			{printf("L_EQ\n"); col += 3;}
geq			{printf("G_EQ\n"); col += 3;}
AND			{printf("AND\n"); col += 3;}
OR			{printf("OR\n"); col += 2;}
NOT			{printf("NOT\n"); col += 3;}
same			{printf("EQUALS\n"); col += 4;}
diff			{printf("NOT_EQ\n"); col += 4;}
"("			{printf("L_PAR\n"); col++;}
")"			{printf("R_PAR\n"); col++;}
break		{printf("BREAK\n"); col += 5;}
contn {printf("CONT\n"); col += 5;}
"." {printf("PERIOD\n"); col++;}
loop {printf("LOOP\n"); col += 4;}
IF {printf("IF\n"); col += 2;}
ELSE {printf("ELSE\n"); col += 4; }
scan {printf("INPUT\n"); col += 4;}
print {printf("OUTPUT\n"); col += 5;}
printL {printf("OUTPUT_WITH_NEWLINE\n"); col += 6;}
ret {printf("RETURN\n"); col += 3;}
"," {printf("COMMA\n"); col++;}
":" {printf("COLON\n"); col++;}
{ALPHA}+            {printf("IDENTIFIER:%s\n", yytext); col++;}

.		{printf("**Error. Unidentified symbol  %s at line %d, column %d \n", yytext, newLine, col);}
%%

int main(void){
    printf("Ctrl+D to quit\n");
    yylex();
}
