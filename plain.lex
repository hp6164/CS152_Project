%{
// c code here
#include <stdio.h>
%}

DIGIT [0-9]
Letter [a-zA-z]
%%

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

{DIGIT}+ {printf("NUMBER: %s\n", yytext);}
{Letter}+ {printf("")}

%%

int main(void){
    printf("Ctrl+D to quit\n")
}