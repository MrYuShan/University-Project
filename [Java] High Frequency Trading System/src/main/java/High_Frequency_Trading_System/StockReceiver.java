package High_Frequency_Trading_System;

import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.util.concurrent.TimeoutException;

//STOCK RECEIVER CLASS - RECEIVE MESSAGE FROM STOCK MONITOR
public class StockReceiver implements Runnable{
    int no;
    String queueName;
    
    public StockReceiver(int no, String queueName) throws IOException, TimeoutException{
        this.no = no;
        this.queueName = queueName;
    }

    public int getNo() {
        return no;
    }

    public String getQueueName() {
        return queueName;
    }
    
    // METHOD TO RECEIVE UPDATE
    public void receiveUpdate() throws Exception{
        //CREATE A CONNECTION FACTORY
        ConnectionFactory f = new ConnectionFactory();

        //CREATE A NEW CONNECTION
        Connection connection = f.newConnection();
        
        //CREATE A CHANNEL
        Channel channel = connection.createChannel();
        
        //DEFINE THE QUEUE
        channel.queueDeclare(getQueueName(),false,false,false,null);
        
        //RECEIVE MESSAGE
        channel.basicConsume(getQueueName(),(x,stk)->{
            try {
                //CONVERT BYTE ARRAY BACK INTO STOCK CLASS
                ByteArrayInputStream bais = new ByteArrayInputStream(stk.getBody());
                ObjectInputStream ois = new ObjectInputStream(bais);
                
                //THE STOCK OBJECT
                Stock stock = (Stock) ois.readObject();
                
                //PRINT OUT THE RECEIVED MESSAGE
                System.out.println("Stock Receiver "+getNo()+" : Received Update from Stock "+stock.getName()+", New price is RM"+stock.getPrice()+"\n");
                
                if (stock.getPrice()>150){
                    System.out.println("Stock Receiver "+getNo()+" : Stock "+stock.getName()+" is overpriced, sell it now!\n");
                }
            } catch (IOException | ClassNotFoundException ex) {
                
            }},x->{});
        
    }

    @Override
    public void run() {
        try {            
            receiveUpdate();
        }  catch (Exception ex) {
            
        }
    }
}
    

