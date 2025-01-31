global SIZE_1: u32 = 64;
global SIZE_2: u32 = 128;

/**
 * Packs elements from two bounded vectorss into one
 * @notice in practice you'd use this to call std::hash::sha256_var(packed.storage(), packed.len() as u64)
 *         but we want to isolate the cost of the circuit to conditional RAM usage
 * @notice BAD EXAMPLE: GENERATES xxx CONSTRAINTS
 *
 * @param item_1: the first bounded vector containing the bytes to pack
 * @param item_2: the second bounded vector containing the bytes to pack
 * @return the packed bounded vector
 */
fn main(
    item_1: BoundedVec<u8, SIZE_1>,
    item_2: BoundedVec<u8, SIZE_2>
) -> pub BoundedVec<u8, SIZE_1 + SIZE_2> {
    let mut packed: BoundedVec<u8, SIZE_1 + SIZE_2> = BoundedVec::new();
    packed.extend_from_bounded_vec(item_1);
    packed.extend_from_bounded_vec(item_2);
    packed
}