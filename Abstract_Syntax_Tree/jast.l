%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>

	#include "y.tab.h"


	int line = 1;
	extern int scope;

	extern void yyerror(const char *);  

	extern struct node * checksym(char *);


%}


D   		[0-9]
L   		[a-zA-Z_]
A   		[a-zA-Z_0-9]
WS  		[ \t\v\f]


%%

[\n]		{ fprintf(yyout, "%s", yytext); line++;	}
\/\/(.*)                                                            ;
\/\*([^\*\/]*)\*\/                                                  ;


	/* Data Types */
int			{ fprintf(yyout, "%s", yytext);  yylval.ival=0; return(INT); 	}
float		{ fprintf(yyout, "%s", yytext);  yylval.ival=1; return(FLOAT); }
char		{ fprintf(yyout, "%s", yytext);  yylval.ival=2; return(CHAR); }
void		{ fprintf(yyout, "%s", yytext);  yylval.ival=3; return(VOID); }




	/* Headers */
class		{ return CLASS; }
import		{ return IMPORT;}


	/* Java Libraries */
java.util.\*	{ fprintf(yyout, "%s", yytext);  return UTIL; }
java.lang.\*	{ fprintf(yyout, "%s", yytext);  return LANG; }
java.math.\*	{ fprintf(yyout, "%s", yytext);  return MATH; }
java.io.\*	{ fprintf(yyout, "%s", yytext);  return IO; }

	/* Control Structures */
for			{ fprintf(yyout, "%s", yytext);  return FOR; }
while			{ fprintf(yyout, "%s", yytext);  return WHILE; }

"System.out.println"	{ fprintf( yyout,"%s", yytext); return PRINT;}
"System.out.print" 		{ fprintf( yyout,"%s", yytext); return PRINT;}
return 		{ fprintf(yyout, "%s", yytext);	 return RETURN; }

	/* User Defined Data Types, Identifiers */

{L}{A}*							{	fprintf(yyout, "%s", yytext);  
									yylval.ptr = checksym(yytext); 
									return IDENTIFIER;
								}
{D}+\.{D}+                      {	fprintf(yyout, "%s", yytext);   
									yylval.fval=atof(yytext);
									return FLOAT_LITERAL;
								}  		
{D}+							{	fprintf(yyout, "%s", yytext);  
									yylval.ival=atoi(yytext);
									return INTEGER_LITERAL;
								}	

"'"."'"							{	fprintf(yyout, "%s", yytext);
									yylval.cval= yytext[1];
									return CHARACTER_LITERAL;  
								}


\".*\"							{fprintf(yyout, "%s", yytext);  return STRING_LITERAL; }


	/* Assignment Operators */
"+="		{fprintf(yyout, "%s", yytext);  return(ADD_ASSIGN); }
"-="		{fprintf(yyout, "%s", yytext);  return(SUB_ASSIGN); }
"*="		{fprintf(yyout, "%s", yytext);  return(MUL_ASSIGN); }
"/="		{fprintf(yyout, "%s", yytext);  return(DIV_ASSIGN); }
"%="		{fprintf(yyout, "%s", yytext);  return(MOD_ASSIGN); }

	/* Relational Operators */
"++"		{fprintf(yyout, "%s", yytext);  return(INC_OP); }
"--"		{fprintf(yyout, "%s", yytext);  return(DEC_OP); }
"<="		{fprintf(yyout, "%s", yytext);  return(LE_OP); }
">="		{fprintf(yyout, "%s", yytext);  return(GE_OP); }
"=="		{fprintf(yyout, "%s", yytext);  return(EQ_OP); }
"!="		{fprintf(yyout, "%s", yytext);  return(NE_OP); }

	/* Basic Syntax */
";"			{fprintf(yyout, "%s", yytext);  return(';'); }
"{"			{fprintf(yyout, "%s", yytext);  scope++; return('{'); }
"}"			{fprintf(yyout, "%s", yytext);  return('}'); }
","			{fprintf(yyout, "%s", yytext);  return(','); }
":"			{fprintf(yyout, "%s", yytext);  return(':'); }
"="			{fprintf(yyout, "%s", yytext);  return('='); }
"("			{fprintf(yyout, "%s", yytext);  return('('); }
")"			{fprintf(yyout, "%s", yytext);  return(')'); }
("]")   	{fprintf(yyout, "%s", yytext);  return(']'); }
("[")   	{fprintf(yyout, "%s", yytext);  return('['); }
"."			{fprintf(yyout, "%s", yytext);  return('.'); }
"&"			{fprintf(yyout, "%s", yytext);  return('&'); }
"!"			{fprintf(yyout, "%s", yytext);  return('!'); }
"~"			{fprintf(yyout, "%s", yytext);  return('~'); }
"-"			{fprintf(yyout, "%s", yytext);  return('-'); }
"+"			{fprintf(yyout, "%s", yytext);  return('+'); }
"*"			{fprintf(yyout, "%s", yytext);  return('*'); }
"/"			{fprintf(yyout, "%s", yytext);  return('/'); }
"%"			{fprintf(yyout, "%s", yytext);  return('%'); }
"<"			{fprintf(yyout, "%s", yytext);  return('<'); }
">"			{fprintf(yyout, "%s", yytext);  return('>'); }
"^"			{fprintf(yyout, "%s", yytext);  return('^'); }
"|"			{fprintf(yyout, "%s", yytext);  return('|'); }
"?"			{fprintf(yyout, "%s", yytext);  return('?'); }


{WS}+		{fprintf(yyout, "%s", yytext); /* whitespace separates tokens */}

.			{ printf("No Match, Invalid Expression %s\n", yytext); return yytext[0];}

%%

int yywrap(void)
{
	return 1;
}