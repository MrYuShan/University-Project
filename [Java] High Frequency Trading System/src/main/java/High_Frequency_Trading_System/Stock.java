package High_Frequency_Trading_System;

import java.io.Serializable;

//STOCK CLASS
public class Stock implements Serializable{
    String name;
    int price;
    int previousPrice;
    boolean isUpdated;
    
    public Stock(String name, int price) {
        this.name = name;
        this.price = price;
        this.previousPrice = price;
        this.isUpdated = false;
    }

    public boolean isIsUpdated() {
        return isUpdated;
    }

    public void setIsUpdated(boolean isUpdated) {
        this.isUpdated = isUpdated;
    }
    
    public int getPrice() {
        return price;
    }
    
    public void setPrice(int price) {
        this.price = price;
    }

    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }

    public int getPreviousPrice() {
        return previousPrice;
    }

    public void setPreviousPrice(int previousPrice) {
        this.previousPrice = previousPrice;
    }

    @Override
    public String toString() {
        return "Stock "+ name + " new price is RM"+ price;
    }
}
