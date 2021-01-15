package se.nackademin;

import java.util.*;

public class App {

    public static void main(String[] args) throws InterruptedException {
        Gym goldenGloves = new Gym("GoldenGloves");
        List<Boxer> catalog = new ArrayList<>();
        List<String> weights = new ArrayList<>();
        List<String> names = new ArrayList<>();
        List<String> weightClasses = Arrays.asList("heavy weight", "light-heavy weight", "cruiser weight", "middle weight", "welter weight", "light weight", "rooster weight");
        String data;

        // Create 7 boxers, to initially add objects when program is run.
        catalog.add(new Boxer("Bosse", "Heavy Weight", 90.00, 75.00, 70.00));
        catalog.add(new Boxer("Ivan", "Heavy Weight", 94.00, 72.00, 68.00));
        catalog.add(new Boxer("Rocky", "Middle Weight", 82.00, 82.00, 76.00));
        catalog.add(new Boxer("Holly", "Middle Weight", 80.00, 84.00, 79.00));
        catalog.add(new Boxer("Marc", "Welter Weight", 77.00, 87.00, 85.00));
        catalog.add(new Boxer("Ali", "Light Weight", 65.00, 94.00, 88.00));
        catalog.add(new Boxer("Apollo", "Light Weight", 70.00, 90.00, 87.00));

        System.out.println("\nWelcome to " + goldenGloves.name + " boxing gym");

        // ----- MENU FOR GYM -----
        try (Scanner input = new Scanner(System.in)) {

            do {
                Scanner getInput = new Scanner(System.in);
                // Using english locale on scanner to force input to be same on all os
                // ex. on swe os input on double/float will only accept ","
                getInput.useLocale(Locale.ENGLISH);
                System.out.println("\n-----    MENU    -----");
                System.out.println(
                        "1. To list all boxers\n2. To list approved weight classes\n3. To add a boxer\n4. To train boxers\n5. To make a fight with names\n6. To make all fighters in one weight class fight\n9. To exit\n");
                System.out.print("Input: ");
                data = input.next();

                if (data.equals("1")) {
                    goldenGloves.printAll(catalog);
                                
                } else if (data.equals("2")) {
                    data2(weightClasses);

                } else if (data.equals("3")) {
                    data3(getInput, names, catalog, weightClasses);

                } else if (data.equals("4")) {
                    data4(getInput, goldenGloves, catalog);

                } else if (data.equals("5")) {
                    data5(getInput, goldenGloves, names, catalog);

                } else if (data.equals("6")) {
                    data6(getInput, goldenGloves, weights, catalog, weightClasses);

                } else if (data.equals("9")) {
                    System.out.println("exiting");

                } else {
                    System.out.println("No matching command");
                }

                Thread.sleep(1000); // Optional
            } while (!"9".equalsIgnoreCase(data));
        }
    }

    static String capitalizeWord(String str) {
        String words[] = str.split("\\s");
        String capitalizeWord = "";
        for (String w : words) {
            String first = w.substring(0, 1);
            String afterfirst = w.substring(1);
            capitalizeWord += first.toUpperCase() + afterfirst + " ";
        }
        return capitalizeWord.trim();
    }

    // Called methods found here
    static void data2( List<String> weightClasses) {
        System.out.println("\nWEIGHT CLASSES\n");

        // Looping through list of objects
        weightClasses.stream().forEach(weightClass -> System.out.println(capitalizeWord(weightClass)));
    }

    static void data3(Scanner input, List<String> names, List<Boxer> catalog, List<String> weightClasses) {
        for (Boxer boxer : catalog) {
            names.add(boxer.getName());
        }
        String name = "";
        boolean myTry1 = false;
        while (!myTry1) {
            System.out.print("Enter boxer name: ");
            name = input.nextLine().toLowerCase();
            name = capitalizeWord(name);
            if (names.contains(name)) {
                System.out.println("Name already taken, choose another");
            } else {
                myTry1 = true;
                names.clear();
            }
        }

        String weightClass = "";
        boolean myTry2 = false;
        while (!myTry2) {
            System.out.print("Enter weight class (ex: \"Heavy Weight\", \"Middle Weight\", \"Light Weight\"): ");
            weightClass = input.nextLine().toLowerCase();
            if (weightClasses.contains(weightClass)) {
                weightClass = capitalizeWord(weightClass);
                myTry2 = true;
            } else {
                System.out.println("Not approved weight class");
            }
        }

        System.out.print("Enter striking power (ex 25.00): ");
        double hitPower = input.nextDouble();

        System.out.print("Enter striking speed (ex 25.00): ");
        double speed = input.nextDouble();

        System.out.print("Enter stamina (ex 25.00): ");
        double stamina = input.nextDouble();

        catalog.add(new Boxer(name, weightClass, hitPower, speed, stamina));
        System.out.println("Boxer added");
    }

    static void data4(Scanner input, Gym goldenGloves, List<Boxer> catalog) {
        // user promtp, checking value with condition. Removed hard-coding.
        boolean myTry = false;
        while (!myTry) {
            System.out.print("Enter training method (\"stamina\", \"speed\" or \"power\"): ");
            String userChoice = input.next().toLowerCase();
            if (userChoice.equals("stamina") || userChoice.equals("speed") || userChoice.equals("power")) {
                goldenGloves.train(userChoice, catalog);
                myTry = true;
            } else {
                System.out.println("Wrong input, no such training method");
            }
        }
    }

    static void data5(Scanner input, Gym goldenGloves, List<String> names, List<Boxer> catalog)
            throws InterruptedException {
        // this method starts by adding all the names of the boxers in our catalog to a
        // list called names.
        for (Boxer boxer : catalog) {
            names.add(((Boxer) boxer).getName());
        }
        String fighter1 = "";
        String fighter2 = "";
        boolean myTry1 = false;
        boolean myTry2 = false;
        // this checks if the entered name exists in the list of names,
        // if yes the first name is set
        while (!myTry1) {
            System.out.print("Enter name of first fighter: ");
            fighter1 = input.nextLine().toLowerCase();
            fighter1 = capitalizeWord(fighter1);
            if (names.contains(fighter1)) {
                myTry1 = true;
            } else {
                System.out.println("No such fighter");
            }
        }
        // this checks if the second name is equal to the first, if not we continue
        // if the name is not equal the first name and it exists in the list, the second
        // name is set
        while (!myTry2) {
            System.out.print("Enter name of second fighter: ");
            fighter2 = input.nextLine().toLowerCase();
            fighter2 = capitalizeWord(fighter2);
            if (fighter2.equalsIgnoreCase(fighter1)) {
                System.out.println("Fighter already chosen");
            } else if (names.contains(fighter2)) {
                myTry2 = true;
            } else {
                System.out.println("No such fighter");
            }
        }
        // the list of names is cleared to be used again and the variables are sent to
        // next method
        // and the method fight is started
        names.clear();
        goldenGloves.makeFightcard(fighter1, fighter2, catalog);
        goldenGloves.fight();
    }

    static void data6(Scanner input, Gym goldenGloves, List<String> weights, List<Boxer> catalog,
            List<String> weightClasses) throws InterruptedException {

        // each boxer's weightclass from catalog, to be put in a temporary list
        // 'weigths'
        int count = 0;
        String weightClass = "";
        boolean myTry = false;

        for (Boxer boxer : catalog) {
            weights.add(boxer.getWeight());
        }

        while (!myTry) {
            System.out.print("Enter weight class (ex: \"Heavy Weight\", \"Middle Weight\", \"Light Weight\"): ");
            weightClass = input.nextLine().toLowerCase();

            // check if the entered weight class is a valid weight class
            if (weightClasses.contains(weightClass)) {
                weightClass = capitalizeWord(weightClass);

                // resets after each count
                count = 0;

                // check how many times a weight class exists in the list of weights
                for (String w : weights) {
                    if (w.equalsIgnoreCase(weightClass)) {
                        ++count;
                    }
                }
                // if criteria of atleast 2 boxers (of a weight class) are met, start a fight
                if (count == 0) {
                    System.out.println("No fighters in that weight class");
                } else if (count == 1) {
                    System.out.println("Only one fighters in that weight class");
                } else {
                    myTry = true;
                }
            } else {
                System.out.println("Not approved weight class");
            }
        }
        // temporary list 'weights' is cleared for reuse when method called
        // method fight is started, given criterias in method are met
        weights.clear();
        goldenGloves.getFightcard(weightClass, catalog);
        goldenGloves.fight();
    }
}
