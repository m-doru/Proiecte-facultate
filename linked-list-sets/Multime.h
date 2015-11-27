#ifndef MULTIME_H_INCLUDED
#define MULTIME_H_INCLUDED
#include <iostream>
using namespace std;

template <typename T>
class Multime
{
    int size;
    struct Element
    {
        T info;
        Element *next;
        void initializare(T);
    }*head;
public:
    Multime();
    ~Multime();
    Multime(const Multime&);
    Multime operator=(const Multime& right);
    int getSize() {return size;}
    void adauga(T);
    void afiseaza();
    void multimizare();
    Multime reuneste (Multime);
    Multime intersecteaza (Multime);
    Multime diferentiaza (Multime);
};


#endif // MULTIME_H_INCLUDED
