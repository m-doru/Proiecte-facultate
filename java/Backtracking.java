public abstract class Backtracking 
{
    //sol = tabloul in care se construieste solutia
    //nrs = numarul de ordine al solutiei curente
    protected int sol[] , nrs;

    //lsol = lungimea maxima a unei solutii
    public Backtracking(int lsol)
    {
        sol = new int[lsol];
        nrs = 0;
    }

    public Backtracking() {}

    protected abstract boolean esteSolutiePartiala(int k);
    protected abstract boolean esteSolutie(int k);
    protected abstract int valoareMinimaComponenta(int k);
    protected abstract int valoareMaximaComponenta(int k);

    protected void afisareSolutie(int k)
    {
        nrs++;
        System.out.print(nrs + ". ");
        for(int i = 0; i < k; i++)
            System.out.print(sol[i] + " ");
        System.out.println();
    }

    private void backtrackingRecursiv(int k)
    {
        if(esteSolutie(k))
            afisareSolutie(k);
        else
            for(int i = valoareMinimaComponenta(k); i <= valoareMaximaComponenta(k); i++)
            {
                sol[k] = i;
                if(esteSolutiePartiala(k))
                    backtrackingRecursiv(k + 1);
            }
    }

    public void rulareBacktracking()
    {
        backtrackingRecursiv(0);
    }
}
