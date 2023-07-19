
public class Gate {
	private int id;
	Runway runway;
	
	//CONSTRUCTOR
	public Gate(int id, Runway runway) {
		this.id = id;
		this.runway = runway;
	}
	
	//GET GATE ID
	public int getId() {
		return id;
	}
	
	//DISEMBARK PASSENGER
	public void disembark(Plane plane,int amount) throws InterruptedException {
		for(int i=1;i<=amount;i++) {
			Passenger passenger = new Passenger(i,1,plane); //1 - DISEMBARK
			Thread thpassenger = new Thread(passenger);
			thpassenger.start();
			Thread.sleep((long)(Math.random()*150));
		}
		
	}
	
	//EMBARK PASSENGER
	public void embark(Plane plane,int amount) throws InterruptedException {
		for(int i=1;i<=amount;i++) {
			Passenger passenger = new Passenger(i,2,plane); //2 - EMBARK
			Thread thpassenger = new Thread(passenger);
			thpassenger.start();
			Thread.sleep((long)(Math.random()*150));
		}
	}
	
	//REFILL SUPPLY
	public void refill(Plane plane) throws InterruptedException{
		System.out.println("\n				Plane "+plane.getId()+" : Refilling Supplies.");
		Thread.sleep((long)(Math.random()*500));
		System.out.println("				Plane "+plane.getId()+" : Refilling Completed.");
	}
	
	//REFUEL PLANE
	public void refuel(Plane plane)throws InterruptedException {
		System.out.println("\n				Plane "+plane.getId()+" : Refuelling.");
		Thread.sleep((long)(Math.random()*500));
		System.out.println("				Plane "+plane.getId()+" : Refueling Completed.");
	}
	
	//CLEANING PLANE
	public void cleaning(Plane plane) throws InterruptedException{
		System.out.println("\n				Plane "+plane.getId()+" : Cleaning Aircraft.");
		Thread.sleep((long)(Math.random()*500));
		System.out.println("				Plane "+plane.getId()+" : Cleaning Completed.");
	}
}
