import sqlite3
from sqlite3 import Error
import pandas as pd


def open_connection(filename):
    return sqlite3.connect(filename)


def create_tables(connection):
    '''
    Körs varje gång programmet startar och skapar databasen
    om den inte redan finns, isf ignoreras skapandet.
    Inga värden matas in per automatik när programmet körs,
    utan allt måste matas in manuellt.
    '''
    with connection:
        connection.execute("""CREATE TABLE IF NOT EXISTS pantry(
                    ingredient TEXT PRIMARY KEY NOT NULL,
                    unit REAL NOT NULL)""")

        connection.execute("""CREATE TABLE IF NOT EXISTS recipes(
                    id INTEGER PRIMARY KEY NOT NULL,
                    recipe TEXT UNIQUE NOT NULL,
                    portions INTEGER,
                    instructions TEXT)""")

        connection.execute("""CREATE TABLE IF NOT EXISTS ingredients(
                    id INTEGER PRIMARY KEY NOT NULL,
                    ingredient TEXT)""")

        connection.execute("""CREATE TABLE IF NOT EXISTS units(
                    id INTEGER PRIMARY KEY NOT NULL,
                    recipe_id INTEGER NOT NULL,
                    ingredient_id INTEGER NOT NULL,
                    unit REAL NOT NULL,
                    FOREIGN KEY (recipe_id) REFERENCES recipes(id),
                    FOREIGN KEY (ingredient_id) REFERENCES
                    ingredients(id))""")


class Pantry:

    def __init__(self, ingredient, volume):
        self.ingredient = ingredient
        self.volume = volume

    def insert_ingredient(self, connection):
        with connection:
            try:
                sql = """INSERT INTO pantry (ingredient, unit) VALUES (?, ?)
                    ON CONFLICT (ingredient) DO UPDATE SET unit = unit+?"""
                # Om en ingrediens redan finns så ökar mängden i skafferiet
                values = (self.ingredient, self.volume, self.volume)
                connection.execute(sql, values)
            except Error as e:
                print(e)
                raise

    def delete_ingredient(self, connection):
        with connection:
            try:
                sql = """DELETE FROM pantry WHERE ingredient = ?"""
                values = (self.ingredient)
                connection.execute(sql, (values,))
            except Error as e:
                print(e)
                raise


class Recipe:

    def __init__(self, recipe, portion, instruction, ingredient_list):
        self.recipe = recipe
        self.portion = portion
        self.instruction = instruction
        self.ingredient_list = ingredient_list

    def insert_recipe(self, connection):
        with connection:
            try:
                sql = """INSERT OR REPLACE INTO recipes (recipe, portions, instructions)
                    VALUES (?, ?, ?)"""
                values = (self.recipe, self.portion, self.instruction)
                connection.execute(sql, values)
            except Error as e:
                print(e)
                raise

    def insert_ingredient_list(self, connection):
        '''
        Den här metoden använder listan med ingredienser och
        loopar över den och matar in värden för aktuellt recept.
        '''
        with connection:
            try:
                for i, u in self.ingredient_list:
                    sql1 = """INSERT INTO ingredients (ingredient)
                        VALUES (?)"""
                    sql2 = """INSERT INTO units (recipe_id, ingredient_id, unit)
                            VALUES ((SELECT id FROM recipes WHERE recipe = ?),
                            (SELECT id FROM ingredients WHERE ingredient = ?),
                            (?))"""
                    values1 = (i,)
                    values2 = (self.recipe, str(i), float(u))
                    connection.execute(sql1, values1)
                    connection.execute(sql2, values2)
            except Error as e:
                print(e)
                raise

    def insert_all(self, connection):
        self.insert_recipe(connection)
        self.insert_ingredient_list(connection)


def show_pantry(connection):
    data = pd.read_sql_query("""SELECT ingredient, unit FROM pantry""",
                             connection)
    print(data)
    input("\nTryck på valfri knapp för att fortsätta\n")


def show_recipes(connection):
    while True:
        data = pd.read_sql_query("""SELECT * FROM recipes""", connection)
        print(data)
        print("\n1. Se ingredienser för ett recept\n"
              "2. Ta bort ett recept\n"
              "3. Få receptförslag utifrån vad som finns i skafferiet\n"
              "0. Återgå till huvudmeny\n")
        choice = input("Ditt val: ")
        print()
        if choice not in ("1, 2, 3, 0"):
            print("Felaktig inmatning, försök igen.\n")
        if choice == "0":
            break
        if choice == "1":
            view_recipe = input("Ange id för receptet: ")
            print()
            sql = """SELECT i.ingredient, u.unit FROM ingredients AS i
                LEFT JOIN units AS u ON i.id = u.ingredient_id
                WHERE u.recipe_id = {}""".format(view_recipe)
            ing_db = pd.read_sql_query(sql, connection)
            print(ing_db)
            input("\nTryck på valfri knapp för att fortsätta\n")
        if choice == "2":
            with connection:
                try:
                    del_recipe = input("Ange id för receptet: ")
                    sql1 = """DELETE FROM recipes WHERE id = ?"""
                    sql2 = """DELETE FROM ingredients AS i
                        WHERE i.id IN (
                        SELECT i.id FROM ingredients INNER JOIN
                        units AS u ON i.id = u.ingredient_id
                        WHERE u.recipe_id = ?)"""
                    sql3 = """DELETE FROM units WHERE recipe_id = ?"""
                    values = (del_recipe)
                    connection.execute(sql1, (values,))
                    connection.execute(sql2, (values,))
                    connection.execute(sql3, (values,))
                    input("\nTryck på valfri knapp för att fortsätta\n")
                except Error as e:
                    print(e)
                    raise
        if choice == "3":
            with connection:
                try:
                    dinner = pd.read_sql_query("""SELECT DISTINCT recipes.recipe
                                FROM recipes, units, pantry, ingredients
                                WHERE units.recipe_id = recipes.id
                                AND pantry.ingredient = ingredients.ingredient
                                AND ingredients.id = units.ingredient_id
                                AND pantry.unit >= units.unit""", connection)
                    print(dinner)
                    print("\nReceptet högst upp är mest komplett.")
                    input("Tryck på valfri knapp för att fortsätta\n")
                except Error as e:
                    print(e)
                    raise


def user_input():
    # Huvudmenyn, returnerar värde till main
    print("--------------------------------------------\n"
          "|                                          |")
    print("|          VÄLKOMMEN TILL KÖKET!           |\n"
          "|                                          |\n"
          "| Du får nu fem val,                       |\n"
          "| använd motsvarande siffra för att välja. |\n"
          "|                                          |")
    while True:
        print("| 1. Visa skafferi.                        |\n"
              "| 2. Lägg till matvara i skafferiet.       |\n"
              "| 3. Ta bort en matvara ur skafferiet.     |\n"
              "| 4. Lägg till recept.                     |\n"
              "| 5. Hämta recept.                         |\n"
              "| 0. Avsluta.                              |\n"
              "|                                          |")
        print("--------------------------------------------")
        user_input = input("\nDitt val: ")
        print()
        if user_input in ("1", "2", "3", "4", "5", "0"):
            return user_input
        else:
            print("Felaktig inmatning, försök igen\n")


def add_ingredient_name():
    try:
        print("Du kommer nu att kunna mata in din vara.\n"
              "Börja med matvarans namn och \"ENTER\"\n"
              "Sedan mängden vara med en siffra och \"ENTER\"\n"
              "Sist enheten för mängden i antal, vikt eller volym, "
              "avsluta med \"ENTER\"\n")
        ingredient = input("Matvara: ")
        return ingredient.lower()
    except Error as e:
        print(e)
        raise


def add_ingredient_volume():
    '''
    Inmatning i skafferiet tillåter olika enheter
    då funktionen har en konverterare till kilogram.
    Om enheten inte finns med i listan får användaren
    formulera om inmatningen.
    '''
    try:
        while True:
            volume = input("Mängd: ")
            if volume.isdigit() is True:
                volume = float(volume)
                break
            else:
                print("Felaktig inmatning, försök igen.\n")
        while True:
            unit = input("dl/hg/kg/st/msk etc: ")
            if unit.lower() not in ("mg", "g", "hg", "kg", "ml", "cl",
                                    "dl", "l", "st", "msk"):
                print("Inte godkänd enhet.\n")
            else:
                break
        if unit.lower() == "ml":
            volume *= 0.001
        if unit.lower() == "cl":
            volume *= 0.01
        if unit.lower() == "dl":
            volume *= 0.1
        if unit.lower() == "l":
            volume *= 1
        if unit.lower() == "mg":
            volume *= 0.000001
        if unit.lower() == "g":
            volume *= 0.001
        if unit.lower() == "hg":
            volume *= 0.1
        if unit.lower() == "kg":
            volume *= 1
        if unit.lower() == "st":
            volume *= 1
        if unit.lower() == "msk":
            volume *= 0.015
        return volume
    except Error as e:
        print(e)
        raise


def add_recipe():
    try:
        recipe = input("Receptets namn: ")
        return recipe.lower()
    except Error as e:
        print(e)
        raise


def add_portion():
    try:
        while True:
            portion = input("Antal portioner: ")
            if portion.isdigit() is True:
                portion = int(portion)
                return portion
            else:
                print("Felaktig inmatning, försök igen.\n")
    except Error as e:
        print(e)
        raise


def add_instruction():
    try:
        instruction = input("Tillagning: ")
        return instruction
    except Error as e:
        print(e)
        raise


def add_ingredient_list():
    '''
    Skapar en lista där varje inlägg är en lista med ingrediens och vikt/antal.
    Returnerar listan.
    '''
    try:
        ingredient_list = []
        print("Ange ingrediens följt av \"ENTER\",\n"
              "sedan följt av mängden i kilo eller antal följt av \"ENTER\".\n"
              "Tryck \"q\" eller \"Q\" för att avsluta inmatning.")
        while True:
            temp_ingredient_list = []
            ingredient = input("Ingrediens: ")
            if ingredient == "q" or ingredient == "Q":
                break
            while True:
                unit = input("Mängd i kilo eller antal: ")
                unit = unit.replace(",", ".")
                temp_unit = unit.replace(".", "")
                if temp_unit.isdigit() is True:
                    unit = float(unit)
                    break
                else:
                    print("Felaktig inmatning, använd siffror.")
            temp_ingredient_list.append(ingredient)
            temp_ingredient_list.append(unit)
            ingredient_list.append(temp_ingredient_list)
        return ingredient_list
    except Error as e:
        print(e)
        raise
