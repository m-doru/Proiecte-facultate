#ifndef CHESS_H_INCLUDED
#define CHESS_H_INCLUDED

class Piesa
{
public:
    virtual bool valid_move(int, int, int, int, Piesa* [8][8]) = 0;
    virtual char get_tip() = 0;
    virtual char get_player() = 0;
    Piesa(){}
    virtual ~Piesa(){}
protected:
    bool check_diagonal(int, int, int, int, Piesa* [8][8]);
    bool check_linie(int, int, int, int, Piesa* [8][8]);
};

class Game
{
    Piesa *tabla[8][8];
    std::string player[2];
    char player_turn;
    void get_move(int&, int &, int&, int &, char);

    bool is_move_valid(int, int, int, int, char);
    //pentru verificarea aspectelor ce nu tin de piesa
    //cum ar fi: selectarea unei locatii din afara tablei, a unei locatii libere, a unei piese a oponentului

    void update_tabla(int, int, int, int);
    //inlocuite cu >>
    //void print_tabla_player1();
    //void print_tabla_player2();

    friend std::ostream& operator<<(std::ostream &, Game&);
public:
    Game();
    ~Game();
    void play();

};

class Pion : public Piesa
{
    static const char tip = 'I';
    char player;
public:
    Pion(char pl = '0') : player(pl){}
    Pion(const Pion& ob){player = ob.player;}
    ~Pion(){}
    bool valid_move(int, int, int, int, Piesa* [8][8]);
    char get_tip(){return tip;}
    char get_player(){return player;}
};

class Tura : public Piesa
{
    static const char tip = 'T';
    char player;
public:
    Tura(char pl = '0') : player(pl){}
    ~Tura(){}
    bool valid_move(int, int, int, int, Piesa* [8][8]);
    char get_tip(){return tip;}
    char get_player(){return player;}
};

class Cal : public Piesa
{
    static const char tip = 'C';
    char player;
public:
    Cal(char pl = '0') : player(pl) {}
    ~Cal(){}
    bool valid_move(int, int, int, int, Piesa* [8][8]);
    char get_tip(){return tip;}
    char get_player(){return player;}
};

class Nebun : public Piesa
{
    static const char tip = 'N';
    char player;
public:
    Nebun(char pl = '0') : player(pl){}
    ~Nebun(){}
    bool valid_move(int, int, int, int, Piesa* [8][8]);
    char get_tip() {return tip;}
    char get_player(){return player;}
};

class Regina : public Piesa
{
    static const char tip = 'Q';
    char player;
public:
    Regina(char pl = '0') : player(pl){}
    ~Regina(){}
    bool valid_move(int, int, int, int, Piesa* [8][8]);
    char get_tip(){return tip;}
    char get_player(){return player;}
};

class Rege : public Piesa
{
    static const char tip = 'K';
    char player;
public:
    Rege(char pl = '0') : player(pl){}
    ~Rege(){}
    bool valid_move(int, int, int, int, Piesa* [8][8]);
    char get_tip(){return tip;}
    char get_player(){return player;}
};

#endif // CHESS_H_INCLUDED
