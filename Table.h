#include <stdio.h>
#include <string.h>

extern int nb_ligne;

typedef struct
{
    char NomEntite[20];
    char CodeEntite[20];
    char TypeEntite[20];
    int TailleEntite;
    int ConstantEntite;
    char nomFunction[20];
    int param;

}TypeTS;

TypeTS ts[100];

int CpTabSym=0;
int cptTypeEntit=-1;

int recherche(char entite[],char Funct[]){
    int i=0;

    while(i<CpTabSym)
    {
        if (strcmp(entite,ts[i].NomEntite)==0 && strcmp(Funct,ts[i].nomFunction)==0) return i;
        i++;
    }
    return -1;
}

void inserer(char entite[], char code[],char Funct[])
{
    if ( recherche(entite,Funct)==-1)
    {
        strcpy(ts[CpTabSym].NomEntite,entite);
        strcpy(ts[CpTabSym].CodeEntite,code);
        strcpy(ts[CpTabSym].nomFunction,Funct);
        CpTabSym++;
        cptTypeEntit++;
    }
    else
    {
    
        printf("Double Declaration %s a la ligne %d posTab = %d \n",entite,nb_ligne, recherche(entite,Funct));
    }
    afficher();
}


void afficher ()
{
    printf("\n/***************Table des symboles ******************/\n");
    printf("_______________________________________________________\n");
    printf("\t| NomEntite | CodeEntite |TypeEntite |Taille Entite| Constant| Nom De Fonction | Parme  \n");
    printf("_______________________________________________________\n");
    int i=0;
    while(i<CpTabSym)
    {
        printf("\t|%10s |%12s | %12s | %12d | %12d | %12s | %12d\n",ts[i].NomEntite,
            ts[i].CodeEntite,ts[i].TypeEntite,ts[i].TailleEntite,ts[i].ConstantEntite,ts[i].nomFunction,ts[i].param);

        i++;
    }
}

void insererType(char type[])
{               
    for(int i=cptTypeEntit;i>=0;i--)
    {
    strcpy(ts[CpTabSym-i].TypeEntite,type);
    }
    cptTypeEntit=0;
}  


void insertTable(char entite[],char code[],int taille,char NomFunct[]){
    int x = recherche(entite,NomFunct);
    if (x!=-1)
    {
        strcpy(ts[x].CodeEntite,"Table");
        ts[x].TailleEntite=taille;
    }
}

void insertCST(char entite[],char funct[])
{
    int x = recherche(entite,funct);
    ts[x].ConstantEntite=1;
}

void insererTypeFunct( char NomFunct[], char Type[])
{
    int x = recherche(NomFunct,"");
    if(x!=-1)
    {
        strcpy(ts[x].TypeEntite,Type);  
    }
}

void inserePrm(char entite[],char funct[]){
    int x = recherche(entite,funct);
    if(x!=-1)
    {
        ts[x].param=1;  
    }
}