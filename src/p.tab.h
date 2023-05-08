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

#ifndef YY_YY_P_TAB_H_INCLUDED
# define YY_YY_P_TAB_H_INCLUDED
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
    NUM = 258,
    COLON = 259,
    IDENTIFIER = 260,
    L_SQR = 261,
    R_SQR = 262,
    L_CUR = 263,
    R_CUR = 264,
    L_PAR = 265,
    R_PAR = 266,
    MODULUS = 267,
    PLUS = 268,
    MINUS = 269,
    DIVIDE = 270,
    MULTIPLY = 271,
    L_T = 272,
    G_T = 273,
    L_EQ = 274,
    G_EQ = 275,
    EQ = 276,
    AND = 277,
    OR = 278,
    NOT = 279,
    EQUALS = 280,
    NOT_EQ = 281,
    CONTAIN = 282,
    BREAK = 283,
    PERIOD = 284,
    CONT = 285,
    LOOP = 286,
    IF = 287,
    ELSE = 288,
    INPUT = 289,
    OUTPUT = 290,
    OUTPUT_WITH_NEWLINE = 291,
    RETURN = 292,
    COMMA = 293,
    FUNCNAME = 294,
    DIGIT = 295
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_P_TAB_H_INCLUDED  */
