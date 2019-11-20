%{
#include "synt.tab.h"  
#include<stdio.h>
int nb_ligne=1;
int nb_char=1;
%}
lettre [a-zA-Z]
chiffre [0-9]
IDF {lettre}({lettre}|{chiffre})*
cst {chiffre}+
IDFFONC {lettre}({lettre}|{chiffre}|_){1,11}

%%

ALGORITHME return algo;
DEBUT return deb;
FIN return fin;
VAR return var;
entier return entier;
reel return reel;
chaine return chaine;
: return dp;
\. return vg;
$$include return include;
InOut return InOut;
Arithme return Arithme;
\< return O;
\>\n return F;
\( return oprt;
\) return cprt;
\n
FONCTION" "*{IDFFONC} return idfFonc; 
\[ return obrk;   
\] return cbrk;
CONST return mc_const;
{IDF}  return idf;
{cst} return cst;
= return aff;
# return pvg;
[ \t] 
. printf("erreur lexicale a la ligne %d \n",nb_ligne) ;
