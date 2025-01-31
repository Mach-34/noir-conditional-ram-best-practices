global SIZE_1: u32 = 64;
global SIZE_2: u32 = 128;

/**
 * Packs elements from two arrays into a single array
 * @notice in practice you'd use this to call std::hash::sha256_var(packed_preimage, packed_length as u64)
 *         but we want to isolate the cost of the circuit to conditional RAM usage
 * @notice BAD EXAMPLE: GENERATES xxx CONSTRAINTS
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
    let mut packed = [0; SIZE_1 + SIZE_2];
    let mut index = 0;
    for i in 0..SIZE_1 {
        if i < item_1_length {
            packed[index] = item_1[i];
            index += 1;
        }
    }
    for i in 0..SIZE_2 {
        if i < item_2_length {
            packed[index] = item_2[i];
            index += 1;
        }
    }
    (packed, index)
}