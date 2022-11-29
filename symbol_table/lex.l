%{
	#include <stdio.h>
	#include <stdlib.h>	
	#include "y.tab.h"
	#include "symbol_table.h"
	extern int scope;
	extern SymbolTable symbolTable;
	int lines = 0;	
%}

digit			[0-9]
alpha			[a-zA-Z]
und				"_"

%%
"//".*\n 							// Single-Line Comment Removal	
"/*"[^*/]*"*/" 						// Multi-Line Comment Removal
[\t ]								// Removal of tabs and new-lines 
"\n"			{lines++;}
({digit})+		{yylval.integer = atoi(yytext); return T_NUM;}	//integers

"import"  		{return T_IMPORT;}
"class"			{return T_CLASS;}
"public" 		{return T_PUBLIC;}
"private" 		{return T_PRIVATE;}
"protected" 	{return T_PROTECTED;}
"static" 		{return T_STATIC;}
"true"			{return T_TRUE;}
"false"			{return T_FALSE;}
"void"			{return T_VOID;}
"main" 			{return T_MAIN;}
"char"			{return T_CHAR;}
"int" 			{return T_INT;}
"float" 		{return T_FLOAT;}
"if"			{return T_IF;}
"long"			{return T_LONG;}
"double" 		{return T_DOUBLE;}
"boolean"		{return T_BOOLEAN;}
"while" 		{return T_WHILE;}
"for" 			{return T_FOR;}
"do" 			{return T_DO;}
"{"				{scope++; return '{';}
"}"				{
					PrintSymbolTable(scope, &symbolTable); 
					RemoveSymbolScope(scope, &symbolTable); 
					scope--; 
					return '}';	
				}

"==" 			{return T_S_EQ;}

"--" 			{return T_U_DECR;}
"++" 			{return T_U_INCR;}
"+="			{return T_S_PLUSEQ;}
"-="			{return T_S_MINUSEQ;}
"*="			{return T_S_MULTEQ;}
"/="     		{return T_S_DIVEQ;}
"!="      	    {return T_NE;}
">="			{return T_GEQ;}
"<="			{return T_LEQ;}
">"				{return T_GE;}
"<"				{return T_LE;}
"=" 	    	{return T_ASSG;}
"+"  			{return T_S_PLUS;}
"-"   			{return T_S_MINUS;}
"*"				{return T_S_MULT;}
"/"				{return T_S_DIV;}

({alpha}|{und}|$)({alpha}|{und}|{digit}|$)*	{
				yylval.string = strdup(yytext); 
				return T_ID ;
				}
.    			{return yytext[0];}
%%
