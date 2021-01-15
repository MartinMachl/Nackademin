package se.nackademin;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;
import java.util.*;

class AppTest {
    Gym goldenGloves = new Gym("GoldenGloves");
    Boxer x = new Boxer("testName", "Heavy weight", 10, 20, 30);
    List<Boxer> catalog = new ArrayList<>();
    List<String> weightClasses = Arrays.asList("heavy weight", "cruiser weight", "middle weight", "light-heavy weight", "rooster weight", "light weight", "welter weight");
    List<String> names = new ArrayList<>();

    @Test
    @DisplayName("---is empty---")
    void isNamedCorrectly() {
        assertEquals("GoldenGloves", goldenGloves.name);
    }

    @Test
    void isEmpty() {
        assertTrue(catalog.isEmpty());
    }

    @Test
    void isNotEmpty() {
        catalog.add(new Boxer("first", "heavy weight", 60.00, 45.00, 90.00));
        assertFalse(catalog.isEmpty());
    }

    @Test
    void userHasName() {
        catalog.add(new Boxer("first", "heavy weight", 60.00, 45.00, 90.00));
        assertFalse(catalog.isEmpty());
    }

    @Test
    void weightClassApproved() {
        assertTrue(weightClasses.contains("heavy weight"));
    }

    @Test
    void acceptsOnlyLowerCase() {
        assertFalse(weightClasses.contains("Heavy Weight"));
    }

    @Test
    void checksObjectNameInList() {
        catalog.add(x);
        for (Boxer boxer : catalog) {
            names.add(((Boxer) boxer).getName());
        }
        String myName = "ivan";
        assertFalse(names.contains(myName));
    }

    @Test
    void checksObjectNameInList2() {
        catalog.add(x);
        for (Boxer boxer : catalog) {
            names.add(((Boxer) boxer).getName());
        }
        String myName = "testName";
        assertTrue(names.contains(myName));
    }
}
