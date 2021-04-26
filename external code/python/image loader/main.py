import codecs
from bs4 import BeautifulSoup
from lxml import html

fileObj = codecs.open("page.html", "r", "utf_8_sig")
page = fileObj.read()
fileObj.close()



soup = BeautifulSoup(page, features='lxml')
body=soup.find('div', {'class': ['qztBA']})
items = body.find_all('a', {'rel':"nofollow", 'target':"_blank", 'title':"Download photo"})
print(items[0]['href'])
print(len(items))
hrefs=[]
for i in items:
    hrefs.append(i['href'])
    print(i['href'])



import requests


count=0
for i in hrefs:
    url = i
    r = requests.get(url, allow_redirects=True)

    open(f'images/image{count}.jpg', 'wb').write(r.content)
    count+=1