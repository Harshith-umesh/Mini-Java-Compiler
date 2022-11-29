%{
#include <stdio.h>
#include <stdlib.h>
#include "symbol_table.h"

int yylex(void);
void yyerror(char *);

extern int lines;

int scope = 0;
SymbolTable symbolTable;
char type_helper[30] = "unavailable";
%}

%union
{
	int integer;
	char *string;
}

%token <integer> T_NUM
%token <string> T_ID
%type<integer> T_Const
%type<integer> T_expr
%type<integer> empty

%token 	T_PUBLIC 	T_PRIVATE 	T_PROTECTED 	T_STATIC 	T_VOID 		T_CLASS 	T_IMPORT
%token  T_WHILE 	T_MAIN  	T_DO 		T_FOR		T_IF	
%token 	T_INT 		T_FLOAT 	T_LONG 		T_DOUBLE 	T_BOOLEAN 	T_CHAR
%token	T_S_PLUSEQ 	T_S_MINUSEQ T_S_MULTEQ 		T_S_DIVEQ 	T_TRUE 		T_FALSE 
%nonassoc  	T_S_EQ
%left 	T_S_PLUS 	T_S_MINUS 	T_S_MULT 	T_S_DIV 	T_U_DECR 	T_U_INCR
%right 	T_GEQ 		T_LEQ 		T_LE 		T_GE T_ASSG 	T_NE

%start start_aug

%%

start_aug
	: import_stmt class_def {exit(0);}
	| class_def  {exit(0);}
	;
	
import_stmt
	: T_IMPORT T_ID 
	| import_stmt T_IMPORT T_ID
	;

class_def
	: modifier class_head
	;
	
class_head
	: T_CLASS T_ID '{' main_stmt '}'   {	}
	;

modifier
	: T_PUBLIC  
	| T_STATIC
	| T_PRIVATE
	| T_PROTECTED
	| T_VOID
	;

main_stmt
	: modifier modifier modifier T_MAIN '(' ')' '{'	body	'}'
	;

empty_st
	:
	;

body  
	:  statement_list
	|  empty_st
	;

statement_list
	:	statement
	|	statement_list	statement
	;

statement
	: T_ID T_ASSG T_expr ';' 	{ UpdateSymbolTable($1, scope, $3, &symbolTable);}  
	| var_decl
	| iteration_statement
	| conditional_statement
	;

iteration_statement
	: T_WHILE '(' cond ')' '{' body '}'
	| T_DO '{' body '}' T_WHILE'(' cond ')' ';'
	| T_FOR '(' custom_cond ';' cond ';' cond ')'  '{' body '}'
	;
	
custom_cond
	: cond
	| type T_ID T_ASSG T_expr 	{ InsertIdentifier($2, type_helper, scope, $4, &symbolTable);}
	| T_ID T_ASSG T_expr 		{ UpdateSymbolTable($1, scope, $3, &symbolTable);}
	;
	
conditional_statement
	: T_IF '(' cond ')'  '{' body '}'
	;
	
T_expr
	: T_expr T_S_PLUS	T_expr	{$$ = $1 + $3;}
	| T_expr T_S_MINUS 	T_expr 	{$$ = $1 - $3;}
	| T_expr T_S_MULT 	T_expr  {$$ = $1 * $3;}
	| T_expr T_S_DIV 	T_expr  {$$ = $1 / $3;}
	| T_Const 			{$$ = $1;}
	| empty
	;
	
empty
	: %empty {}
	;
	
T_Const
	: T_ID 				{$$ = LookUpSymbolTable($1, scope, &symbolTable);}
	| T_NUM 			{$$ = $1;}
	;

cond
	: T_TRUE 
	| T_FALSE
	| T_expr T_S_EQ T_expr
	| T_expr T_GEQ T_expr 
	| T_expr T_LEQ T_expr
	| T_expr T_GE T_expr
	| T_expr T_LE T_expr 
	| T_expr
	| T_expr T_S_PLUSEQ T_expr	{$1 = $1 + $3;}
	| T_expr T_S_MINUSEQ T_expr	{$1 = $1 - $3;}
	| T_expr T_S_MULTEQ T_expr	{$1 = $1 * $3;}
	| T_expr T_S_DIVEQ T_expr	{$1 = $1 / $3;}		
	;

type
	: T_INT		{strcpy(type_helper,"int");}
	| T_FLOAT	{strcpy(type_helper,"float");}	
	| T_LONG	{strcpy(type_helper,"long");}
	| T_DOUBLE	{strcpy(type_helper,"float");}
	| T_BOOLEAN	{strcpy(type_helper,"boolean");}
	; 
	
var_decl
	: type T_ID T_ASSG T_expr ';' 	{ InsertIdentifier($2, type_helper, scope, $4, &symbolTable);}
	| type T_ID ';' 		{ InsertIdentifier($2, type_helper, scope, 0, &symbolTable);}
	;
%%

void yyerror(char *s) 
{
	fprintf(stderr, "%s\n", s);
}
int main()
{
	printf("|Variable Name\t|Variable Type\t|Scope\t|Value\t|Line Number\t|\n");
	yyparse();
	return 0;
}
