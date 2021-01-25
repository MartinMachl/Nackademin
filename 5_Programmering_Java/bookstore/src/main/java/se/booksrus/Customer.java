package se.booksrus;

public class Customer {
    private int ID;
    private String firstName;
    private String lastName;
    private String street;
    private String zip;
    private String city;
    private String userName;
    private String password;

    public Customer(int ID, String firstName, String lastName, String street, String zip, String city, String userName, String password) {
        this.ID = ID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.street = street;
        this.zip = zip;
        this.city = city;
        this.userName = userName;
        this.password = password;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    int getID() {
        return ID;
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

    public void setUserName(String userName) {
        this.userName = userName;
    }

    String getUserName() {
        return userName;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    String getPassword() {
        return password;
    }
}