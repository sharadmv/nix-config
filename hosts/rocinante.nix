# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

let
  rtl8812au = config.boot.kernelPackages.callPackage ../drivers/wifi/rtl8812au.nix {};
in
{
  networking.hostName = "rocinante";

  boot.extraModulePackages = [
    rtl8812au
  ];
  boot.kernelParams = [
    "quiet"
  ];

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Hardware configuration
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "8812au" ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/70dcb2e6-3216-4a51-859f-f39cee83c56e";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/2F82-1940";
      fsType = "vfat";
    };

  fileSystems."/media/big" =
    { device = "/dev/disk/by-uuid/81d20c8c-3817-43d2-85e0-10d8a09fdf56";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/ee187a56-6629-4715-8430-1e1076799967"; }
    ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
