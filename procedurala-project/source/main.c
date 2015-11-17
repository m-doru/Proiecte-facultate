/*Proiectul: Cont bancar
Ideea programului este urmatoarea: am creat o structura de date: lista simplu inlantuita
pentru a retine toate conturile din fisier ca mai apoi, la fiecare modificare a vreunuia,
acestea sa fie updatate.
Programul este tolerant la greseli de input. In acest scop s-au folosit pentru citirea de la tastatura
vectori de dimensiuni mai mari decat necesar pentru a prelua intregul input si a da un feedback mai precis.
Un feature interesant al programului e ca blocheaza contul pentru 5 minute
daca s-a introdus de mai mult de 3 ori un pin gresit
Cele 2 warning-uri trebuie ignorate, ele apar deoarece s-a dorit in mod intentionat conversia la int
a numarului de secunde returnat de functia time().
*/
/*
Instructiuni de utilizare:
-simplu: se alege din comenzile disponibile
*/
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
int numar_conturi;
char nume_crt[30];
typedef struct nume_temp
{
    char nume[30];
    char pin[5];
    char blocat;
    int  ultim_aces;//pentru a verifica daca au trecut 5 minute de la momentul blocarii
    int  sold_crt;
    int tranz_tip[5];//retragere sau depunere
    int tranz_valoare[5];
    time_t data[5];
    struct nume_temp *cont_urmator;

}Cont;
Cont *prim, *ultim, *utilizator;
char comanda_meniu_logat();
void update_conturi(FILE *);
void retragere();
void depunere();
void sold_curent();
int cautare_cont(char[]);
void afisare_tranzactii();
void meniu_logat();
Cont *creare_cont();
char comanda_intermediara();
char comanda_intermediara2();
void citire_cont(FILE *);
void citeste_nume(Cont *);
void citeste_pin(Cont *);
void update_tranzactii(int, int);
void reset_pin(Cont *);
Cont *logare();
int nume_existent(char[]);
int main()
{

    FILE *f=fopen("input2.in","a+");
    int logat=0;
    char c;
    citire_cont(f);//creeaza lista cu conturile deja existente
    fclose(f);
    printf("Pentru logare, introduceti: 1\nPentru creare cont nou, introduceti: 2\nPentru iesire, introduceti: 0\n");
    c=comanda_intermediara();
    if(c=='0')
    {
        system("CLS");
        printf("Va mai asteptam! La revedere");
        return 0;
    }
    if(c=='2')
    {
        system("CLS");
        utilizator=creare_cont();//functia returneaza NULL daca nu a reusit logarea
                                 //sau un pointer de tip cont catre elementul nou creat
                                // si pus la sfarsitul listei deja existente
        if(utilizator)
            {
                logat=1;
                c='1';
            }
        else
            {
                printf("Creare cont esuata!\n");
                return 0;
            }
    }
    if(c=='1')
    {
        if(!logat)
            {
                utilizator=logare();//functia returneaza NULL daca nu
                if(utilizator==NULL)
                {
                    printf("Logare esuata!\n");
                    update_conturi(f);
                    return 0;
                }
                logat=1;
            }
        if(logat)
            {
                system("CLS");
                meniu_logat();
            }
    }
    update_conturi(f);
    return 0;
}

void reset_pin(Cont *crt)
{
    int ok=1;
    char pin_buff_1[21],pin_buff_2[21],comanda;
    do
    {
        fflush(stdin);
        printf("Introduceti noul pin, exact 4 caractere:\n");
        fgets(pin_buff_1,20,stdin);
        system("CLS");
        if(strlen(pin_buff_1)!=5)
            printf("Pinul nu corespunde cerintelor!\n");
    }while(strlen(pin_buff_1)!=5);
    do
    {
        ok=1;
        printf("Rentroduceti noul pin:\n");
        fflush(stdin);
        fgets(pin_buff_2,20,stdin);
        system("CLS");
        if(strlen(pin_buff_2)!=5)
            {
                printf("Pinul nu are lungimea 4!\n\n");
                ok=0;
            }
        else if(strcmp(pin_buff_1,pin_buff_2))
        {
            printf("Pinul nu corespunde cu cel introdus anterior!\n");
            ok=0;
            printf("Pentru a reincerca, introduceti: 1\nPentru a renunta, introduceti: 0\n");
            comanda=comanda_intermediara2();
        }
    }while(ok==0&&comanda=='1');
    if(ok==1)
    {
        system("CLS");
        printf("Pin modificat cu succes!\n");
        pin_buff_1[strlen(pin_buff_1)-1]='\0';
        strcpy(crt->pin,pin_buff_1);
    }
    else
    {
        system("CLS");
        printf("Modificarea pinului esuata!\n");
    }
}

void update_conturi(FILE *f)
{
    /*
    functia rescrie fisierul dupa ce au au avut loc modificari asupra conturilor
    */
    f=fopen("input2.in","w");
    Cont *crt;
    int i;
    crt=prim;
    while(crt)
    {
        fprintf(f,"%s\n",crt->nume);
        fprintf(f,"%s\n",crt->pin);
        fprintf(f,"%c\n",crt->blocat);
        fprintf(f,"%d\n",crt->ultim_aces);
        fprintf(f,"%d\n",crt->sold_crt);
        for(i=0;i<5;i++)
                fprintf(f,"%d %d %d\n",crt->tranz_tip[i],crt->tranz_valoare[i],crt->data[i]);
        crt=crt->cont_urmator;
        free(prim);
        prim=crt;
    }
}

char comanda_meniu_logat()
{
    /*
    functia citeste comanda data cand utilizatorul este logat
    */
    char citire_buff[20];
        do{
            scanf("%s",citire_buff);
            if(strlen(citire_buff)!=1)
                printf("Comanda introdusa este invalida! Va rugam reintroduceti comanda!\n");
            else if(citire_buff[0]!='0'&&citire_buff[0]!='1'&&citire_buff[0]!='2'&&citire_buff[0]!='3'&&citire_buff[0]!='4'&&citire_buff[0]!='5')
                printf("Comanda introdusa este invalida! Va rugam reintroduceti comanda!\n");
        }while(strlen(citire_buff)!=1||(citire_buff[0]!='0'&&citire_buff[0]!='1'&&citire_buff[0]!='2'&&citire_buff[0]!='3'&&citire_buff[0]!='4'&&citire_buff[0]!='5'));
    return citire_buff[0];

}

void meniu_logat()
{
    /*
    fucntia afiseaza optiunile meniului logat si selecteaza actiunea dorita
    */
    char comanda;
    do{
    printf("Pentru resetarea pinului, introduceti: 1\n");
    printf("Pentru consultarea soldului curent, introduceti: 2\n");
    printf("Pentru depunere numerar, introduceti: 3\n");
    printf("Pentru retragere numerar, introduceti: 4\n");
    printf("Pentru consultarea tranzactiilor anterioare, introduceti: 5\n");
    printf("Pentru iesire, introduceti: 0\n");
    comanda=comanda_meniu_logat();
    switch(comanda)
    {
    case '1':
        reset_pin(utilizator);
        break;
    case '2':
        sold_curent();
        break;
    case '3':
        depunere();
        break;
    case '4':
        retragere();
        break;
    case '5':
        afisare_tranzactii();
        break;
    case '0':
        printf("Va multumim! La revedere!");
        return;
    }
    }while(comanda!='0');
}

void afisare_tranzactii()
{
    system("CLS");
    int i=4;
    /*
    pana cand nu au fost facute 5 tranzactii, este le aseaza de la coada la cap
    astfel, cea mai veche tranzactie e memorata pe pozitia 5
    apoi cand vine una noua se memoreaza pe pozitia 4 si tot asa
    din acest motiv se cauta tranzactiile de la pozitia 4 spre pozitia 0
    */
    while(i>=0&&utilizator->tranz_tip[i]!=0)
        i--;
    i++;
    if(i==5)
    {
        printf("Ne pare rau, nu aveti tranzactii anterioare\n");
        return;
    }
    for(;i<=4;i++)
    {
        if(utilizator->tranz_tip[i]==1)
            {
                printf("Depunere: %d ",utilizator->tranz_valoare[i]);
                printf(ctime(&(utilizator->data[i])));
                printf("\n");
            }
        else
        {
            printf("Retragere: %d ",utilizator->tranz_valoare[i]);
            printf(ctime(&(utilizator->data[i])));
            printf("\n");
        }
    }
}

void retragere()
{
    int bancnota[]={500,200,100,50,10,5,1};
    int valoare;
    int valid_input;
    int i;
    char valoare_buff[20];
    char cifre[]="01234456789";
    char comanda=0;
    do{
    do{
            system("CLS");
            printf("Introduceti valoare pe care doriti sa o retrageti:\n");
            fflush(stdin);
            fgets(valoare_buff,20,stdin);
            valoare_buff[strlen(valoare_buff)-1]='\0';//se scapa de \n din coada
            valid_input=1;
            if(strlen(valoare_buff)>9)
                valid_input=0;
            else
                for(i=0;i<strlen(valoare_buff);i++)//acest for verifica daca inputul este format di cifre
                    if(!strchr(cifre,valoare_buff[i]))
                    {
                        valid_input=0;
                        break;
                    }
            if(valid_input)
                    valoare=atoi(valoare_buff);
            else
            {
                printf("Valoare introdusa nu este valida!\n");
                printf("Pentru a introduce o alta valoare, apasati: 1\n Pentru revenire la meniul principal: 0\n");
                comanda=comanda_intermediara2();
                if(comanda=='0')
                {
                    system("CLS");
                    return;
                }
            }
            }while(!valid_input);
            if(valoare>utilizator->sold_crt)
            {
                printf("Sold insuficient!\n");
                printf("Pentru a retrage o alta suma, introduceti: 1\nPentru revenire la meniul principal, introduceti: 0\n");
                comanda=comanda_intermediara2();
                if(comanda=='0')
                 {
                    system("CLS");
                    return;
                }
            }
            else
            {
                comanda='0';
                utilizator->sold_crt-=valoare;
                int aux,nr_banc;
                aux=valoare;
                system("CLS");
                //returnam valoarea retrasa pe bancnote
                for(i=0;i<7;i++)
                {
                    nr_banc=0;
                    while(aux>=bancnota[i])
                    {
                        aux-=bancnota[i];
                        nr_banc++;
                    }
                    if(nr_banc)
                        printf("%d x %dLei\n",nr_banc,bancnota[i]);
                }
                update_tranzactii(-1,valoare);
            }
    }while(comanda=='1');
}

void depunere()
{
    char bancnote[]="500 200 100 50 10 5 1";
    char cifre[]="0123456789";
    char bancnota_introdusa[10];
    char comanda_bancnota='1',comanda_nr_bancnote='1';
    char numar_bancnote[20];
    int i,nr_banc, banc,valid_input;
    do
    {
        comanda_bancnota='0';
        system("CLS");
        printf("Introduceti tipul de bancnota depusa(500 200 100 50 10 5 1)\n");
        fflush(stdin);
        fgets(bancnota_introdusa,9,stdin);
        bancnota_introdusa[strlen(bancnota_introdusa)-1]='\0';
        //se ia doar prima bancnota, in cazul in care sunt introduse mai multe
        if(!strstr(bancnote,bancnota_introdusa))
        {
            printf("Bancnota introdusa nu este una valabila\n");
            printf("Pentru a reintroduce o bancnota, apasati: 1\nPentru iesire, introduceti: 0\n");
            comanda_bancnota=comanda_intermediara2();
            if(comanda_bancnota=='0')
            {
                system("CLS");
                return;
            }
        }
        else
        {
            do{
                system("CLS");
                printf("Introduceti numarul de bancnote de %s lei:\n",bancnota_introdusa);
                fflush(stdin);
                fgets(numar_bancnote,20,stdin);
                numar_bancnote[strlen(numar_bancnote)-1]='\0';
                valid_input=1;
                //numarul cifrelor numarului de bancnote nu poate depasi 7 pentru ca atunci ar da overflow
                if(strlen(numar_bancnote)>7)
                    valid_input=0;
                else
                for(i=0;i<strlen(numar_bancnote);i++)
                    if(!strchr(cifre,numar_bancnote[i]))
                    {
                        valid_input=0;
                        break;
                    }
                if(valid_input)
                    {
                        nr_banc=atoi(numar_bancnote);
                        banc=atoi(bancnota_introdusa);
                        utilizator->sold_crt+=nr_banc*banc;
                        update_tranzactii(1,nr_banc*banc);
                    }
                else
                {
                    printf("Numarul de bancnote introdus nu este valid!\n");
                    printf("Pentru a reintroduce numarul, apasati: 1\nPentru iesire, introduceti: 0\n");
                    comanda_nr_bancnote=comanda_intermediara2();
                    if(comanda_nr_bancnote=='0')
                    {
                        system("CLS");
                        return;
                    }
                }
            }while(!valid_input);
        }

    }while(comanda_bancnota=='1');
}

void update_tranzactii(int tip, int valoare)
{
    int i=4;
    /*
    in while se verifica numarul de tranzactii deja existente
    */
    while(i>=0&&utilizator->tranz_tip[i]!=0)
        i--;
    if(i==-1)
    {
        /*
        daca au fost 5, i-ul scade de la 4 la -1
        in acest caz sunt shiftate primele 4 cu o pozitie la dreapta
        */
        for(i=4;i>0;i--)
        {
            utilizator->tranz_tip[i]=utilizator->tranz_tip[i-1];
            utilizator->tranz_valoare[i]=utilizator->tranz_valoare[i-1];
            utilizator->data[i]=utilizator->data[i-1];
        }
        /*
        apoi pe prima pozitie este pusa noua tranzactie
        */
        utilizator->tranz_tip[0]=tip;
        utilizator->tranz_valoare[0]=valoare;
        utilizator->data[0]=time(NULL);
    }
    else
    {
        utilizator->tranz_tip[i]=tip;
        utilizator->tranz_valoare[i]=valoare;
        utilizator->data[i]=time(NULL);
    }
}

void sold_curent()
{
    system("CLS");
    printf("Soldul curent este:%d\n",utilizator->sold_crt);
}

void citire_cont(FILE *g)
{
    /*
    functia creeaza lista cu conturile deja existente
    */
    Cont *crt,*validare;
    int fisier_continut;
    if(feof(g))
        return;
    if(!prim)
    {
        prim=(Cont *)malloc(sizeof(Cont));
        //se verifica daca fisierul este gol
        fisier_continut=fscanf(g,"%[a-zA-Z ]s",prim->nume);
        if(fisier_continut!=1)
        {
            free(prim);
            prim=NULL;
            return;
        }
        fgetc(g);
        fscanf(g,"%s",prim->pin);
        fgetc(g);
        fscanf(g,"%c",&prim->blocat);
        fgetc(g);
        fscanf(g,"%d",&prim->ultim_aces);
        fgetc(g);
        fscanf(g,"%d",&prim->sold_crt);
        fgetc(g);
        int i;
        for(i=0;i<5;i++)
            {
                fscanf(g,"%d %d %d",&prim->tranz_tip[i],&prim->tranz_valoare[i], &prim->data[i]);
                fgetc(g);
            }
        prim->cont_urmator=NULL;
        ultim=prim;
    }
    while(!feof(g)){
    crt=(Cont *)malloc(sizeof(Cont));
    fscanf(g,"%[a-zA-Z ]s",crt->nume);
    fgetc(g);
    fscanf(g,"%s",crt->pin);
    fgetc(g);
    fscanf(g,"%c",&crt->blocat);
    fgetc(g);
    fscanf(g,"%d",&crt->ultim_aces);
    fgetc(g);
    fscanf(g,"%d",&crt->sold_crt);
    fgetc(g);
    int i;
    for(i=0;i<5;i++)
        {
            fscanf(g,"%d %d",&crt->tranz_tip[i],&crt->tranz_valoare[i]);
            fgetc(g);
        }

    crt->cont_urmator=NULL;
    validare=ultim;
    ultim->cont_urmator=crt;
    ultim=crt;
    }
    free(ultim);
    ultim=validare;
    ultim->cont_urmator=NULL;
}

char comanda_intermediara()
{

    char citire_buff[20];
        do{
            scanf("%s",citire_buff);
            if(strlen(citire_buff)!=1)
            {
                system("CLS");
                printf("Comanda introdusa este invalida! Va rugam reintroduceti comanda!\n");
            }
            else if(citire_buff[0]!='1'&&citire_buff[0]!='0'&&citire_buff[0]!='2')
                {
                system("CLS");
                printf("Comanda introdusa este invalida! Va rugam reintroduceti comanda!\n");
                }
        }while(strlen(citire_buff)!=1||(citire_buff[0]!='1'&&citire_buff[0]!='0'&&citire_buff[0]!='2'));
    return citire_buff[0];
}

char comanda_intermediara2()
{

    char citire_buff[20];
        do{
            scanf("%s",citire_buff);
            if(strlen(citire_buff)!=1)
            {
                system("CLS");
                printf("Comanda introdusa este invalida! Va rugam reintroduceti comanda!\n");
            }
            else if(citire_buff[0]!='1'&&citire_buff[0]!='0')
                {
                system("CLS");
                printf("Comanda introdusa este invalida! Va rugam reintroduceti comanda!\n");
                }
        }while(strlen(citire_buff)!=1||(citire_buff[0]!='1'&&citire_buff[0]!='0'));
    return citire_buff[0];
}

Cont *creare_cont()
{
    //functia creeaza si puna in coada listei cu conturi un nou cont
    Cont *crt;
    if(!prim)
    {
        prim=(Cont *)malloc(sizeof(Cont));
        citeste_nume(prim);
        fflush(stdin);
        citeste_pin(prim);
        fflush(stdin);
        prim->blocat='0';
        prim->ultim_aces=time(NULL);
        prim->sold_crt=0;
        int i;
        for(i=0;i<5;i++)
            {
                prim->tranz_tip[i]=0;
                prim->tranz_valoare[i]=0;
                prim->data[i]=0;
            }
        ultim=prim;
        prim->cont_urmator=NULL;
        return ultim;
    }
    else
    {
        crt=(Cont *)malloc(sizeof(Cont));
        citeste_nume(crt);
        if(nume_existent(crt->nume))
        {
            system("CLS");
            printf("Exista deja un cont cu acest nume!\n");
            free(crt);
            return NULL;
        }
        fflush(stdin);
        citeste_pin(crt);
        fflush(stdin);
        crt->blocat='0';
        crt->ultim_aces=time(NULL);
        crt->sold_crt=0;
        int i;
        for(i=0;i<5;i++)
            {
                crt->tranz_tip[i]=0;
                crt->tranz_valoare[i]=0;
                crt->data[i]=0;
            }

        ultim->cont_urmator=crt;
        ultim=crt;
        ultim->cont_urmator=NULL;
        return ultim;
    }
}
int nume_existent(char nume[30])
{
    //functia este apelata atunci cand se creeaza un cont nou
    //si verifica daca numele este deja existent
    Cont *crt;
    crt=prim;
    while(crt)
    {
        if(!strcmp(crt->nume,nume))
            return 1;
        crt=crt->cont_urmator;
    }
    return 0;
}
void citeste_nume(Cont *crt)
{
    char nume_buff[100];
    fflush(stdin);
    do
    {
        printf("Introduceti numele contului, maxim 30 caractere:\n");
        fgets(nume_buff,100,stdin);
        system("CLS");
        if(strlen(nume_buff)>30)
            printf("Nume prea lung!\n");
    }while(strlen(nume_buff)>30);
    nume_buff[strlen(nume_buff)-1]='\0';
    strcpy(crt->nume,nume_buff);
}

void citeste_pin(Cont *crt)
{
    char pin_buff[20];
    fflush(stdin);
    do
    {
        printf("Introduceti pinul, exact 4 caractere:\n");
        fgets(pin_buff,20,stdin);
        system("CLS");
        if(strlen(pin_buff)!=5)
            printf("Pinul nu corespunde cerintelor!\n");
    }while(strlen(pin_buff)!=5);
    pin_buff[strlen(pin_buff)-1]='\0';
    strcpy(crt->pin,pin_buff);
}

Cont *logare()
{
    Cont *utilizator_crt;
    char nume[100],pin[20],c='0',incercari_logare=0;
    int logat=0,gasit=0;
    do{
            fflush(stdin);
            c='0';
    //se citeste conditionat numele
    do
    {
        printf("Introduceti numele contului, maxim 30 caractere:\n");
        fgets(nume,100,stdin);
        system("CLS");
        if(strlen(nume)>30)
            printf("Nume prea lung!\n");
    }while(strlen(nume)>30);
    utilizator_crt=prim;
    nume[strlen(nume)-1]='\0';
    //se verifica daca este existent contul al carui nume a fost introdus
    while(!gasit&&utilizator_crt)
    {
        if(strcmp(utilizator_crt->nume,nume))
            utilizator_crt=utilizator_crt->cont_urmator;
        else
            gasit=1;
    }
    if(utilizator_crt==NULL)
    {
        system("CLS");
        printf("Contul nu exista!\n");
        printf("Pentru a accesa alt cont, introduceti: 1\nPentru iesire, introduceti: 0\n");
        c=comanda_intermediara2();
        if(c=='0')
        {
            return NULL;
        }
    }
    }while(c=='1');
    fflush(stdin);
    /*
    se verifica, in cazul in care contul era blocat
    daca au trecut 5 minute de la ultima incercare si se deblocheaza
    in cazul in care nu era blocat, totul merge struna
    */
    if((utilizator_crt->blocat=='1'&&time(NULL)-utilizator_crt->ultim_aces>300)||utilizator_crt->blocat=='0')
    {
        utilizator_crt->blocat='0';
    //se citeste conditionat pinul
    do
    {
        c='0';
        printf("Introduceti pinul, exact 4 caractere:\n");
        fflush(stdin);
        fgets(pin,20,stdin);
        system("CLS");
        if(strlen(pin)!=5)
            {
                printf("Pinul nu corespunde cerintelor!\n");
                printf("Pentru reincercare introduceti: 1\nPentru iesire introduceti: 0\n");
                c=comanda_intermediara2();
                if(c=='0')
                {
                    system("CLS");
                    printf("Va multumim! La revedere!\n");
                    exit(0);
                }
            }
        else
        {
            pin[strlen(pin)-1]='\0';
            if(strcmp(utilizator_crt->pin,pin))
            {
                incercari_logare++;
                //daca nu a fost introduc gresi un gresit de mai mult de 3 ori
                if(incercari_logare<3)
                    {
                        printf("Pinul introdus nu corespunde contului\n");
                        printf("Daca doriti sa reincercati, introduceti: 1\nPentru iesiere, introduceti: 0\n");
                        c=comanda_intermediara2();
                        if(c=='0')
                        {
                            system("CLS");
                            printf("Va multumim! La revedere!");
                            exit(0);
                        }
                    }
                else
                {
                    //in caz contrar, se blocheaza contul
                    utilizator_crt->blocat='1';
                    utilizator_crt->ultim_aces=time(NULL);
                    system("CLS");
                    printf("Pinul a fost introdus gresit de prea multe ori. Incercati din nou peste 5 minute\n");
                    system("PAUSE");
                    return NULL;
                }
            }
            else
                logat=1;
        }
    }while((strlen(pin)!=5||c=='1')&&!logat);
    }
    else
    {
        int minute, secunde;
        minute=(300-(time(NULL)-utilizator_crt->ultim_aces))/60;
        secunde=(300-(time(NULL)-utilizator_crt->ultim_aces))%60;
        printf("Contul este blocat!\nReveniti in %d minute si %d secunde\n",minute, secunde);
    }
    if(logat)
        return utilizator_crt;
    else
        return NULL;
}
