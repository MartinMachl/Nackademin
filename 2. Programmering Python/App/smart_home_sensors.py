import random
from threading import Thread
import datetime
import socket
from errno import EAGAIN, EWOULDBLOCK
from sys import exit

HEADER = 10

IP = socket.gethostbyname(socket.gethostname())
PORT = 5050
main_client = "Sensor"

client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
now = datetime.datetime.now()
message_list = [""]


# Try to connect to server when program launches
# If server is offline close program
def start_sensor():
    try:
        client_socket.connect((IP, PORT))
        client_socket.setblocking(False)

        client = main_client.encode('utf-8')
        client_header = f"{len(client):<{HEADER}}".encode('utf-8')
        client_socket.send(client_header + client)
    except Exception as e:
        print(e)
        exit()

    # Start a thread that listens for messages so our
    # input function still works, so we can use a command
    # to close the program
    Thread(target=listen_for_message, daemon=True).start()
    # Welcome message after we have connected
    print("\nWelcome to sensor client")
    # Looping menu waiting for command to close program
    while True:
        command = input("Type \"STOP\" to stop client\n"
                        "Input: ")

        if command == "STOP" or command == "stop":
            exit()

        else:
            print("\n[ERROR] wrong command\n")


# This is a function that pretends to be a sensor
# It returns temperatures in slightly different ranges depending
# on the actual time of day we ask, to simulate reality
def get_temperature(data):
    try:
        if data <= 9:
            temp = round(random.uniform(19.8, 20.2), 1)
        elif data > 9 and now.hour < 12:
            temp = round(random.uniform(20.2, 22.2), 1)
        elif data >= 12 and now.hour < 17:
            temp = round(random.uniform(21.2, 23.2), 1)
        elif data >= 17 and now.hour < 20:
            temp = round(random.uniform(20.2, 22.2), 1)
        elif data >= 20:
            temp = round(random.uniform(19.8, 20.8), 1)
        temp = "Temperatur: "+str(temp)+" celsius"
        return temp
    except Exception:
        return "Temperatur: 20.5 celsius"


# This is a function that pretends to be a sensor
# It returns humidity in slightly different ranges depending
# on the actual time of day we ask, to simulate reality
def get_humidity(data):
    try:
        if data <= 9:
            humid = random.randint(30, 40)
        elif data > 9 and now.hour < 12:
            humid = random.randint(24, 38)
        elif data >= 12 and now.hour < 17:
            humid = random.randint(20, 30)
        elif data >= 17 and now.hour < 20:
            humid = random.randint(22, 36)
        elif data >= 20:
            humid = random.randint(30, 40)
        humid = "Luftfuktighet: "+str(humid)+"%"
        return humid
    except Exception:
        return "Luftfuktighet: 30%"


# This function continuously sends messages to server
# and listens for messages from server
def listen_for_message():
    while True:
        # If there is a message in the list, send it
        message = message_list[0]

        if message:
            message = message.encode('utf-8')
            message_header = f"{len(message):<{HEADER}}".encode('utf-8')
            client_socket.send(message_header + message)
            message_list[0] = ""

        try:
            while True:
                client_header = client_socket.recv(HEADER)

                if not len(client_header):
                    print('Connection closed by the server')
                    exit()

                client_length = int(client_header.decode('utf-8').strip())
                client = client_socket.recv(client_length).decode('utf-8')
                message_header = client_socket.recv(HEADER)
                message_length = int(message_header.decode('utf-8').strip())
                message = client_socket.recv(message_length).decode('utf-8')

                print(f'{client} > {message}')
                # If we get the specific messages we want add them to
                # message_list and send it next iteration
                if message == "?temperature":
                    message_list[0] = get_temperature(now.hour)

                if message == "?humidity":
                    message_list[0] = get_humidity(now.hour)

        # When there are no incoming data, error is going to be raised
        # We are going to check for both, as they can depend on different os,
        # and only want to close if both errors hit
        # We expecte one error, meaning no incoming data, so continue as normal
        except IOError as e:
            if e != EAGAIN and e.errno != EWOULDBLOCK:
                print('Reading error: {}'.format(str(e)))
                exit()
            continue
        # Something else went wrong
        except Exception as e:
            print('General: {}'.format(str(e)))
            exit()


if __name__ == "__main__":
    start_sensor()
