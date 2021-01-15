import unittest
from unittest.mock import patch
from App import smart_home_sensors


class HomeSensorTest_random(unittest.TestCase):

    @patch('App.smart_home_sensors.random.randint')
    def test_get_humidity_low(self, mock_random):
        mock_random.return_value = 35
        self.assertEqual(smart_home_sensors.get_humidity(1), "Luftfuktighet: 35%")

    @patch('App.smart_home_sensors.random.randint')
    def test_get_humidity_mid_low(self, mock_random):
        mock_random.return_value = 30
        self.assertEqual(smart_home_sensors.get_humidity(13), "Luftfuktighet: 30%")

    @patch('App.smart_home_sensors.random.randint')
    def test_get_humidity_mid_high(self, mock_random):
        mock_random.return_value = 30
        self.assertEqual(smart_home_sensors.get_humidity(18), "Luftfuktighet: 30%")

    @patch('App.smart_home_sensors.random.randint')
    def test_get_humidity_high(self, mock_random):
        mock_random.return_value = 37
        self.assertEqual(smart_home_sensors.get_humidity(23), "Luftfuktighet: 37%")


class HomeSensorTest_uniform(unittest.TestCase):

    @patch('App.smart_home_sensors.random.uniform')
    def test_get_temperature_low(self, mock_random):
        mock_random.return_value = 19.9
        self.assertEqual(smart_home_sensors.get_temperature(1), "Temperatur: 19.9 celsius")

    @patch('App.smart_home_sensors.random.uniform')
    def test_get_temperature_mid_low(self, mock_random):
        mock_random.return_value = 20.5
        self.assertEqual(smart_home_sensors.get_temperature(13), "Temperatur: 20.5 celsius")

    @patch('App.smart_home_sensors.random.uniform')
    def test_get_temperature_mid_high(self, mock_random):
        mock_random.return_value = 20.5
        self.assertEqual(smart_home_sensors.get_temperature(19), "Temperatur: 20.5 celsius")

    @patch('App.smart_home_sensors.random.uniform')
    def test_get_temperature_high(self, mock_random):
        mock_random.return_value = 20.8
        self.assertEqual(smart_home_sensors.get_temperature(23), "Temperatur: 20.8 celsius")


class HomeSensorTest_False(unittest.TestCase):

    def test_get_temperature_false(self):
        self.assertEqual(smart_home_sensors.get_temperature(None), "Temperatur: 20.5 celsius")

    def test_get_humidity_false(self):
        self.assertEqual(smart_home_sensors.get_humidity(None), "Luftfuktighet: 30%")


if __name__ == '__main__':
    unittest.main()
