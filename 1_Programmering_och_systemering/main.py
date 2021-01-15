from setup import (open_connection, create_tables, user_input,
                   show_pantry, add_ingredient_name, add_ingredient_volume,
                   Pantry, add_recipe, add_portion, add_instruction,
                   add_ingredient_list, Recipe, show_recipes)


def main():
    connection = open_connection("kitchen.db")
    with connection:
        # SKAPA DATABAS OM EJ FINNS
        create_tables(connection)

        while True:
            ans = user_input()
            if ans == "1":
                # VISA SKAFFERIET
                show_pantry(connection)

            if ans == "2":
                # LÄGG TILL I SKAFFERIET
                ingredient_name = add_ingredient_name()
                volume = add_ingredient_volume()
                ingredient = Pantry(ingredient_name, volume)
                ingredient.insert_ingredient(connection)

            if ans == "3":
                # TA BORT FRÅN SKAFFERIET
                ingredient_name = add_ingredient_name()
                volume = add_ingredient_volume
                ingredient = Pantry(ingredient_name, volume)
                ingredient.delete_ingredient(connection)

            if ans == "4":
                # LÄGG TILL ETT RECEPT
                recipe = add_recipe()
                portion = add_portion()
                instruction = add_instruction()
                ingredients = add_ingredient_list()
                recept = Recipe(recipe, portion, instruction, ingredients)
                recept.insert_all(connection)

            if ans == "5":
                # KLIV IN I RECEPBOKEN
                show_recipes(connection)

            if ans == "0":
                break


if __name__ == "__main__":
    main()
