import tkinter as tk
import socket
from threading import Thread
from errno import EAGAIN, EWOULDBLOCK
from sys import exit

HEADER = 10

IP = socket.gethostbyname(socket.gethostname())
PORT = 5050

client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
mainwindow = tk.Tk()
text_box = tk.Text()


# Build GUI
def build_Gui():
    mainwindow.title("Smart home app")

    mainframe = tk.Frame(mainwindow, bg="#1e1e1e")
    mainframe.pack(fill="both", expand=True)

    label = tk.Label(mainframe, bg="#1e1e1e", fg="white", padx=5, pady=5)
    label.config(font=("Arial", 18))
    label.pack(fill="x")

    verticalFrame = tk.Frame(mainframe, bg="#1e1e1e")
    label = tk.Label(verticalFrame, text="Smarta hemmet",
                     bg="#1e1e1e", fg="white", padx=10, pady=10,
                     font=("Arial", 20))
    label.pack(fill="x", padx=10, pady=10)
    verticalFrame.pack(fill="x")

    label = tk.Label(mainframe, text="Anslut till server och be om data "
                     "från hemmets sensorer", bg="#1e1e1e", fg="white",
                     padx=5, pady=5, font=("Arial", 14))
    label.pack(fill="x")

    label = tk.Label(mainframe, text="Om ingen data visas vid förfrågan "
                     "är sensorklient ej operativ", bg="#1e1e1e", fg="white",
                     padx=5, pady=5, font=("Arial", 14))
    label.pack(fill="x")

    horizontal_frame = tk.Frame(mainframe, bg="#1e1e1e")

    button1 = tk.Button(horizontal_frame, text="Anslut till server",
                        command=connect_to_server,
                        fg="#1e1e1e", bg="white", padx=10, pady=10)
    button1.grid(row=0, column=0, padx=10, pady=10, sticky="nsew")
    button2 = tk.Button(horizontal_frame, text="Temperatur",
                        command=ask_temperature,
                        fg="#1e1e1e", bg="white", padx=10, pady=10)
    button2.grid(row=0, column=1, padx=10, pady=10, sticky="nsew")
    button3 = tk.Button(horizontal_frame, text="Luftfuktighet",
                        command=ask_humidity,
                        fg="#1e1e1e", bg="white", padx=10, pady=10)
    button3.grid(row=0, column=2, padx=10, pady=10, sticky="nsew")
    button4 = tk.Button(horizontal_frame, text="Stäng anslutning",
                        command=close_connection,
                        fg="#1e1e1e", bg="white", padx=10, pady=10)
    button4.grid(row=0, column=3, padx=10, pady=10, sticky="nsew")

    horizontal_frame.grid_columnconfigure(0, weight=1)
    horizontal_frame.grid_columnconfigure(1, weight=1)
    horizontal_frame.grid_columnconfigure(2, weight=1)
    horizontal_frame.grid_columnconfigure(3, weight=1)
    horizontal_frame.pack(fill="x")

    verticalFrame = tk.Frame(mainframe, bg="#1e1e1e")
    text_box.configure(fg="white", bg="#1e1e1e", font=("arial", 12),
                       state=tk.DISABLED)
    text_box.pack(fill="both", padx=5, pady=5)
    verticalFrame.pack(fill="both")


# This function inserts data in GUI text box
def insert_text(msg):
    try:
        text_box.configure(state=tk.NORMAL)
        text_box.insert(tk.END, msg + "\n")
        text_box.configure(state=tk.DISABLED)
    except Exception as e:
        print(e)
        pass


# Connect to server and start a thread that listens for messages
# Here I wanted to get a connection message back from server,
# but I didn't get that to work.
# If we fail to connect we hit the Exception so this should be fine as it is
def connect_to_server():
    try:
        client_socket.connect((IP, PORT))
        client_socket.setblocking(False)

        send("Client")
        insert_text("Ansluten till server")
        Thread(target=listen_for_message, daemon=True).start()
    except OSError as e:
        insert_text(str(e))
        print(e)
        pass


# Continuously listens for messages and if there is one
# send it to insert_text function
# If we get disconnection message from server close program
def listen_for_message():
    while True:
        message = recieve()
        if message:
            insert_text(message)
            if message == "Anslutning avbruten":
                # If server sends our disconnection message back
                # we want to close app
                mainwindow.after(1000, mainwindow.destroy)


# This function returns message from server IF there is one
def recieve():
    try:
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
        return message

    # When there are no incoming data, error is going to be raised
    # We are going to check for both, as they can depend on different os,
    # and only want to close if both errors hit
    # We expecte one error, meaning no incoming data, so continue as normal
    except IOError as e:
        if e != EAGAIN and e.errno != EWOULDBLOCK:
            print('Reading error: {}'.format(str(e)))
            exit()
        pass
    # Something else went wrong
    except Exception as e:
        print('General error: {}'.format(str(e)))
        exit()


# This function converts message to bytes and sends it to server
def send(data):
    message = data.encode("utf-8")
    message_header = f"{len(message):<{HEADER}}".encode('utf-8')
    client_socket.send(message_header + message)


# Sends message to server asking sensor klient for temperature
def ask_temperature():
    try:
        send("?temperature")
    except OSError as e:
        insert_text("[WinError 10057] Ej ansluten till server")
        print(e)
        pass


# Sends message to server asking sensor klient for humidity
def ask_humidity():
    try:
        send("?humidity")
    except OSError as e:
        insert_text("[WinError 10057] Ej ansluten till server")
        print(e)
        pass


# This function sends disconnection message to server
def close_connection():
    try:
        send("Anslutning avbruten")
    except OSError as e:
        insert_text("[WinError 10057] Ej ansluten till server\n"
                    "Stänger program...")
        print(e)
        mainwindow.after(1500, mainwindow.destroy)


# Starts GUI Client
def start_Gui():
    build_Gui()
    mainwindow.mainloop()


if __name__ == "__main__":
    start_Gui()
