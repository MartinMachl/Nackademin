package se.nackademin;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;

public class BoxerTest {
    Boxer x = new Boxer("testName", "Heavy weight", 10, 20, 30, 1);
    Boxer y = new Boxer("secondName", "Middle weight", 40, 50, 60, 1);
    Boxer z = new Boxer("thirdTestName", "Light weight", 70, 80, 90, 1);

    @Test
    void checkNameChanged() {
        x.setName("Prince");
        assertEquals("Prince", x.name);
    }

    @Test
    void checkIfObjectCopied() {
        Boxer copiedObject = new Boxer("temp", "temp", 1.00, 1.00, 1.00, 1);
        ((Boxer) copiedObject).copy((Boxer) x);
        assertEquals(10, copiedObject.hitPower);
    }

    @Test
    void setNewSpeed() {
        x.setSpeed(100);
        assertEquals(100, x.getSpeed());
    }

    @Test
    void negatesWrongSpeedComparison() {
        x.setSpeed(88);
        assertNotEquals(50, x.getSpeed());
    }

    @Test
    void getsCorrectValue() {
        assertEquals(40, y.getPower());
    }

    @Test
    void getsIncorrectValue() {
        z.setStamina(50);
        assertNotEquals(0, z.getStamina());
    }

    @Test
    void collectiveAssertSpeed() {
        // A grouped assertion. Keep in mind, x has speed of 20 NOT 100!
        assertAll("boxer", () -> assertEquals(20, x.getSpeed()), () -> assertEquals(50, y.getSpeed()),
                () -> assertEquals(80, z.getSpeed()));
    }

    @Test
    void acceptsFloats() {
        assertDoesNotThrow(() -> z.setPower(10.6f));
    }

    @Test
    void correctGetStat() {
        assertEquals(60, x.getStat());
    }

    @Test
    void classBelonging() {
        assertTrue(x instanceof Boxer);
    }
}
