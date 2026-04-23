# SmartVision Ops 🚀

This repository centralizes all automation and infrastructure management scripts for the **SmartVision** ecosystem.

## 📋 Features

* **Automated Installation:** One-liner setup for Ubuntu environments.
* **Dependency Management:** Automatic check and install for `curl`, `wget`, `tar`, and `docker`.
* **Smart Transition:** Seamless handover from environment setup to the operational submenu.

## 🛠 Prerequisites

* Ubuntu 20.04 LTS or higher.
* Active internet connection to download Docker and project assets.
* Administrative (sudo) privileges.

## 🚀 Getting Started

To run the main installation script on a fresh Ubuntu server, simply run:

```bash
curl -fsSL https://raw.githubusercontent.com/2s-inovacoes-tecnologicas/smartvision-ops/refs/heads/main/install/install.sh | bash

