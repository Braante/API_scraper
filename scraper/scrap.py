import requests, json, threading, os, logging
from datetime import date,datetime
from bs4 import BeautifulSoup

path = "./log/"
if not os.path.exists(path):
    os.makedirs(path)

log_format = '%(asctime)s %(filename)s: %(message)s'
logging.basicConfig(filename=path+(datetime.now()).strftime("%m_%d_%Y_%H%M%S")+'.log', encoding='utf-8',format=log_format, level=logging.DEBUG)
logging.info('Running scrapt.py')

res_arr = []

url = 'https://www.metacritic.com/browse/games/score/metascore/all/all/filtered?page=0'
userAgent = {'User-agent': 'Mozilla/5.0'}
response = requests.get(url, headers=userAgent)
soup = BeautifulSoup(response.text, 'html.parser')
nbpagemax = soup.find_all('a',{"class":"page_num"})

def scrap_page(numpage):
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

logging.info('Start Multithread Scraping')
threads = []
try:
    for numpage in range(int(nbpagemax[-1].text)+1):
        threads.append(threading.Thread(target=scrap_page,args=(numpage,)))
        threads[-1].start()
except:
    logging.exception('Scraping page function doesnt work properly')

for t in threads:
    t.join()

#print(len(res_arr))
try:
    resultat = {"games":res_arr}
    path = ".//scraper_data/"
    logging.info('Save in json file')
    if not os.path.exists(path):
        os.makedirs(path)
    save_file = open(path+date.today().strftime("%m_%d_%y")+"_data.json", "w")  
    json.dump(resultat, save_file)  
    save_file.close()
except:
    logging.exception('Data not saved properly')
logging.info('End of script')