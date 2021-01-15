package se.nackademin;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;

import java.util.*;

public class GymTest {
    Boxer x = new Boxer("testName", "Heavy Weight", 10, 20, 30);
    Boxer y = new Boxer("testName2", "Welter Weight", 20, 30, 40);
    Boxer z = new Boxer("testName3", "Heavy Weight", 15, 15, 15);
    Gym goldenGloves = new Gym("GoldenGloves");
    List<Boxer> catalog = new ArrayList<>();
    List<Boxer> fightcard = new ArrayList<>();

    @Test
    void trainStaminaWorks() {
        catalog.add(x);
        goldenGloves.train("stamina", catalog);
        assertEquals(37.50, x.getStamina());
    }

    @Test
    void throwsArgumentNullPassed() {
        String myString = null;
        assertThrows(NullPointerException.class, () -> goldenGloves.train(myString, catalog));
    }

    @Test
    void setWeightclassCatchWorks() {
        fightcard.add(x);
        fightcard.add(y);
        assertEquals("Catch Weight", goldenGloves.setWeightclass(fightcard));
    }

    @Test
    void setWeightclassSameWorks() {
        fightcard.add(x);
        fightcard.add(z);
        assertEquals("Heavy Weight", goldenGloves.setWeightclass(fightcard));
    }

    @Test
    void setRoundWorks() {
        String weightClass = "MIDDLE WEIGHT";
        assertEquals(10, goldenGloves.setRound(weightClass));
    }

    @Test
    void noExceptionThrown() {
        // No exception thrown because passed argument not tested against condition
        // until within called method.
        String myString = "testWronArg";
        assertDoesNotThrow(() -> goldenGloves.train(myString, catalog));
    }
}