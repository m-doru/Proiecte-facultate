#include "Multime.h"
#include <iostream>
using namespace std;
template <typename T>
void Multime<T>::Element::initializare(T data)
{
    info = data;
    next = 0;
}

template <typename T>
Multime<T>::Multime(string s)
{
    nume = s;
    head = 0;
    size = 0;
}

template <typename T>
Multime<T>::~Multime()
{
    //sterge lista in care sunt tinute elementele multimii
    cout<<"Distruge "<<nume<<'\n';
    Element *ptr;
    while(head)
    {
        ptr = head;
        head = head -> next;
        delete ptr;
    }
}

template <typename T>
Multime<T>::Multime(const Multime&a)
{
    nume = a.nume + " copie";
    size = a.size;
    if(a.head)
    {
        Element *ptr,*ptr1, *ptr2 = a.head;
        head = new Element;
        head->initializare(ptr2->info);
        ptr1 = head;
        ptr2 = ptr2->next;
        while(ptr2)
        {
            ptr = new Element;
            ptr->initializare(ptr2->info);
            ptr1->next = ptr;
            ptr1 = ptr;
            ptr2 = ptr2->next;
        }
    }

}

template <typename T>
Multime<T> Multime<T>::operator=(const Multime& right)
{
    if (this == &right) return *this;
    nume = right.nume + " c=pie";
    size = right.size;
    if(right.head)
    {
        Element *ptr,*ptr1, *ptr2 = right.head;
        head = new Element;
        head->initializare(ptr2->info);
        ptr1 = head;
        ptr2 = ptr2->next;
        while(ptr2)
        {
            ptr = new Element;
            ptr->initializare(ptr2->info);
            ptr1->next = ptr;
            ptr1 = ptr;
            ptr2 = ptr2->next;
        }
    }
    return *this;
}

template<typename T>
void Multime<T>::adauga(T data)
{
    if(!head)
    {
        head = new Element;
        head -> initializare(data);
        size++;
    }
    else
    {
        Element *parcrg,*parcrg_ant, *ptr = new Element;
        ptr->initializare(data);
        if(ptr->info < head->info)
            {
                ptr->next = head;
                head = ptr;
            }
        else
        {
            parcrg_ant = head;
            parcrg = head->next;
            while(parcrg && parcrg->info < ptr->info )
                {
                    parcrg_ant = parcrg;
                    parcrg = parcrg->next;
                }
            parcrg_ant->next = ptr;
            ptr->next = parcrg;
        }
        size++;
    }
}

template <typename T>
void Multime<T>::afiseaza()
{
    Element *ptr;
    ptr = head;
    while(ptr)
    {
        cout<<ptr->info<<' ';
        ptr = ptr->next;
    }
    cout<<'\n';
}

template <typename T>
void Multime<T>::multimizare()
{
    Element *elem_inc, *elem_act, *elem_ant;
    elem_inc = head;
    while(elem_inc)//iau fiecare element din lista si verific daca mai sunt elemente egale
    {
        elem_act = elem_inc -> next;
        elem_ant = elem_inc;
        while(elem_act)//verific toate elementele de dupa elem_inc
        {
            if(elem_act->info == elem_inc->info)
            {
                elem_ant->next = elem_act->next;
                delete(elem_act);
                elem_act = elem_ant->next;
                size--;
            }
            else
            {
                elem_act = elem_act->next;
                elem_ant = elem_ant->next;
            }
        }
        elem_inc = elem_inc->next;
    }
}

template <typename T>
Multime<T> Multime<T>::reuneste(Multime op2)
{
    Multime rez("reuniune");
    Element *parc_this = head, *parc_op2 = op2.head;
    //intersecteaza cele 2 liste din cele 2 obiecte
    while(parc_this&&parc_op2)
    {
        if(parc_this->info < parc_op2->info)
            {
                rez.adauga(parc_this->info);
                parc_this = parc_this->next;
            }
        else
            {
                rez.adauga(parc_op2->info);
                parc_op2 = parc_op2->next;
            }
    }
    while(parc_this)
    {
        rez.adauga(parc_this->info);
        parc_this = parc_this->next;
    }
    while(parc_op2)
    {
        rez.adauga(parc_op2->info);
        parc_op2 = parc_op2->next;
    }
    rez.multimizare();
    return rez;
}

template <typename T>
Multime<T> Multime<T>::intersecteaza(Multime op2)
{
    Multime rez("Intersectie");
    Element *parc_this = head, *parc_op2 = op2.head;//pointeri pentru parcurgere
    while(parc_this&&parc_op2)
    {
        if(parc_this->info < parc_op2->info)
            parc_this = parc_this->next;
        else
            {
                if(parc_op2->info < parc_this->info)
                    parc_op2 = parc_op2->next;
                else
                    {
                        rez.adauga(parc_op2->info);
                        parc_op2 = parc_op2->next;
                        parc_this = parc_this->next;
                    }
            }
    }
    rez.multimizare();
    return rez;
}

template <typename T>
Multime<T> Multime<T>::diferentiaza(Multime op2)
{
    Multime rez("diferenta");
    Element *parc_this, *parc_op2;
    parc_this = head;
    while(parc_this)
    {
        parc_op2 = op2.head;
        while(parc_op2 && (parc_op2->info < parc_this->info))
            parc_op2 = parc_op2->next;
        if(!parc_op2 || parc_this->info != parc_op2->info)
                rez.adauga(parc_this->info);
        parc_this = parc_this->next;
    }
    parc_op2 = op2.head;
    while(parc_op2)
    {
        parc_this = head;
        while(parc_this && (parc_this->info < parc_op2->info))
            parc_this = parc_this->next;
        if(!parc_this || parc_this->info != parc_op2->info)
                rez.adauga(parc_op2->info);
        parc_op2 = parc_op2->next;
    }
    rez.multimizare();
    return rez;
}

