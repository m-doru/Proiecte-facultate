[solBis, nrStepBis] = findSolBisect(0.5, 1.5, @Fex3, -1);
[solNR, nrStepNR] = findSolNR(0.5, 1.5, @Fex3, @Fdex3, 1, 10^-5);

solBis
nrStepBis

solNR
nrStepNR