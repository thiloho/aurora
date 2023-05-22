---
cover: "../../assets/blog/nix-flake-examples/cover.jpg"
coverAlt: "Cover image for the blog post"
title: "Nix flake examples"
publicationDate: 2023-05-12
description: "Improve reproducibility, composability and usability of nix-based projects with flakes and the experimental cli commands."
---

## Multi-machine configuration

```
nixos-config
├── flake.nix
└── nixos-configurations
    ├── laptop
    │   ├── default.nix
    │   └── hardware-configuration.nix
    ├── pc
    │   ├── default.nix
    │   └── hardware-configuration.nix
    └── shared.nix
```

```nix
{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos-configurations/pc
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
            };
          }
        ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos-configurations/laptop
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
            };
          }
        ];
      };
    };
  };
}
```

### Set up a new machine

First, complete the following steps:

1. Create a new GitHub repository and push your configuration to the repository
2. Boot the machine you wish to install on with the minimal NixOS ISO image
3. Follow the instructions in the [nixos installation guide](https://nixos.org/manual/nixos/stable/index.html#sec-installation-manual-summary) until `nixos-generate-config --root /mnt`

After that, you can use these commands:

```
nix-shell -p git
git clone https://github.com/<username>/<repository>.git
cd <config>/nixos-configurations/<machine>
nixos-generate-config --root /mnt --show-hardware-config > hardware-configuration.nix
git add --all
git commit -m "Set hardware configuration for new machine"
git push -u origin main
cd ~
nixos-install --flake github:<username>/<repository>#<configuration>
```

And that is it. Once the installation is done, you can set the root password, reboot, unplug the boot medium and enjoy your new system.

#### Example machine installation

An example of the above procedure for the `laptop` configuration, defined in `flake.nix` of [my minimal multihost configuration](https://github.com/thiloho/nixos-config)

```
nix-shell -p git
git clone https://github.com/thiloho/nixos-config.git
cd nixos-config/nixos-configurations/laptop
nixos-generate-config --root /mnt --show-hardware-config > hardware-configuration.nix
git add --all
git commit -m "Set hardware configuration for new machine"
git push -u origin main
cd ~
nixos-install --flake github:thiloho/nixos-config#laptop

```

### Changing and rebuilding configuration of another machine remotely

Suppose you want to host a new service on your NixOS server that is several hundred kilometers away from you. In that case, it would be very handy to use a nearby machine to remotely update the server's configuration.

You can easily do that by updating the configuration file for the machine and then deploying the changes with the following command:

```
nixos-rebuild switch --flake .#server root@<ip-adress>
```

Of course, you can also use the configuration of some GitHub flake or whatever:

```
nixos-rebuild switch --flake github:<username>/<repository>#<configuration> root@<ip-address>
```

#### Example remote deployment

```
nixos-rebuild switch --flake github:thiloho/nixos-config#laptop root@142.251.46.206
```

## Development environments

```
website
├── astro.config.ts
├── flake.lock
├── flake.nix
├── LICENSE
├── node_modules
├── package.json
├── package-lock.json
├── public
├── README.md
├── src
├── svelte.config.ts
└── tsconfig.json
```

```nix
{
  description = "JavaScript development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }:
    let
      # Systems supported
      allSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      
      forAllSystems = f: nixpkgs.lib.genAttrs allSystems (system: f {
        pkgs = nixpkgs.legacyPackages.${system};
      });
    in
    {
      devShells = forAllSystems ({ pkgs }: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            nodejs
            tree
            exa
            fd
          ];
          
          shellHooks = ''
            alias ls = exa
            alias find = fd
          '';
        };
      });
    };
}
```

In the root of the project directory, you can now use the command `nix develop` to enter the development environment with the specified set of build dependencies.

That means the packages `nodejs`, `tree`, `exa` and `fd`, as well as the aliases are now available for you to use, and they are "scoped" to the project. This is beneficial because it allows you to make specific dependencies available only where they are needed.

## Conclusion

Of course, you can do much more with flakes, but multi-machine configurations and development environments are the features I have found most useful so far.

The examples provided are minimal and straightforward, but you can expand them as much as you want and achieve some impressive results.

I took the project structures and flake files used in this article from [my website source code](https://github.com/thiloho/website) and [my nixos-config source code](https://github.com/thiloho/nixos-config), so feel free to check these repositories out.
