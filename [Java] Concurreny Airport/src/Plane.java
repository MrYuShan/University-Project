import java.util.concurrent.BlockingQueue;

public class Plane implements Runnable{
	private int id;
	private Runway runway;
	private BlockingQueue<Runway> runwayQueue = null;
	
	//CONSTRUCTOR
	public Plane(int id,Runway runway, BlockingQueue<Runway> runwayQueue) {
			this.id = id;
			this.runway = runway;
			this.runwayQueue = runwayQueue;
	}
	
	//PLANE THREAD RUN
	public void run() {
		try {
			//ARRIVE, REQUEST ACCESS RUNWAY AND GATE ( COUNT THE WAIT TIME )
			long startTime = System.nanoTime(); //START TIME
			runway.requestAccessToTheRunway(this);
			Gate gate = runway.gateQueue.take();
			runwayQueue.take();
			long endTime = System.nanoTime(); //END TIME (AFTER A GATE AND RUNWAY IS AVAILABLE)
			long duration = (endTime - startTime); //WAIT TIME DURATION = END TIME - START TIME
			Airport.waitTime.add((double)(duration)/1000000000); //TURN NANOSECOND to SECOND by DIVIDING 10^9
			runway.accessRunway(this);
			runway.accessGate(this, gate);
			runwayQueue.put(runway);
			
			//EVENTS HAPPEN IN THE GATE
			gate.disembark(this, 50);
			gate.cleaning(this);
			gate.refill(this);
			gate.refuel(this);
			gate.embark(this,50);
			
			//LEAVE GATE, ACCESS RUNWAY THEN LEAVE AIRPORT
			runwayQueue.take();
			runway.leaveGate(this, gate);
			runway.accessRunway(this);
			runway.leaveAirport(this);
			runwayQueue.put(runway);
			
			Airport.listPlane.remove(this);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}	
	}
	
	//RETURN PLANE ID
	public int getId() {
		return id;
	}
}
