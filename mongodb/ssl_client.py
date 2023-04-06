import socket, ssl
from datetime import date,datetime

context = ssl.SSLContext(ssl.PROTOCOL_TLSv1_2)
context.load_cert_chain(certfile="~/mongodb/certificate.pem", keyfile="~/mongodb/key.pem")

bindsocket = socket.socket()
bindsocket.bind(('10.101.1.10', 60000))
bindsocket.listen(5)

def deal_with_client(connstream):
    data = connstream.recv(1024)
    # empty data means the client is finished with us
    result = ''
    while data:
        result += str(data)
        data = connstream.recv(1024)
    correctData = result[2:-1]
    file = open("~/mongodb/"+date.today().strftime("%m%d%y")+"_data.json", "w")
    file.write(correctData)
    file.close()

while True:
    newsocket, fromaddr = bindsocket.accept()
    connstream = context.wrap_socket(newsocket, server_side=True)
    try:
        deal_with_client(connstream)
    finally:
        connstream.shutdown(socket.SHUT_RDWR)
        connstream.close()

