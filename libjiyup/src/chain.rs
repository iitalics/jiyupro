use storage::Address;
use artifact::ArtAddress;

#[derive(Serialize, Deserialize)]
pub struct Block {
	version: u16,
	parent: BlockAddress,
	timestamp: u64, // UNIX
	author: ArtAddress,
	artifacts: Vec<BlockAddress>
}

type BlockAddress = Address;

#[derive(Serialize, Deserialize)]
pub struct Chunk {
	version: u16,
	parent: ChunkAddress,
	timestamp: u64, // UNIX
	author: ArtAddress,
	difficulty: u64, // FIXME Define this better.
	blocks: Vec<BlockAddress>
}

pub type ChunkAddress = Address;
