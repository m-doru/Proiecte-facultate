#include <iostream>
#include "Chess.h"
#include <cmath>
using namespace std;
const char Player1 = '1';
const char Player2 = '2';

bool Piesa :: check_diagonal(int fromx, int fromy, int tox, int toy, Piesa* tabla[8][8])
{
    if(fromx < tox && fromy < toy)
    {
        for(int i = fromx + 1, j = fromy + 1; i < tox && j < toy; i++, j++)
        {
            if(tabla[i][j])
            {
                string s = "Mutare invalida! Nebunul are deplasarea blocata la pozitia ";
                s += ('A' + j);
                if(tabla[fromx][fromy]->get_player() == Player1)
                    s += ('1' + i);
                else
                    s += ('1' + 7 - i);
                throw s;
            }
        }
        return true;
    }
    if(fromx > tox && fromy > toy)
    {
        for(int i = fromx - 1, j = fromy - 1; i > tox && j > toy; i--, j--)
        {
            if(tabla[i][j])
            {
                string s = "Mutare invalida! Nebunul are deplasarea blocata la pozitia ";
                s += ('A' + j);
                if(tabla[fromx][fromy]->get_player() == Player1)
                    s += ('1' + i);
                else
                    s += ('1' + 7 - i);
                throw s;
            }
        }
        return true;
    }
    if(fromx > tox && fromy < toy)
    {
        for(int i = fromx - 1, j = fromy + 1; i > tox && j < toy; i--, j++)
        {
            if(tabla[i][j])
            {
                string s = "Mutare invalida! Nebunul are deplasarea blocata la pozitia ";
                s += ('A' + j);
                if(tabla[fromx][fromy]->get_player() == Player1)
                    s += ('1' + i);
                else
                    s += ('1' + 7 - i);
                throw s;
            }
        }
        return true;
    }
    if(fromx < tox && fromy > toy)
    {
        for(int i = fromx + 1, j = fromy - 1; i < tox && j > toy; i++, j--)
        {
            if(tabla[i][j])
            {
                string s = "Mutare invalida! Nebunul are deplasarea blocata la pozitia ";
                s += ('A' + j);
                if(tabla[fromx][fromy]->get_player() == Player1)
                    s += ('1' + i);
                else
                    s += ('1' + 7 - i);
                throw s;
            }
        }
        return true;
    }
    return true;
}

bool Piesa :: check_linie(int fromx, int fromy, int tox, int toy, Piesa* tabla[8][8])
{
    if(fromx < tox)
    {for(int i = fromx + 1; i < tox; i++)
        if(tabla[i][fromy])
        {
            string s = "Mutare invalida! Tura are deplasarea blocata la pozitia ";
             s += ('A' + fromy);
            if(tabla[fromx][fromy]->get_player() == Player1)
                s += ('1' + i);
            else
                s += ('1' + 7 - i);
            s += '!';
            throw s;
        }
    }
    else
        for(int i = fromx - 1; i > tox; i--)
        if(tabla[i][fromy])
        {
            string s = "Mutare invalida! Tura are deplasarea blocata la pozitia ";
            s += ('A' + fromy);
            if(tabla[fromx][fromy]->get_player() == Player1)
                s += ('1' + i);
            else
                s += ('1' + 7 - i);
            s += '!';
            throw s;
        }
    if(fromy < toy)
    {for(int i = fromy + 1; i < toy; i++)
        if(tabla[fromx][i])
        {
            string s = "Mutare invalida! Tura are deplasarea blocata la pozitia ";
            s += ('A' + i);
            if(tabla[fromx][fromy]->get_player() == Player1)
                s += ('1' + fromx);
            else
                s += ('1' + 7 - fromx);
            s += '!';
            throw s;
        }
    }
    else
    {
        for(int i = fromy - 1; i > toy; i--)
        if(tabla[fromx][i])
        {
            string s = "Mutare invalida! Tura are deplasarea blocata la pozitia ";
            s += ('A' + i);
            if(tabla[fromx][fromy]->get_player() == Player1)
                s += ('1' + fromx);
            else
                s += ('1' + 7 - fromx);
            s += '!';
            throw s;
        }
    }
    return true;
}

bool Pion :: valid_move(int fromx, int fromy, int tox, int toy, Piesa* tabla[8][8])
{
    if(fromx == tox)
        throw string("Mutare invalida! Pionul nu se deplaseaza lateral!");
    if(tabla[fromx][fromy]->get_player() == Player1)
    {
        if(tox < fromx)
            throw string("Mutare invalida! Pionul nu poate merge inapoi!");
        if(tox - fromx > 1)
        {
            if(fromx != 1 || tox - fromx != 2 || abs(toy - fromy) > 1)
                throw string("Mutare invalida! Pionul nu se poate deplasa decat o casuta!");
            if(toy - fromy != 0)
                throw string("Mutare invalida! Pionul la prima mutare merge doar inainte!");
        }
        if(abs(toy - fromy) == 1)
        {
            if(!tabla[tox][toy])
                throw string("Mutare invalida! Pionul nu se poate deplasa pe diagonala in lipsa unei piese a oponentului!");
        }
        if(toy == fromy && tabla[tox][toy])
            throw string("Mutare invalida! Pionul are deplasarea blocata!");
        return true;
    }
    else
    {
        if(fromx < tox)
            throw string("Mutare invalida! Pionul nu poate merge inapoi!");
        if(fromx - tox > 1)
        {
            if(fromx != 6 || fromx - tox !=2 || abs(fromy - toy) > 1)
                throw string("Mutare invalida! Pionul nu se poate deplasa decat o casuta!");
            if(toy - fromy != 0)
                throw string("Mutare invalida! Pionul la prima mutare merge doar inainte!");
        }
        if(abs(toy - fromy) == 1)
        {
            if(!tabla[tox][toy])
                throw string("Mutare invalida! Pionul nu se poate deplasa pe diagonala in lipsa unei piese a oponentului!");
        }
        if(toy == fromy && tabla[tox][toy])
            throw string("Mutare invalida! Pionul are deplasarea blocata!");
        return true;
    }
}

bool Cal :: valid_move(int fromx, int fromy, int tox, int toy, Piesa* tabla[8][8])
{
    if(abs(fromx - tox) * abs(fromy - toy) != 2)
        throw string("Mutare invalida! Calul se deplaseaza doar in L!");
    return true;
}


bool Tura :: valid_move(int fromx, int fromy, int tox, int toy, Piesa* tabla[8][8])
{
    if(fromx != tox && fromy != toy)
        throw string("Mutare invalida! Tura nu se deplaseaza decat pe o singura directie!");
    bool validitate_mutare = false;
    validitate_mutare = check_linie(fromx, fromy, tox, toy, tabla);
    return validitate_mutare;

}

bool Nebun :: valid_move(int fromx, int fromy, int tox, int toy, Piesa* tabla[8][8])
{
    if(abs(tox-fromx) != abs(toy - fromy))
        throw string("Mutare invalida! Nebunul se poate deplasa doar pe diagonala!");
    bool validitate_mutare = false;
    validitate_mutare = check_diagonal(fromx, fromy, tox, toy, tabla);
    return validitate_mutare;

}

bool Rege :: valid_move(int fromx, int fromy, int tox, int toy, Piesa* tabla[8][8])
{
    if(abs(tox - fromx) > 1 || abs(toy - fromy) > 1)
        throw string("Mutare invalida! Regele nu se poate deplasa decat o casuta!");
    return true;
}

bool Regina :: valid_move(int fromx, int fromy, int tox, int toy, Piesa* tabla [8][8])
{
    if(abs(fromx - tox) != abs(fromy - toy) && (fromx != tox && fromy != toy))
        throw string ("Mutare invalida! Regina se deplaseaza ori pe diagonala ori pe o singura directie!");
    bool validitate_mutare1 = false, validitate_mutare2 = false;
    if(fromx != tox && fromy != toy)
    {
        try
        {
            validitate_mutare1 = check_diagonal(fromx, fromy, tox, toy, tabla);
        }  
        catch(string s)
        {
            throw;
        }
    }
    else
    {
        try
            {
                validitate_mutare2 = check_linie(fromx, fromy, tox, toy, tabla);
            }
        catch(string s)
        {
            throw;
        }   
    }
    return validitate_mutare1&&validitate_mutare2;
}

