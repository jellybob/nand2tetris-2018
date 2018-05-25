#[macro_use]
extern crate clap;
use clap::App;
use clap::ArgMatches;

extern crate compiler;

fn main() {
    let cli_config = load_yaml!("cli.yaml");
    let args = App::from_yaml(cli_config).get_matches();

    match args.subcommand_name() {
        Some("assemble") => assemble(args),
        _ => panic!("Invalid subcommand"),
    }
}

fn assemble(args: ArgMatches) {
    if let Some(sub_args) = args.subcommand_matches("assemble") {
        println!("Assembling {}", sub_args.value_of("INPUT").unwrap());
    }
}
