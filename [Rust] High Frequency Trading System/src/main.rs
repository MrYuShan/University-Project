mod High_Frequency_Trading_System;

use bma_benchmark::{benchmark, benchmark_stage, staged_benchmark_print_for};
use perf_monitor::cpu::{processor_numbers, ProcessStat, ThreadStat};
use perf_monitor::mem::get_process_memory_info;
use High_Frequency_Trading_System::*;

fn main() {
    high_frequency_trading_system();

    // FOR PROFILING
    // let mem_info = get_process_memory_info().unwrap();
    // let mut stat_p = ProcessStat::cur().unwrap();
    // let usage_p = stat_p.cpu().unwrap() * 100f64;
    // println!(
    //     "[Memory] Memory used: {} bytes ",
    //     mem_info.resident_set_size
    // );
    // println!("[CPU] process usage: {:.2}%", usage_p);

    // FOR BENCHMARKING
    // staged_benchmark_print_for!("tradingsystem");
}
