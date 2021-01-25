package se.booksrus;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

class JDBCSQLUtils {
    String hostname = "localhost";
    String userName = "username";
    String password = "password";
    String database = "BookLibrary";

    JDBCSQLUtils(String hostname) {
        this.hostname = hostname;
    }

    public void setUsername(String userName) {
        this.userName = userName;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    // Update book quantity minus one in table Books when purchase is completed
    public void updateBook(Connection conn, int bookId) throws SQLException {
        String createString = "update Books set BookQuantity = BookQuantity - 1 where BookID = "+bookId+"";
        
        try (Statement stmt = conn.createStatement()) {
          stmt.executeUpdate(createString);
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    // Returns last inserted order number for incrementation
    public int getOrderNum(Connection conn) throws SQLException {
        int number = 1;
        ResultSet rs = null;
        String createString = "SELECT OrderNum FROM OrderNumbers";
        
        try (Statement stmt = conn.createStatement()) {
          rs = stmt.executeQuery(createString);
            while (rs.next()) {
                number = rs.getInt("OrderNum");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return number;
    }

    // Returns customer object if user name matches existing customer
    // If no match is found a default customer is retured for input handeling
    List<Customer> getCustomerLogin(Connection conn) throws SQLException {
        ResultSet rs = null;
        List<Customer> customers = new ArrayList<>();
        String createString = "SELECT CustomerID, UserName, Password FROM Customers";
        
        try (Statement stmt = conn.createStatement()) {
            rs = stmt.executeQuery(createString);
              while (rs.next()) {
                int id = rs.getInt("CustomerID");
                String userName = rs.getString("UserName");
                String password = rs.getString("Password");

                Customer customer = new Customer(id, "null", "null", "null", "null", "null", userName, password);
                customers.add(customer);
              }
          } catch (SQLException e) {
              System.out.println(e);
          }
        return customers;
    }

    // returns ineger id of customer with matching user name and password
    int getCustomerId(Connection conn, String userName, String password) throws SQLException {
        int id = 0;
        ResultSet rs = null;
        String createString = "SELECT CustomerID FROM Customers WHERE UserName = '"+userName+"' AND Password = '"+password+"'";
        
        try (Statement stmt = conn.createStatement()) {
            rs = stmt.executeQuery(createString);
              while (rs.next()) {
                  id = rs.getInt("CustomerID");
              }
          } catch (SQLException e) {
              System.out.println(e);
          }
        return id;
    }

    // inserts into table Customers when new customer is created with new id
    public void insertCustomer(Connection conn, String firstName, String lastName, String street, String zip, String city, String userName, String password) throws SQLException {
        String createString = "INSERT INTO Customers (FirstName, LastName, Street, Zip, City, UserName, Password) VALUES "+
                            "('"+firstName+"', '"+lastName+"', '"+street+"', '"+zip+"', '"+city+"', '"+userName+"', '"+password+"')";

        try (Statement stmt = conn.createStatement()) {
          stmt.executeUpdate(createString);
          System.out.println("\nYou have been added to system");
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    // inserts into table OrderNumbers to update order numbers automaticly
    public void insertOrderNumber(Connection conn, int orderNum) throws SQLException {
        String createString = "INSERT INTO OrderNumbers (OrderNum) VALUES ("+orderNum+")";

        try (Statement stmt = conn.createStatement()) {
          stmt.executeUpdate(createString);
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    // inserts into table Orders
    public void insertOrder(Connection conn, int orderNum, int id, int bookId) throws SQLException {
        String createString = "INSERT INTO Orders (OrderID, CustomerID, BookID) VALUES ((SELECT OrderID FROM OrderNumbers WHERE OrderNum = "+orderNum+"), "+
                            "(SELECT CustomerID FROM Customers WHERE CustomerID = "+id+"), (SELECT BookID FROM Books WHERE BookID = "+bookId+"))";

        try (Statement stmt = conn.createStatement()) {
          stmt.executeUpdate(createString);
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    // inserts into table BackOrders
    public void insertBackOrder(Connection conn, int orderNum, int id, int bookId) throws SQLException {
        String createString = "INSERT INTO BackOrders (OrderID, CustomerID, BookID) VALUES ((SELECT OrderID FROM OrderNumbers WHERE OrderNum = "+orderNum+"), "+
                            "(SELECT CustomerID FROM Customers WHERE CustomerID = "+id+"), (SELECT BookID FROM Books WHERE BookID = "+bookId+"))";

        try (Statement stmt = conn.createStatement()) {
          stmt.executeUpdate(createString);
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    // inserts into table WishList
    public void insertWish(Connection conn, String aTitle, String email) throws SQLException {
        String createString = "INSERT INTO WishList (BookTitle, Email) VALUES ('"+aTitle+"', '"+email+"')";

        try (Statement stmt = conn.createStatement()) {
            stmt.executeUpdate(createString);
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    // Returns a list with all book objects with partly matching title in table Books
    List<Book> selectTitle(Connection conn, String aTitle) throws SQLException {
        ResultSet rs = null;
        List<Book> books = new ArrayList<>();
        String createString = "select * from Books where BookTitle like '%" + aTitle + "%' order by BookTitle, BookGenre";
        try (Statement stmt = conn.createStatement()) {

            rs = stmt.executeQuery(createString);
            
            while (rs.next()) {
                int id = rs.getInt("BookID");
                String title = rs.getString("BookTitle");
                String author = rs.getString("BookAuthor");
                String genre = rs.getString("BookGenre");
                String isbn = rs.getString("BookISBN");
                int price = rs.getInt("BookPrice");
                int num = rs.getInt("BookQuantity");

                Book book = new Book(id, title, author, genre, isbn, price, num);
                books.add(book);
            }
        } catch (SQLException e) {
              System.out.println(e);
        }
        return books;
    }

    // Returns a list with all book objects with partly matching author in table Books
    List<Book> selectAuthor(Connection conn, String anAuthor) throws SQLException {
        ResultSet rs = null;
        List<Book> books = new ArrayList<>();
        String createString = "select * from Books where BookAuthor like '%" + anAuthor + "%' order by BookAuthor, BookTitle";
        try (Statement stmt = conn.createStatement()) {

            rs = stmt.executeQuery(createString);
            
            while (rs.next()) {
                int id = rs.getInt("BookID");
                String title = rs.getString("BookTitle");
                String author = rs.getString("BookAuthor");
                String genre = rs.getString("BookGenre");
                String isbn = rs.getString("BookISBN");
                int price = rs.getInt("BookPrice");
                int num = rs.getInt("BookQuantity");

                Book book = new Book(id, title, author, genre, isbn, price, num);
                books.add(book);
            }
        } catch (SQLException e) {
              System.out.println(e);
        }
        return books;
    }

    // Returns a list with all book objects with partly matching isbn in table Books
    List<Book> selectIsbn(Connection conn, String anIsbn) throws SQLException {
        ResultSet rs = null;
        List<Book> books = new ArrayList<>();
        String createString = "select * from Books where BookISBN like '" + anIsbn + "%' order by BookISBN, BookTitle";
        try (Statement stmt = conn.createStatement()) {

            rs = stmt.executeQuery(createString);
            
            while (rs.next()) {
                int id = rs.getInt("BookID");
                String title = rs.getString("BookTitle");
                String author = rs.getString("BookAuthor");
                String genre = rs.getString("BookGenre");
                String isbn = rs.getString("BookISBN");
                int price = rs.getInt("BookPrice");
                int num = rs.getInt("BookQuantity");

                Book book = new Book(id, title, author, genre, isbn, price, num);
                books.add(book);
            }
        } catch (SQLException e) {
              System.out.println(e);
        }
        return books;
    }

    // Returns a list with all book objects with partly matching genre in table Books
    List<Book> selectGenre(Connection conn, String aGenre) throws SQLException {
        ResultSet rs = null;
        List<Book> books = new ArrayList<>();
        String createString = "select * from Books where BookGenre like '%" + aGenre + "%' order by BookGenre, BookTitle";
        try (Statement stmt = conn.createStatement()) {

            rs = stmt.executeQuery(createString);
            
            while (rs.next()) {
                int id = rs.getInt("BookID");
                String title = rs.getString("BookTitle");
                String author = rs.getString("BookAuthor");
                String genre = rs.getString("BookGenre");
                String isbn = rs.getString("BookISBN");
                int price = rs.getInt("BookPrice");
                int num = rs.getInt("BookQuantity");

                Book book = new Book(id, title, author, genre, isbn, price, num);
                books.add(book);
            }
        } catch (SQLException e) {
              System.out.println(e);
        }
        return books;
    }

    // Returns a list with all book objects in table Books
    List<Book> selectAll(Connection conn) throws SQLException {
        ResultSet rs = null;
        List<Book> books = new ArrayList<>();
        String createString = "SELECT * FROM Books order by BookTitle";
        try (Statement stmt = conn.createStatement()) {

            rs = stmt.executeQuery(createString);
            
            while (rs.next()) {
                int id = rs.getInt("BookID");
                String title = rs.getString("BookTitle");
                String author = rs.getString("BookAuthor");
                String genre = rs.getString("BookGenre");
                String isbn = rs.getString("BookISBN");
                int price = rs.getInt("BookPrice");
                int num = rs.getInt("BookQuantity");

                Book book = new Book(id, title, author, genre, isbn, price, num);
                books.add(book);
            }
        } catch (SQLException e) {
              System.out.println(e);
        }
        return books;
    }

    // Returns a list with all customer objects in table Customers
    List<Customer> adminShowCustomers(Connection conn) throws SQLException {
        ResultSet rs = null;
        List<Customer> customers = new ArrayList<>();
        String createString = "SELECT CustomerID, FirstName, LastName, Street, Zip, City FROM Customers order by CustomerID";
        try (Statement stmt = conn.createStatement()) {

            rs = stmt.executeQuery(createString);
            while (rs.next()) {
                int id = rs.getInt("CustomerID");
                String firstName = rs.getString("FirstName");
                String lastName = rs.getString("LastName");
                String street = rs.getString("Street");
                String zip = rs.getString("Zip");
                String city = rs.getString("City");

                Customer customer = new Customer(id, firstName, lastName, street, zip, city, "secret", "secret");
                customers.add(customer);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return customers;
    }

    // Returns a list with all book objects in table WishList
    List<Book> adminShowWishes(Connection conn) throws SQLException {
        ResultSet rs = null;
        List<Book> books = new ArrayList<>();
        String createString = "SELECT BookTitle, Email FROM WishList";
        try (Statement stmt = conn.createStatement()) {

            rs = stmt.executeQuery(createString);
            while (rs.next()) {
                String title = rs.getString("BookTitle");
                String email = rs.getString("Email");

                Book book = new Book(0, title, email, "null", "null", 0, 0);
                books.add(book);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return books;
    }

    // Returns a list with all order objects in table Orders
    List<Order> adminShowOrders(Connection conn) throws SQLException {
        ResultSet rs = null;
        List<Order> orders = new ArrayList<>();
        String createString = "SELECT O.OrderNum, C.FirstName, C.LastName, C.Street, C.Zip, C.City, B.BookTitle, B.BookPrice "+
                            "FROM OrderNumbers as O INNER JOIN Orders as O2 ON O.OrderID = O2.OrderID INNER JOIN Customers as C "+
                            "ON C.CustomerID = O2.CustomerID INNER JOIN Books as B ON O2.BookID = B.BookID order by O2.OrderID";
        try (Statement stmt = conn.createStatement()) {

            rs = stmt.executeQuery(createString);
            while (rs.next()) {
                int num = rs.getInt("OrderNum");
                String firstName = rs.getString("FirstName");
                String lastName = rs.getString("LastName");
                String street = rs.getString("Street");
                String zip = rs.getString("Zip");
                String city = rs.getString("City");
                String title = rs.getString("BookTitle");
                int backorder = 0;
                int price = rs.getInt("BookPrice");

                Order order = new Order(num, firstName, lastName, street, zip, city, title, backorder, price);
                orders.add(order);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return orders;
    }

    // Returns a list with all order objects in table BackOrders
    List<Order> adminShowBackOrders(Connection conn) throws SQLException {
        ResultSet rs = null;
        List<Order> orders = new ArrayList<>();
        String createString = "SELECT O.OrderNum, C.FirstName, C.LastName, C.Street, C.Zip, C.City, B.BookTitle, B.BookPrice "+
                            "FROM OrderNumbers as O INNER JOIN BackOrders as BO ON O.OrderID = BO.OrderID "+
                            "INNER JOIN Customers as C ON C.CustomerID = BO.customerID INNER JOIN Books as B "+
                            "ON BO.BookID = B.BookID order by BO.OrderID";
        try (Statement stmt = conn.createStatement()) {

            rs = stmt.executeQuery(createString);
            while (rs.next()) {
                int num = rs.getInt("OrderNum");
                String firstName = rs.getString("FirstName");
                String lastName = rs.getString("LastName");
                String street = rs.getString("Street");
                String zip = rs.getString("Zip");
                String city = rs.getString("City");
                String title = rs.getString("BookTitle");
                int backorder = 1;
                int price = rs.getInt("BookPrice");

                Order order = new Order(num, firstName, lastName, street, zip, city, title, backorder, price);
                orders.add(order);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return orders;
    }

    public Connection getConnection() throws SQLException {
        Connection conn = null;
        conn = DriverManager.getConnection("jdbc:sqlserver://" + this.hostname + ";databaseName=" + this.database + ";user=" + this.userName + ";password=" + this.password);
        return conn;
    }
}
