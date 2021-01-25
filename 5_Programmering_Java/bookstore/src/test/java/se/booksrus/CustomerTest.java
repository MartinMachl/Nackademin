package se.booksrus;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;
import org.junit.platform.commons.annotation.Testable;

@Testable
public class CustomerTest {
    Customer a = new Customer(5, "first name", "last name", "street", "zip", "city", "userName", "password");

    @BeforeEach
    public void init() {
        a.setID(5);
        a.setFirstName("first name");;
        a.setLastName("last name");
        a.setStreet("street");
        a.setZip("zip");
        a.setCity("city");
        a.setUserName("userName");
        a.setPassword("password");
    }
    
    @Test
    void getIDWorks() {
        assertEquals(5, a.getID());
    }

    @Test
    void getFirstNameWorks() {
        assertEquals("first name", a.getFirstName());
    }

    @Test
    void getLastNameWorks() {
        assertEquals("last name", a.getLastName());
    }

    @Test
    void getStreetWorks() {
        assertEquals("street", a.getStreet());
    }

    @Test
    void getZipWorks() {
        assertEquals("zip", a.getZip());
    }

    @Test
    void getCityWorks() {
        assertEquals("city", a.getCity());
    }

    @Test
    void getUserNameWorks() {
        assertEquals("userName", a.getUserName());
    }

    @Test
    void getPasswordWorks() {
        assertEquals("password", a.getPassword());
    }
    
    @Test
    void setIDWorks() {
        a.setID(77);
        assertEquals(77, a.getID());
    }

    @Test
    void setFirstNameWorks() {
        a.setFirstName("Martin");;
        assertEquals("Martin", a.getFirstName());
    }

    @Test
    void setLastNameWorks() {
        a.setLastName("Machl");
        assertEquals("Machl", a.getLastName());
    }
    
    @Test
    void setStreetWorks() {
        a.setStreet("Gatan 14");
        assertEquals("Gatan 14", a.getStreet());
    }
    
    @Test
    void setZipWorks() {
        a.setZip("11436");
        assertEquals("11436", a.getZip());
    }
    
    @Test
    void setCityWorks() {
        a.setCity("Stockholm");
        assertEquals("Stockholm", a.getCity());
    }

    @Test
    void setUserNameWorks() {
        a.setUserName("userNameTT");
        assertEquals("userNameTT", a.getUserName());
    }

    @Test
    void setPasswordWorks() {
        a.setPassword("pelle");
        assertEquals("pelle", a.getPassword());
    }
}
