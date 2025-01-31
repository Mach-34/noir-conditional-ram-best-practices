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
    pack(item_1, item_2)
}

/**
 * Unconstrained packing of two bounded vectors into one to avoid conditional RAM usage
 * @notice - this cannot be called directly - call pack() to get constrained packed BoundedVec
 *
 * @param item_1: the first bounded vector containing the bytes to pack
 * @param item_2: the second bounded vector containing the bytes to pack
 * @return the packed bounded vector
 */ 
unconstrained fn __pack<let N: u32, let M: u32>(
    item_1: BoundedVec<u8, N>,
    item_2: BoundedVec<u8, M>
) -> BoundedVec<u8, N + M> {
    let mut preimage: BoundedVec<u8, N + M> = BoundedVec::new();
    preimage.extend_from_bounded_vec(item_1);
    preimage.extend_from_bounded_vec(item_2);
    preimage
}

/**
 * Calls unconstrained packing of two bounded vectors into one and checks the result
 * 
 * @param item_1: the first bounded vector containing the bytes to pack
 * @param item_2: the second bounded vector containing the bytes to pack
 * @return the packed bounded vector
 */
fn pack<let N: u32, let M: u32>(
    item_1: BoundedVec<u8, N>,
    item_2: BoundedVec<u8, M>,
) -> BoundedVec<u8, N + M> {
    // unconstrained construction of array
    let packed= unsafe { __pack(item_1, item_2) };
    // check length
    assert(item_1.len() + item_2.len() == packed.len());
    // check packing of element 1
    for i in 0..N {
        let out_of_bounds = i > item_1.len();
        let matched = item_1.get_unchecked(i) == packed.get_unchecked(i);
        assert(out_of_bounds | matched);
    }
    // check packing of element 2
    for i in 0..M {
        let out_of_bounds = i > item_2.len();
        let idx = i + item_1.len();
        let matched = item_2.get_unchecked(i) == packed.get_unchecked(idx);
        assert(out_of_bounds | matched);
    }
    // return
    packed
}