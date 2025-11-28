use std::env;
use std::fs::{self, OpenOptions};
use std::io::Write;
use std::path::PathBuf;
use std::process;

fn main() {
    // Collect command-line arguments
    let args: Vec<String> = env::args().collect();

    // Check if a note was provided
    if args.len() < 2 {
        eprintln!("Usage: note <your note text>");
        eprintln!("       note list");
        eprintln!("Example: note 'aurynk, an android device manager and mirroring tool for linux'");
        process::exit(1);
    }

    // Get the home directory
    let home_dir = match dirs::home_dir() {
        Some(path) => path,
        None => {
            eprintln!("Error: Could not determine home directory");
            process::exit(1);
        }
    };

    // Construct the path to notes.md
    let notes_path: PathBuf = home_dir.join("notes.md");

    // Check if the command is "list"
    if args[1] == "list" {
        if let Err(e) = list_notes(&notes_path) {
            eprintln!("Error reading notes: {}", e);
            process::exit(1);
        }
        return;
    }

    // Join all arguments after the program name into a single note
    let note = args[1..].join(" ");

    // Append the note to the file
    if let Err(e) = append_note(&notes_path, &note) {
        eprintln!("Error writing note: {}", e);
        process::exit(1);
    }

    println!("Note added to {}", notes_path.display());
}

fn append_note(path: &PathBuf, note: &str) -> std::io::Result<()> {
    let mut file = OpenOptions::new()
        .create(true)
        .append(true)
        .open(path)?;

    writeln!(file, "- {}", note)?;

    Ok(())
}

fn list_notes(path: &PathBuf) -> std::io::Result<()> {
    // Check if the file exists
    if !path.exists() {
        // No notes yet, exit silently
        return Ok(());
    }

    // Read the entire file
    let contents = fs::read_to_string(path)?;

    // Print each note, removing the markdown bullet prefix
    for line in contents.lines() {
        let trimmed = line.trim();
        if trimmed.starts_with("- ") {
            // Remove the "- " prefix
            println!("{}", &trimmed[2..]);
        } else if !trimmed.is_empty() {
            // Print non-empty lines that don't have the bullet format
            println!("{}", trimmed);
        }
    }

    Ok(())
}
