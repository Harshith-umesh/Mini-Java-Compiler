%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>

	#include "y.tab.h"

	int line = 1;
	
	extern FILE * fp;

	extern void yyerror(const char *);  
	static void comment(void);



%}


D   		[0-9]
L   		[a-zA-Z_]
A   		[a-zA-Z_0-9]
WS  		[ \t\v\f]


%%

[\n]		{   line++;	}
\/\/(.*)                                                            ;
\/\*([^\*\/]*)\*\/  


	/* Data Types */
int			{    return(INT); }
float		{    return(FLOAT); }
char		{    return(CHAR); }
void		{    return(VOID); }




	/* Headers */
class		{ return CLASS; }
import		{ return IMPORT;}


	/* Java Libraries */
java.util.\*	{ fprintf(yyout, "%s", yytext);  return UTIL; }
java.lang.\*	{ fprintf(yyout, "%s", yytext);  return LANG; }
java.math.\*	{ fprintf(yyout, "%s", yytext);  return MATH; }
java.io.\*	{ fprintf(yyout, "%s", yytext);  return IO; }

	/* Control Structures */
for			{    return FOR; }


"System.out.println"	{ fprintf( yyout,"%s", yytext); return PRINT;}
"System.out.print" 		{ fprintf( yyout,"%s", yytext); return PRINT;}
return 		{ 	  return RETURN; }

	/* User Defined Data Types, Identifiers */

{L}{A}*							{	
									
									strcpy(yylval.sval, yytext);
									return IDENTIFIER;
								}
{D}+\.{D}+                      {	
									 
									strcpy(yylval.sval, yytext);  
									return FLOAT_LITERAL;
								}  		
{D}+							{	
									 
									strcpy(yylval.sval, yytext); 
									return INTEGER_LITERAL;
								}	

"'"."'"							{	
									
									strcpy(yylval.sval, yytext);
									return CHARACTER_LITERAL;  
								}

\"{A}+(".h"|".c")\"				{  
									
									strcpy(yylval.sval, yytext);
									return HEADER_LITERAL;
								}

\".*\"							{  
									
									strcpy(yylval.sval, yytext);
									return STRING_LITERAL; 
								}


	/* Assignment Operators */
"+="		{   return(ADD_ASSIGN); }
"-="		{   return(SUB_ASSIGN); }
"*="		{   return(MUL_ASSIGN); }
"/="		{   return(DIV_ASSIGN); }
"%="		{   return(MOD_ASSIGN); }

	/* Relational Operators */
"++"		{   return(INC_OP); }
"--"		{   return(DEC_OP); }
"<="		{   return(LE_OP); }
">="		{   return(GE_OP); }
"=="		{   return(EQ_OP); }
"!="		{   return(NE_OP); }

	/* Basic Syntax */
";"			{   return(';'); }
"{"			{   return('{'); }
"}"			{   return('}'); }
","			{   return(','); }
":"			{   return(':'); }
"="			{   return('='); }
"("			{   return('('); }
")"			{   return(')'); }
("["|"<:")	{   return('['); }
("]"|":>")	{   return(']'); }
"."			{   return('.'); }
"&"			{   return('&'); }
"!"			{   return('!'); }
"~"			{   return('~'); }
"-"			{   return('-'); }
"+"			{   return('+'); }
"*"			{   return('*'); }
"/"			{   return('/'); }
"%"			{   return('%'); }
"<"			{   return('<'); }
">"			{   return('>'); }
"^"			{   return('^'); }
"|"			{   return('|'); }
"?"			{   return('?'); }


{WS}+		{  /* whitespace separates tokens */}

.			{ printf("No Match, Invalid Expression %s\n", yytext); return yytext[0];}

%%

int yywrap(void)
{
	return 1;
}


static void comment(void)
{
    int c;

    while ((c = input()) != 0)
        if (c == '*')
        {
            while ((c = input()) == '*');
            if (c == '/')
                return;

            if (c == 0)
                break;
        }
    yyerror("Unterminated comment");
}