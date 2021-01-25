package se.booksrus;

import java.sql.SQLException;
import java.sql.Connection;
import java.util.List;
import java.util.ArrayList;
import java.util.Scanner;

public class App {
    
    public static void main(String[] args) throws SQLException {
        App app = new App();
        app.mainMeny();
    }

    public void mainMeny() throws SQLException {
        // Start needed classes and get connection
        String data;
        Printer printer = new Printer();
        Basket basket = new Basket();
        List<Book> books = new ArrayList<>();
        JDBCSQLUtils sql = new JDBCSQLUtils("localhost");
        sql.setUsername("guest");
        sql.setPassword("85seCpaSS21");
        Connection conn = sql.getConnection();
        // Start scanner and list meny options
        try (Scanner input = new Scanner(System.in)) {
            printer.printTitle();
            do {           
                System.out.println("\n-----    MENU    -----");
                System.out.println(
                        "1. List all books\n"+
                        "2. Search for book\n"+ // search meny
                        "3. View basket\n"+ // basket meny
                        "4. Log in as admin\n"+ // admin check
                        "9. Exit shop\n");
                System.out.print("Input: ");
                data = input.next();

                if (data.equals("1")) {
                    // Get list of book objects that exists in database
                    List<Book> workList = sql.selectAll(conn);
                    // Send list to printer
                    printer.printBooks(workList);
                                
                } else if (data.equals("2")) {
                    searchMeny(input, sql, conn, printer);

                } else if (data.equals("3")) {
                    basketMeny(input, sql, conn, basket, printer, books);

                } else if (data.equals("4")) {
                    adminTest(input, printer);

                } else if (data.equals("9")) {
                    System.out.println("Welcome back!");

                } else {
                    System.out.println("No matching command");
                }
            } while (!"9".equalsIgnoreCase(data));
        } 
    }

    public void adminMeny(Scanner input, Printer printer) throws SQLException {
        String data;
        JDBCSQLUtils sqladmin = new JDBCSQLUtils("localhost");
        sqladmin.setUsername("bookadm");
        sqladmin.setPassword("2021BookADM1985");
        Connection conn2 = sqladmin.getConnection();
        do {
            System.out.println("\n-----    ADMIN    -----");
            System.out.println(
                    "1. List all books\n"+
                    "2. List customers\n"+ 
                    "3. List orders\n"+
                    "4. List book requests\n"+
                    "9. Return\n");
            System.out.print("Input: ");
            data = input.next();

            if (data.equals("1")) {
                // Get list of book objects that exists in database
                List<Book> workList = sqladmin.selectAll(conn2);
                // Send list to printer
                printer.adminPrintBooks(workList);
                          
            } else if (data.equals("2")) {
                // Get list of customer objects that exists in database
                List<Customer> customerList = sqladmin.adminShowCustomers(conn2);
                // Send list to printer
                printer.adminPrintCustomers(customerList);

            } else if (data.equals("3")) {
                // Get lists of order objects that exists in database
                List<Order> orderList = sqladmin.adminShowOrders(conn2);
                List<Order> backOrderList = sqladmin.adminShowBackOrders(conn2);
                // Send lists to printer for sorting and printing
                List<Order> orders = printer.sortOrders(orderList, backOrderList);
                printer.adminPrintOrders(orders);

            } else if (data.equals("4")) {
                // Get lists of book objects that exists in database table over wishes
                List<Book> wishes = sqladmin.adminShowWishes(conn2);
                // Send lists to printer for printing
                printer.adminPrintWishes(wishes);

            } else if (data.equals("9")) {
                System.out.println("Returning");

            } else {
                System.out.println("No matching command");
            }
        } while (!"9".equalsIgnoreCase(data));
    }

    public void searchMeny(Scanner input, JDBCSQLUtils sql, Connection conn, Printer printer) throws SQLException {
        String data;
        String word;
        do {
            System.out.println("\n------   SEARCH   ------");
            System.out.println(
                    "1. Search for book by title\n"+
                    "2. Search for book by author\n"+
                    "3. Search for book by genre\n"+
                    "4. Search for book by isbn\n"+
                    "5. Send request for book\n"+
                    "9. Return\n");
            System.out.print("Input: ");
            data = input.next();
            word = input.nextLine();

            if (data.equals("1")) {
                System.out.print("Enter title: ");
                word = input.nextLine().toLowerCase();
                // Get list of book objects with partly matching title that exists in the database
                List<Book> workList = sql.selectTitle(conn, word);
                // send list to printer
                printer.printBooks(workList);
                            
            } else if (data.equals("2")) {
                System.out.print("Enter author: ");
                word = input.nextLine().toLowerCase();
                // Get list of book objects with partly matching author that exists in the database
                List<Book> workList = sql.selectAuthor(conn, word);
                // send list to printer
                printer.printBooks(workList);

            } else if (data.equals("3")) {
                System.out.print("Enter genre: ");
                word = input.nextLine().toLowerCase();
                // Get list of book objects with partly matching genre that exists in the database
                List<Book> workList = sql.selectGenre(conn, word);
                // send list to printer
                printer.printBooks(workList);

            } else if (data.equals("4")) {
                System.out.print("Enter ISBN: ");
                word = input.nextLine().toLowerCase();
                // Get list of book objects with partly matching ISBN that exists in the database
                List<Book> workList = sql.selectIsbn(conn, word);
                // send list to printer
                printer.printBooks(workList);

            } else if (data.equals("5")) {
                System.out.print("Enter title: ");
                word = capitalizeWord(input.nextLine().toLowerCase());
                System.out.print("Enter email: ");
                String email = input.nextLine().toLowerCase();
                // Send title and customer email to database with book request
                sql.insertWish(conn, word, email);
                System.out.println("\nRequest sent");                

            } else if (data.equals("9")) {
                System.out.println("Returning\n");

            } else {
                System.out.println("No matching command");
            }
        } while (!"9".equalsIgnoreCase(data));
    }

    public void basketMeny(Scanner input, JDBCSQLUtils sql, Connection conn, Basket basket, Printer printer, List<Book> books) throws SQLException {
        String data;
        String word;
        do {
            System.out.println("\n------   Basket   ------");
            System.out.println(
                    "1. Show basket\n"+
                    "2. Add book to basket\n"+
                    "3. Remove book from basket\n"+
                    "4. Finish order\n"+ // finish order meny
                    "9. Return\n");
            System.out.print("Input: ");
            data = input.next();
            word = input.nextLine();

            if (data.equals("1")) {
                printer.printBasket(basket, books);
                            
            } else if (data.equals("2")) {
                System.out.print("Enter title: ");
                word = input.nextLine().toLowerCase();
                // Get list with book objects that partly match entered title
                List<Book> workList = sql.selectTitle(conn, word);
                // Send list to method to check if book is in stock
                // If list is empty (no title matched enterd word) method prints message
                checkAvailability(basket, input, workList, books);

            } else if (data.equals("3")) {
                if (books.isEmpty()) {
                    System.out.println("\nBasket is empty");
                } else {
                    System.out.print("Enter title: ");
                    word = input.nextLine().toLowerCase();
                    basket.removeFromBasket(books, word);
                }

            } else if (data.equals("4")) {
                if (books.isEmpty()) {
                    System.out.println("\nBasket is empty");
                } else {
                    finishOrderMeny(input, sql, conn, basket, printer, books);
                    data = "9";
                }

            } else if (data.equals("9")) {
                System.out.println("Returning\n");

            } else {
                System.out.println("No matching command");
            }
        } while (!"9".equalsIgnoreCase(data));
    }

    public void finishOrderMeny(Scanner input, JDBCSQLUtils sql, Connection conn, Basket basket, Printer printer, List<Book> books) throws SQLException {
        String data;
        do {
            System.out.println("\n----- Finish order -----");
            System.out.println(
                    "1. Log in\n"+
                    "2. Create new customer\n"+
                    "9. Return\n");
            System.out.print("Input: ");
            data = input.nextLine();

            if (data.equals("1")) {
                List<Customer> customers = sql.getCustomerLogin(conn);
                userCheck(sql, conn, input, printer, basket, customers, books);
                data = "9";
                
            } else if (data.equals("2")) {
                createUser(sql, conn, input, printer, basket, books);
                // force return
                data = "9";

            } else if (data.equals("9")) {
                System.out.println("Returning\n");

            } else {
                System.out.println("No matching command");
            }
        } while (!"9".equalsIgnoreCase(data));
    }

    public void createUser(JDBCSQLUtils sql, Connection conn, Scanner input, Printer printer, Basket basket, List<Book> books) throws SQLException {
        printer.printBasket(basket, books);
        System.out.print("Enter first name: ");
        String firstName = capitalizeWord(input.nextLine().toLowerCase());
        System.out.print("Enter last name: ");
        String lastName = capitalizeWord(input.nextLine().toLowerCase());
        System.out.print("Enter street: ");
        String street = capitalizeWord(input.nextLine().toLowerCase());
        System.out.print("Enter zip: ");
        String zip = capitalizeWord(input.nextLine().toLowerCase());
        System.out.print("Enter city: ");
        String city = capitalizeWord(input.nextLine().toLowerCase());
        System.out.print("Enter user name: ");
        String userName= input.nextLine();
        System.out.print("Enter password: ");
        String password = input.nextLine();
        // create new customer
        sql.insertCustomer(conn, firstName, lastName, street, zip, city, userName, password);
        // get id from created customer
        int id = sql.getCustomerId(conn, userName, password);
        // Get last used ordernumber and add 1
        int orderNum = sql.getOrderNum(conn)+1;
        // Order number gets added to table with order numbers
        sql.insertOrderNumber(conn, orderNum);
        // Tables with books, orders and backorders are updated with all data and a total amount is returned
        int total = finishOrder(sql, conn, books, orderNum, id);
        // empty list of books
        books.clear();
        System.out.println("\nOrder completed! You will be billed: "+total+":-");
    }

    public void finishCheckedCustomer(JDBCSQLUtils sql, Connection conn, Scanner input, Basket basket, List<Book> books, Customer customer) throws SQLException {
        // Get last used ordernumber and add 1
        int orderNum = sql.getOrderNum(conn)+1;
        int id = customer.getID();
        // Order number gets added to table with order numbers
        sql.insertOrderNumber(conn, orderNum);
        // Tables with books, orders and backorders are updated with all data and a total amount is returned
        int total = finishOrder(sql, conn, books, orderNum, id);
        // empty list of books
        books.clear();
        System.out.println("\nOrder completed! You will be billed: "+total+":-");
        
    }

    int finishOrder(JDBCSQLUtils sql, Connection conn, List<Book> books, int orderNum, int id) throws SQLException {
        int total = 0;
        for (Book book : books) {
            if (book.getQuantity() < 1) {
                // Books that are out of stock gets added to table with backorders
                sql.insertBackOrder(conn, orderNum, id, book.getID());
            } else {
                // Books that are in stock gets added to table with orders
                sql.insertOrder(conn, orderNum, id, book.getID());
            }
            // Table with book quantity is updated to one less
            sql.updateBook(conn, book.getID());
            total = total + book.getPrice();
        }
        return total;
    }

    public void checkAvailability(Basket basket, Scanner input, List<Book> workList, List<Book> books) {
        // check if book is in stock
        System.out.println();
        boolean answer = false;
        if (workList.isEmpty()) {
            System.out.println("No matching book to add");
        } else {
            for (Book book : workList) {
                // if book is out of stock you get option to order book on backorder
                if (book.getQuantity() < 1) {
                    System.out.println("\""+book.getTitle()+"\" is out of stock");
                    String data;
                    while (answer == false) {
                        System.out.print("Do you want to add it to backorder? (y/n): ");
                        data = input.nextLine().toLowerCase();
                        // if answer is y the book is added to basket
                        if (data.equalsIgnoreCase("y")) {
                            System.out.println();
                            basket.addToBasket(books, book);
                            answer = true;
                        }
                        // if answer is n the book is not sent basket
                        else if (data.equalsIgnoreCase("n")) {
                            answer = true;
                        }
                    }
                } else {
                    basket.addToBasket(books, book);
                }
            }
        }
    }

    public void userCheck(JDBCSQLUtils sql, Connection conn, Scanner input, Printer printer, Basket basket, List<Customer> customers, List<Book> books) throws SQLException {
        // Three tries to enter or returned to previous meny
        printer.printBasket(basket, books);
        for (int i = 0; i < 3; ++i) { 
            System.out.print("Enter user name: ");
            String userName = input.nextLine();
            List<Customer> client = testUserName(customers, userName);
            if (client.isEmpty()) {
                System.out.println("Wrong user name");
            } else {
                Customer customer = getCustomer(client);
                // Three tries to enter password or returned to previous meny
                for (int x = 0; x < 3; ++x) {
                    System.out.print("Enter password: ");
                    String password = input.nextLine();
                    if (!testPassword(password, customer.getPassword())) {
                        System.out.println("Wrong password");
                    }
                    else {
                        finishCheckedCustomer(sql, conn, input, basket, books, customer);
                        break;
                    }
                }
                break;
            }
        }
    }

    List<Customer> testUserName(List<Customer> customers, String userName) {
        List<Customer> client = new ArrayList<>();
        for (Customer customer : customers) {
            if (userName.equals(customer.getUserName())) {
                client.add(customer);
                break;
            }
        }
        return client;
    }
    
    Customer getCustomer(List<Customer> client) {
        Customer customer = client.get(0);
        return customer;
    }

    public void adminTest(Scanner input, Printer printer) throws SQLException {
        String password;
        password = input.nextLine();
        // Three tries to enter admin meny or returned to main meny
        for (int i = 0; i < 3; ++i) { 
            System.out.print("Enter password: ");
            password = input.nextLine();
            if (testPassword(password, "2021BookADM1985")) {
                adminMeny(input, printer);
                break;
            } else {
                System.out.println("Wrong password");
            }
        } 
    }

    boolean testPassword(String input, String password) {
        if (input.equals(password)) {
            return true;
        } else {
            return false;
        }
    }
    
    String capitalizeWord(String str) {
        String words[] = str.split("\\s");
        String capitalizeWord = "";
        for (String w : words) {
            String first = w.substring(0, 1);
            String afterfirst = w.substring(1);
            capitalizeWord += first.toUpperCase() + afterfirst + " ";
        }
        return capitalizeWord.trim();
    }
}
