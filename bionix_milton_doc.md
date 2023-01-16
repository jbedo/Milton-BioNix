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
First access [subread-wf-output.txt](https://wehieduau.sharepoint.com/:t:/r/sites/StudentInternGroupatWEHI/Shared%20Documents/BioNix%20Introduction/subread-wf-output.txt?csf=1&web=1&e=PsQQ7z), and copy all the contents of this file (ctrl-a).
Then create a new file called `subread-wf-output.txt`, in the `/BioNix-qc-pipe/subread-wf` directory by running:
```{sh}
$ vim subread-wf-output.txt
```
then entering 'insert mode' by pressing 'i', pasting with right-click, deleting the empty last line by exiting 'insert-mode' with the escape key and pressing 'dd' (two lowercase d's), and exiting and saving by pressing 'ZZ' (two capital z's).
Now run:
```{sh}
$ diff result subread-wf-output.txt
```
which will compare the result to the expected result. If the last command does not output anything to the terminal, that means the contents of the file are the same and nix has been run successfully.
