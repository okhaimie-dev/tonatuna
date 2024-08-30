// Internal imports

// use tonatuna::elements::tuna;

#[derive(Copy, Drop)]
enum CommitStatus {
    None,
    Committed,
    Revealed,
    Used
}

#[generate_trait]
impl CommitStatusImpl of CommitStatusTrait {}

impl IntoCommitStatusFelt252 of core::Into<CommitStatus, felt252> {
    #[inline]
    fn into(self: CommitStatus) -> felt252 {
        match self {
            CommitStatus::None => 'NONE',
            CommitStatus::Committed => 'COMMITTED',
            CommitStatus::Revealed => 'REVEALED',
            CommitStatus::Used => 'USED'
        }
    }
}

impl IntoCommitStatusU8 of core::Into<CommitStatus, u8> {
    #[inline]
    fn into(self: CommitStatus) -> u8 {
        match self {
            CommitStatus::None => 0,
            CommitStatus::Committed => 1,
            CommitStatus::Revealed => 2,
            CommitStatus::Used => 3
        }
    }
}

impl IntoU8CommitStatus of core::Into<u8, CommitStatus> {
    #[inline]
    fn into(self: u8) -> CommitStatus {
        let commit_status: felt252 = self.into();
        match commit_status {
            0 => CommitStatus::None,
            1 => CommitStatus::Committed,
            2 => CommitStatus::Revealed,
            3 => CommitStatus::Used,
            _ => CommitStatus::None
        }
    }
}

impl CommitStatusPrint of core::debug::PrintTrait<CommitStatus> {
    #[inline]
    fn print(self: CommitStatus) {
        let felt: felt252 = self.into();
        felt.print();
    }
}

