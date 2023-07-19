//THEAN YEE SIN TP061278
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;



public class Airport {
	public static LinkedList<Plane> listPlane = new LinkedList<Plane>(); //LINKED LIST FOR PLANE
	public static ArrayList<Double> waitTime = new ArrayList<Double>(); //ARRAY LIST FOR WAIT TIME
	public static int totalPassengerDisembark; //TOTAL PASSENGER DISEMBARK
	public static int totalPassengerEmbark; //TOTAL PASSENGER EMBARK
	private static final DecimalFormat df = new DecimalFormat("0.00");
	
	public static void main(String[] args) throws InterruptedException {
		//TOTAL PLANE FOR STATISTIC
		int totalPlane = 0;
		
		//BLOCKING QUEUE FOR RUNWAY AND GATE
		BlockingQueue<Runway> runwayQueue = new ArrayBlockingQueue<Runway>(1); //1 RUNWAY
		BlockingQueue<Gate> gateQueue = new ArrayBlockingQueue<Gate>(2); //2 GATE
		Runway r1 = new Runway(gateQueue);
		Gate g1 = new Gate(1,r1);
		Gate g2 = new Gate(2,r1);
		
		//ADD RUNWAY/GATE TO THE BLOCKING QUEUE
		runwayQueue.put(r1);
		gateQueue.put(g1);
		gateQueue.put(g2);
		
		
		//CREATE PLANE THREAD AND ADD TO LINKED LIST
		for(int i = 1; i<=10;i++) {
			Plane p = new Plane(i,r1,runwayQueue);
			Thread pThread = new Thread(p);
			pThread.start();
			totalPlane++;
			Thread.sleep((long)(Math.random()*3000));
			listPlane.add(p);
		}
		
		//CHECK IF LINKED LIST FOR PLANE IS EMPTY OR NOT
		while(!listPlane.isEmpty()) {
			Thread.sleep(100);
		}
		
		//MIN WAIT TIME
		double min = waitTime.get(0);
        for (int i = 1; i < waitTime.size(); i++) {
            if (min > waitTime.get(i)) {
                min = waitTime.get(i);
            }
        }
        
        //MAX WAIT TIME
        double max = waitTime.get(0);
		for(int i = 1; i<waitTime.size();i++) {
			if (max < waitTime.get(i)) {
				max = waitTime.get(i);
			}
		}
		
		//AVERAGE WAIT TIME
		double total = 0;
		for(int i = 0; i<waitTime.size();i++) {
			total = total + waitTime.get(i);
		}
		double average = total /waitTime.size();
		
		//IF LINKED LIST IS EMPTY, PRINT STATISTICS
		System.out.println("\n\nSTATISTICS:\n");
		System.out.println("Runway Available: "+!runwayQueue.isEmpty()); //RUNWAY AVAILABILITY
		System.out.println("Gate Available: "+ !gateQueue.isEmpty()+"("+gateQueue.size()+")"); //TWO GATE AVAILABILITY
		System.out.println("Min Wait Time: "+df.format(min)+" second(s)"); //MINIMUM WAIT TIME
		System.out.println("Average Wait Time: "+df.format(average)+" second(s)"); //AVERAGE WAIT TIME
		System.out.println("Max Wait Time: "+df.format(max)+" second(s)"); //MAXIMUM WAIT TIME
		System.out.println("Total Plane: "+totalPlane); //TOTAL PLANE
		System.out.println("Total Passenger Disembark: "+totalPassengerDisembark); //TOTAL PASSENGER DISEMBARK
		System.out.println("Total Passenger Embark: "+totalPassengerEmbark); //TOTAL PASSENGER EMBARK	
		System.out.println("\nPROGRAM ENDED\n");
	}
}
