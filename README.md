# tsubas-ublue

## Screenshots follow sometime later.

## Installation

To rebase an existing Silverblue/Kinoite installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
- 
  GNOME:
  ```
  sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/tsubajashi/tsubas-ublue:latest
  ```
  KDE:
  ```
  sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/tsubajashi/tsubas-kinoite:latest
  ```
- If Nvidia:
- 
  GNOME:
  ```
  sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/tsubajashi/tsubas-ublue-nvidia:latest
  ```
  KDE:
  ```
  sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/tsubajashi/tsubas-kinoite-nvidia:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```

This repository builds date tags as well, so if you want to rebase to a particular day's build:

```
sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/Tsubajashi/tsubas-ublue:20230403
```
