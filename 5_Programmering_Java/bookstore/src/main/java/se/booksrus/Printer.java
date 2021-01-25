package se.booksrus;

import java.util.ArrayList;
import java.util.List;

public class Printer {

    public void printTitle() {
        System.out.println("\n----------------------");
        System.out.println(String.format("%-20s %s","|","|"));
        System.out.println(String.format("%-5s %-14s %s","|","Books'R'us","|"));
        System.out.println(String.format("%-20s %s","|","|"));
        System.out.println("----------------------");
    }

    // takes a list of book objects and prints to terminal
    // if list is empty "No search result" is printed
    public void printBooks(List<Book> books) {
        System.out.println("\n\n");
        if (books.isEmpty()) {
            System.out.println("No search result");
        } else {
            System.out.println(String.format("%-30s %-20s %-17s %-15s %-8s %s %n", "Title", "Author", "Genre", "ISBN", "Price", "Status"));
            books.stream().forEach(book -> System.out.println(String.format("%-30s %-20s %-17s %-15s %-8s %s", 
                    book.getTitle(), book.getAuthor(), book.getGenre(), book.getIsbn(), book.getPrice()+":-", getStatus(book.getQuantity()))));
        }
    }

    // takes a list of book objects and prints to terminal
    // if list is empty "No result" is printed
    public void adminPrintBooks(List<Book> books) {
        if (books.isEmpty()) {
            System.out.println("No result");
        } else {
            System.out.println(String.format("%n%-5s %-30s %-20s %-17s %-15s %-8s %s %n", "ID", "Title", "Author", "Genre", "ISBN", "Price", "Quantity"));
            books.stream().forEach(book -> System.out.println(String.format("%-5d %-30s %-20s %-17s %-15s %-8s %d", 
                        book.getID(), book.getTitle(), book.getAuthor(), book.getGenre(), book.getIsbn(), book.getPrice()+":-", book.getQuantity())));
        }
    }

    // takes a list of customer objects and prints to terminal
    // if list is empty "No result" is printed
    public void adminPrintCustomers(List<Customer> customers) {
        System.out.println("\n\nCustomers");
        if (customers.isEmpty()) {
            System.out.println("\nNo result");
        } else {
            System.out.println(String.format("%-5s %-15s %-15s %-25s %-10s %s %n", "ID", "First name", "Last name", "Street", "Zip", "City"));
            customers.stream().forEach(customer -> System.out.println(String.format("%-5d %-15s %-15s %-25s %-10s %s", 
                        customer.getID(), customer.getFirstName(), customer.getLastName(), customer.getStreet(), customer.getZip(), customer.getCity())));
        }
    }

    // takes a list of book objects and prints to terminal
    // if list is empty "No result" is printed
    public void adminPrintWishes(List<Book> wishes) {
        System.out.println("\n\nBook requests");
        if (wishes.isEmpty()) {
            System.out.println("\nNo result");
        } else {
            System.out.println(String.format("%n%-35s %s %n", "Title", "E-Mail"));
            wishes.stream().forEach(book -> System.out.println(String.format("%-35s %s %n", book.getTitle(), book.getAuthor())));
        }
    }
    
    // takes two lists of order objects and adds all in backorders to orders
    // then the list orders is sorted by order number and returned
    List<Order> sortOrders(List<Order> orders, List<Order> backOrders) {
        for (Order order : backOrders) {
            orders.add(order);
        }
        orders.sort((o1, o2) -> Integer.compare((o1).getNumber(), (o2).getNumber()));
        return orders;
    }

    // takes sorted list of all orders and prints in various steps
    // handle for empty list
    public void adminPrintOrders(List<Order> orders) {
        int orderNum = 1;
        int rested = 0;
        int backorder = 0;
        String title = "";
        List<String> backorders = new ArrayList<>();
        boolean newBook = true;
        int total = 0;
        System.out.println("\n\nOrder History");
        if (orders.isEmpty()) {
            System.out.println("\nNo result");
        } else {
            System.out.println(String.format("%n%-8s %-12s %-12s %-25s %-8s %-12s %-25s %s", "Order", "First name", "Last name", "Street", "Zip", "City", "Title", "Price"));
            // iterate over list of orders
            for (Order order : orders){
                // this step will always be skipped the first iteration
                // this is the last print every order but the last that does not have a backorder
                if (orderNum != order.getNumber() && newBook == false && backorder == 0) {
                    System.out.println(String.format("%-100s %s %d:-", " ", "Total: ", total));
                    System.out.println("------------------------------------------------------------------------------------------------------------------");
                    total = 0;
                    newBook = true;
                }
                // this step will always be skipped the first iteration
                // this is the last print every order but the last that has a backorder
                else if (orderNum != order.getNumber() && newBook == false && backorder > 0) {
                    System.out.println(String.format("%-100s %s %d:-", " ", "Total: ", total));
                    for (String bookTitle : backorders) {
                        System.out.println(String.format("%-5s %s", "Backorder:", bookTitle));
                    }
                    System.out.println("------------------------------------------------------------------------------------------------------------------");
                    total = 0;
                    backorder = 0;
                    backorders.clear();
                    newBook = true;
                }
                // this is the first print in the series and the first print of every new order number
                if (orderNum != order.getNumber() && newBook == true) { 
                    System.out.println(String.format("%n%-8d %-12s %-12s %-25s %-8s %-12s %-25s %d:-", 
                    order.getNumber(), order.getFirstName(), order.getLastName(), order.getStreet(), order.getZip(), order.getCity(), order.getTitle(), order.getPrice()));
                    orderNum = order.getNumber();
                    total = total + order.getPrice();
                    rested = order.getBackorder();
                    if (rested == 1) {
                        title = order.getTitle();
                        backorders.add(title);
                    }
                    backorder = backorder + rested;
                    newBook = false;
                } else {
                    // this is the print of the next object if the ordernumber is not new since last iteration (same order)
                    System.out.println(String.format("%-82s %-25s %d:-", " ", order.getTitle(), order.getPrice()));
                    total = total + order.getPrice();
                    rested = order.getBackorder();
                    if (rested == 1) {
                        title = order.getTitle();
                        backorders.add(title);
                    }
                    backorder = backorder + rested;
                }
            }
            if (backorder == 0) {
                // this is the last print of the last order if it does not have a backorder
                System.out.println(String.format("%-100s %s %d:-", " ", "Total: ", total));
                System.out.println("------------------------------------------------------------------------------------------------------------------");
            } else {
                // this is the last print of the last order if it has a backorder
                System.out.println(String.format("%-100s %s %d:-", " ", "Total: ", total));
                    for (String bookTitle : backorders) {
                        System.out.println(String.format("%-5s %s", "Backorder:", bookTitle));
                    }
                    System.out.println("------------------------------------------------------------------------------------------------------------------");
            }
        }
    }

    // takes a list of books, calculate the total in basket class and prints to terminal
    public void printBasket(Basket basket, List<Book> books) {
        System.out.println("\nBasket:");
        System.out.println(String.format("%-30s %-20s %s %n", "Title", "Author", "Price"));
        // Loop over the list and print all objects
        books.stream().forEach(book -> System.out.println(String.format("%-30s %-20s %d:-",book.getTitle(), book.getAuthor(), book.getPrice())));
        System.out.println("---------------------------------------------------------");
        System.out.println(String.format("%-43s %s %d:-", "", "Total: ", basket.getTotal(books)));
    }
    
    // takes an integer and returns a string message for customer print method
    String getStatus(int num) {
        String message = "";
        if (num < 1) {
              message = "Out of stock";
        }
        else if (num == 1) {
            message = "Only one left";
        } else {
            message = "In stock";
        }
        return message;
    }
}
