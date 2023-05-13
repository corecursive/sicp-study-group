use autosurgeon::{Reconcile, Hydrate};

// A simple contact document

#[derive(Debug, Clone, Reconcile, Hydrate, PartialEq)]
pub struct MineField {
    grid: Grid,
}

#[derive(Debug, Clone, Reconcile, Hydrate, PartialEq)]
pub struct Grid {
    cells: Vec<Vec<Cell>>,
}

impl Grid {
    pub fn new(size: usize) -> Grid {
        Grid {
            cells: vec![vec![Cell::default(); size]; size],
        }
    }
}

#[derive(Debug, Clone, Reconcile, Hydrate, PartialEq)]
pub struct Cell {
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
pub enum CellState {
    Hidden,
    Flagged,
    Revealed,
}

pub const FIELD_SIZE: usize = 3;


// This is the service definition. It looks a lot like a trait definition.
// It defines one RPC, sync, which takes one arg, name, and returns a String.
#[tarpc::service]
pub trait Rpc {
    async fn sync(name: Vec<u8>) -> Vec<u8>;
    async fn connect(client: ()) -> u8;
}
