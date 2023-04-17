%{
// c code here
#include <stdio.h>
%}

DIGIT [0-9]
Letter [a-zA-z]
%%

{DIGIT}+ {printf("NUMBER: %s\n", yytext);}
{Letter}+ {printf(")}

%%

int main(void){
    printf("Ctrl+D to quit\n")
}