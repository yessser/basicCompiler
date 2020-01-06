%{
#include "synt.tab.h"
//#include "Table.h"
#include <stdio.h>
#include <string.h>

extern int nb_ligne;
extern char sauvFct[15];
extern YYSTYPE yylval;

%}
%option yylineno

lettre [a-zA-Z]
chiffre [0-9]
IDF {lettre}({lettre}|{chiffre}|_)*
IDFCmntr [^"*/"]*
IDFTxt [^"""]*
cst [+-]?{chiffre}+
IDFFONC {lettre}({lettre}|{chiffre}|_){1,11}

%%

ALGORITHME return algo;
DEBUT return deb;
FIN return fin;
VAR return var;
\/\*{IDFCmntr}\*\/
\"{IDFTxt}\" return Str; 
entier {yylval.str=strdup(yytext); return entier;}
reel {yylval.str=strdup(yytext); return reel;}
chaine {yylval.str=strdup(yytext); return chaine;}
Tanque" "*\( return tanq;
Faire return Faire;
Fait return Fait;
: return dp;
\. return vg;
$$include return include;
InOut return InOut;
Arithme return Arithme;
\>\n {nb_ligne++; return F;}
\( return oprt;
\) return cprt;
\> return great;
\>= return greatEql;
\< return infr;
\<= return infrEql;
\= return equal;
\!= return notEqual;
ECRIRE" "*\( return Ecrire;
LIRE return Lire;
RETURN return Return;
\" return guil;
\n nb_ligne++;
FONCTION" "*{IDFFONC} {yylval.str=strdup(yytext); insererFct(yytext); return idfFonc;} 
\[ return obrk;   
\] return cbrk;
CONST return mc_const;
{IDF}  {yylval.str=strdup(yytext);  return idf;}
{cst} {yylval.entier=atoi(yytext); return cst;}
:= return aff;
# return pvg;
\+ return plus;
\- return minus;
\* return mult;
\/ return dive;


[ \t]

. printf("erreur lexicale a la ligne %d \n",nb_ligne) ;
