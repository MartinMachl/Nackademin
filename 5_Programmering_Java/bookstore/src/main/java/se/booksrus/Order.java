package se.booksrus;

public class Order {
    private int number;
    private String firstName;
    private String lastName;
    private String street;
    private String zip;
    private String city;
    private String title;
    private int backorder;
    private int price;

    public Order(int number, String firstName, String lastName, String street, String zip, String city, String title, int backorder, int price) {
        this.number = number;
        this.firstName = firstName;
        this.lastName = lastName;
        this.street = street;
        this.zip = zip;
        this.city = city;
        this.title = title;
        this.backorder = backorder;
        this.price = price;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    int getNumber() {
        return number;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    String getFirstName() {
        return firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    String getLastName() {
        return lastName;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    String getStreet() {
        return street;
    }

    public void setZip(String zip) {
        this.zip = zip;
    }

    String getZip() {
        return zip;
    }

    public void setCity(String city) {
        this.city = city;
    }

    String getCity() {
        return city;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    String getTitle() {
        return title;
    }

    public void setBackorder(int backorder) {
        this.backorder = backorder;
    }

    int getBackorder() {
        return backorder;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    int getPrice() {
        return price;
    }
}
