package se.booksrus;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;
import org.junit.platform.commons.annotation.Testable;
import java.util.List;
import java.util.ArrayList;

@Testable
public class BasketTest {
    Book a = new Book(66, "testBook1", "Martin", "test1", "9791234567890", 129, 1);
    Book b = new Book(67, "testBook2", "Martin", "test2", "9791234567891", 250, 1);
    Book c = new Book(68, "testBook3", "Machl", "test1", "9791234567892", 1349, 1);
    List<Book> books = new ArrayList<>();
    Basket basket = new Basket();


    @BeforeEach
    public void init() {
        books.clear();
        books.add(a);
        books.add(b);
    }

    @Test
    void totalWorks() {
        assertEquals(379, basket.getTotal(books));
    }

    @Test
    void totalWorksAfterAdd() {
        basket.addToBasket(books, c);
        assertEquals(1728, basket.getTotal(books));
    }

    @Test
    void totalWorksAfterRemove() {
        basket.removeFromBasket(books, "testBook2");
        assertEquals(129, basket.getTotal(books));
        basket.removeFromBasket(books, "testBook1");
        assertEquals(0, basket.getTotal(books));
    }
}
