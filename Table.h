#include <stdio.h>
#include <string.h>


typedef struct
{
    char NomEntite[20];
    char CodeEntite[20];
    char TypeEntite[20];
}TypeTS;

extern TypeTS ts[100];

int CpTabSym=0;

int recherche(char entite[]){
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
        strcpy(ts[CpTabSym].NomEntite,entite);
        strcpy(ts[CpTabSym].CodeEntite,code);
        CpTabSym++;
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

void insererType(char entite[], char type[])
{               
    int posEntite=recherche(entite);
    if (posEntite!=-1)
    { 
        strcpy(ts[posEntite].TypeEntite,type);
    }
}  

int doubleDeclaration (char entite[])
{

    int posEntite=recherche(entite);
    if (strcmp(ts[posEntite].TypeEntite,"")==0) return 1;
    else return 0; 
}

