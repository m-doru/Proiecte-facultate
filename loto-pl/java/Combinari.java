public class Combinari extends Backtracking
{
    private int n , p;
    private Processer processer;

    public Combinari(int n , int p, Processer pro)
    {
        super(p);
        this.n = n;
        this.p = p;
        this.processer = pro;
    }

    @Override
    protected boolean esteSolutiePartiala(int k)
    {
        return true;
    }

    @Override
    protected boolean esteSolutie(int k)
    {
        return k == p;
    }

    @Override
    protected int valoareMinimaComponenta(int k)
    {
        if(k == 0) return 1;
        return sol[k - 1] + 1;
    }

    @Override
    protected int valoareMaximaComponenta(int k)
    {
        return n - p + k + 1;
    }


    @Override
    protected void afisareSolutie(int k){
      processer.process(sol);
    }
}
