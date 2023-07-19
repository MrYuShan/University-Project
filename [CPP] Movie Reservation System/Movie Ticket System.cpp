#include <iostream>
#include <string>
#include <iomanip>

using namespace std;

//STRUCTURE MOVIE
struct movie {
	int id;
	string name;
	int date;
	int startTime;
	int duration;
	int venue;
	string type;
	int totalSeat;
	int availableSeat;
	movie* prev;
	movie* next;
}*movieHead, * movieTail, * newMovie, * movieTemp;

//STRUCTURE PURCHASE
struct purchase {
	string customerName;
	int purchaseNo;
	int movieID;
	string movieName;
	int date;
	int startTime;
	int duration;
	int venue;
	string movieType;
	int quantity;
	double price;
	purchase* next;
	purchase* prev;
}*purchaseHead, *purchaseTail;

//FUNCTION PROTOTYPE: MOVIE
void mainMenu();
void addProduct();
void displayProduct();
void searchProduct();
void categoryFilter();
void updateProduct();
void sortProduct(movie** tempHead);
void movieFrontBackSplit(movie* tempHead, movie** frontRef, movie** backRef);
movie* movieMerge(movie* x, movie* y);
void deleteProduct();
void insertProduct(string name, int date, int startingTime, int duration, int venue, string type, int totalSeat);

//FUNCTION PROTOTYPE: PURCHASE
void addPurchase();
void purchaseDetail();
void sortPurchase(purchase**tempHead);
void viewPurchase();
purchase* purchaseMerge(purchase* a, purchase* b);
void purchaseFrontBackSplit(purchase* tempHead, purchase** frontRef, purchase** backRef);
void insertPurchase(string customerName, int movieID, string movieName, int date, int startTime, int duration, int venue, string movieType, int quantity, double price);

//GLOBAL SIZE
int movieSize = 0;
int purchaseSize = 0;

/*=====================================================================================
	MAIN
=====================================================================================*/
int main() {
	movieHead = NULL;
	movieTail = NULL;
	newMovie = NULL;
	movieTemp = NULL;
	purchaseHead = NULL;
	purchaseTail = NULL;

	//PRE-ADD THE MOVIE INVENTORY
	string name[10] = {"The Batman","The Batman","Uncharted","Uncharted","No Time To Die","Dangerous","Jujutsu Kaisen 0","Jurassic World Dominion","Blacklight","Sonic The Hedgehog 2"};
	int date[10] = {1,2,1,2,1,3,4,6,1,7};
	int startTime[10] = {1000,1000,1330,1330,1810,1000,1145,1530,2200,1315};
	int duration[10] = {175,175,115,115,165,100,105,128,105,120};
	int venue[10] = {1,1,2,2,3,4,5,6,7,1};
	string type[10] = {"Classic","Classic 3D", "Classic","Classic 3D", "Deluxe", "IMAX", "IMAX 3D","Classic","Classic 3D","Deluxe"};
	int totalSeat[10] = {120,60,100,50,100,75,100,90,120,100};
	for (int i = 0; i < 10; i++) {
		insertProduct(name[i], date[i], startTime[i], duration[i], venue[i], type[i], totalSeat[i]);
	}

	//PRE-ADD THE PURCHASE INVENTORY
	string customerName[5] = {"Thean Yee Sin","Naimur Rahman","Ng Jing Kai","Tom Cruise","Elon Musk"};
	int movieID[5] = {1,9,6,4,8};
	string movieName[5] = {"The Batman","Blacklight","Dangerous","Uncharted","Jurassic World Dominion"};
	int movieDate[5] = {1,1,3,2,6};
	int movieStartTime[5] = {1000,2200,1000,1330,1530};
	int movieDuration[5] = {173,105,100,115,128};
	int hallVenue[5] = {1,7,4,2,6};
	string movieType[5] = {"Classic","Classic 3D","IMAX","Classic 3D","Classic"};
	int quantity[5] = {5,2,7,10,1};
	double price[5] = {50,30,105,150,10};
	for (int i = 0; i < 5; i++) {
		insertPurchase(customerName[i], movieID[i], movieName[i], movieDate[i], movieStartTime[i], movieDuration[i], hallVenue[i], movieType[i], quantity[i], price[i]);
	}
	mainMenu();
	return 0;
}

/*=====================================================================================
	MAIN MENU
=====================================================================================*/
void mainMenu() {
	
	int option = 12;
	while (true) {
		cout << string(50, '-') << endl;
		cout << "WELCOME TO GRANDPLEX CINEMA" << endl;
		cout << string(50, '-') << endl;
		cout << "Inventory: " << endl;
		cout << "\t1. Add Product" << endl;
		cout << "\t2. Display Product" << endl;
		cout << "\t3. Product Search" << endl;
		cout << "\t4. Category Filter" << endl;
		cout << "\t5. Update Product" << endl;
		cout << "\t6. Sort Product" << endl;
		cout << "\t7. Delete Product" << endl;
		cout << "\nTransaction: " << endl;
		cout << "\t8. Add Purchase" << endl;
		cout << "\t9. View Purchase" << endl;
		cout << "\t10. Sort Purchase" << endl;
		cout << "\t11. Purchase Detail" << endl;
		cout << "\n\t12. Exit" << endl;
		cout << "Choose your option: ";
		cin >> option;
		if (option < 1 || option >12) {
			cout << endl << endl << "Please choose operation between 1 - 12!" << endl << endl;
		}
		else if (option == 1) {
			addProduct();
		}
		else if (option == 2) {
			displayProduct();
		}
		else if (option == 3) {
			searchProduct();
		}
		else if (option == 4) {
			categoryFilter();
		}
		else if (option == 5) {
			updateProduct();
		}
		else if (option == 6) {
			sortProduct(&movieHead);
			displayProduct();
		}
		else if (option == 7) {
			deleteProduct();
		}
		else if (option == 8) {
			addPurchase();
		}
		else if (option == 9) {
			viewPurchase();
		}
		else if (option == 10) {
			sortPurchase(&purchaseHead);
			viewPurchase();
		}
		else if (option == 11) {
			purchaseDetail();
		}
		else {
			cout << "Have a good day!" << endl;
			break;
		}
	}
}

/*=====================================================================================
	ADD PRODUCT
=====================================================================================*/
void addProduct()
{
	string name;
	cout << "\nEnter movie name: ";
	cin.ignore();
	getline(cin, name);
	cout << endl;

	int date;
	cout << "Enter date of the movie ( 0 - 7 ): ";
	cin >> date;
	cout << endl;

	int startingTime;
	cout << "Enter the starting time of the movie (24 hour time format): ";
	cin >> startingTime;
	cout << endl;
	while (startingTime < 0 || startingTime > 2359 || startingTime % 100 > 59)
	{
		cout << "Invalid input. Please enter valid starting time of the movie (24 hour time format): ";
		cin >> startingTime;
		cout << endl;
	}

	int duration;
	cout << "Enter the duration of the movie in minutes: ";
	cin >> duration;
	cout << endl;
	while (duration < 1)
	{
		cout << "Invalid input. Please enter the duration of the movie in minutes: ";
		cin >> duration;
		cout << endl;
	}

	int venue;
	cout << "Enter the venue of the movie (Hall 1 - 7): Hall ";
	cin >> venue;
	cout << endl;
	while (venue < 1 || venue >> 7)
	{
		cout << "Invalid input. Please enter the venue of the movie (Hall 1 - 7): Hall ";
		cin >> venue;
		cout << endl;
	}

	string type;
	cout << "Enter the type of the movie (Classic, Classic 3D, Deluxe, IMAX, IMAX 3D): ";
	cin.ignore();
	getline(cin, type);
	cout << endl;
	while (type.compare("Classic") != 0 && type.compare("Classic 3D") != 0 && type.compare("Deluxe") != 0 && type.compare("IMAX") != 0 && type.compare("IMAX 3D") != 0)
	{
		cout << "Invalid input. Please enter the type of the movie (Classic, Classic 3D, Deluxe, IMAX, IMAX 3D): ";
		getline(cin, type);
		cout << endl;
	}

	int totalSeat;
	cout << "Enter the total number of seat of the movie: ";
	cin >> totalSeat;
	cout << endl;
	while (totalSeat < 0)
	{
		cout << "Invalid input. Please enter the total number of seat of the movie: ";
		cin >> totalSeat;
		cout << endl;
	}

	insertProduct(name, date, startingTime, duration, venue, type, totalSeat);

	cout << "The Movie details is added as below: " << endl;
	cout << "Movie Id: " << ::movieSize << endl;
	cout << "Movie Name: " << name << endl;
	cout << "Date: " << date << endl;
	cout << "Starting time: " << startingTime << endl;
	cout << "Duration: " << duration <<" minutes" << endl;
	cout << "Venue: Hall " << venue << endl;
	cout << "Type: " << type << endl;
	cout << "Total seat: " << totalSeat << endl;

	
}

/*=====================================================================================
	DISPLAY PRODUCT
=====================================================================================*/
void displayProduct()
{
	if (movieHead == NULL) {
		cout << "No movie stored in the system\n\n";
		return;
	}
	movieTemp = movieHead;
	cout << "The movies currently available - \n\n";
	while (movieTemp != NULL) {
		
		cout << "Movie ID: " << movieTemp->id << endl;
		cout << "Movie Name: " << movieTemp->name << endl;
		cout << "Date: " << movieTemp->date << endl;
		cout << "Start Time: " << movieTemp->startTime << endl;
		cout << "Movie Duration: " << movieTemp->duration <<" minutes" << endl;
		cout << "Venue: Hall " << movieTemp->venue << endl;
		cout << "Movie Type: " << movieTemp->type << endl;
		cout << "Seat Available: " << movieTemp->availableSeat <<"("<<movieTemp->totalSeat<<")" << endl;
		cout << "\n";
		movieTemp = movieTemp->next;
	}
}

/*=====================================================================================
	SEARCH PRODUCT
=====================================================================================*/
void searchProduct()
{
	movie* movieTemp = movieHead;

	if (movieTemp != NULL)
	{
		int id;
		cout << "Please enter the movie id you wish to search: ";
		cin >> id;

		while (movieTemp != NULL)
		{
			if (movieTemp->id == id)
			{
				cout << "Movie id: " << movieTemp->id << endl;
				cout << "Movie Name: " << movieTemp->name << endl;
				cout << "Date: " << movieTemp->date << endl;
				cout << "Starting time: " << movieTemp->startTime << endl;
				cout << "Venue: Hall " << movieTemp->venue << endl;
				cout << "Type: " << movieTemp->type << endl;
				cout << "\n";
			}
			movieTemp = movieTemp->next;
		}
	}
	else
	{
		cout << "The list is empty!" << endl;
		return;
	}
}

/*=====================================================================================
	CATEGORY FILTER
=====================================================================================*/
void categoryFilter()
{
	movie* movieTemp = movieHead;

	int filterSearch;
	string mType;
	int mDate;

	cout << "Categories - \n";
	cout << "1. Movie Type \n";
	cout << "2. Movie Date \n";
	cout << "3. Movie Name \n";
	cout << "4. Back \n";
	cout << "Select you category: ";
	cin >> filterSearch;

	if (filterSearch > 4 || filterSearch < 1) {
		cout << "Invalid Input! Please try again\n";
		categoryFilter();
	}
	else if (filterSearch == 1) {
		cout << "Movie Types -\n";
		cout << "\tClassic \n";
		cout << "\tClassic 3D \n";
		cout << "\tDeluxe \n";
		cout << "\tIMAX \n";
		cout << "\tIMAX 3D \n";
		cout << "Enter the type you want to filter: ";
		cin.ignore();
		getline(cin, mType);


		while (mType.compare("Classic") != 0 && mType.compare("Classic 3D") != 0 && mType.compare("Deluxe") != 0 && mType.compare("IMAX") != 0 && mType.compare("IMAX 3D") != 0)
		{
			cout << "Invalid input. Please enter the type of the movie (Classic, Classic 3D, Deluxe, IMAX, IMAX 3D): ";
			getline(cin, mType);
		}

		if (movieHead == NULL) {
			cout << "No movie stored in the system. \n" << endl;
			categoryFilter();
		}
		cout << "\n";
		while (movieTemp != NULL)
		{
			if (movieTemp->type == mType) {
				cout << "Movie ID: " << movieTemp->id << endl;
				cout << "Movie Name: " << movieTemp->name << endl;
				cout << "Date: " << movieTemp->date << endl;
				cout << "Start Time: " << movieTemp->startTime << endl;
				cout << "Movie Duration: " << movieTemp->duration << " minutes" << endl;
				cout << "Venue: " << movieTemp->venue << endl;
				cout << "Movie Type: " << movieTemp->type << endl;
				cout << "Seat Available: " << movieTemp->availableSeat << endl;
				cout << "\n";
			}
			movieTemp = movieTemp->next;
		}
	}

	else if (filterSearch == 2) {

		cout << "Enter movie date between (0 - 7): ";
		cin >> mDate;

		while (mDate > 7 || mDate < 1)
		{
			cout << "Please enter date between (0 - 7): ";
			cin >> mDate;
		}

		if (movieHead == NULL) {
			cout << "No movie stored in the system. \n" << endl;
			categoryFilter();
		}
		cout << "\n";
		while (movieTemp != NULL)
		{
			if (movieTemp->date == mDate) {
				cout << "Movie ID: " << movieTemp->id << endl;
				cout << "Movie Name: " << movieTemp->name << endl;
				cout << "Date: " << movieTemp->date << endl;
				cout << "Start Time: " << movieTemp->startTime << endl;
				cout << "Movie Duration: " << movieTemp->duration <<" minutes" << endl;
				cout << "Venue: " << movieTemp->venue << endl;
				cout << "Movie Type: " << movieTemp->type << endl;
				cout << "Seat Available: " << movieTemp->availableSeat << endl;
				cout << "\n";
			}
			movieTemp = movieTemp->next;
		}
	}
	else if (filterSearch == 3) {

		string mName;
		cout << "Enter the movie name: ";
		cin >> mName;

		if (movieHead == NULL) {
			cout << "No movie stored in the system. \n" << endl;
			categoryFilter();
		};
		cout << "\n";
		while (movieTemp != NULL)
		{
			if (movieTemp->name == mName) {
				cout << "Movie ID: " << movieTemp->id << endl;
				cout << "Movie Name: " << movieTemp->name << endl;
				cout << "Date: " << movieTemp->date << endl;
				cout << "Start Time: " << movieTemp->startTime << endl;
				cout << "Movie Duration: " << movieTemp->duration << " minutes" << endl;
				cout << "Venue: " << movieTemp->venue << endl;
				cout << "Movie Type: " << movieTemp->type << endl;
				cout << "Seat Available: " << movieTemp->availableSeat << endl;
				cout << "\n";
			}
			movieTemp = movieTemp->next;
		}
	}
	else if (filterSearch == 4) {
		return;
	}

}

/*=====================================================================================
	UPDATE PRODUCT
=====================================================================================*/
void updateProduct()
{
	movie* movieTemp = movieHead;

	int id;
	cout << "Please enter the movie id to locate the movie to edit: ";
	cin >> id;

	while (movieTemp != NULL)
	{
		if (movieTemp->id == id)
		{
			cout << "\nMovie id: " << movieTemp->id << endl;
			cout << "Movie Name: " << movieTemp->name << endl;
			cout << "Date: " << movieTemp->date << endl;
			cout << "Starting time: " << movieTemp->startTime << endl;
			cout << "Venue: Hall " << movieTemp->venue << endl;

			int decision;
			cout << "\nEnter the detail you want to update by" << endl
				<< "1. Movie Name" << endl
				<< "2. Date" << endl
				<< "3. Time" << endl
				<< "4. Duration" << endl
				<< "5. Venue" << endl
				<< "Enter your choice (1 - 5): ";
			cin >> decision;

			switch (decision)
			{
			case 1:
				cout << endl << "Enter the new movie name for the movie: ";
				cin.ignore();
				getline(cin,movieTemp->name);
				break;

			case 2:
				cout << endl << "Enter the new date for the movie: ";
				cin >> movieTemp->date;

				while (movieTemp->date < 1 || movieTemp->date > 31)
				{
					cout << endl << "Invalid input. Please enter the new date for the movie: ";
					cin >> movieTemp->date;
				}
				break;

			case 3:
				cout << endl << "Enter the new starting time  for the movie: ";
				cin >> movieTemp->startTime;

				while (movieTemp->startTime < 0 || movieTemp->startTime > 2359 || movieTemp->startTime % 100 > 59)
				{
					cout << "Invalid input. Please enter the new starting time for the movie: ";
					cin >> movieTemp->startTime;
				}
				break;

			case 4:
				cout << endl << "Enter the new duration  for the movie: ";
				cin >> movieTemp->duration;

				while (movieTemp->duration < 1)
				{
					cout << "Invalid input. Please enter the new date for the movie: ";
					cin >> movieTemp->duration;
				}
				break;

			case 5:
				cout << endl << "Enter the new venue for the movie: Hall ";
				cin >> movieTemp->venue;

				while (movieTemp->venue < 1 || movieTemp->venue>7)
				{
					cout << "Invalid input. Please enter the new venue for the movie: ";
					cin >> movieTemp->venue;
				}
				break;

			default:
				cout << "Invalid input. Please try again!";
				break;
			}
		}
		movieTemp = movieTemp->next;
	}
}

/*=====================================================================================
	SORT PRODUCT
=====================================================================================*/
//(GeeksforGeeks, 2021)
void movieFrontBackSplit(movie* tempHead, movie** frontRef, movie** backRef) {
	movie* slow = tempHead;
	movie* fast = tempHead->next;
	while (fast != NULL) {
		fast = fast->next;
		if (fast != NULL) {
			fast = fast->next;
			slow = slow->next;
		}
	}
	*frontRef = tempHead;
	*backRef = slow->next;
	slow->next = NULL;
}
//(GeeksforGeeks, 2021)
movie* movieMerge(movie* x, movie* y) {
	movie* result = NULL;
	if (x == NULL) {
		return y;
	}
	if (y == NULL) {
		return x;
	}
	if (x->availableSeat <= y->availableSeat) {
		result = x;
		result->next = movieMerge(x->next, y);
	}
	else {
		result = y;
		result->next = movieMerge(x, y->next);
	}
	return result;
}
//(GeeksforGeeks, 2021)
void sortProduct(movie** tempHead) {
	movie* mHead = *tempHead;
	movie* fMovie;
	movie* bMovie;
	if (mHead == NULL || mHead->next == NULL) {  //problem here
		return;
	}
	movieFrontBackSplit(mHead, &fMovie, &bMovie);
	sortProduct(&fMovie);
	sortProduct(&bMovie);
	*tempHead = movieMerge(fMovie, bMovie);
}

/*=====================================================================================
	DELETE PRODUCT
=====================================================================================*/
void deleteProduct()
{
	int id;
	cout << "Please enter the movie id to locate the movie to delete: ";
	cin >> id;
	if (id <= 0) {
		cout << "Invalid input!" << endl << endl;
		deleteProduct();
	}
	movieTemp = movieHead;
	if (movieTemp == NULL)
	{
		cout << "The list is empty! Unable to delete." << endl;
	}
	else if (movieTemp->id == id)
	{
		movieTemp->next->prev = NULL;
		movieHead = movieTemp->next;
		cout << movieTemp->id << " is deleted!\n";
		delete movieTemp;
	}
	else
	{
		movie* prev = NULL;
		while (movieTemp != NULL)
		{
			if (movieTemp->id == id)
			{
				prev->next = movieTemp->next;
				cout << movieTemp->id << " is deleted!\n";
				delete movieTemp;
				return;
			}
			prev = movieTemp;
			movieTemp = movieTemp->next;
		}
		cout << "Id is not found. Please try again!";
	}
	return;
}
/*=====================================================================================
	INSERT PRODUCT
=====================================================================================*/
void insertProduct(string name,int date,int startingTime, int duration, int venue, string type, int totalSeat)
{
	newMovie = new movie;
	newMovie->id = ::movieSize + 1;
	newMovie->name = name;
	newMovie->date = date;
	newMovie->startTime = startingTime;
	newMovie->duration = duration;
	newMovie->venue = venue;
	newMovie->type = type;
	newMovie->totalSeat = totalSeat;
	newMovie->availableSeat = totalSeat;
	newMovie->prev = NULL;
	newMovie->next = NULL;

	if (movieHead == NULL || movieTail == NULL)
	{
		movieHead = movieTail = newMovie;
	}
	else
	{
		movieTail->next = newMovie;
		newMovie->prev = movieTail;
		movieTail = newMovie;
	}
	::movieSize++;
	return;
}

/*=====================================================================================
	ADD PURCHASE
=====================================================================================*/
void addPurchase() 
{
	if (movieHead == NULL) {
		cout << "There is no movie available currently." << endl << endl;
		return;
	}
	bool found = false;
	string movieName;
	string movieType;
	int movieDate;
	int movieTime;
	int ticketAmount = 0;
	double totalPrice = 0;
	string customerName;
	

	//print all the movie first

	movie* movieTemp = movieHead;
	while (movieTemp != NULL) {
		cout << "\nMovie available: " << movieTemp->name << endl;
		cout << "Movie type: " << movieTemp->type << endl;
		cout << "Movie date: " << movieTemp->date << endl;
		cout << "Movie start time: " << movieTemp->startTime << endl;
		cout << "Movie duration: " << movieTemp->duration << endl;
		cout << "Number of available seat: " << movieTemp->availableSeat << endl << endl;
		movieTemp = movieTemp->next;
	}

	//get the movie name and list all the movie with the same name

	cout << "Enter movie name: ";
	cin.ignore();
	getline(cin, movieName);
	movieTemp = movieHead;
	cout << "\n";
	cout << string(30, '-') << endl;
	cout << "Movie Available: " << endl;
	cout << string(30, '-') << endl;
	while (movieTemp != NULL) {
		if (movieTemp->name == movieName) {
			cout << "Movie name: " + movieTemp->name << endl;
			cout << "Movie type: " << movieTemp->type << endl;
			cout << "Movie date: " << movieTemp->date << endl;
			cout << "Movie start time: " << movieTemp->startTime << endl;
			cout << "Movie duration: " << movieTemp->duration << endl;
			cout << "Number of available seat: " << movieTemp->availableSeat << endl << endl;
			found = true;
		}
		movieTemp = movieTemp->next;
	}
	if (found == false) {
		cout << "No movie is available based on your search."<< endl;
		return;
	}
	
	//read the movie type and add in consideration while displaying the movie

	cout << "\nMovie Type: " << endl;
	cout << "\tClassic" << endl;
	cout << "\tClassic 3D" << endl;
	cout << "\tDeluxe" << endl;
	cout << "\tIMAX" << endl;
	cout << "\tIMAX 3D" << endl;
	cout << "Enter movie type: ";
	getline(cin, movieType);
	cout << "\n";
	cout << string(30, '-') << endl;
	cout << "Movie Available: " << endl;
	cout << string(30, '-') << endl;
	movieTemp = movieHead;
	found = false;
	while (movieTemp != NULL) {
		if (movieTemp->name == movieName && movieTemp->type == movieType) {
			cout << "Movie name: " + movieTemp->name << endl;
			cout << "Movie type: " << movieTemp->type << endl;
			cout << "Movie date: " << movieTemp->date << endl;
			cout << "Movie start time: " << movieTemp->startTime << endl;
			cout << "Movie duration: " << movieTemp->duration << endl;
			cout << "Number of available seat: " << movieTemp->availableSeat << endl <<endl;
			found = true;
		}
		movieTemp = movieTemp->next;
	}
	if (found == false) {
		cout << "No movie is available based on your search." << endl;
		return;
	}

	//read the movie date and add in consideration while displaying the movie

	cout << "\nEnter the movie date: ";
	cin >> movieDate;
	cout << "\n";
	cout << string(30, '-') << endl;
	cout << "Movie Available: " << endl;
	cout << string(30, '-') << endl;
	if (movieDate >= 0 && movieDate < 8) {
		movieTemp = movieHead;
		found = false;
		while (movieTemp != NULL) {
			if (movieName == movieTemp->name && movieTemp->type == movieType && movieTemp->date==movieDate) {
				cout << "Movie name: " + movieTemp->name << endl;
				cout << "Movie type: " << movieTemp->type << endl;
				cout << "Movie date: " << movieTemp->date << endl;
				cout << "Movie start time: " << movieTemp->startTime << endl;
				cout << "Movie duration: " << movieTemp->duration << endl;
				cout << "Number of available seat: " << movieTemp->availableSeat << endl << endl;
				found = true;
			}
			movieTemp = movieTemp->next;
		}
	}
	else {
		cout << "Invalid Entry (Date is between 0-7)" << endl;
		return;
	}
	if (found == false) {
		cout << "No movie is available based on your search." << endl;
		return;
	}

	//read the movie time and add in consideration while displaying the movie

	cout << "\nEnter the movie time: ";
	cin >> movieTime;
	cout << "\n";
	if (movieTime > 0 && movieTime < 2400 && movieTime%100<60) {
		movieTemp = movieHead;
		found = false;
		while (movieTemp != NULL) {	
			if (movieName == movieTemp->name && movieTemp->type ==movieType && movieTemp->date == movieDate  && movieTemp->startTime ==movieTime && movieTemp->availableSeat>0) {
				double payment;
				double amount;
				double change;
				cout << "The movie is found!"<< endl << endl;
				found = true;
				cout << "Enter the ticket amount: ";
				cin >> ticketAmount;
				if (movieType=="Classic") {
					totalPrice = 10;
				}
				else if (movieType=="Classic 3D") {
					totalPrice = 15;
				}
				else if (movieType=="Deluxe") {
					totalPrice = 13;
				}
				else if (movieType=="IMAX") {
					totalPrice = 15;
				}
				else if (movieType=="IMAX 3D") {
					totalPrice = 18;
				}
				else {
					cout << "Invalid Entry" << endl;
					return;
				}
				if (ticketAmount <= movieTemp->availableSeat) {
					totalPrice = totalPrice * ticketAmount;
					payment = totalPrice;
					
				}
				else {
					cout << "Not available for " << ticketAmount << " seats!"<<endl;
					return;
				}
				while (payment != 0) {
					cout << "Enter amount to pay RM " << payment << ": RM";
					cin >> amount;
					if (amount < payment) {
						payment = payment - amount;
					}
					else if(amount >= payment){
						change = amount - payment;
						payment = 0;
						cout << "\nHere is your change: RM" << change << endl << endl;
					}
					else {
						cout << "Invalid input" << endl;
					}
				}
				break;
			}
			movieTemp = movieTemp->next;
		}
	}
	else {
		cout << "Invalid Entry (Time is between 1-2359)";
		return;
	}
	if (found == false) {
		cout << "No movie is available based on your search." << endl;
		return;
	}
	cout << "Enter the customer name: ";
	cin.ignore();
	getline(cin, customerName);
	insertPurchase(customerName, movieTemp->id, movieTemp->name, movieTemp->date, movieTemp->startTime, movieTemp->duration, movieTemp->venue, movieTemp->type, ticketAmount, totalPrice);
	cout << "Added Successfully!" << endl;
	return;
}

/*=====================================================================================
	VIEW PURCHASE
=====================================================================================*/
void viewPurchase() 
{
	if (purchaseHead == NULL && purchaseTail == NULL) {
		cout << "The list is empty." << endl << endl;
		return;
	}
	purchase* purchaseTemp = purchaseHead;
	while (purchaseTemp != NULL) {
		cout << "\nCustomer Name: " << purchaseTemp->customerName << endl;
		cout << "Purchase No: " << purchaseTemp->purchaseNo << endl;
		cout << "Movie ID: " << purchaseTemp->movieID << endl;
		cout << "Movie Name: " << purchaseTemp->movieName << endl;
		cout << "Date: " << purchaseTemp->date << endl;
		cout << "Start time: " << purchaseTemp->startTime << endl;
		cout << "Duration: " << purchaseTemp->duration << " minutes" << endl;
		cout << "Venue: Hall " << purchaseTemp->venue << endl;
		cout << "Movie Type: " << purchaseTemp->movieType << endl;
		cout << "Quantity: " << purchaseTemp->quantity << endl;
		cout << "Price: RM" << purchaseTemp->price << endl;
		purchaseTemp = purchaseTemp->next;
	}
	cout << "\n";
}

/*=====================================================================================
	SORT PURCHASE
=====================================================================================*/
//(GeeksforGeeks, 2021)
void purchaseFrontBackSplit(purchase* tempHead, purchase** frontRef, purchase**backRef) 
{
	purchase* slow = tempHead;
	purchase* fast = tempHead->next;
	while (fast != NULL) {
		fast = fast->next;
		if (fast != NULL) {
			fast = fast->next;
			slow = slow->next;
		}
	}
	*frontRef = tempHead;
	*backRef = slow->next;
	slow->next = NULL;
}

//(GeeksforGeeks, 2021)
purchase* purchaseMerge(purchase* a, purchase* b) 
{
	purchase* result = NULL;
	if (a == NULL) {
		return b;
	}
	if (b == NULL) {
		return a;
	}
	if (a->price <= b->price) {
		result = a;
		result->next = purchaseMerge(a->next, b);
	}
	else {
		result = b;
		result->next = purchaseMerge(a, b->next);
	}
	return result;
}

//(GeeksforGeeks, 2021)
void sortPurchase(purchase** tempHead) 
{
	purchase* tHead = *tempHead;
	purchase* frontHalf;
	purchase* backHalf;
	if (tHead == NULL || tHead->next == NULL) {
		return;
	}
	purchaseFrontBackSplit(tHead, &frontHalf, &backHalf);
	sortPurchase(&frontHalf);
	sortPurchase(&backHalf);
	*tempHead = purchaseMerge(frontHalf, backHalf);

}

/*=====================================================================================
	PURCHASE DETAIL
=====================================================================================*/
void purchaseDetail() 
{
	if (purchaseHead == NULL && purchaseTail == NULL) {
		cout << "The list is empty." << endl << endl;
		return;
	}
	purchase* purchaseTemp = purchaseHead;
	int purchaseNo;
	cout << "Enter the purchase no: " ;
	cin >> purchaseNo;
	while (purchaseTemp != NULL) {
		if (purchaseNo == purchaseTemp->purchaseNo) {
			cout << "\nCustomer Name: " << purchaseTemp->customerName << endl;
			cout << "Purchase No: " << purchaseTemp->purchaseNo << endl;
			cout << "Movie ID: " << purchaseTemp->movieID << endl;
			cout << "Movie Name: " << purchaseTemp->movieName << endl;
			cout << "Date: " << purchaseTemp->date << endl;
			cout << "Start time: " << purchaseTemp->startTime <<" minutes" << endl;
			cout << "Duration: " << purchaseTemp->duration << endl;
			cout << "Venue: Hall" << purchaseTemp->venue << endl;
			cout << "Movie Type: " << purchaseTemp->movieType << endl;
			cout << "Quantity: " << purchaseTemp->quantity << endl;
			cout << "Price: " << purchaseTemp->price << endl << endl;
			return;
		}
		purchaseTemp = purchaseTemp->next;
	}
	cout << "Purchase NO not found!" << endl;
}
/*=====================================================================================
	INSERT PURCHASE
=====================================================================================*/
void insertPurchase(string customerName,int movieID,string movieName,int date,int startTime,int duration,int venue,string movieType,int ticketAmount,double totalPrice)
{
	movieTemp = movieHead;
	while (movieTemp != NULL) {
		if (movieName == movieTemp->name && movieTemp->type == movieType && movieTemp->date == date && movieTemp->startTime == startTime && movieTemp->availableSeat > 0) {
			movieTemp->availableSeat = movieTemp->availableSeat - ticketAmount;
			break;
		}
		movieTemp = movieTemp->next;
	}
	purchase* newPurchase = new purchase;
	newPurchase->customerName = customerName;
	newPurchase->purchaseNo = purchaseSize + 1;
	newPurchase->movieID = movieID;
	newPurchase->movieName = movieName;
	newPurchase->movieType = movieType;
	newPurchase->date = date;
	newPurchase->startTime = startTime;
	newPurchase->duration = duration;
	newPurchase->venue = venue;
	newPurchase->quantity = ticketAmount;
	newPurchase->price = totalPrice;
	newPurchase->prev = NULL;
	newPurchase->next = NULL;
	if (purchaseHead == NULL && purchaseTail == NULL) {
		purchaseHead = purchaseTail = newPurchase;
	}
	else {
		purchaseTail->next = newPurchase;
		newPurchase->prev = purchaseTail;
		purchaseTail = newPurchase;
	}
	::purchaseSize++;
}
/*
Reference:

1. GeeksforGeeks (26 Nov, 2021). Merge Sort for Linked Lists. GeeksforGeeks.org. https://www.geeksforgeeks.org/merge-sort-for-linked-list/

*/