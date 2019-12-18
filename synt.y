%{
#include <stdio.h>
#include <string.h>

char suavType[20];
char sauvFct[15]="";
char sauvTypeFunct[15];
int nb_ligne=1;


%}

%union{
        int entier;
        char* str;
}

%token  <str>idf <entier>cst aff  pvg algo var dp vg <str>entier <str>reel <str>chaine  deb fin idfTAB
        InOut Arithme O F include 
        idfFonc
        oprt cprt
        obrk cbrk mc_const
        idenFun Return guil Ecrire Lire 
        notEqual great infr greatEql infrEql equal
        plus minus mult dive tanq Faire Fait 
        Str

        
  
%%


S: LISTE_BIBL algo idf {DECLARATION CORPS  { printf("syntaxe correcte");YYACCEPT;}
;

LISTE_BIBL: include infr BIBL F  LISTE_BIBL
            |
;
BIBL: InOut |Arithme 
;
DECLARATION: var DECLARATIONFONC DECLARATIONVAR
;
DECLARATIONFONC:idfFonc {strcpy(sauvTypeFunct,$1); strcpy(sauvFct,$1);} oprt LISTE_PARAM cprt dp TYPE {strcpy(sauvTypeFunct,"");} var DECLARATIONVAR CORPS {strcpy(sauvFct,"");} DECLARATIONFONC 
            |
;
LISTE_PARAM: idf dp TYPE vg LISTE_PARAM { inserer($1,"idf",sauvFct); inserePrm($1,sauvFct); }
            |idf dp TYPE { inserer($1,"idf",sauvFct); inserePrm($1,sauvFct);}
            |
;
TYPE:entier  { if(strcmp(sauvTypeFunct,"")==1) insererTypeFunct(sauvTypeFunct,$1); else insererType($1); }
    |reel  {  if(strcmp(sauvTypeFunct,"")==1) insererTypeFunct(sauvTypeFunct,$1); else insererType($1); }
    |chaine  { if(strcmp(sauvTypeFunct,"")==1) insererTypeFunct(sauvTypeFunct,$1); else insererType($1); }
;
DECLARATIONVAR:LISTE_IDF dp TYPE pvg DECLARATIONVAR 
              |
;
IDENTIF:idf  {inserer($1,"idf",sauvFct);}
| idf obrk cst cbrk { inserer($1,"idf",sauvFct); insertTable($1,"Table",$3,sauvFct);}
        | mc_const idf { inserer($1,"idf",sauvFct); insertCST($2,sauvFct);}
;
LISTE_IDF: IDENTIF vg LISTE_IDF
          |IDENTIF 
;


CORPS: deb LISTE_INST fin
;	

INSTRUCTION:AFFECTATION|BOUCLE|ECRIRE|LIRE|NOM_FONCTION|RETURN
;
LISTE_INST:INSTRUCTION LISTE_INST
          |
;	  

AFFECTATION:idf aff Expr_Arit pvg
          |idfTAB aff Expr_Arit pvg
;
OPERATEUR:plus|minus|mult|dive
;
OPERAND:idfTAB|idf|cst
;
Expr_Arit:OPERAND 
        |Expr_Arit OPERATEUR Expr_Arit 
        |oprt Expr_Arit cprt
;


BOUCLE: tanq CONDITION cprt Faire LISTE_INST Fait
;


CONDITION_Cond:great|greatEql|infr|infrEql|equal|notEqual
;
CONDITION:OPERAND CONDITION_Cond OPERAND
;

PARAMETRE:idf LISTE_VARIABLE 
        |
;
NOM_FONCTION:idenFun PARAMETRE cprt pvg
;

ECRIRE:Ecrire Str cprt pvg
;
LIRE:Lire oprt idf LISTE_VARIABLE cprt pvg 
;

LISTE_VARIABLE:vg idf LISTE_VARIABLE
            |
;
RETURN:Return idf pvg
;
%%
main () 
{
yyparse();
afficher();
}
yywrap() 
{}
