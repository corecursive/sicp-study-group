use std::{
    io::{BufReader, Write},
    net::TcpListener,
};

use automerge::sync::{Message, SyncDoc};
use autosurgeon::{hydrate, reconcile, Hydrate, Reconcile};

// A simple contact document

#[derive(Debug, Clone, Reconcile, Hydrate, PartialEq)]
struct MineField {
    grid: Grid,
}

#[derive(Debug, Clone, Reconcile, Hydrate, PartialEq)]
struct Grid {
    cells: Vec<Vec<Cell>>,
}

impl Grid {
    fn new(size: usize) -> Grid {
        Grid {
            cells: vec![vec![Cell::default(); size]; size],
        }
    }
}

#[derive(Debug, Clone, Reconcile, Hydrate, PartialEq)]
struct Cell {
    state: CellState,
    has_a_mine: bool,
}

impl Default for Cell {
    fn default() -> Self {
        Cell {
            state: CellState::Hidden,
            has_a_mine: false,
        }
    }
}

#[derive(Debug, Clone, Reconcile, Hydrate, PartialEq)]
enum CellState {
    Hidden,
    Flagged,
    Revealed,
}

const FIELD_SIZE: usize = 3;

#[derive(Debug)]
struct Error;

impl std::error::Error for Error {}

impl std::fmt::Display for Error {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "")
    }
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let listener = TcpListener::bind("127.0.0.1:7878").unwrap();

    let mut stream = listener.incoming().next().unwrap()?;
    let mut peer1 = automerge::AutoCommit::new();
    let mut peer1_state = automerge::sync::State::new();
    // Peer 1 puts data into the document
    reconcile(
        &mut peer1,
        &MineField {
            grid: Grid::new(FIELD_SIZE),
        },
    )
    .unwrap();
    let message1to2 = peer1
        .sync()
        .generate_sync_message(&mut peer1_state)
        .ok_or(Error {})
        .unwrap()
        .encode();

    stream.write(&message1to2);

    loop {
        let buf_reader = BufReader::new(&stream);
        // TODO need to handle message length to ensure proper decoding
        // use gRPC or something? Maybe https://github.com/google/tarpc/
        let two_to_one = Message::decode(buf_reader.buffer());
        if let Ok(message) = two_to_one {
            println!("two to one");
            peer1
                .sync()
                .receive_sync_message(&mut peer1_state, message)
                .unwrap();
        }
        let one_to_two = peer1.sync().generate_sync_message(&mut peer1_state);
        if let Some(message) = one_to_two {
            println!("one to two");
            stream.write(&message.encode());
        }
        if (&two_to_one).is_err() && one_to_two.is_none() {
            break;
        }
    }

    Ok(())
}
