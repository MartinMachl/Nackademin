package se.booksrus;

import java.util.List;

public class Basket {
    
    public void removeFromBasket(List<Book> books, String title) {
        int i = 0;
        if (title.equalsIgnoreCase("")) {
            System.out.println("\nNo book chosen");
        } else {
            if (!books.isEmpty()) {
                for (Book book : books) {
                    if (book.getTitle().equalsIgnoreCase(title)) {
                        books.remove(books.indexOf(book));
                        System.out.println("\nBook: \""+book.getTitle()+"\" removed from basket");
                        i = 1;
                        break;                                                
                    }
                }
                if (i == 0) {
                    System.out.println("\n\""+title+"\" not in basket");
                }
            } else {
                System.out.println("\nBasket is empty");
            }
        }
    }

    public void addToBasket(List<Book> books, Book book) {
        books.add(book);
        System.out.println("Book: \""+book.getTitle()+"\" added to basket");
    }

    int getTotal(List<Book> books) {
        int total = 0;
        for (Book book : books) {
            total = total + book.getPrice();
        }
        return total;
    }    

}
