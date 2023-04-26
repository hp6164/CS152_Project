BISON FILE FORMAT:
%{

%}
%token NUM COLON IDENTIFIER L_SQR R_SQR ....
%%
prog_start: %empty {printf("prog_start --> epsilon\n");}
            | functions {printf("prog_start --> functions\n");}
            ; 

functions:  function {printf("function --> functions\n");}
            | function functions {printf("function --> function functions\n");}
            ;
function:   NUM IDENTIFIER L_PAR arguments R_PAR L_CUR statements R_CUR
            {printf("function -->   NUM IDENTIFIER L_PAR arguments R_PAR L_CUR statements R_CUR\n");}

arguments:  %empty {printf("arguments --> epsilon");}
            | argument COMMA NUM arguments {printf("arguments --> arguments COMMA arguments");}
            ;

argument:   %empty {printf("arguments --> epsilon");} 
            | NUM IDENTIFIER {printf("argument --> NUM IDENTIFIER");}
            ;

statements: %empty {printf("statements --> epsilon")}
            | statement PERIOD statements
            ;

statement:  declaration
            | function_call
            | printstatement
            | printstatementnewline
            | readstatement
            ;

printstatement:  OUTPUT L_PAR IDENTIFIER R_PAR;

printstatementnewline:  OUTPUT_WITH_NEWLINE L_PAR IDENTIFIER R_PAR;

readstatement: INPUT L_PAR IDENTIFIER R_PAR;
                

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
