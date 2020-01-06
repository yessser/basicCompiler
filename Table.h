#include <stdio.h>
#include <string.h>

extern int nb_ligne;
extern int qc;

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

typedef struct 
{
    char NomFonction[20];
    char TypeEntite[20];

}TypeTF;


typedef struct qdr{

    char oper[100]; 
    char op1[100];   
    char op2[100];   
    char res[100];  
    
  }qdr;
qdr quad[1000];

TypeTF tf[100];

TypeTS ts[100];

int CpTabSym=0;
int cptTypeEntit=0;
int CpTabFct=0;


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
}


void afficher ()
{
    printf("\n/***************Table des symboles ******************/\n");
    printf("___________________________________________________________________________________________________\n");
    printf("\t| NomEntite | CodeEntite  |  TypeEntite  | Taille Entite|    Constant  | Nom De Fonction | Parme  \n");
    printf("___________________________________________________________________________________________________\n");
    int i=0;
    while(i<CpTabSym)
    {
        printf("\t|%10s |%12s | %12s | %12d | %12d | %12s | %12d\n",ts[i].NomEntite,
            ts[i].CodeEntite,ts[i].TypeEntite,ts[i].TailleEntite,ts[i].ConstantEntite,ts[i].nomFunction+8,ts[i].param);

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

void inserePrm(char entite[],char funct[]){
    int x = recherche(entite,funct);
    if(x!=-1)
    {
        ts[x].param=1;  
    }
}

int RecherchFct(char Nom[])
{
    int i=0;

    while(i<CpTabSym)
    {
        if (strcmp(Nom,tf[i].NomFonction)==0) return i;
        i++;
    }
    return -1;}

void insererFct(char Entite[])
{
    int x = RecherchFct(Entite);
    if (x == -1)
    {
        strcpy(tf[CpTabFct].NomFonction,Entite);
        CpTabFct++;
    }
    else
    {
        printf("fonction Deja Declaré");
    }
}
void insererTypeFct(char Entite[],char Type[])
{
    int x = RecherchFct(Entite);
    strcpy(tf[x].TypeEntite,Type);
}

void affichTF()
{
   printf("\n/***************Table des Fonction ******************/\n");
    printf("_______________________________________________________\n");
    printf("\t Nom Fonction | Type Fonction \n");
    printf("_______________________________________________________\n");
    int i=0;
    while(i<CpTabFct)
    {
        printf("%10s | %10s \n",tf[i].NomFonction+8,tf[i].TypeEntite);
        i++;
    }
}



void quadr(char opr[],char op1[],char op2[],char res[])
{

	strcpy(quad[qc].oper,opr);
	strcpy(quad[qc].op1,op1);
	strcpy(quad[qc].op2,op2);
	strcpy(quad[qc].res,res);
	
	
qc++;

}

void ajour_quad(int num_quad, int colon_quad, char val [])
{
if (colon_quad==0) strcpy(quad[num_quad].oper,val);
else if (colon_quad==1) strcpy(quad[num_quad].op1,val);
         else if (colon_quad==2) strcpy(quad[num_quad].op2,val);
                   else if (colon_quad==3) strcpy(quad[num_quad].res,val);

}

void afficher_qdr()
{
printf("*********************Les Quadruplets***********************\n");

int i;

for(i=0;i<qc;i++)
		{

 printf("\n %d - ( %s  ,  %s  ,  %s  ,  %s )",i,quad[i].oper,quad[i].op1,quad[i].op2,quad[i].res); 
 printf("\n--------------------------------------------------------\n");

    }
}

