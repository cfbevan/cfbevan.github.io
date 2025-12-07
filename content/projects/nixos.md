+++
title = "Adventures in NixOS"
description = "Installing NixOS on a new ThinkPad."
date = "2025-11-30"
tags = ["NixOS"]
+++

## It Starts...

{{< mastodon instance="infosec.exchange" id="115619657378081387" >}}

Yes, I got a new Lenovo ThinkPad X1 Carbon 13 Gen on sale for black Friday. I have had ThinkPads off and on since high school when I first started getting in to using Linux. I switched to Mac about five years ago when the M1s came on the the market. I have been super happy with the switch. The connected ecosystem, battery life, and just works was a fresh change from the churn and constant fixing I was doing with Linux. Recently with the addition of AI to everything and the revelations of corporate tracking has made me nostalgic for the control I had over what was running on my laptop back when I ran Linux.

I decided to give NixOS a try this time. I started my Linux journey on Debian back in the day and tended to stay with it for my personal computer use. Debian > Ubuntu > Mint > Manjaro. For work I have mostly been on RedHat and copy cats distributions when RHEL stopped really having LTS versions. NixOS is nothing like anything I have used before, but there is no time to let that scare me now.

## Use Cases

I have a tablet and phone for consuming media. I need my laptop for programming, penetration testing, and generating content (like this site). The number of apps that I need is not a large list:

- Programming
  - Editors (nvim, vscode)
  - Git
  - Docker/Podman
  - Language Tools (uv, golang, bun)
- Penetration testing
  - nmap
  - tcpdump
  - Burp Suite
  - Mitm Proxy
  - WireShark
- Writing
  - pandoc
  - vscode
- Browsers
  - FireFox
  - Vivaldi

I have a good system for Mac to install all of this using `Brew` and a few scripts I wrote. I never took the time before to make a repeatable install for Linux. The closest I have come is using `yadm` to manage dot files.

## Learning

I learn best by listening and then getting some hands on time.Yes, traditional school really worked for me. I found a YouTube user with a shared configuration repository that I could use as examples and to follow along in the videos.

- <https://www.youtube.com/watch?v=6WLaNIlDW0M&list=PL_WcXIXdDWWpuypAEKzZF2b5PijTluxRG>
- <https://gitlab.com/librephoenix/nixos-config>

## Take One

I started by using `Etcher` installed with `Brew` to create a USB installer for NixOs from my Mac. Popped the USB into my laptop and attempted to boot in to the NixOS installer.

> Failure #1: Forgot to turn off signed bootloader protection in the BIOS.

Easy fix, just jumped in to the BIOS, flipped a switch and restarted. The GUI installer for NixOS was pretty straight forward and similar to other installers I have used in the past. I simply set up my username and password, selected no starting UI (foreshadowing), used the recommended formatting for overwriting the whole disk, and clicked go. A few minutes later I was asked to restart. After a quick restart I was provided with a simple login prompt.

This is where all the fun starts. The first thing I did was edit the `/etc/nixos/configuration.nix` file to change my hostname and add `vim`. NoxOs came with `nano` but I could not see me doing major edits without `vim`. I then called `sudo nixos-rebuild switch` which should have rebuilt my configuration and loaded the changes in to my shell.

> Failure #2: Can't rebuild without Internet. How do I get Internet?

I am a bit embarrassed about how long it took me to connect my wireless via a command line only interface. I will save you from teh hour+ I spent going down a rabbit hole on `wpa_cli` and `wpa_supplicant` trying to figure out how to simply connect and getting error after error because `wpa_supplicant` was already running and I could not edit `wlp0s20f3` because the interface was already in use. What I really needed to do was use `nmtui` (network manager) to config the already running `wpa_supplicant` to connect to my wifi.

After getting internet connected and calling `sudo nixos-rebuild` again I was able to get my system to update as expected. I spent the rest of the day writing all my configuration files by hand using the above GitLab repository as examples. I started by just focusing on getting a graphical interface with FireFox installed. I transferred everything to Nix Flakes, got Git installed and tracking my changes, and set up Hyprland with a CacheOS kernel. There were a bunch of places I had to stop and clear up my poor typing. Missing `;` or `:` were the biggest issue I had. Compiling the kernel took over an hour by itself. At the end of the day though I had a working GUI on my system and I went to bed happy with a sense of accomplishment.

## Oops

Starting day two I wanted to harden my now working OS a bit. I wanted to make sure I was running encryption correctly, install Bitwarden, and add biometrics. It was here I noticed that encryption is not as easy to set up in NixOS as the other apps that I have been installing thus far. LUKS encryption has to be enabled at initial install even though that was not a clear option in the installer.

> Failure 3: Failed to set up LUKS at first install.

This was both good news and bad news. The good news was that I now get to test my configs to see if they actually work in rebuilding my system. The bad news is that I have to start over from step 1.

## Take Two

I popped the USB back in and booted back to the installer. This time I had to select "custom partitioning" instead of just erasing the entire disk. This is the only way on NisOS to set up LUKS at installation. I chose a no UI install again, but did not fall in to the same pitfalls I hit the first time. I use `nix-shell --packages git` to clone my saved configuration repo, copied my new `hardware-configuration.nix`, and called `sudo nixos-rebuild --flake .`. After about another hour recompiling the kernel the system booted up in the same state it was in before. This seemed a bit like magic. The only difference I noted was a bit longer startup time due to having to decrypt the hard drive. I spent a few more hours on day two writing more modules to install all the other apps that I wanted in order to use my computer.

## Where I am Now

I have a "working" laptop. There are a few issues that are still outstanding:

- Bitwarden can't auto start and unlock using the keychain.
- Fingerprint reading in Hyprlock requires hitting enter first (known issue).
- Still need to learn Hyprland keybindings. I keep finding myself trying to use Mac keybindings for things like copy and paste as well.
- There are random freezes in the UI and CLI. This started since I first installed NixOS, I am not sure if this is a Linux issue or something wrong with the laptop.
- The startup time after adding LUX increased to an unreasonable time. It went from starting in seconds to taking two minutes to start and even the `nixos-rebuild` command is taking a long time to run.
- I am unable to turn off the mouse tap to click.

This was about two full days of work to set up and I am not 100% there. I have learned quite a bit about how NixOS works and have got comfortable with the basic commands and workflow. Overall a success.

## Plans For the Future

I plan on working on the NixOS problems for a bit more to see if I can fix the parts that bother me. I need to balance the time fixing my system with the time doing things I really want to do. If I am unable to easily fix the above issues I will consider switching to a better supported Debian distribution. While the one command rebuild is really nice, I am not sure it is worth the pain for how few applications I really use.

I have also noticed that 50% of my battery is used with just `vscode` and `FireFox` running. Neither taking more than 10% CPU at any time. The M1 battery life is still better than that even though it is five year old at this point. I will likely get a new M6 MacBook when they come out if they finally add the OLED screens. I will end up using this laptop for smaller edits and virtualization testing. As a programmer it is nice to have both an ARM and Intel chip on hand for testing.

## Update 2025-12-07

I have abandoned Nix for a base Debian + Gnome. the number of issues I was having with NixOS even just opening a file browser. I also was unable to run pre-built linux binaries that did not exist on Nix repositories due to the base file system being different than other distributions. There were just too many issues. I am wondering if there is something wrong with my hard drive. changing directories, saving, listing all seem to lag.
