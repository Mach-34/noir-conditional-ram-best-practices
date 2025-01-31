global SIZE_1: u32 = 64;
global SIZE_2: u32 = 128;

fn main(
    item_1: BoundedVec<u8, SIZE_1>,
    item_2: BoundedVec<u8, SIZE_2>
// ) -> pub [u8; 32] {
) -> pub ([u8; SIZE_1 + SIZE_2], u32) {
    let (packed_preimage, packed_length) = good_packing(item_1.storage, item_1.len, item_2.storage, item_2.len);
    
    // let packed_preimage = unsafe {
    //     __pack(
    //         item_1.storage,
    //         item_1.len,
    //         item_2.storage,
    //         item_2.len
    //     )
    // };
    // check_packing(
    //     item_1.storage,
    //     item_1.len,
    //     item_2.storage,
    //     item_2.len,
    //     packed_preimage
    // );
    // let packed_length = item_1.len + item_2.len;
    (packed_preimage, packed_length)

    // let ()
    // let hash = std::hash::sha256_var(packed_preimage, packed_length as u64);
    // hash
}

fn bad_packing<let N: u32, let M: u32>(
    item_1: [u8; N],
    item_1_length: u32,
    item_2: [u8; M],
    item_2_length: u32
) -> ([u8; N + M], u32) {
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
    (preimage, index)
}

fn good_packing<let N: u32, let M: u32>(
    item_1: [u8; N],
    item_1_length: u32,
    item_2: [u8; M],
    item_2_length: u32
) -> ([u8; N + M], u32) {
    let mut preimage = [0; N + M];
    let mut index = 0;
    for i in 1..N {
        let mut current_index = 0;
        if i < item_1_length {
            index += 1;
            current_index = index;
        }
        preimage[current_index] = item_1[i];
    }
    for i in 0..M {
        let mut current_index = 0;
        if i < item_2_length {
            index += 1;
            current_index = index;
        }
        preimage[current_index] = item_2[i];
    }
    preimage[0] = item_1[0];
    (preimage, index)
}

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

fn check_packing<let N: u32, let M: u32>(
    item_1: [u8; N],
    item_1_length: u32,
    item_2: [u8; M],
    item_2_length: u32,
    packed_preimage: [u8; N + M]
) {
    for i in 0..N {
        let switch = i > item_1_length;
        let item_match = item_1[i] == packed_preimage[i];
        let correct = (switch | item_match);
        assert(correct);
    }
    for i in 0..M {
        let switch = i > item_2_length;
        let idx = i + item_1_length;
        let item_match = item_2[i] == packed_preimage[idx];
        let correct = (switch | item_match);
        assert(correct);
    }
}