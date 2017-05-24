#![allow(unused_imports, dead_code, unused_variables)]

use std;
use std::fs::File;
use std::path::{Path, PathBuf};
use std::io::Read;

use chain::*;
use artifact::*;

pub trait BlockchainElement {
    fn encode(&self) -> &[u8];
    fn decode(bytes: &[u8]) -> Self;
}

// FIXME Make this struct deserialize more compactly, like to just a hex string.
#[derive(Serialize, Deserialize)]
pub struct Address {
    id: [u8; 32], // FIXME Make this 32 configuratble based on which hash algo we choose.
}

impl Address {
    pub fn to_str(&self) -> String {

        let mut hex = String::with_capacity(64);

        for b in self.id.into_iter() {

            let conv = |n| match n {
                0 => '0',
                1 => '1',
                2 => '2',
                3 => '3',
                4 => '4',
                5 => '5',
                6 => '6',
                7 => '7',
                8 => '8',
                9 => '9',
                10 => 'a',
                11 => 'b',
                12 => 'c',
                13 => 'd',
                14 => 'e',
                _ => 'f', // ???
            };

            hex.push(conv((b & 0xf0) >> 4));
            hex.push(conv(b & 0x0f));
        }

        assert_eq!(hex.len(), 64);
        hex.to_owned()
    }
}

pub trait Entity {
    fn from_bytes(bytes: &[u8]) -> Self;
    fn to_bytes(&self) -> &[u8];
}

pub trait EntitySource<E>
    where E: Entity
{
    type Err;
    fn load(&self, addr: Address) -> Result<Option<E>, Self::Err>;
    fn publish(&self, ent: E) -> Result<(), Self::Err>;
}

pub struct LocalStorage {
    root: PathBuf,
}

impl LocalStorage {
    fn new(path: PathBuf) -> Result<LocalStorage, ()> {
        if path.is_dir() {
            Ok(LocalStorage { root: path })
        } else {
            Err(())
        }
    }
}

impl<E> EntitySource<E> for LocalStorage
    where E: Entity
{
    type Err = std::io::Error;

    fn load(&self, addr: Address) -> Result<Option<E>, Self::Err> {

        let mut p = self.root.to_owned();
        let addr_str = addr.to_str();
        p.push(&addr_str[..4]);
        p.push(&addr_str[4..]);

        if p.exists() && p.is_file() {

            let mut f = File::open(p)?;
            let mut buf = Vec::new();
            f.read_to_end(buf.as_mut())?;
            Ok(Some(E::from_bytes(buf.as_slice())))

        } else {
            Ok(None)
        }

    }

    fn publish(&self, ent: E) {
        unimplemented!();
    }
}
