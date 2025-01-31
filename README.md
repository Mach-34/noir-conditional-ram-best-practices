# Noir Conditional Array Best Practice Demo

Bad examples show how conditional writes to RAM tables (mutable arrays) in Noir can blow up your circuit.
Good examples show how you can use unconstrained functions to construct your arrays with constrained reads to check the proper output.

See the following constraint counts to see how important this practice is:
```
Bad Array Circuit: 641340 gates
Bad BoundedVec Circuit: 431312 gates
Good Array Circuit: 6073 gates
Good BoundedVec Circuit: 6075 gates
```
Example issues: [noir-lang/noir#6144](https://github.com/noir-lang/noir/issues/6144), [noir-lang/noir#5027](https://github.com/noir-lang/noir/issues/5027)

## Usage
nargo version used: 1.0.0-beta.1+03b58fa2dfcc8acc8cf5198b1b23b55676fbdb02
bb version used: 0.66.0

```console
git clone https://github.com/mach-34/noir-conditional-ram-best-practices
cd noir-conditional-ram-best-practices
# compile the circuits and get gate counts
./scripts/info.sh
# regenerate the flame graphs
./scripts/profile.sh
``` 

### Profiler Prerequisite Dependency
If you want to use the noir profiler ([./scripts/profile.sh](./scripts/profiler.sh)) you must install the profiler. You may need to checkout a specific commit to match your compiler version
```console
git clone https://github.com/noir-lang/noir && cd noir
cd tooling/profiler
cargo install --path .
# Now you should have the profiler installed with:
noir-profiler
```
The script requires bb to be installed and will use `which bb` to find it - if you're having issues, check here firstS

