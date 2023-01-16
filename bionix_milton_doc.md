# Running BioNix on Milton

Milton can be accessed via [WEHI RAP](https://rap.wehi.edu.au/), under the tab **RDP – SSH**. After entering your WEHI login details, select **SSH – slurm-login**. You will now see a welcome message, indicating that you have successfully connected to Milton.

## Setting up BioNix

To run [BioNix](https://github.com/PapenfussLab/bionix) on Milton, we first need to switch the node to `vc7-shared` as Nix can only be run in this node. Run the following command:
```{sh}
$ ssh vc7-shared
```
and type in your WEHI password. You will see another message that tells you have switched node successfully.
If you wish to read more about the node `vc7-shared`, you can refer to this [page](https://wehieduau.sharepoint.com/sites/rc2/SitePages/using-milton.aspx) in WEHI's [Research Computing Website](https://wehieduau.sharepoint.com/sites/rc2).


Using BioNix on Milton requires dependencies [Nix](https://nixos.org/) and [Git](https://git-scm.com/). To load them, type in:
```{sh}
$ module load nix git
```


Since Nix is not installed globally on Milton, it is important to bind mount your personal user store using:
```{sh}
$ nix-chroot bash
```
Otherwise you will get a broken symlink when you build an expression.
Now you can run BioNix as you would on your local machine. E.g. `nix build`. 


If you want to use [nixpkgs](https://github.com/NixOS/nixpkgs/tree/master/pkgs), you use:
```{nix}
with import (builtins.getFlake "nixpkgs") {};
```
rather than `with import <nixpkgs> {};` as channels are not configured with `nix-channel`.


## Testing BioNix

To ensure BioNix is working correctly on Milton we will test it with [Kai Bing's BioNix-qc-pipe](https://github.com/victorwkb/BioNix-qc-pipe).

First, make sure you have correctly set up Nix on Milton according to the instructions above, then in your home directory or your preferred location on Milton, run:
```{sh}
$ git clone https://github.com/victorwkb/BioNix-qc-pipe.git
```

Now change the directory to `subread-wf`:
```{sh}
$ cd BioNix-qc-pipe/subread-wf/
```

Build the expression using:
```{sh}
$ nix build
```
This will build the `default.nix` file in the current directory.

You can view the results with:
```{sh}
$ cat result
```

To ensure the result is correct we will compare it with the expected result.
A couple of files are required to do this test, you can get them by doing:
```{sh}
$ git clone --depth 1 https://github.com/dansunwz/Milton-BioNix.git
```

Now change directory to the test folder we've just cloned:
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

After running the script `test.sh`, a prompt will show up in the terminal to tell you whether BioNix is working as intended. If it isn't, please follow the guide from the beginning and try to configure BioNix again.

