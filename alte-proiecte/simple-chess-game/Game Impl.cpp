#include <iostream>
#include <fstream>
#include "Chess.h"
using namespace std;
const char Player1 = '1';
const char Player2 = '2';

Game :: Game()
{
    cout<<"Player1: ";
    cin>>player[0];
    cout<<"Player2: ";
    cin>>player[1];
    player_turn = Player1;
    //plasez piesele pe tabla

    //pentru player1
    for(int i = 0; i < 8; i++)
        tabla[1][i] = new Pion('1');
    tabla[0][0] = new Tura('1');
    tabla[0][1] = new Cal('1');
    tabla[0][2] = new Nebun('1');
    tabla[0][3] = new Regina('1');
    tabla[0][4] = new Rege('1');
    tabla[0][5] = new Nebun('1');
    tabla[0][6] = new Cal('1');
    tabla[0][7] = new Tura('1');

    //pentru player2
    for(int i = 0; i < 8; i++)
        tabla[6][i] = new Pion('2');
    tabla[7][0] = new Tura('2');
    tabla[7][1] = new Cal('2');
    tabla[7][2] = new Nebun('2');
    tabla[7][3] = new Regina('2');
    tabla[7][4] = new Rege('2');
    tabla[7][5] = new Nebun('2');
    tabla[7][6] = new Cal('2');
    tabla[7][7] = new Tura('2');

    //restul pozitiilor le initializez cu NULL
    for(int i = 2; i < 6; i++)
        for(int j = 0; j < 8; j ++)
            tabla[i][j] = 0;
}

Game :: ~Game()
{
    for(int i = 0 ; i < 8; i++)
        for(int j = 0; j < 8; j++)
            delete tabla[i][j];
}
ostream& operator<<(ostream& out, Game& ob)
{
    if(ob.player_turn == Player1)
    {for(int i = 7; i >= 0; i --)
    {
        cout<<'\t'<<i+1<<"  ";
        for(int j = 0; j < 8; j++)
        {
            if(ob.tabla[i][j])
            {
                if(ob.tabla[i][j]->get_player() == Player1)
                    cout<<(char)toupper(ob.tabla[i][j]->get_tip())<<' ';
                else
                    cout<<(char)tolower(ob.tabla[i][j]->get_tip())<<' ';
            }
            else
                cout<<"- ";
        }
        cout<<'\n';
    }
    cout<<"\n\t   A B C D E F G H\n\n";
    }
    else
    {
        for(int i = 0; i < 8; i ++)
    {
        cout<<'\t'<<8-i<<"  ";
        for(int j = 0; j < 8; j++)
        {
            if(ob.tabla[i][j])
            {
                if(ob.tabla[i][j]->get_player() == Player1)
                    cout<<(char)toupper(ob.tabla[i][j]->get_tip())<<' ';
                else
                    cout<<(char)tolower(ob.tabla[i][j]->get_tip())<<' ';
            }
            else
                cout<<"- ";
        }
        cout<<'\n';
    }
    cout<<"\n\t   A B C D E F G H\n\n";
    }
    return out;
}


void Game :: update_tabla(int fromx, int fromy, int tox, int toy)
{
    tabla[tox][toy] = tabla[fromx][fromy];
    tabla[fromx][fromy] = 0;
}

bool Game :: is_move_valid(int fromx, int fromy, int tox, int toy, char player)
{

    if(fromx<0 || fromx >7 || fromy < 0 || fromy > 7)
        throw string("Mutare invalida! Locatia piesei selectate este in afara tablei!");

    if(tox < 0 || tox > 7 || toy < 0 || toy > 7)
        throw string("Mutare invalida! Locatia destinatie este in afara tablei!");

    if(!tabla[fromx][fromy])
        throw string("Mutare invalida! Piesa lipsa la locatia data!");

    if(fromx == tox && fromy == toy)
        throw string("Mutare invalida! Nu se face deplasare!");

    if(player != tabla[fromx][fromy]->get_player())
        throw string("Mutare invalida! Piesa de la locatia initiala nu iti apartine!");
    try
    {
        tabla[fromx][fromy]->valid_move(fromx, fromy, tox, toy, tabla);
    }
    catch(string err)
    {
        throw;
    }
    if(tabla[tox][toy]&&tabla[tox][toy]->get_player() == player)
        throw string("Mutare invalida! Piesa de la locatia destinatie iti apartine!");
    if(dynamic_cast<Rege*>(tabla[tox][toy]))
        throw char('V');
    return true;
}


void Game :: play()
{
    bool game_over = false;
    char winner;
    while(!game_over)
    {
        bool valid_move = false;
        int fromx, fromy, tox, toy;
        player_turn = Player1;
        //player1 move
        cout<<'\n';
        do
        {
            cout<<*this;
            get_move(fromx, fromy, tox, toy, Player1);
            try
            {
                valid_move = is_move_valid(fromx, fromy, tox, toy, Player1);
            }
            catch(string err)
            {
                cout<<err<<'\n';
                cout<<"Introduceti o alta mutare\n\n";
            }
            catch(char result)
            {
                valid_move = true;
                game_over = result;
                winner = Player1;
            }
        }while(!valid_move);
        update_tabla(fromx, fromy, tox, toy);
        if(game_over)
            break;

        //player2 move
        player_turn = Player2;
        valid_move = false;
        cout<<'\n';

        do
        {
            cout<<*this;
            get_move(fromx, fromy, tox, toy, Player2);
            try
            {
                valid_move = is_move_valid(fromx, fromy, tox, toy, Player2);
            }
            catch(string err)
            {
                cout<<err<<'\n';
                cout<<"Introduceti o alta mutare\n\n";
            }
            catch(char result)
            {
                valid_move = true;
                game_over = result;
                winner = Player2;
            }
        }while(!valid_move);
        update_tabla(fromx, fromy, tox, toy);
    }
    cout<<"\nFelicitari, "<<player[winner - '1']<<"! Ai castigat!\n\n";
    cout<<"Ghinion, "<<player[(winner - '1')^1]<<"! Mai bine apuca-te de programare!";
}


void Game :: get_move(int &fromx, int &fromy, int &tox, int& toy, char pl)
{
    char y, yy;
    int x, xx;

    cout<<"\nRandul lui "<<player[pl-'1']<<'\n';
    cout<<"Introduceti locatia piesei pe care vreti sa o mutati (de tip A1): ";
    cin>>y>>x;
    cout<<"Introduceti locatia destinatie (de tip A1): ";
    cin>>yy>>xx;
    cout<<'\n';
    fromx = x - 1;
    if(y - 'A' > 7)
        fromy = y - 'a';
    else
        fromy = y - 'A';
    tox = xx - 1;
    if(yy - 'A' > 7)
        toy = yy - 'a';
    else
        toy = yy - 'A';
    if(pl == Player2)
    {
        fromx = 7 - fromx;
        tox = 7 - tox;
    }
}



