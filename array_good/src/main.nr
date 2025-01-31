global SIZE_1: u32 = 64;
global SIZE_2: u32 = 128;

/**
 * Packs elements from two arrays into a single array
 * @notice in practice you'd use this to call std::hash::sha256_var(packed_preimage, packed_length as u64)
 *         but we want to isolate the cost of the circuit to conditional RAM usage
 * @notice GOOD EXAMPLE: GENERATES xxx CONSTRAINTS
 *
 * @param item_1: the first array containing the bytes to pack
 * @param item_1_length: the number of items from the first array to pack
 * @param item_2: the second array containing the bytes to pack
 * @param item_2_length: the number of items from the second array to pack
 * @return the packed array and the number of items packed
 */
fn main(
    item_1: [u8; SIZE_1],
    item_1_length: u32,
    item_2: [u8; SIZE_2],
    item_2_length: u32
) -> pub ([u8; SIZE_1 + SIZE_2], u32) {
    pack(item_1, item_1_length, item_2, item_2_length)
}

/**
 * Unconstrained packing of two arrays into one to avoid conditional RAM usage
 * @notice - this cannot be called directly - call pack() to get constrained packed array
 * 
 * @param item_1: the first array containing the bytes to pack
 * @param item_1_length: the number of items from the first array to pack
 * @param item_2: the second array containing the bytes to pack
 * @param item_2_length: the number of items from the second array to pack
 * @return the packed array
 */
unconstrained fn __pack<let N: u32, let M: u32>(
    item_1: [u8; N],
    item_1_length: u32,
    item_2: [u8; M],
    item_2_length: u32
) -> [u8; N + M] {
    let mut preimage = [0; N + M];
    let mut index = 0;
    for i in 0..N {
        if i < item_1_length {
            preimage[index] = item_1[i];
            index += 1;
        }
    }
    for i in 0..M {
        if i < item_2_length {
            preimage[index] = item_2[i];
            index += 1;
        }
    }
    preimage
}

/**
 * Calls unconstrained packing of two arrays into one and checks the result
 *
 * @param item_1: the first array containing the bytes to pack
 * @param item_1_length: the number of items from the first array to pack
 * @param item_2: the second array containing the bytes to pack
 * @param item_2_length: the number of items from the second array to pack
 * @return the packed array and the number of items packed
 */
fn pack<let N: u32, let M: u32>(
    item_1: [u8; N],
    item_1_length: u32,
    item_2: [u8; M],
    item_2_length: u32,
) -> ([u8; N+M], u32){
    // unconstrained construction of array
    let packed= unsafe { __pack(item_1, item_1_length, item_2, item_2_length) };
    // check packing of element 1
    for i in 0..N {
        let out_of_bounds = i > item_1_length;
        let matched = item_1[i] == packed[i];
        assert(out_of_bounds | matched);
    }
    // check packing of element 2
    for i in 0..M {
        let out_of_bounds = i > item_2_length;
        let idx = i + item_1_length;
        let matched = item_2[i] == packed[idx];
        assert(out_of_bounds | matched);
    }
    // set length
    let length = item_1_length + item_2_length;
    // return
    (packed, length)
}