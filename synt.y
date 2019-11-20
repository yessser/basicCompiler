%{
  #include<stdio.h>  
%}
%token idf   cst   aff  pvg algo var dp vg entier reel chaine  deb fin InOut Arithme O F include
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

LISTE_INST: idf aff cst pvg LISTE_INST
            | idf aff idf pvg LISTE_INST
            |
;	  
%%
main () 
{
yyparse();
}
yywrap()
{}
