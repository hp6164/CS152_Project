%{
// c code here
#include <stdio.h>
#include "p.tab.h"
int newLine = 1;
int col = 1;
%}


DIGIT [0-9]+
VARI [a-zA-z][a-zA-Z0-9]*
NUMLETTER [0-9]+[a-zA-z]+[0-9a-zA-Z]*
COLONLETTER (^[^:]:)+
FUNCNAME [:][a-zA-Z]+
COMMENT [\$].*

%%

[\n]+           {newLine++; col = 1;}
[ \t]    	    {col += 1;}
{COMMENT}       {col += yyleng;}
"%"             {return MODULUS; col++;}
"num"           {return NUM; col += 3;}
"+"		        {return PLUS; col++;}
"-"             {return MINUS; col++;}
"/"             {return DIVIDE; col++;}	
"*"             {return MULTIPLY; col++;}
"{"             {return L_CUR; col++;}
"}"             {return R_CUR; col++;}
"["		        {return L_SQR; col++;}
"]"		        {return R_SQR; col++;}
"|"				{return CONTAIN; col++;}
"="				{return EQ; col++;}
lt				{return L_T; col += 2;}
gt				{return G_T; col += 2;}
leq			    {return L_EQ; col += 3;}
geq			    {return G_EQ; col += 3;}
AND			    {return AND; col += 3;}
OR			    {return OR; col += 2;}
NOT			    {return NOT; col += 3;}
same			{return EQUALS; col += 4;}
diff			{return NOT_EQ; col += 4;}
"("			    {return L_PAR; col++;}
")"			    {return R_PAR; col++;}
break		    {return BREAK; col += 5;}
"."             {return PERIOD; col++;}
contn           {return CONT; col += 5;}
loop            {return LOOP; col += 4;}
IF              {return IF; col += 2;}
ELSE            {return ELSE; col += 4; }
scan            {return INPUT; col += 4;}
print           {return OUTPUT; col += 5;}
printL          {return OUTPUT_WITH_NEWLINE; col += 6;}
ret             {return RETURN; col += 3;}
","             {return COMMA; col++;}
"list"          {return LIST; col+=4;}

{FUNCNAME}      {return FUNCNAME; col += yyleng;}
{COLONLETTER}   {{printf("Error at line %d, column %d: identifier %s cannot use variable name with colon \n",newLine, col, yytext);}}
{NUMLETTER}     {{printf("Error at line %d, column %d: identifier %s must begin with a letter \n",newLine, col, yytext);}}

{DIGIT}	        {return DIGIT; col += yyleng;}
{VARI}          {col+=yyleng; return IDENTIFIER;}

.		        {printf("**Error. Unidentified symbol  %s at line %d, column %d \n", yytext, newLine, col);}
%%
