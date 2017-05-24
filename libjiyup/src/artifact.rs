#![allow(dead_code)]

use storage::Address;
pub type ArtAddress = Address;

pub struct Artifact {
    signature: [u8; 32],
    header: ArtifactHeader,
    spec: ArtSpec,
}

pub struct ArtifactHeader {
    timestamp: u64,
    author: ArtAddress,
}

pub enum ArtSpec {
    Unknown { ver: u16, raw: Vec<u8> },
    RootIdent(IdentityDeclararionArtifact), // Should this really just be the same?
    IdentDecl(IdentityDeclararionArtifact),
    SimpleTextMsg(SimpleTextMessageArtifact),
}

impl ArtSpec {
    #[allow(unused_variables)]
    fn get_version(self) -> u16 {
        match self {
            ArtSpec::Unknown { ver, raw } => ver,
            ArtSpec::RootIdent(_) => 0x0000,
            ArtSpec::IdentDecl(_) => 0x0001,
            ArtSpec::SimpleTextMsg(_) => 0x0010,
        }
    }
}

pub struct IdentityDeclararionArtifact {
    key: Vec<u8>,
}

pub struct SimpleTextMessageArtifact {
    msg: Vec<u8>,
}
