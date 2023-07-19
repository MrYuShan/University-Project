package High_Frequency_Trading_System;

import java.io.IOException;
import java.util.ArrayList;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantReadWriteLock;
import org.openjdk.jmh.annotations.*;

/*
    AUTHOR = THEAN YEE SIN, TP061278, APU3F2209CS
*/
public class HighFrequencyTradingSystem {
//    @Benchmark
//    @BenchmarkMode({Mode.Throughput, Mode.AverageTime})
//    @Measurement(iterations = 5,timeUnit = TimeUnit.MILLISECONDS)
//    @Threads(3)
//    @OutputTimeUnit(TimeUnit.MILLISECONDS)
//    @Fork(2)
//    @Warmup(iterations = 1)
//    public void start()throws IOException, TimeoutException{
    public static void main(String[] args) throws IOException, TimeoutException{
       //CREATE 5 SAMPLE STOCKS
       Stock microsoft = new Stock("Microsoft",97);
       Stock apple = new Stock("Apple",80);
       Stock asus = new Stock("Asus",90);
       Stock samsung = new Stock("Samsung",100);
       Stock google = new Stock("Google",110);
       
       //CREATE AN ARRAYLIST TO STORE THE STOCKS
       ArrayList<Stock> stockList = new ArrayList<>();
       
       //ADD STOCKS TO THE ARRAYLIST
       stockList.add(microsoft);
       stockList.add(apple);
       stockList.add(asus);
       stockList.add(samsung);
       stockList.add(google);

       //READ WRITE LOCK TO ACCESS THE STOCK LIST
       ReentrantReadWriteLock lock = new ReentrantReadWriteLock();
       Lock writeLock = lock.writeLock();
       Lock readLock = lock.readLock();
       
       //PRODUCER - TO INCREASE THE PRICE
       StockProducer producer1 = new StockProducer(1,stockList, writeLock);
       
       //MONITOR - TO CHECK THE PRICE AND SEND MESSAGE TO RECEIVER
       StockMonitor monitor1 = new StockMonitor(stockList,readLock,"HighFrequencyTrading");
       
       //RECEIVER - TO RECEIVE MESSAGE FROM MONITOR AND DO SOMETHING WITH THE PRICE
       StockReceiver receiver1 = new StockReceiver(1,"HighFrequencyTrading");

       //EXECUTOR SERVICE FOR BETTER THREAD MANAGEMENT
       ExecutorService exchange = Executors.newCachedThreadPool();
       
       //START ALL THE THREAD
       exchange.submit(producer1);
       exchange.submit(monitor1);
       exchange.submit(receiver1);
    }
    
}
