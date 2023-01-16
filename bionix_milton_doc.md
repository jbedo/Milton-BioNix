# Running BioNix on Milton

To run [BioNix](https://github.com/PapenfussLab/bionix) on Milton run:
```{sh}
$ ssh vc7-shared
```
and type in your WEHI password. Nix can only be run in this node. Also run:
```{sh}
$ module load nix git
```
To use Nix and a more current version of git. Also run:
```{sh}
$ nix-chroot bash
```
To bind mount your personal user store. Otherwise you will get a broken symlink when you build an expression.
Now just run BioNix as you would on your local machine. E.g. `nix build`. 

If you want to use [nixpkgs](https://github.com/NixOS/nixpkgs/tree/master/pkgs), you use:
```{nix}
with import (builtins.getFlake "nixpkgs") {};
```
rather than `with import <nixpkgs> {};` as channels are not configured with `nix-channel`

## Testing BioNix on Milton

To ensure BioNix is working correctly on Milton we will test it with [Kai Bing's](https://github.com/victorwkb) [BioNix-qc-pipe](https://github.com/victorwkb/BioNix-qc-pipe).

First, make sure you have correctly set up Nix on Milton according to the instructions above, then in your home directory or your preferred location in Milton, run:
```{sh}
$ git clone https://github.com/victorwkb/BioNix-qc-pipe.git
```

Then:
```{sh}
$ cd BioNix-qc-pipe/subread-wf/
```

To build, run:
```{sh}
$ nix build
```

You can see the results with:
```{sh}
$ cat result
```

To ensure the result is correct we will compare it with the expected result.
A couple of files are required to do this test, you can get them by doing:
```{sh}
$ git clone --depth 1 https://github.com/dansunwz/Milton-BioNix.git
```

Now let's change the directory to the test folder we've just cloned:
```{sh}
$ cd Milton-BioNix/Milton_bionix_test/
```

Give permission to run the shell script by typing in:
```{sh}
$ chmod +x test.sh
```
Now run the script:
```{sh}
$ ./test.sh
```

After running the script `test.sh`, a prompt will show up in the terminal to tell you whether BioNix is working as intended. If it is not working, please follow the guide from the beginning and try to configure BioNix again.

