package se.booksrus;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;
import org.junit.platform.commons.annotation.Testable;

@Testable
public class OrderTest {
    Order a = new Order(66, "first name", "last name", "street", "zip", "city", "testBook1", 1, 100);

    @BeforeEach
    public void init() {
        a.setNumber(66);
        a.setFirstName("first name");;
        a.setLastName("last name");
        a.setStreet("street");
        a.setZip("zip");
        a.setCity("city");
        a.setTitle("testBook1");
        a.setBackorder(1);
        a.setPrice(100);
    }
    
    @Test
    void getNumberWorks() {
        assertEquals(66, a.getNumber());
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
    void getTitleWorks() {
        assertEquals("testBook1", a.getTitle());
    }

    @Test
    void getBackorderWorks() {
        assertEquals(1, a.getBackorder());
    }

    @Test
    void getPriceWorks() {
        assertEquals(100, a.getPrice());
    }

    @Test
    void setNumberWorks() {
        a.setNumber(77);
        assertEquals(77, a.getNumber());
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
    void setTitleWorks() {
        a.setTitle("testBook2");
        assertEquals("testBook2", a.getTitle());
    }

    @Test
    void setBackorderWorks() {
        a.setBackorder(0);
        assertEquals(0, a.getBackorder());
    }
    
    
    @Test
    void setPriceWorks() {
        a.setPrice(200);
        assertEquals(200, a.getPrice());
    }
}
