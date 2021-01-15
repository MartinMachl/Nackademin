import unittest
from unittest.mock import patch
from App import smart_home_client


class HomeClientTest(unittest.TestCase):

    @patch('App.smart_home_client.send')
    def test_ask_temperature_true(self, mock_send):
        smart_home_client.ask_temperature()
        mock_send.assert_called_once_with("?temperature")

    @patch('App.smart_home_client.insert_text')
    @patch('App.smart_home_client.send')
    def test_ask_temperature_raise_OSR(self, mock_send, mock_insert_text):
        mock_send.side_effect = OSError
        smart_home_client.ask_temperature()
        mock_send.assert_called_once()
        mock_insert_text.assert_called_once_with("[WinError 10057] Ej ansluten till server")

    @patch('App.smart_home_client.send')
    def test_ask_humidity_true(self, mock_send):
        smart_home_client.ask_humidity()
        mock_send.assert_called_once_with("?humidity")

    @patch('App.smart_home_client.insert_text')
    @patch('App.smart_home_client.send')
    def test_ask_humidity_raise_OSR(self, mock_send, mock_insert_text):
        mock_send.side_effect = OSError
        smart_home_client.ask_humidity()
        mock_send.assert_called_once()
        mock_insert_text.assert_called_once_with("[WinError 10057] Ej ansluten till server")

    @patch('App.smart_home_client.send')
    def test_close_connection_true(self, mock_send):
        smart_home_client.close_connection()
        mock_send.assert_called_once_with("Anslutning avbruten")

    @patch('App.smart_home_client.insert_text')
    @patch('App.smart_home_client.send')
    def test_close_connection_raise_OSR(self, mock_send, mock_insert_text):
        mock_send.side_effect = OSError
        smart_home_client.close_connection()
        mock_send.assert_called_once()
        mock_insert_text.assert_called_once_with("[WinError 10057] Ej ansluten till server\n"
                                                 "Stänger program...")


if __name__ == '__main__':
    unittest.main()
