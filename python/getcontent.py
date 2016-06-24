import requests

r = requests.get('http://www.loto49.ro/arhiva-loto-polonia-multi.php')

open('data.in', 'w').write(r.text)

