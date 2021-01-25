package se.booksrus;

import static org.junit.jupiter.api.Assertions.*;

import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.*;
import org.junit.platform.commons.annotation.Testable;

@Testable
public class AppTest {
    App app = new App();  
    List<Customer> customers = new ArrayList<>();

    @BeforeEach
    void init() {
        customers.clear();
        customers.add(new Customer(5, "first name", "last name", "street", "zip", "city", "userName", "password"));
    }

    @Test
    void testPasswordWorks() {
        assertTrue(app.testPassword("passWord", "passWord"));
        assertTrue(app.testPassword("Hello worlD", "Hello worlD"));
        assertFalse(app.testPassword("Hello World", "hello world"));
    }

    @Test
    void testUserExistsWorks() {
        List<Customer> a = app.testUserName(customers, "user");
        assertTrue(a.isEmpty());
        List<Customer> b = app.testUserName(customers, "userName");
        assertFalse(b.isEmpty());
    }

    @Test
    void getCustomerWorks() {
        Customer customer = app.getCustomer(customers);
        assertEquals("userName", customer.getUserName());
        assertNotEquals("user", customer.getUserName());
        assertEquals(5, customer.getID());
    }

    @Test
    void capitalizeWordWorks() {
        assertEquals("Word", app.capitalizeWord("word"));
        assertEquals("Hello World", app.capitalizeWord("hello world"));
    }
}
