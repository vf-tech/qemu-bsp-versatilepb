# Required Packages

```bash
sudo apt install net-tools uml-utilities bridge-utils -y
```

# Image Generation

```bash
tar xvf buildroot-2022.08.3.tar.gz
ln -s buildroot-2022.08.3 buildroot
cd buildroot-2022.08.3/
make BR2_EXTERNAL=../config menuconfig
make qemu_arm_versatile_defconfig
make
```

# Run Qemu

Goto project root directory

```bash
sudo ./qemu_start.sh
```

# LINUX KERNEL BUILD

```bash
git clone git://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git linux --depth 1 --branch v6.1.78-cip15
```


