%token  idf cst   aff  pvg algo var dp vg entier reel chaine  deb fin idfTAB
        InOut Arithme O F include 
        idfFonc
         oprt cprt
        obrk cbrk mc_const
        idenFun Return guil Ecrire Lire 
        notEqual great infr greatEql infrEql equal
        plus minus mult dive tanq Faire Fait 
        Str
  
%%
S: LISTE_BIBL algo idf DECLARATION CORPS { printf("syntaxe correcte");};

LISTE_BIBL: include infr BIBL F  LISTE_BIBL
            |
;
BIBL: InOut |Arithme 
;
DECLARATION: var DECLARATIONFONC DECLARATIONVAR
;
DECLARATIONFONC:idfFonc oprt LISTE_PARAM cprt dp TYPE var DECLARATIONVAR CORPS  DECLARATIONFONC 
            |
;
LISTE_PARAM: idf dp TYPE vg LISTE_PARAM
            |idf dp TYPE
            |
;
TYPE: entier | reel | chaine
;
DECLARATIONVAR: LISTE_IDF dp TYPE pvg DECLARATIONVAR 
                |
;
IDENTIF:idf | idfTAB | mc_const idf
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
}
yywrap() 
{}
