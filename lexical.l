%{
#include "synt.tab.h"  
int nb_ligne=1;
%}
lettre [a-zA-Z]
chiffre [0-9]
IDF {lettre}({lettre}|{chiffre}|_)*
IDFCmntr .|\n
cst {chiffre}+
%%
ALGORITHME return algo;
DEBUT return deb;
FIN return fin;
VAR return var;
\/\*{IDFCmntr}\*\/ return Text;
entier return entier;
reel return reel;
chaine return chaine;
Tanque return tanq;
Faire return Faire;
Fait return Fait;
: return dp;
\. return vg;
$$include return include;
InOut return InOut;
Arithme return Arithme;
\< return O;
\>\n return F;
\> return great;
\>= return greatEql;
\< return infr;
\<= return infrEql;
\= return equal;
\!= return notEqual;
ECRIRE return Ecrire;
RETURN return Return;
\" return guil;
\n 
{IDF} return idf;
{cst} return cst;
:= return aff;
# return pvg;
\+ return plus;
\- return minus;
\* return mult;
\/ return div;
\( return oprt;
\) return cprt;


[ \t] 
. printf("erreur lexicale a la ligne %d \n",nb_ligne) ;
