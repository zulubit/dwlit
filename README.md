# DWLit - a fork of DWL with a lot of extras by zulubit

![Screenshot](screenshot.png)

![Screenshot2](screenshot2.png)

## Building:

A script is included that fires all the build commands:

If you havent already, clone the repository, install the dependencies and:

```bash
cd ~/dwlit/dwlit
./rebuild.sh
```

whenever you change your **config.def.h** you should use the same script to rebuild.

if you decide to do changes to **config.h** directly you should just run

```bash
cd ~/dwlit
sudo make install clean
```

## Apply theme and fonts

There is a script provided to install the *Nord GTK theme* and *Hack Nerd Font* 

```bash
cd ~/dwlit/scripts/bootstrap
chmod +x installtheme.sh
./installtheme.sh
```

## Void (Linux) autoinstall

If you'd like to have a full minimal setup a script is provided.

**This script automatically does all the steps described above**

This sctipt should only ever be used on a fresh network install of *Void (Linux)*

The script will update the system.

You should install **openssl** and **git** packages,

```bash
git clone https://github.com/zulubit/dwlit.git
cd dwlit/scripts/bootstrap
chmod +x voidautoinstall.sh
./voidautoinstall.sh
sudo reboot
```

you'll probably be asked fo your users password so pay some attention.

## Importand bindings:

- **logo + enter** - open terminal
- **logo + p** - open menu
- **logo + shift + Q** - kill focused
- **logo + shift + E** - exit

the rest shloud be looked up in **~/dwlit/dwlit/config.def.h**. It's advisable to be familiar with the entire file.

## Dependencies:

References copied from:

- [dwl](https://codeberg.org/dwl/dwl)
 
### Building dwl
### **dwl branch 0.7 and releases based upon 0.7 build against [wlroots] 0.18**

dwl has the following dependencies:
- libinput
- wayland
- wlroots (compiled with the libinput backend)
- xkbcommon
- wayland-protocols (compile-time only)
- pkg-config (compile-time only)
- libxcb
- libxcb-wm
- wlroots (compiled with X11 support)
- Xwayland (runtime only)

Install these (and their `-devel` versions if your distro has separate development packages)

### Full experience Dependencies

These dependencies are required by DWLit but are not already listed in the DWL dependencies. Many are optional groups and can be installed based on your needs.

#### Networking and Bluetooth
```bash
NetworkManager bluetuith curl
```

#### File Management and Thumbnails
```bash
Thunar tumbler gth
```

#### Multimedia
```bash
Mako vlc grim slurp swappy wf-recorder
```

#### System Utilities
```bash
base-devel base-system make gcc git curl wget elogind light
```

#### Wayland and Related
```bash
swaylock swaybg wl-clipboard
```

#### Audio and Video
```bash
pipewire pipewire-pulse pavucontrol
```

#### Fonts and XWayland Support
```bash
xorg-server-xwayland qt5-wayland qt6-wayland
```

#### Other Tools and Libraries
```bash
polkit polkit-elogind lxsession xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk fcft fcft-devel
```

Install these. The reference names of packages are from *Void (Linux)*, if you're using a different distro, these packages are surely available so make sure to look up their names if instaling referenced ones fails.

## Void extras

You'll need to setup **pipewire, wireplumber and pipewire-pulse** https://docs.voidlinux.org/config/media/pipewire.html

```
sudo mkdir -p /etc/pipewire/pipewire.conf.d
sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
sudo mkdir -p /etc/pipewire/pipewire.conf.d
sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/
```

You should probably also install **sof-firmware** and **sof-tools** and reboot to make your device in/outpusts discoverable

If you're on a laptop you should probably install **tlp** and enable it's service

### Flatpak

You shoud run the foolowing command after installing flatpaks for them to show up in wmenu:

```bash
sudo ln -s /var/lib/flatpak/exports/bin/* /usr/bin
```

### Bluetooth audio

```bash
sudo xbps-install libspa-bluetooth
```

### Banana cursor

A couple of things have to be done to make it work.

1.

```bash
gsettings set org.gnome.desktop.interface cursor-theme cursor_theme_name
```

2.

```bash
sudo cp ~/.local/share/icons/Banana ~/.local/share/icons/default
```
