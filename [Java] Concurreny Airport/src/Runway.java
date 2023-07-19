import java.util.concurrent.BlockingQueue;

public class Runway {
	public BlockingQueue<Gate> gateQueue = null;
	
	//CONSTRUCTOR
	public Runway(BlockingQueue<Gate> gateQueue) {
		this.gateQueue = gateQueue;
	}
	
	//REQUEST ACCESS TO THE RUNWAY
	public void requestAccessToTheRunway(Plane plane) {
		System.out.println("ATC : Plane "+plane.getId()+ " is requiring to access the runway!");
		if(gateQueue.isEmpty()) {
			System.out.println("ATC : All the gates are occupied! Please wait for a moment in the queue Plane "+plane.getId()+"!\n");
		}
	}
	
	//ACCESSING THE RUNWAY
	public void accessRunway(Plane plane) throws InterruptedException {
		System.out.println("ATC [WARNING] : Plane " +plane.getId() + " is accessing the runway......");
		Thread.sleep((long)(Math.random()*2500));
	}
	
	//ACCESSING THE GATE
	public void accessGate(Plane plane, Gate gate) throws InterruptedException {
		System.out.println("ATC : Plane " + plane.getId()+ " has landed at gate "+gate.getId()+"!" );
	}
	
	//LEAVING THE GATE
	public void leaveGate(Plane plane, Gate gate) throws InterruptedException {
		System.out.println("ATC : Plane " + plane.getId()+ " has lefted gate "+gate.getId()+"!" );
		gateQueue.put(gate);
	}
	
	//LEAVING THE AIRPORT
	public void leaveAirport(Plane plane) {
		System.out.println("ATC : Plane " + plane.getId()+ " has lefted the airport!");
	}
}
