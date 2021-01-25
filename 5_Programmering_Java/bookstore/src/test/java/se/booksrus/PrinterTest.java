package se.booksrus;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;
import org.junit.platform.commons.annotation.Testable;
import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;

@Testable
public class PrinterTest {
    Printer printer = new Printer();
    Basket basket = new Basket();
    Book a = new Book(1, "Title1", "Author1", "Genre1", "ISBN1", 100, 1);
    Book b = new Book(2, "Title2", "Author2", "Genre2", "ISBN2", 200, 2);
    Customer c = new Customer(5, "first name", "last name", "street", "zip", "city", "userName", "password");
    Order o1 = new Order(66, "first name1", "last name1", "street1", "zip1", "city1", "testBook1", 0, 100);
    Order o2 = new Order(67, "first name2", "last name2", "street2", "zip2", "city2", "testBook2", 1, 200);
    Order o3 = new Order(67, "first name2", "last name2", "street2", "zip2", "city2", "testBook3", 0, 100);
    ByteArrayOutputStream outContent = new ByteArrayOutputStream();
    List<Book> books = new ArrayList<>();
    List<Book> emptyBookList = new ArrayList<>();
    List<Customer> customers = new ArrayList<>();
    List<Customer> emptyCustomerList = new ArrayList<>();
    List<Order> orders1 = new ArrayList<>();
    List<Order> orders2 = new ArrayList<>();
    List<Order> emptyOrderList = new ArrayList<>();
    
    @BeforeEach
    public void init() {
        System.setOut(new PrintStream(outContent));
        books.clear();
        customers.clear();
        orders1.clear();
        orders2.clear();
        books.add(a);
        books.add(b);
        customers.add(c);
        orders1.add(o1);
        orders2.add(o2);
        orders2.add(o3);
    }

    @Test
    void printBooksWorks() {
        printer.printBooks(books);
        String expectedOutput = "\n\n\r\n"+
        String.format("%-30s %-20s %-17s %-15s %-8s %s %n%n", "Title", "Author", "Genre", "ISBN", "Price", "Status")+
        String.format("%-30s %-20s %-17s %-15s %-8s %s%n", "Title1", "Author1", "Genre1", "ISBN1", 100+":-", "Only one left")+
        String.format("%-30s %-20s %-17s %-15s %-8s %s", "Title2", "Author2", "Genre2", "ISBN2", 200+":-", "In stock")+"\r\n";
        assertEquals(expectedOutput, outContent.toString());
    }

    @Test
    void adminPrintEmptyBookWorks() {
        printer.adminPrintBooks(emptyBookList);
        String expectedOutput = "No result\r\n";
        assertEquals(expectedOutput, outContent.toString());
    }

    @Test
    void adminPrintEmptyCustomerWorks() {
        printer.adminPrintCustomers(emptyCustomerList);
        String expectedOutput = "\n\nCustomers\r\n\nNo result\r\n";
        assertEquals(expectedOutput, outContent.toString());
    }

    @Test
    void adminPrintCustomersWorks() {
        printer.adminPrintCustomers(customers);
        String expectedOutput = "\n\nCustomers\r\n"+
        String.format("%-5s %-15s %-15s %-25s %-10s %s %n%n", "ID", "First name", "Last name", "Street", "Zip", "City")+
        String.format("%-5d %-15s %-15s %-25s %-10s %s", 5, "first name", "last name", "street", "zip", "city")+"\r\n";
        assertEquals(expectedOutput, outContent.toString());
    }

    @Test
    void adminPrintEmptyOrderWorks() {
        printer.adminPrintOrders(emptyOrderList);
        String expectedOutput = "\n\nOrder History\r\n\nNo result\r\n";
        assertEquals(expectedOutput, outContent.toString());
    }

    @Test
    void adminPrintOrderWorks() {
        printer.adminPrintOrders(orders1);
        String expectedOutput = "\n\nOrder History\r\n"+
        String.format("%n%-8s %-12s %-12s %-25s %-8s %-12s %-25s %s%n", "Order", "First name", "Last name", "Street", "Zip", "City", "Title", "Price")+
        String.format("%n%-8d %-12s %-12s %-25s %-8s %-12s %-25s %d:-%n", 66, "first name1", "last name1", "street1", "zip1", "city1", "testBook1", 100)+
        String.format("%-100s %s %d:-%n", " ", "Total: ", 100)+
        "------------------------------------------------------------------------------------------------------------------\r\n";
        assertEquals(expectedOutput, outContent.toString());
    }

    @Test
    void adminPrintBackOrderWorks() {
        printer.adminPrintOrders(orders2);
        String expectedOutput = "\n\nOrder History\r\n"+
        String.format("%n%-8s %-12s %-12s %-25s %-8s %-12s %-25s %s%n", "Order", "First name", "Last name", "Street", "Zip", "City", "Title", "Price")+
        String.format("%n%-8d %-12s %-12s %-25s %-8s %-12s %-25s %d:-%n", 67, "first name2", "last name2", "street2", "zip2", "city2", "testBook2", 200)+
        String.format("%-82s %-25s %d:-%n", " ", "testBook3", 100)+
        String.format("%-100s %s %d:-%n", " ", "Total: ", 300)+
        String.format("%-5s %s%n", "Backorder:", "testBook2")+
        "------------------------------------------------------------------------------------------------------------------\r\n";
        assertEquals(expectedOutput, outContent.toString());
    }

    @Test
    void printBasketWorks() {
        printer.printBasket(basket, books);
        String expectedOutput = "\nBasket:"+
        String.format("%n%-30s %-20s %s %n", "Title", "Author", "Price")+
        String.format("%n%-30s %-20s %d:-","Title1", "Author1", 100)+
        String.format("%n%-30s %-20s %d:-%n","Title2", "Author2", 200)+
        "---------------------------------------------------------"+
        String.format("%n%-43s %s %d:-%n", "", "Total: ", 300);
        assertEquals(expectedOutput, outContent.toString());
    }

    @Test
    void getStatusWorks() {
        assertEquals("Out of stock", printer.getStatus(0));
        assertEquals("Only one left", printer.getStatus(1));
        assertEquals("In stock", printer.getStatus(2));
    }
}
