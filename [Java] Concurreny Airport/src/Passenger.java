
public class Passenger implements Runnable {
	private int id;
	private int status;
	Plane plane;
	
	//CONSTRUCTOR
	public Passenger(int id, int status, Plane plane) {
		this.id = id;
		this.status = status;
		this.plane = plane;
	}
	
	//PASSENGER THREAD RUN
	public void run() {
		if(status == 1) {
			disembark();
		}else {
			embark();
		}
		
	}
	
	//PASSENGER DISEMBARKING
	private synchronized void disembark() {
		Airport.totalPassengerDisembark++;
		System.out.println("				Plane "+plane.getId()+" : Passenger "+this.id+"("+java.time.LocalTime.now()+")"+" is disembarking.");
	}
	
	//PASSENGER EMBARKING
	private synchronized void embark() {
		Airport.totalPassengerEmbark++;
		System.out.println("				Plane "+plane.getId()+" : Passenger "+this.id+"("+java.time.LocalTime.now()+")"+" is embarking.");
	}
}
