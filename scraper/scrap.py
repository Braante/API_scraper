import requests, json, time
from datetime import date
from bs4 import BeautifulSoup

res_arr = []

url = 'https://www.metacritic.com/browse/games/score/metascore/all/all/filtered?page=0'
userAgent = {'User-agent': 'Mozilla/5.0'}
response = requests.get(url, headers=userAgent)
soup = BeautifulSoup(response.text, 'html.parser')
nbpagemax = soup.find_all('a',{"class":"page_num"})

for numpage in range(int(nbpagemax[-1].text)+1):
    time.sleep(1)

    url = 'https://www.metacritic.com/browse/games/score/metascore/all/all/filtered?page='+str(numpage)
    response = requests.get(url, headers=userAgent)
    soup = BeautifulSoup(response.text, 'html.parser')
    content = soup.find_all('table')
    num_loops = len(content)
    tblnum = 0
    while tblnum < num_loops:
        table_rows = content[tblnum].find_all('tr')
        for tr in table_rows:
            td = tr.find_all('td')
            if(len(td) != 0):
                temp = {}
                for a in td[1].find_all('a', {"class":"title"}):
                    temp['name'] = a.find('h3').text
                for date in td[1].find_all('span',{"class":""}):
                    temp['date'] = date.text
                for platform in td[1].find_all('span',{"class":"data"}):
                    temp['platform'] = platform.text.strip()
                for a in td[1].find_all('a', {"class":"title"} ,href=True):
                    temp['title'] = "https://www.metacritic.com"+a['href']
                for score in td[1].find_all('div', {"class":"metascore_w","class":"user"}):
                    temp['userscore'] = score.text
                for score in td[1].find_all('div', {"class":"metascore_w"}):
                    temp['metascore'] = score.text
                    break
                res_arr.append(temp)     
        tblnum += 1

print(len(res_arr))
resultat = {"games":res_arr}
save_file = open(date.today().strftime("%m_%d_%y")+"_data.json", "w")  
json.dump(resultat, save_file)  
save_file.close()