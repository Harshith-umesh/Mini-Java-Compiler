/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IMPORT = 258,
    UTIL = 259,
    MATH = 260,
    IO = 261,
    LANG = 262,
    CLASS = 263,
    STRING_LITERAL = 264,
    HEADER_LITERAL = 265,
    PRINT = 266,
    RETURN = 267,
    UMINUS = 268,
    INTEGER_LITERAL = 269,
    CHARACTER_LITERAL = 270,
    FLOAT_LITERAL = 271,
    IDENTIFIER = 272,
    FOR = 273,
    INC_OP = 274,
    DEC_OP = 275,
    LE_OP = 276,
    GE_OP = 277,
    EQ_OP = 278,
    NE_OP = 279,
    MUL_ASSIGN = 280,
    DIV_ASSIGN = 281,
    MOD_ASSIGN = 282,
    ADD_ASSIGN = 283,
    SUB_ASSIGN = 284,
    CHAR = 285,
    INT = 286,
    FLOAT = 287,
    VOID = 288
  };
#endif
/* Tokens.  */
#define IMPORT 258
#define UTIL 259
#define MATH 260
#define IO 261
#define LANG 262
#define CLASS 263
#define STRING_LITERAL 264
#define HEADER_LITERAL 265
#define PRINT 266
#define RETURN 267
#define UMINUS 268
#define INTEGER_LITERAL 269
#define CHARACTER_LITERAL 270
#define FLOAT_LITERAL 271
#define IDENTIFIER 272
#define FOR 273
#define INC_OP 274
#define DEC_OP 275
#define LE_OP 276
#define GE_OP 277
#define EQ_OP 278
#define NE_OP 279
#define MUL_ASSIGN 280
#define DIV_ASSIGN 281
#define MOD_ASSIGN 282
#define ADD_ASSIGN 283
#define SUB_ASSIGN 284
#define CHAR 285
#define INT 286
#define FLOAT 287
#define VOID 288

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 40 "jicg.y" /* yacc.c:1909  */
	
	char sval[300];

#line 124 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
