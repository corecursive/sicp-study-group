use automerge::sync::SyncDoc;
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
        .unwrap();

    let mut peer2 = automerge::AutoCommit::new();
    let mut peer2_state = automerge::sync::State::new();
    peer2
        .sync()
        .receive_sync_message(&mut peer2_state, message1to2)
        .unwrap();

    let message2to1 = peer2
        .sync()
        .generate_sync_message(&mut peer2_state)
        .ok_or(Error {})
        .unwrap();
    peer1
        .sync()
        .receive_sync_message(&mut peer1_state, message2to1)
        .unwrap();

    let message1to2 = peer1
        .sync()
        .generate_sync_message(&mut peer1_state)
        .ok_or(Error {})
        .unwrap();
    peer2
        .sync()
        .receive_sync_message(&mut peer2_state, message1to2)
        .unwrap();
    let mut mine_field2: MineField = hydrate(&peer2).unwrap();

    // Peer 2 modifies the doc
    mine_field2.grid.cells[0][1].state = CellState::Revealed;
    reconcile(&mut peer2, &mine_field2).unwrap();
    let message2to1 = peer2
        .sync()
        .generate_sync_message(&mut peer2_state)
        .ok_or(Error {})
        .unwrap();

    peer1
        .sync()
        .receive_sync_message(&mut peer1_state, message2to1)
        .unwrap();
    let synced: MineField = hydrate(&peer1).unwrap();
    assert_eq!(synced, mine_field2);
    Ok(())
}
