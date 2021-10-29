import socket
import time
def server_program():
    host=socket.gethostname()
    port=5000
    server_socket=socket.socket()
    server_socket.bind((host,port))
    server_socket.listen(2)
    conn,address=server_socket.accept()
    print("connection from :"+str(address))
    i=1
    while True:
        data=conn.recv(1024).decode()
        if not data:
             break
        print("from connected user:"+str(data))  
        data="data recieved"
        conn.send(encode())
        i=i+1
        conn.close()
server_program()
