package High_Frequency_Trading_System;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Random;
import java.util.concurrent.TimeoutException;
import java.util.concurrent.locks.Lock;

//STOCK PRODUCER CLASS - INCREASE THE PRICE
public class StockProducer implements Runnable{
    int no;
    ArrayList<Stock> stockList;
    Lock writeLock;
    Random rand = new Random();

    public StockProducer(int no, ArrayList<Stock> stockList, Lock writeLock) throws IOException, TimeoutException {
        this.no = no;
        this.stockList = stockList;
        this.writeLock = writeLock;
    }
   
    public int getNo() {
        return no;
    }

    @Override
    public void run() {
        while(true){
            try {
                Thread.sleep(5000);
            } catch (InterruptedException ex) {
                
            }
            //SELECT A RANDOM STOCK AND INCREASE THE PRICE
            int s = rand.nextInt(stockList.size());
            Stock chosenStock = stockList.get(s);
            int value = chosenStock.getPrice();
            int inc = rand.nextInt(10);
            value += inc;
            try {
                writeLock.lock();
                chosenStock.setPreviousPrice(chosenStock.price);
                chosenStock.setIsUpdated(true);
                chosenStock.setPrice(value);
                
                //PRINT OUT THE NEW STOCK PRICE
                System.out.println("Stock Producer "+getNo()+ " : "+chosenStock);
            }finally{
                writeLock.unlock();
            }  
        }
    }
}
