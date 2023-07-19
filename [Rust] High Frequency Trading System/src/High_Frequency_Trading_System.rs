use amiquip::{Connection, ConsumerMessage, ConsumerOptions, Exchange, Publish, Result};
use bma_benchmark::benchmark_stage;
use rand::seq::SliceRandom;
use rand::Rng;
use serde::{Deserialize, Serialize};
use std::{sync::mpsc, sync::Arc, sync::Mutex, thread, time::Duration};

/*
    AUTHOR: THEAN YEE SIN, TP061278, APU3F2209CS
*/

// STOCK STRUCT TO STORE STOCK INFORMATION
#[derive(Clone, Serialize, Deserialize)]
struct Stock {
    name: String,
    price: i32,
    previous_price: i32,
}

// MAIN FUNCTION
//#[benchmark_stage(i = 10, name = "tradingsystem")] // FOR BENCHMARKING
pub fn high_frequency_trading_system() {
    // CREATE 5 SAMPLE STOCKS
    let mut microsoft = Stock {
        name: String::from("Microsoft"),
        price: 97,
        previous_price: 97,
    };
    let mut apple = Stock {
        name: String::from("Apple"),
        price: 80,
        previous_price: 80,
    };
    let mut asus = Stock {
        name: String::from("Asus"),
        price: 90,
        previous_price: 90,
    };
    let mut samsung = Stock {
        name: String::from("Samsung"),
        price: 100,
        previous_price: 100,
    };
    let mut google = Stock {
        name: String::from("Google"),
        price: 110,
        previous_price: 110,
    };

    //STORE STOCKS IN A VECTOR
    let stocks = vec![microsoft, apple, asus, samsung, google];

    //MAKE THE STOCK LIST MUTUAL EXCLUSIVE
    let stock_list = Arc::new(Mutex::new(stocks));

    //CREATE A CHANNEL (NOT FOR RABBITMQ)
    let (s1, r1) = mpsc::channel::<Stock>();

    //STOCK PRODUCER THREAD - INCREASE THE PRICE AND SEND A MESSAGE TO THE STOCK MONITOR THROUGH A CHANNEL
    let stock_producer = thread::spawn(move || {
        let stocks = stock_list.clone();
        loop {
            thread::sleep(Duration::from_millis(5000));
            let mut stocks_list = stocks.lock().unwrap();

            let mut rng = rand::thread_rng();

            let mut stock = stocks_list.choose_mut(&mut rng).unwrap();

            let increment = rng.gen_range(1..10);

            stock.previous_price = stock.price;

            stock.price += increment;

            let new_stock = stock.clone();

            s1.send(new_stock).unwrap();
            println!(
                "Stock Producer : Stock {} new price is RM{}",
                stock.name, stock.price
            );
        }
    });

    //STOCK MONITOR THREAD - RECEIVE MESSAGE FROM STOCK PRODUCER AND SEND A MESSAGE TO THE STOCK RECEIVER THROUGH RABBITMQ
    let stock_monitor = thread::spawn(move || loop {
        let stock = r1.recv().unwrap();
        send_message(stock).unwrap();
    });

    //STOCK RECEIVER THREAD - RECEIVE MESSAGE FROM STOCK MONITOR THROUGH RABBITMQ AND PRINT THE MESSAGE
    let stock_receiver = thread::spawn(move || {
        receive_message();
    });
    loop {}
}

//FUNCTION - SEND MESSAGE THROUGH RABBITMQ
fn send_message(stock: Stock) -> Result<()> {
    //CREATE A CONNECTION
    let mut connection = Connection::insecure_open("amqp://guest:guest@localhost:5672")?;

    //CREATE A CHANNEL
    let channel = connection.open_channel(None)?;

    //CREATE A EXCHANGE
    let exchange = Exchange::direct(&channel);

    //PUBLISH THE MESSAGE
    exchange.publish(Publish::new(
        //SERIALIZE THE MESSAGE (WITH BINCODE AND SERDE), STRUCT -> BYTE ARRAY
        &bincode::serialize(&stock).unwrap(),
        "HighFrequencyTradingSystem",
    ))?;

    //CLOSE THE CONNECTION
    connection.close()
}

//FUNCTION - RECEIVE MESSAGE THROUGH RABBITMQ
fn receive_message() -> Result<()> {
    //CREATE A CONNECTION
    let mut connection = Connection::insecure_open("amqp://guest:guest@localhost:5672")?;

    //CREATE A CHANNEL
    let channel = connection.open_channel(None)?;

    //DECLARE A QUEUE
    let queue = channel.queue_declare(
        "HighFrequencyTradingSystem",
        amiquip::QueueDeclareOptions::default(),
    )?;

    //LAUNCH A CONSUMER
    let consumer = queue.consume(ConsumerOptions::default())?;

    //RECEIVE THE MESSAGE
    for (i, message) in consumer.receiver().iter().enumerate() {
        match message {
            ConsumerMessage::Delivery(delivery) => {
                //DESERIALIZE THE MESSAGE (WITH BINCODE AND SERDE), BYTE ARRAY -> STRUCT
                let stock: Stock = bincode::deserialize(&delivery.body).unwrap();
                println!(
                    "Stock Receiver : Received Update from Stock {}, New price is RM{}\n",
                    stock.name, stock.price
                );
                if stock.price > 150 {
                    println!(
                        "\nStock Receiver : Stock {} is overpriced, sell it now!\n",
                        stock.name
                    );
                }
            }
            _ => {
                println!("Stock Receiver : I Received Something Else");
            }
        }
    }

    //CLOSE THE CONNECTION
    connection.close()
}
