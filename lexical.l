%{
#include "synt.tab.h"  
#include<stdio.h>
int nb_ligne=1;
%}
lettre [a-zA-Z]
chiffre [0-9]
IDF {lettre}({lettre}|{chiffre})*
cst {chiffre}+
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
\n 
{IDF}  return idf;
{cst} return cst;
= return aff;
# return pvg;
[ \t] 
. printf("erreur lexicale a la ligne %d \n",nb_ligne) ;
