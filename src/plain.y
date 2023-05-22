%{
#include <stdio.h>
#include<stdio.h>
#include<string>
#include<vector>
#include<string.h>
#include<stdlib.h>
#include "p.tab.h"

extern FILE* yyin;
extern int yylex(void);
void yyerror(const char *msg);
extern int currLine;

char *identToken;
int numberToken;
int  count_names = 0;

enum Type { Integer, Array };

struct Symbol {
  std::string name;
  Type type;
};

struct Function {
  std::string name;
  std::vector<Symbol> declarations;
};

std::vector <Function> symbol_table;

// remember that Bison is a bottom up parser: that it parses leaf nodes first before
// parsing the parent nodes. So control flow begins at the leaf grammar nodes
// and propagates up to the parents.
Function *get_function() {
  int last = symbol_table.size()-1;
  if (last < 0) {
    printf("***Error. Attempt to call get_function with an empty symbol table\n");
    printf("Create a 'Function' object using 'add_function_to_symbol_table' before\n");
    printf("calling 'find' or 'add_variable_to_symbol_table'");
    exit(1);
  }
  return &symbol_table[last];
}

// find a particular variable using the symbol table.
// grab the most recent function, and linear search to
// find the symbol you are looking for.
// you may want to extend "find" to handle different types of "Integer" vs "Array"
bool find(std::string &value) {
  Function *f = get_function();
  for(int i=0; i < f->declarations.size(); i++) {
    Symbol *s = &f->declarations[i];
    if (s->name == value) {
      return true;
    }
  }
  return false;
}

// when you see a function declaration inside the grammar, add
// the function name to the symbol table
void add_function_to_symbol_table(std::string &value) {
  Function f; 
  f.name = value; 
  symbol_table.push_back(f);
}

// when you see a symbol declaration inside the grammar, add
// the symbol name as well as some type information to the symbol table
void add_variable_to_symbol_table(std::string &value, Type t) {
  Symbol s;
  s.name = value;
  s.type = t;
  Function *f = get_function();
  f->declarations.push_back(s);
}

// a function to print out the symbol table to the screen
// largely for debugging purposes.
void print_symbol_table(void) {
  printf("symbol table:\n");
  printf("--------------------\n");
  for(int i=0; i<symbol_table.size(); i++) {
    printf("function: %s\n", symbol_table[i].name.c_str());
    for(int j=0; j<symbol_table[i].declarations.size(); j++) {
      printf("  locals: %s\n", symbol_table[i].declarations[j].name.c_str());
    }
  }
  printf("--------------------\n");
}

struct CodeNode {
    std::string code; // generated code as a string.
    std::string name;
};

%define parse.error verbose
%start prog_start
%token NUM COLON IDENTIFIER L_SQR R_SQR L_CUR R_CUR L_PAR R_PAR
%token MODULUS PLUS MINUS DIVIDE MULTIPLY 
%token L_T G_T L_EQ G_EQ EQ AND OR NOT EQUALS NOT_EQ CONTAIN
%token BREAK PERIOD CONT LOOP IF ELSE INPUT OUTPUT OUTPUT_WITH_NEWLINE
%token RETURN COMMA FUNCNAME 
%token DIGIT LIST

%type  <op_val> symbol
%type <node> functions
%type <node> function
%type <node> arguments
%type <node> argument
%type <node> statements
%type <node> statement
%type <node> array
%type <node> assign
%type <node> ifstatement
%type <node> elsestatement
%type <node> loop
%type <node> expressions
%type <node> binop
%type <node> paramaters
%type <node> declarations
%type <node> declist
%type <node> declaration
%type <node> function_call
%type <node> pstatements
%type <node> mathexp
%type <node> addop
%type <node> term
%type <node> mulop
%type <node> factor
%type <node> rstatement

%%
prog_start: %empty
            {
              CodeNode *node = new CodeNode;
              $$ = node;
            }
            | functions
              {
                  CodeNode *node = $1;
                  std::string code = node->code;
              }
            ; 

functions:  function
            {
              $$ = $1;
            }
            | function functions
              {
                CodeNode *func  = $1;
                CodeNode *funcs = $2;
                std::string code = func->code + funcs->code;
                CodeNode *node = new CodeNode;
                node->code = code;
                $$ = node;
              }
            ;

function:   FUNCNAME L_PAR arguments R_PAR NUM L_CUR statements R_CUR
            {printf("function --> FUNCNAME L_PAR arguments R_PAR NUM L_CUR statements R_CUR\n");}
            ;

arguments:  %empty
            { 
              CodeNode *node = new CodeNode;
              $$ = node;
            }
            | argument COMMA arguments
              {
                  CodeNode *arg1 = $1;
                  CodeNode *arg2 = $3;
                  CodeNode *node = new CodeNode;
                  node->code = arg1->code + arg2->code;
                  $$ = node;
              };
            | argument  
            {
              $$ = $1;
            };

argument:   NUM IDENTIFIER
            {
                std::string code = 	$1 + $2;
                CodeNode *node = new CodeNode;
                node->code = code;
                $$ = node;
            };

statements: %empty 
            {
              CodeNode *node = new CodeNode;
              $$ = node;
            }
            | statement statements
            {
              CodeNode *stmt1 = $1;
              CodeNode *stmt2 = $2;
              CodeNode *node = new CodeNode;
              node->code = stmt1->code + stmt2->code;
              $$ = node;
            };

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

elsestatement: %empty
                {
                  CodeNode *node = new CodeNode;
                  $$ = node;
                }
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

pstatements:  OUTPUT L_PAR mathexp R_PAR PERIOD
              {
                  std::string ident = $3;
                  std::string code = std::string("output(") + ident + std::string(").");
                  CodeNode *node = new CodeNode;
                  node->code = code;
                  $$ = node;
              }
              | OUTPUT_WITH_NEWLINE L_PAR mathexp R_PAR PERIOD
              {
                  std::string ident = $3;
                  std::string code = std::string("outputL(") + ident + std::string(").");
                  CodeNode *node = new CodeNode;
                  node->code = code;
                  $$ = node;
              } 
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


rstatement:  INPUT L_PAR IDENTIFIER R_PAR PERIOD 
             {
                std::string ident = $3;
                std::string code = std::string("read(") + ident + std::string(").");
                CodeNode *node = new CodeNode;
                node->code = code;
                $$ = node;
             }
             ;


symbol:
IDENTIFIER
{
      $$ = $1;
}
| DIGIT
{
      $$ = $1;
}  

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
