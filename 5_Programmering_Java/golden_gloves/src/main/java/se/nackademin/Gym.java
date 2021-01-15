package se.nackademin;

import java.util.*;

public class Gym {
    String name;
    List<Boxer> fightcard = new ArrayList<>();

    Gym(String name) {
        this.name = name;
    }

    // this method takes a string argument and depending on what string
    // it will send the object to specified method
    public void printAll(List<Boxer> catalog) {
        System.out.println(String.format("%n%-20s %-20s %-20s %-20s %-20s %n", "NAME", "WEIGHT CLASS", "HIT POWER", "SPEED", "STAMINA"));

        // Looping through list of objects
        catalog.stream().forEach(boxer -> System.out.println(String.format("%-20s %-20s %-20.2f %-20.2f %-20.2f",
                boxer.name, boxer.weightClass, boxer.hitPower, boxer.speed, boxer.stamina)));
    }

    void train(String input, List<Boxer> catalog) {

        // created a variable for same message for multiple places.
        String successMessage = "Training successful!";

        // NOT changing to switch-cases because good to test 'equalsIgnoreCase' in
        // test-file.
        if (input.equals("stamina")) {
            // Increase stamina on all boxers
            for (Boxer boxer : catalog) {
                boxer.addStamina();
            }
            System.out.println(successMessage);
        } else if (input.equals("speed")) {
            // Increase speed and decrease power on all boxers
            for (Boxer boxer : catalog) {
                boxer.addSpeed();
            }
            System.out.println(successMessage);
        } else {
            // Increase power and decrease speed on all boxers
            for (Boxer boxer : catalog) {
                boxer.addPower();
            }
            System.out.println(successMessage);
        }
    }

    /*
     * this method takes a string argument corresponding to weight_class it loops
     * over all objects in the catalog list, creates a temporary copy of the object,
     * and if the weight_class argument is equal to the attribute of the copy adds
     * it to a new list for fighting. this is to prevent changes to the original
     * objects attributes
     */
    public void getFightcard(String input, List<Boxer> catalog) throws InterruptedException {
        for (Boxer boxer : catalog) {
            Boxer tempBoxer = new Boxer("temp", "temp", 1.00, 1.00, 1.00);
            (tempBoxer).copy(boxer);

            if (input.equalsIgnoreCase((tempBoxer).getWeight())) {
                // adding to fighter's list
                fightcard.add(tempBoxer);
            }
        }
    }

    /*
     * this method takes two string argument corresponding to names it loops over
     * all objects in the catalog list, creates a temporary copy of the object, and
     * if the name argument is equal to the attribute of the copy adds it to a new
     * list for fighting. this is to prevent changes to the original objects
     * attributes
     */
    public void makeFightcard(String fighter1, String fighter2, List<Boxer> catalog) throws InterruptedException {
        for (Boxer boxer : catalog) {
            Boxer tempBoxer = new Boxer("temp", "temp", 1.00, 1.00, 1.00);
            (tempBoxer).copy(boxer);
            if (fighter1.equalsIgnoreCase((tempBoxer).getName())) {
                fightcard.add(tempBoxer);
            } else if (fighter2.equalsIgnoreCase((tempBoxer).getName())) {
                fightcard.add(tempBoxer);
            } else {
                // no code here.
            }
        }
    }

    // this method checks if the first two objects weights are equal or not,
    // to determin the correct weight class
    String setWeightclass(List<Boxer> fightcard) {
        if ((fightcard.get(0)).getWeight().equalsIgnoreCase((fightcard.get(1)).getWeight())) {
            return (fightcard.get(0)).getWeight();
        } else {
            return "Catch Weight";
        }
    }

    int setRound(String weightClass) {
        int round = 0;
        // the times of iteration is set by weight class
        if (weightClass.equalsIgnoreCase("heavy weight")) {
            round = 6;
        } else if (weightClass.equalsIgnoreCase("cruiser weight") || (weightClass.equalsIgnoreCase("light-heavy weight"))) {
            round = 8;
        } else if (weightClass.equalsIgnoreCase("middle weight") || (weightClass.equalsIgnoreCase("welter weight"))) {
            round = 10;
        } else if (weightClass.equalsIgnoreCase("rooster weight") || (weightClass.equalsIgnoreCase("light weight"))) {
            round = 12;
        } else {
            round = 8;
        }
        return round;
    }

    /*
     * this method runs after a fightcard list has been created and iterates over
     * the objects and changes the attributes and prints a simulated health after
     * all iterations are completed the health of the objects are compared and the
     * object with the highest double is printed out as winner. afterwards the list
     * is emptied and ready to be used again.
     */
    public void fight() throws InterruptedException {
        // first we determin the correct weight class for the fight
        String weightClass = setWeightclass(fightcard);

        // then we determin the correct amount of iterations
        int round = setRound(weightClass);
        System.out.println("\nWeight class : " + weightClass);
        for (int i = 0; i < round; ++i) {
            System.out.println(String.format("%nRound: %d", i + 1));

            // for every iteration attributes of the objects are decresed
            for (Boxer tempBoxer : fightcard) {
                (tempBoxer).setSpeed((tempBoxer).getSpeed() * 0.89);
                (tempBoxer).setPower((tempBoxer).getPower() * 0.90);
                (tempBoxer).setStamina((tempBoxer).getStamina() * 0.88);
                System.out.println(String.format("Name: %-10s | Health: %.2f", tempBoxer.getName(), tempBoxer.getStat()));
            }
            Thread.sleep(1500);
        }
        // Sort list fightcard after stat
        fightcard.sort((o1, o2) -> Double.compare((o2).getStat(), (o1).getStat()));
        System.out.println((String.format("%nAfter %d rounds of fighting", round)));

        if (Double.compare((fightcard.get(0)).getStat(), (fightcard.get(1)).getStat()) == 0) {
            System.out.println("The match was a tie!");
        } else {
            System.out.println((String.format("The winner is: %s", (fightcard.get(0)).getName())));
        }

        // the list fightcard is cleared to be used again to control duplicates
        fightcard.clear();
        Thread.sleep(2000);
    }
}
