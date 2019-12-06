%{
#include "synt.tab.h"
#include <stdio.h>
#include <string.h>

int nb_ligne=1;
int nb_char=1;
extern YYSTYPE yylval;
extern int cptTypes=0;
extern int CpTabSym=0;


typedef struct
{
    char NomEntite[20];
    char CodeEntite[20];
    char TypeEntite[20];
}TypeTS;

extern TypeTS ts[100];


int colone=1;

void yyerror ( char* msg ) {

printf ( " Erreur Syntaxique rencontrée a la ligne : %d \n ",yylineno );

int recherche(char entite[])
{
    int i=0;

    while(i<CpTabSym)
    {
        if (strcmp(entite,ts[i].NomEntite)==0) return i;
        i++;
    }
    return -1;
}

void inserer(char entite[], char code[])
{
    if ( recherche(entite)==-1)
    {
        cptTypes++;
        strcpy(ts[CpTabSym].NomEntite,entite);
        strcpy(ts[CpTabSym].CodeEntite,code);
        CpTabSym++;
    }
    else
    {
        printf("variable %s already exist a la ligne %d \n ",entite);
    }

}

}

void afficher ()
{
    printf("\n/***************Table des symboles ******************/\n");
    printf("_________________________________________________\n");
    printf("\t| NomEntite | CodeEntite |TypeEntite\n");
    printf("_________________________________________________\n");
    int i=0;
    while(i<CpTabSym)
    {
        printf("\t|%10s |%12s | %12s |\n",ts[i].NomEntite,ts[i].CodeEntite,ts[i].TypeEntite);
        i++;
    }
}
      

%}
%option yylineno

lettre [a-zA-Z]
chiffre [0-9]
IDF {lettre}({lettre}|{chiffre}|_)*
IDFCmntr [^"*/"]*
IDFTxt [^"""]*
cst {chiffre}+
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
\>\n return F;
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
FONCTION" "*{IDFFONC} return idfFonc; 
{IDFFONC}" "*\( return idenFun;
\[ return obrk;   
\] return cbrk;
CONST return mc_const;
{IDF}\[{cst}\] return idfTAB;
{IDF}  {yylval.str=strdup(yytext); return idf;}
{cst} {yylval.entier=atoi(yytext);  return cst;}
:= return aff;
# return pvg;
\+ return plus;
\- return minus;
\* return mult;
\/ return dive;


[ \t]

. printf("erreur lexicale a la ligne %d \n",nb_ligne) ;
