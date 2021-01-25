package se.booksrus;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;
import org.junit.platform.commons.annotation.Testable;

@Testable
public class BookTest {
    Book a = new Book(66, "testBook1", "Martin", "test1", "9791234567890", 129, 1);

    @BeforeEach
    public void init() {
        a.setID(66);
        a.setTitle("testBook1");;
        a.setAuthor("Martin");
        a.setGenre("test1");
        a.setIsbn("9791234567890");
        a.setPrice(129);
        a.setQuantity(1);
    }
    
    @Test
    void getWorks() {
        assertEquals(66, a.getID());
    }

    @Test
    void getIDWorks() {
        assertEquals(66, a.getID());
    }

    @Test
    void getTitleWorks() {
        assertEquals("testBook1", a.getTitle());
    }

    @Test
    void getAuthorWorks() {
        assertEquals("Martin", a.getAuthor());
    }

    @Test
    void getGenretWorks() {
        assertEquals("test1", a.getGenre());  
    }

    @Test
    void getIsbnWorks() {
        assertEquals("9791234567890", a.getIsbn()); 
    }

    @Test
    void getPriceWorks() {
        assertEquals(129, a.getPrice());
    }

    @Test
    void getQuantityWorks() { 
        assertEquals(1, a.getQuantity());
    }

    @Test
    void setIDWorks() {
        a.setID(77);
        assertEquals(77, a.getID());
    }

    @Test
    void setTitleWorks() {
        a.setTitle("testBook2");
        assertEquals("testBook2", a.getTitle());
    }

    @Test
    void setAuthorWorks() {
        a.setAuthor("MartinM");
        assertEquals("MartinM", a.getAuthor());
    }

    @Test
    void setGenreWorks() {
        a.setGenre("test2");
        assertEquals("test2", a.getGenre());
    }
    
    @Test
    void setIsbntWorks() {
        a.setIsbn("9791234567892");
        assertEquals("9791234567892", a.getIsbn());
    }

    @Test
    void setPriceWorks() {
        a.setPrice(200);
        assertEquals(200, a.getPrice());
    }
    
    @Test
    void setQuantityWorks() {
        a.setQuantity(2);
        assertEquals(2, a.getQuantity());
    }
}
