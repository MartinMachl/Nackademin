import socket
import select

HEADER = 10

IP = socket.gethostbyname(socket.gethostname())
PORT = 5050


# Start server
def start_server():
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server_socket.bind((IP, PORT))
    server_socket.listen()

    sockets_list = [server_socket]
    clients = {}

    print(f'Listening for connections on {IP}:{PORT}...')

    while True:
        read_sockets, _, exception_sockets = select.select(
                            sockets_list, [], sockets_list)
        # Loop over sockets
        for notified_socket in read_sockets:
            # New connection
            if notified_socket == server_socket:
                client_socket, client_address = server_socket.accept()
                user = receive(client_socket)
                sockets_list.append(client_socket)
                clients[client_socket] = user

                print("Accepted new connection from {}:{}; "
                      "{}".format(*client_address, user['data'].decode('utf-8')))
                '''
                greet(client_socket, user['data'].decode('utf-8'))
                '''
            # New message from connected socket
            else:
                message = receive(notified_socket)
                # Client closed
                if message is False:
                    print('Closed connection from: {}'.format(
                        clients[notified_socket]['data'].decode('utf-8')))

                    sockets_list.remove(notified_socket)
                    del clients[notified_socket]
                    continue

                user = clients[notified_socket]

                print(f'Received message from {user["data"].decode("utf-8")}: '
                      f'{message["data"].decode("utf-8")}')

                # If client GUI sends disconnection message, return it to client
                if message["data"].decode("utf-8") == "Anslutning avbruten":
                    notified_socket.send(user['header'] + user['data'] +
                                         message['header'] + message['data'])

                # Otherwise send message to other clients (sensor)
                else:
                    for client_socket in clients:
                        if client_socket != notified_socket:
                            client_socket.send(
                                user['header'] + user['data'] +
                                message['header'] + message['data'])


# Receive information from client
def receive(client_socket):
    try:
        message_header = client_socket.recv(HEADER)

        # Client closed connection
        if not len(message_header):
            return False

        message_length = int(message_header.decode('utf-8').strip())

        return {'header': message_header,
                'data': client_socket.recv(message_length)}
    except Exception:
        return False


# This function in not working as intended but left in
# for explanation purposes
def greet(client_socket, user):
    data = user+" connected to server"
    message = data.encode("utf-8")
    message_header = f"{len(message):<{HEADER}}".encode('utf-8')
    client_socket.sendall(message_header + message)


if __name__ == "__main__":
    start_server()
