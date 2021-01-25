package se.booksrus;

public class Book {
    private int ID;
    private String title;
    private String author;
    private String genre;
    private String isbn;
    private int price;
    private int quantity;

    public Book(int ID, String title, String author, String genre, String isbn, int price, int quantity) {
        this.ID = ID;
        this.title = title;
        this.author = author;
        this.genre = genre;
        this.isbn = isbn;
        this.price = price;
        this.quantity = quantity;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    int getID() {
        return ID;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    String getTitle() {
        return title;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    String getAuthor() {
        return author;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    String getGenre() {
        return genre;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    String getIsbn() {
        return isbn;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    int getPrice() {
        return price;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    int getQuantity() {
        return quantity;
    }
}
