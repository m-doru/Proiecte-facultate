rm processedData.out

set -e 

python3 ./python/processdata.py

cd java

javac Main.java

java Main


set +e
