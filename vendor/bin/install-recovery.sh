#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):67633152:eaed55fd870067d28140acd0fcc79fd29cb4e153; then
  applypatch \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):57671680:aea2547230287c99143ffddd87f94b8512387467 \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):67633152:eaed55fd870067d28140acd0fcc79fd29cb4e153 && \
      (log -t install_recovery "Installing new recovery image: succeeded" && setprop vendor.ota.recovery.status 200) || \
      (log -t install_recovery "Installing new recovery image: failed" && setprop vendor.ota.recovery.status 454)
else
  log -t install_recovery "Recovery image already installed" && setprop vendor.ota.recovery.status 200
fi

