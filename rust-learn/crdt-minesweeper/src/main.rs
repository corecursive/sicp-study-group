use std::{
    io::{BufReader, Write},
    net::TcpListener, future::{Ready, self},
};

use automerge::sync::{Message, SyncDoc};
use autosurgeon::{reconcile, Hydrate, Reconcile};

use tarpc::{
    client, context,
    server::{self, incoming::Incoming, Channel},
};

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

// This is the service definition. It looks a lot like a trait definition.
// It defines one RPC, hello, which takes one arg, name, and returns a String.
#[tarpc::service]
trait Rpc {
    async fn hello(name: Vec<u8>) -> Vec<u8>;
}

// This is the type that implements the generated World trait. It is the business logic
// and is used to start the server.
#[derive(Clone)]
struct GameServer;

impl Rpc for GameServer {
    // Each defined rpc generates two items in the trait, a fn that serves the RPC, and
    // an associated type representing the future output by the fn.
    type HelloFut = Ready<Vec<u8>>;

    fn hello(self, _: context::Context, name: Vec<u8>) -> Self::HelloFut {
        future::ready(name)
    }
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let (client_transport, server_transport) = tarpc::transport::channel::unbounded();

    let server = server::BaseChannel::with_defaults(server_transport);
    tokio::spawn(server.execute(GameServer.serve()));

    // WorldClient is generated by the #[tarpc::service] attribute. It has a constructor `new`
    // that takes a config and any Transport as input.
    let mut client = RpcClient::new(client::Config::default(), client_transport).spawn();
    let hello = client.hello(context::current(), vec![]).await?;

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
        if let Ok(message) = &two_to_one {
            println!("two to one");
            peer1
                .sync()
                .receive_sync_message(&mut peer1_state, message.to_owned())
                .unwrap();
        }
        let one_to_two = peer1.sync().generate_sync_message(&mut peer1_state);
        if let Some(message) = &one_to_two {
            println!("one to two");
            stream.write(&message.to_owned().encode());
        }
        if (&two_to_one).is_err() && one_to_two.is_none() {
            break;
        }
    }

    Ok(())
}
