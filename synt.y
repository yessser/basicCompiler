%token Ecrire Return guil equal idf notEqual great infr cst greatEql infrEql aff  pvg algo var dp vg entier reel chaine  deb fin InOut Arithme O F include plus minus mult div tanq Faire Fait
%%
S: LISTE_BIBL algo idf DECLARATION CORPS { printf("syntaxe correcte");};

LISTE_BIBL: include O BIBL F  LISTE_BIBL
            |
;
BIBL: InOut |Arithme ;
DECLARATION: var DECLARATIONFONC DECLARATIONVAR
;
DECLARATIONFONC: FONC idfFonc (LISTE_PARA) dp TYPE var DECLARATIONVAR CORPS  DECLARATIONFONC 
            |
;
TYPE: entier | reel | chaine
;
DECLARATIONVAR: LISTE_IDF dp entier pvg
;
LISTE_IDF: idf vg LISTE_IDF 
          |idf
		  ;

CORPS: deb  LISTE_INST fin
;	

LISTE_INST:AFFECTATION LISTE_INST
          |BOUCLE LISTE_INST
          |ECRIRE LISTE_INST
          |LIRE LISTE_INST
          |COMMENTAIRE LISTE_INST
          |
;	  
AFFECTATION: idf aff Expr_Arit pvg
          |idfTAB aff Expr_Arit pvg
;
Expr_Arit:cst
          |idf
          |idfTAB
          |Expr_Arit plus Expr_Arit
          |Expr_Arit minus Expr_Arit
          |Expr_Arit mult Expr_Arit
          |Expr_Arit div Expr_Arit
          |oprt Expr_Arit cprt
;
BOUCLE: tanq oprt CONDITION cprt Faire LISTE_INST Fait
;
CONDITION:idf great idf
          |idf greatEql idf
          |idf infr idf
          |idf infrEql idf
          |idf equal idf
          |idf notEqual idf
;
NOM_FONCTION:idfFonc oprt idf LISTE_VARIABLE cprt pvg
            |idfFonc oprt cprt pvg
;
ECRIRE: Ecrire oprt guil chaine guil cprt pvg
;
LIRE:Lire oprt idf LISTE_VARIABLE cprt pvg 
;
LISTE_VARIABLE:vg idf LISTE_VARIABLE
            |
;
COMMENTAIRE:Text
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
