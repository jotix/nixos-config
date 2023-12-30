  # udev rules for Arduino Pro Micro
  # services.udev.extraRules = ''
  #   # arduino pro micro rules
  #   SUBSYSTEMS=="usb", ATTRS{idVendor}=="2341", ATTRS{idProduct}=="0037", MODE="0666"
  #   SUBSYSTEMS=="usb", ATTRS{idVendor}=="2341", ATTRS{idProduct}=="0036", MODE="0666"
  #   # jotanck rule
  #   SUBSYSTEMS=="usb", ATTRS{idVendor}=="4a4f", ATTRS{idProduct}=="5458", MODE="0666"
  #   # bm40hsrgb_v2 rule 4b50:1141 KP Republic BM40V2
  #   SUBSYSTEMS=="usb", ATTRS{idVendor}=="4b50", ATTRS{idProduct}=="1141", MODE="0666"
  #   # vial firmware rules
  #   KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  #   '';
