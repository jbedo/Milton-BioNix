# Running BioNix on Milton

Milton can be accessed via [WEHI RAP](https://rap.wehi.edu.au/), under the tab **RDP – SSH**. After entering your WEHI login details, select **SSH – slurm-login**. You will now see a welcome message, indicating that you have successfully connected to Milton.

## Setting up BioNix

To run [BioNix](https://github.com/PapenfussLab/bionix) on Milton, we first need to switch the node to `vc7-shared` as Nix can only be run in this node. Run the following command:
```{sh}
ssh vc7-shared
```
and type in your WEHI password. You will see another message that tells you have switched node successfully.
If you wish to read more about the node `vc7-shared`, you can refer to this [page](https://wehieduau.sharepoint.com/sites/rc2/SitePages/using-milton.aspx) in WEHI's [Research Computing Website](https://wehieduau.sharepoint.com/sites/rc2).

Using BioNix on Milton requires dependencies [Nix](https://nixos.org/) and [Git](https://git-scm.com/). Note that although Git is installed globally on Milton, it is an older version (view by `git --version`). 
To load them, type in: (loading Nix will also load a later version of Git)
```{sh}
module load nix
```
Application software on Milton is provided through [Environment Modules](https://modules.sourceforge.net/) and can be accessed via `module` command. For more information, please refer to the page [Accessing software](https://wehieduau.sharepoint.com/sites/rc2/SitePages/modules.aspx).

Since Nix is not installed globally on Milton, it is important to bind mount your personal user store using:
```{sh}
nix-chroot bash
```
Bind mount allows you to mount Nix to another location in the file system (i.e. your personal store) so that you can get access to it. Otherwise you will get a broken symlink when you build an expression.
Now you can run BioNix as you would on your local machine. E.g. `nix build`. 

If you want to use [nixpkgs](https://github.com/NixOS/nixpkgs/tree/master/pkgs), you use:
```{nix}
with import (builtins.getFlake "nixpkgs") {};
```
rather than `with import <nixpkgs> {};` as channels are not configured with `nix-channel`.


## Testing BioNix

To ensure BioNix is working correctly on Milton we will test it with [Kai Bing's BioNix-qc-pipe](https://github.com/victorwkb/BioNix-qc-pipe).

First, make sure you have correctly set up Nix on Milton according to the instructions above, then in your home directory or your preferred location on Milton, build the expression using:
```{sh}
nix build github:victorwkb/BioNix-qc-pipe?dir=subread-wf
```
By default a symlink to the build result is created with the name `result`. 
You can view the results with:
```{sh}
cat result
```

To ensure the result is correct we will compare it with the expected result.
Run
```{sh}
sha256sum ./result
```
and verify it matches `4981a389ae8fc26be195a664b3ed19f7766eee59e2af22daea689bb4780b5cdf`.
