# tsubas-ublue

## Installation

To rebase an existing Silverblue/Kinoite installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/tsubajashi/tsubas-ublue:latest
  ```

- If Nvidia:
  ```
  sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/tsubajashi/tsubas-ublue-nvidia:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/Tsubajashi/tsubas-ublue:latest
  ```
- If Nvidia:
  ```
  sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/Tsubajashi/tsubas-ublue-nvidia:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

This repository builds date tags as well, so if you want to rebase to a particular day's build:

```
sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/Tsubajashi/tsubas-ublue:20230403
```

This repository by default also supports signing.

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.
