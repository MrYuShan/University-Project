package High_Frequency_Trading_System;

import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.concurrent.TimeoutException;
import java.util.concurrent.locks.Lock;

//STOCK MONITOR CLASS - TO MONITOR PRICE AND SEND MESSAGE
public class StockMonitor implements Runnable{
    ArrayList<Stock> stocks;
    Lock readLock;
    String queueName;   

    public StockMonitor(ArrayList<Stock> stocks, Lock readLock, String queueName) throws IOException, TimeoutException{
        this.stocks = stocks;
        this.readLock = readLock;
        this.queueName = queueName;
    }
    
    
    //METHOD TO SEND UPDATE TO RECEIVER
    public void sendUpdate(Stock stock)throws IOException, TimeoutException{
        //CONVERT STOCK CLASS INTO BYTE ARRAY
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ObjectOutputStream oos = new ObjectOutputStream(baos);
        oos.writeObject(stock);

        //CREATE A CONNECTION FACTORY
        ConnectionFactory f = new ConnectionFactory();
        
        //CREATE A NEW CONNECTION
        Connection connection = f.newConnection();
        
        //CREATE A CHANNEL
        Channel channel = connection.createChannel();        

        //DEFINE THE QUEUE
        channel.queueDeclare(queueName,false,false,false,null);
        
        //SEND THE STOCK CLASS IN BYTE ARRAY FORM
        channel.basicPublish("",queueName,true,null,baos.toByteArray()); 
    }
    
    @Override
    public void run() {
        //RUN METHOD
        while(true){
            try{
                //COMPARE THE NEW PRICE TO THE PREVIOUS PRICE
                readLock.lock();
                for (Stock s: stocks){
                    if(s.getPrice()!=s.getPreviousPrice() && s.isIsUpdated()){
                        s.setIsUpdated(false);
                        //SEND THE MESSAGE
                        sendUpdate(s);
                    }
                }
            } 
            catch (IOException | TimeoutException ex) {
            
            }                
            finally{
                readLock.unlock();
            }
        }
    }
}
