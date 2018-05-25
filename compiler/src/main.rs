#[macro_use]
extern crate clap;
use clap::App;
use clap::ArgMatches;

extern crate compiler;

fn main() {
    let cli_config = load_yaml!("cli.yaml");
    let args = App::from_yaml(cli_config).get_matches();

    match args.subcommand_name() {
        Some("assemble") => assemble(args.subcommand_matches("assemble").unwrap()),
        _ => panic!("Invalid subcommand"),
    }
}

fn assemble(args: &ArgMatches) {
    println!("Assembling {}", args.value_of("INPUT").unwrap());
}
