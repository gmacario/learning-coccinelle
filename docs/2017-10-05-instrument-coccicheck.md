# Testing scripts/instrument-coccicheck.sh

<!-- 2017-10-05 11:00 CEST -->

```
gmacario@mv-linux-powerhorse:~ $ ~/github/gmacario/learning-coccinelle/scripts/instrument-coccicheck.sh
INFO: Thu Oct  5 11:58:42 CEST 2017: Script start
INFO: hostname=mv-linux-powerhorse
================================================================================================
INFO: Applying SmPL 1: scripts/coccinelle/misc/boolconv.cocci
INFO: make coccicheck COCCI=scripts/coccinelle/misc/boolconv.cocci MODE=report
/bin/bash ./scripts/coccicheck

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

Processing boolconv.cocci
with option(s) ""

Message example to submit a patch:
 Remove unneeded conversion to bool

 The semantic patch that makes this report is available
 in scriptcoccinelle/misc/boolconv.cocci.

 More information about semantic patching is available at
 http://coccinelle.lip6.fr/

Semantic patch information:
 Relational and logical operators evaluate to bool,
 explicit conversion is overly verbose and unneeded.

Running (8 in parallel): /usr/bin/spatch -D report --no-show-diff --very-quiet --cocci-file scripts/coccinelle/misc/boolconv.cocci --dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 8 --chunksize 1
773 777
coccicheck failed
INFO: Thu Oct  5 11:58:43 CEST 2017: make coccicheck end
================================================================================================
INFO: Applying SmPL 2: scripts/coccinelle/misc/of_table.cocci
INFO: make coccicheck COCCI=scripts/coccinelle/misc/of_table.cocci MODE=report
/bin/bash ./scripts/coccicheck

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

Processing of_table.cocci
with option(s) " --include-headers"

Message example to submit a patch:
 Make sure (of/i2c/platform)_device_id tables are NULL terminated
 The semantic patch that makes this report is available
 in scriptcoccinelle/misc/of_table.cocci.

 More information about semantic patching is available at
 http://coccinelle.lip6.fr/

Running (8 in parallel): /usr/bin/spatch -D report --no-show-diff --very-quiet --cocci-file scripts/coccinelle/misc/of_table.cocci --include-headers --dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 8 --chunksize 1
./arch/arm/mach-mediatek/platsmp.c:62:64-65: mtk_smp_boot_infos is not NULL terminated at line 62
./arch/arm/mach-mediatek/platsmp.c:56:66-67: mtk_tz_smp_boot_infos is not NULL terminated at line 56
./drivers/i2c/busses/i2c-sprd.c:629:36-37: sprd_i2c_of_match is not NULL terminated at line 629
coccicheck failed
INFO: Thu Oct  5 11:59:39 CEST 2017: make coccicheck end
================================================================================================
INFO: Applying SmPL 3: scripts/coccinelle/misc/badty.cocci
INFO: make coccicheck COCCI=scripts/coccinelle/misc/badty.cocci MODE=report
/bin/bash ./scripts/coccicheck

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

Processing badty.cocci
with option(s) ""

Message example to submit a patch:
 Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element

 The semantic patch that makes this report is available
 in scriptcoccinelle/misc/badty.cocci.

 More information about semantic patching is available at
 http://coccinelle.lip6.fr/

Semantic patch information:
 This makes an effort to find cases where the argument to sizeof is wrong
 in memory allocation functions by checking the type of the allocated memory
 when it is a double pointer and ensuring the sizeof argument takes a pointer
 to the the memory being allocated. There are false positives in cases the
 sizeof argument is not used in constructing the return value. The result
 may need some reformatting.

Running (8 in parallel): /usr/bin/spatch -D report --no-show-diff --very-quiet --cocci-file scripts/coccinelle/misc/badty.cocci --dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 8 --chunksize 1
./drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c:2181:15-37: WARNING: Use correct pointer type argument for sizeof
./drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c:2208:14-35: WARNING: Use correct pointer type argument for sizeof
./drivers/staging/rtl8188eu/core/rtw_efuse.c:105:85-88: WARNING: Use correct pointer type argument for sizeof
./scripts/kconfig/symbol.c:1064:36-49: WARNING: Use correct pointer type argument for sizeof
coccicheck failed
INFO: Thu Oct  5 12:09:08 CEST 2017: make coccicheck end
================================================================================================
INFO: Applying SmPL 4: scripts/coccinelle/misc/array_size.cocci
INFO: make coccicheck COCCI=scripts/coccinelle/misc/array_size.cocci MODE=report
/bin/bash ./scripts/coccicheck

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

Processing array_size.cocci
with option(s) " --no-includes --include-headers"

Message example to submit a patch:
 Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element

 The semantic patch that makes this report is available
 in scriptcoccinelle/misc/array_size.cocci.

 More information about semantic patching is available at
 http://coccinelle.lip6.fr/

Semantic patch information:
 This makes an effort to find cases where ARRAY_SIZE can be used such as
 where there is a division of sizeof the array by the sizeof its first
 element or by any indexed element or the element type. It replaces the
 division of the two sizeofs by ARRAY_SIZE.

Running (8 in parallel): /usr/bin/spatch -D report --no-show-diff --very-quiet --cocci-file scripts/coccinelle/misc/array_size.cocci --no-includes --include-headers --dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 8 --chunksize 1
./tools/perf/tests/bpf.c:312:22-23: WARNING: Use ARRAY_SIZE
./tools/perf/arch/x86/util/dwarf-regs.c:106:46-47: WARNING: Use ARRAY_SIZE
./arch/x86/platform/intel-mid/device_libs/platform_gpio_keys.c:67:25-26: WARNING: Use ARRAY_SIZE
./arch/powerpc/xmon/ppc-opc.c:969:67-68: WARNING: Use ARRAY_SIZE
./arch/powerpc/xmon/ppc-opc.c:7292:24-25: WARNING: Use ARRAY_SIZE
./arch/powerpc/xmon/ppc-opc.c:6984:25-26: WARNING: Use ARRAY_SIZE
./arch/powerpc/xmon/ppc-opc.c:7223:21-22: WARNING: Use ARRAY_SIZE
./arch/ia64/kernel/perfmon.c:4656:41-42: WARNING: Use ARRAY_SIZE
coccicheck failed
INFO: Thu Oct  5 12:11:28 CEST 2017: make coccicheck end
================================================================================================
INFO: Applying SmPL 5: scripts/coccinelle/misc/semicolon.cocci
INFO: make coccicheck COCCI=scripts/coccinelle/misc/semicolon.cocci MODE=report
/bin/bash ./scripts/coccicheck

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

Processing semicolon.cocci
with option(s) " --no-includes --include-headers"

Message example to submit a patch:

 Remove unneeded semicolon.

 The semantic patch that makes this report is available
 in scriptcoccinelle/misc/semicolon.cocci.

 More information about semantic patching is available at
 http://coccinelle.lip6.fr/

Running (8 in parallel): /usr/bin/spatch -D report --no-show-diff --very-quiet --cocci-file scripts/coccinelle/misc/semicolon.cocci --no-includes --include-headers --dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 8 --chunksize 1
./virt/kvm/arm/vgic/vgic-init.c:491:2-3: Unneeded semicolon
./virt/kvm/arm/vgic/vgic.c:132:2-3: Unneeded semicolon
./scripts/gcc-plugins/latent_entropy_plugin.c:546:2-3: Unneeded semicolon
./net/sunrpc/auth_gss/auth_gss.c:520:2-3: Unneeded semicolon
./net/core/utils.c:400:2-3: Unneeded semicolon
./net/mac80211/debugfs_sta.c:423:3-4: Unneeded semicolon
./net/mac80211/debugfs_sta.c:441:3-4: Unneeded semicolon
./net/sched/act_pedit.c:266:2-3: Unneeded semicolon
./net/netfilter/nft_dynset.c:167:61-62: Unneeded semicolon
./net/netfilter/ipvs/ip_vs_ctl.c:137:3-4: Unneeded semicolon
./net/openvswitch/flow_netlink.c:2199:2-3: Unneeded semicolon
./net/openvswitch/flow_netlink.c:2166:2-3: Unneeded semicolon
./net/packet/af_packet.c:1627:2-3: Unneeded semicolon
./arch/blackfin/include/asm/dma.h:244:2-3: Unneeded semicolon
./arch/powerpc/platforms/ps3/system-bus.c:619:2-3: Unneeded semicolon
./arch/powerpc/platforms/ps3/system-bus.c:777:2-3: Unneeded semicolon
./arch/cris/arch-v32/drivers/cryptocop.c:3009:3-4: Unneeded semicolon
./arch/cris/arch-v32/drivers/cryptocop.c:1776:2-3: Unneeded semicolon
./arch/powerpc/platforms/pseries/lpar.c:682:2-3: Unneeded semicolon
./arch/powerpc/crypto/sha256-spe-glue.c:138:2-3: Unneeded semicolon
./arch/powerpc/crypto/sha1-spe-glue.c:116:2-3: Unneeded semicolon
./arch/powerpc/boot/cuboot-c2k.c:118:2-3: Unneeded semicolon
./arch/powerpc/platforms/powernv/pci-ioda.c:1825:17-18: Unneeded semicolon
./arch/powerpc/kernel/dma.c:105:2-3: Unneeded semicolon
./arch/powerpc/kernel/prom_init.c:2801:2-3: Unneeded semicolon
./arch/powerpc/kernel/eeh.c:790:2-3: Unneeded semicolon
./arch/powerpc/sysdev/tsi108_dev.c:54:2-3: Unneeded semicolon
./arch/powerpc/kvm/booke.c:703:2-3: Unneeded semicolon
./arch/mips/mti-malta/malta-time.c:153:2-3: Unneeded semicolon
./arch/mips/oprofile/common.c:113:2-3: Unneeded semicolon
./arch/mips/kvm/tlb.c:472:2-3: Unneeded semicolon
./arch/mips/kvm/tlb.c:489:2-3: Unneeded semicolon
./arch/mips/netlogic/xlr/fmn.c:106:2-3: Unneeded semicolon
./arch/mips/kvm/mips.c:143:2-3: Unneeded semicolon
./arch/mips/kvm/emulate.c:1969:3-4: Unneeded semicolon
./arch/mips/kvm/emulate.c:1794:3-4: Unneeded semicolon
./arch/mips/kvm/vz.c:1186:4-5: Unneeded semicolon
./arch/mips/kvm/vz.c:1195:3-4: Unneeded semicolon
./arch/mips/kvm/vz.c:1949:3-4: Unneeded semicolon
./arch/mips/kvm/vz.c:1121:2-3: Unneeded semicolon
./arch/mips/kvm/vz.c:2188:3-4: Unneeded semicolon
./arch/arm64/kernel/probes/kprobes.c:110:2-3: Unneeded semicolon
./arch/arm64/kvm/guest.c:296:3-4: Unneeded semicolon
./arch/arm64/kvm/guest.c:302:3-4: Unneeded semicolon
./arch/arm64/kvm/guest.c:304:2-3: Unneeded semicolon
./arch/m68k/include/asm/sun3xflop.h:108:2-3: Unneeded semicolon
./arch/arm/mach-artpec/board-artpec6.c:45:2-3: Unneeded semicolon
./arch/alpha/kernel/sys_eiger.c:178:2-3: Unneeded semicolon
./arch/alpha/kernel/osf_sys.c:682:2-3: Unneeded semicolon
./arch/s390/kernel/perf_cpum_cf.c:401:2-3: Unneeded semicolon
./arch/arc/kernel/unwind.c:369:51-52: Unneeded semicolon
./lib/decompress_bunzip2.c:387:3-4: Unneeded semicolon
./crypto/af_alg.c:493:2-3: Unneeded semicolon
./crypto/tgr192.c:563:43-44: Unneeded semicolon
./crypto/tgr192.c:591:44-45: Unneeded semicolon
./fs/ntfs/lcnalloc.c:916:2-3: Unneeded semicolon
./fs/nfsd/nfs4state.c:2823:2-3: Unneeded semicolon
./fs/ntfs/super.c:1629:2-3: Unneeded semicolon
./fs/ntfs/super.c:1698:2-3: Unneeded semicolon
./fs/ocfs2/dlmglue.c:560:2-3: Unneeded semicolon
./fs/ocfs2/cluster/quorum.c:89:2-3: Unneeded semicolon
./fs/nfs/nfs4state.c:1103:2-3: Unneeded semicolon
./fs/ubifs/sb.c:606:2-3: Unneeded semicolon
./fs/nfs/super.c:2516:3-4: Unneeded semicolon
./fs/nfs/super.c:1569:4-5: Unneeded semicolon
./fs/nfs/super.c:1602:4-5: Unneeded semicolon
./fs/nfs/nfs4proc.c:7984:2-3: Unneeded semicolon
./fs/nfs/nfs4proc.c:6253:2-3: Unneeded semicolon
./fs/dlm/rcom.c:580:2-3: Unneeded semicolon
./fs/9p/vfs_inode.c:161:3-4: Unneeded semicolon
./fs/gfs2/recovery.c:485:3-4: Unneeded semicolon
./fs/gfs2/inode.c:1478:3-4: Unneeded semicolon
./fs/gfs2/glops.c:349:2-3: Unneeded semicolon
./fs/xfs/xfs_itable.c:384:54-55: Unneeded semicolon
./fs/btrfs/print-tree.c:337:3-4: Unneeded semicolon
./fs/f2fs/checkpoint.c:989:2-3: Unneeded semicolon
./tools/virtio/virtio-trace/trace-agent-ctl.c:80:2-3: Unneeded semicolon
./tools/lib/traceevent/kbuffer-parse.c:456:2-3: Unneeded semicolon
./tools/testing/selftests/timers/nanosleep.c:75:2-3: Unneeded semicolon
./tools/testing/selftests/timers/alarmtimer-suspend.c:82:2-3: Unneeded semicolon
./tools/testing/selftests/timers/set-timer-lat.c:83:2-3: Unneeded semicolon
./tools/testing/selftests/timers/inconsistency-check.c:75:2-3: Unneeded semicolon
./tools/testing/selftests/timers/nsleep-lat.c:75:2-3: Unneeded semicolon
./tools/testing/selftests/x86/ldt_gdt.c:558:2-3: Unneeded semicolon
./tools/testing/selftests/nsfs/pidns.c:72:36-37: Unneeded semicolon
./tools/testing/selftests/ipc/msgque.c:181:2-3: Unneeded semicolon
./tools/testing/selftests/ipc/msgque.c:189:2-3: Unneeded semicolon
./tools/testing/selftests/ipc/msgque.c:70:3-4: Unneeded semicolon
./tools/perf/builtin-diff.c:1040:2-3: Unneeded semicolon
./tools/perf/builtin-c2c.c:1611:2-3: Unneeded semicolon
./tools/perf/builtin-c2c.c:1827:2-3: Unneeded semicolon
./tools/perf/builtin-c2c.c:2740:2-3: Unneeded semicolon
./tools/perf/builtin-lock.c:776:2-3: Unneeded semicolon
./tools/perf/util/ordered-events.c:271:2-3: Unneeded semicolon
./tools/perf/util/trace-event-read.c:97:2-3: Unneeded semicolon
./tools/perf/util/evlist.c:1996:18-19: Unneeded semicolon
./tools/perf/util/event.c:969:2-3: Unneeded semicolon
./tools/perf/builtin-mem.c:120:2-3: Unneeded semicolon
./tools/power/cpupower/utils/cpupower-info.c:57:2-3: Unneeded semicolon
./tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c:121:2-3: Unneeded semicolon
./tools/power/cpupower/utils/idle_monitor/nhm_idle.c:95:2-3: Unneeded semicolon
./tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c:84:2-3: Unneeded semicolon
./tools/power/cpupower/utils/idle_monitor/snb_idle.c:81:2-3: Unneeded semicolon
./tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c:159:2-3: Unneeded semicolon
./tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c:58:2-3: Unneeded semicolon
./tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c:77:2-3: Unneeded semicolon
./tools/power/cpupower/utils/cpupower-set.c:67:2-3: Unneeded semicolon
./include/linux/nfs4.h:296:2-3: Unneeded semicolon
./sound/soc/sunxi/sun4i-codec.c:1280:2-3: Unneeded semicolon
./sound/soc/sunxi/sun4i-codec.c:1318:2-3: Unneeded semicolon
./sound/soc/sunxi/sun4i-codec.c:1356:2-3: Unneeded semicolon
./sound/soc/soc-topology.c:2113:2-3: Unneeded semicolon
./sound/soc/intel/haswell/sst-haswell-pcm.c:547:2-3: Unneeded semicolon
./samples/bpf/cookie_uid_helper_example.c:316:3-4: Unneeded semicolon
./drivers/rtc/rtc-omap.c:599:2-3: Unneeded semicolon
./drivers/ata/pata_bf54x.c:1679:2-3: Unneeded semicolon
./drivers/firmware/iscsi_ibft.c:807:2-3: Unneeded semicolon
./drivers/firmware/psci.c:145:2-3: Unneeded semicolon
./drivers/misc/mic/cosm/cosm_scif_server.c:129:2-3: Unneeded semicolon
./drivers/misc/mic/vop/vop_main.c:411:2-3: Unneeded semicolon
./drivers/misc/mic/vop/vop_main.c:216:2-3: Unneeded semicolon
./drivers/misc/ti-st/st_core.c:383:3-4: Unneeded semicolon
./drivers/watchdog/riowd.c:143:2-3: Unneeded semicolon
./drivers/pinctrl/mvebu/pinctrl-armada-37xx.c:724:2-3: Unneeded semicolon
./drivers/pinctrl/mvebu/pinctrl-armada-37xx.c:659:2-3: Unneeded semicolon
./drivers/block/drbd/drbd_req.c:899:2-3: Unneeded semicolon
./drivers/block/ataflop.c:779:53-54: Unneeded semicolon
./drivers/block/sunvdc.c:614:2-3: Unneeded semicolon
./drivers/scsi/fcoe/fcoe_sysfs.c:361:2-3: Unneeded semicolon
./drivers/scsi/fcoe/fcoe.c:1929:3-4: Unneeded semicolon
./drivers/scsi/fcoe/fcoe.c:1941:3-4: Unneeded semicolon
./drivers/scsi/ipr.h:1983:2-3: Unneeded semicolon
./drivers/scsi/nsp32.c:1260:4-5: Unneeded semicolon
./drivers/scsi/nsp32.c:1852:2-3: Unneeded semicolon
./drivers/scsi/bnx2fc/bnx2fc_fcoe.c:954:4-5: Unneeded semicolon
./drivers/scsi/bnx2fc/bnx2fc_fcoe.c:974:4-5: Unneeded semicolon
./drivers/scsi/bfa/bfa_fcs_lport.c:4369:3-4: Unneeded semicolon
./drivers/scsi/bfa/bfa_fcs_rport.c:2465:2-3: Unneeded semicolon
./drivers/scsi/bfa/bfa_fcs_rport.c:1591:3-4: Unneeded semicolon
./drivers/scsi/fnic/fnic_main.c:439:2-3: Unneeded semicolon
./drivers/scsi/ipr.c:1181:2-3: Unneeded semicolon
./drivers/scsi/pmcraid.c:5172:2-3: Unneeded semicolon
./drivers/scsi/aha1542.c:520:2-3: Unneeded semicolon
./drivers/scsi/aha1542.c:547:2-3: Unneeded semicolon
./drivers/scsi/aha1542.c:570:2-3: Unneeded semicolon
./drivers/scsi/aha1542.c:264:2-3: Unneeded semicolon
./drivers/scsi/aha1542.c:304:3-4: Unneeded semicolon
./drivers/scsi/aha1542.c:367:2-3: Unneeded semicolon
./drivers/scsi/aha1542.c:603:2-3: Unneeded semicolon
./drivers/scsi/aha1542.c:621:2-3: Unneeded semicolon
./drivers/scsi/aha1542.c:639:2-3: Unneeded semicolon
./drivers/scsi/aha1542.c:463:3-4: Unneeded semicolon
./drivers/scsi/aha1542.c:475:2-3: Unneeded semicolon
./drivers/scsi/aha1542.c:505:2-3: Unneeded semicolon
./drivers/scsi/sym53c8xx_2/sym_fw.c:389:3-4: Unneeded semicolon
./drivers/scsi/sym53c8xx_2/sym_fw.c:497:3-4: Unneeded semicolon
./drivers/scsi/sym53c8xx_2/sym_fw.c:553:2-3: Unneeded semicolon
./drivers/scsi/qla4xxx/ql4_os.c:954:3-4: Unneeded semicolon
./drivers/scsi/sgiwd93.c:190:2-3: Unneeded semicolon
./drivers/scsi/ibmvscsi/ibmvfc.c:4241:2-3: Unneeded semicolon
./drivers/scsi/ibmvscsi/ibmvfc.c:1860:2-3: Unneeded semicolon
./drivers/scsi/ibmvscsi/ibmvfc.c:4469:2-3: Unneeded semicolon
./drivers/scsi/ibmvscsi/ibmvfc.c:2665:3-4: Unneeded semicolon
./drivers/scsi/ibmvscsi/ibmvfc.c:2719:2-3: Unneeded semicolon
./drivers/scsi/ibmvscsi/ibmvfc.c:1605:2-3: Unneeded semicolon
./drivers/scsi/ibmvscsi/ibmvfc.c:503:3-4: Unneeded semicolon
./drivers/scsi/ibmvscsi/ibmvfc.c:518:3-4: Unneeded semicolon
./drivers/scsi/ibmvscsi/ibmvfc.c:529:2-3: Unneeded semicolon
./drivers/scsi/ibmvscsi/ibmvfc.c:467:2-3: Unneeded semicolon
./drivers/scsi/ibmvscsi/ibmvfc.c:3630:2-3: Unneeded semicolon
./drivers/scsi/ibmvscsi/ibmvfc.c:3526:2-3: Unneeded semicolon
./drivers/scsi/ibmvscsi/ibmvfc.c:3455:2-3: Unneeded semicolon
./drivers/scsi/ibmvscsi/ibmvfc.c:3355:2-3: Unneeded semicolon
./drivers/scsi/ibmvscsi/ibmvfc.c:3843:2-3: Unneeded semicolon
./drivers/scsi/ibmvscsi/ibmvfc.c:223:2-3: Unneeded semicolon
./drivers/scsi/ibmvscsi/ibmvfc.c:184:2-3: Unneeded semicolon
./drivers/scsi/qlogicpti.c:1142:3-4: Unneeded semicolon
./drivers/soc/sunxi/sunxi_sram.c:196:2-3: Unneeded semicolon
./drivers/soc/fsl/guts.c:113:2-3: Unneeded semicolon
./drivers/soc/imx/gpc.c:337:35-36: Unneeded semicolon
./drivers/cpufreq/pcc-cpufreq.c:271:2-3: Unneeded semicolon
./drivers/cpufreq/longhaul.c:854:2-3: Unneeded semicolon
./drivers/remoteproc/qcom_wcnss.c:512:2-3: Unneeded semicolon
./drivers/atm/firestream.c:1088:3-4: Unneeded semicolon
./drivers/spi/spi-topcliff-pch.c:875:47-48: Unneeded semicolon
./drivers/spi/spi-topcliff-pch.c:890:53-54: Unneeded semicolon
./drivers/net/ethernet/ti/cpsw-phy-sel.c:81:2-3: Unneeded semicolon
./drivers/net/ethernet/ti/cpsw-phy-sel.c:136:2-3: Unneeded semicolon
./drivers/net/ethernet/mediatek/mtk_eth_soc.c:228:2-3: Unneeded semicolon
./drivers/net/ethernet/cisco/enic/enic_clsf.c:34:2-3: Unneeded semicolon
./drivers/net/ethernet/faraday/ftgmac100.c:1649:2-3: Unneeded semicolon
./drivers/net/ethernet/mellanox/mlx4/cmd.c:3274:2-3: Unneeded semicolon
./drivers/net/ethernet/mellanox/mlx4/eq.c:822:3-4: Unneeded semicolon
./drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:1041:2-3: Unneeded semicolon
./drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:1015:2-3: Unneeded semicolon
./drivers/net/dsa/mt7530.c:640:3-4: Unneeded semicolon
./drivers/net/wireless/ath/ath10k/wmi.h:1915:2-3: Unneeded semicolon
./drivers/net/wireless/ath/ath6kl/init.c:1143:2-3: Unneeded semicolon
./drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c:696:2-3: Unneeded semicolon
./drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c:376:3-4: Unneeded semicolon
./drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c:334:3-4: Unneeded semicolon
./drivers/net/wireless/intel/iwlwifi/mvm/d3.c:559:2-3: Unneeded semicolon
./drivers/net/wireless/ray_cs.c:2219:2-3: Unneeded semicolon
./drivers/net/usb/sr9700.c:437:2-3: Unneeded semicolon
./drivers/target/sbp/sbp_target.c:1023:2-3: Unneeded semicolon
./drivers/pci/host/pcie-rcar.c:441:2-3: Unneeded semicolon
./drivers/platform/goldfish/pdev_bus.c:100:2-3: Unneeded semicolon
./drivers/uwb/i1480/dfu/mac.c:141:2-3: Unneeded semicolon
./drivers/uwb/ie.c:94:2-3: Unneeded semicolon
./drivers/staging/rtl8723bs/core/rtw_recv.c:1791:2-3: Unneeded semicolon
./drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c:1055:81-82: Unneeded semicolon
./drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c:156:89-90: Unneeded semicolon
./drivers/staging/rtl8723bs/hal/hal_com_phycfg.c:1456:2-3: Unneeded semicolon
./drivers/staging/rtl8723bs/hal/hal_com_phycfg.c:338:3-4: Unneeded semicolon
./drivers/staging/rtl8723bs/hal/hal_com_phycfg.c:728:2-3: Unneeded semicolon
./drivers/staging/rtl8723bs/hal/hal_com_phycfg.c:69:3-4: Unneeded semicolon
./drivers/staging/rtl8723bs/hal/hal_com_phycfg.c:103:3-4: Unneeded semicolon
./drivers/staging/rtl8723bs/hal/hal_com_phycfg.c:163:3-4: Unneeded semicolon
./drivers/staging/rtl8723bs/hal/hal_com_phycfg.c:197:3-4: Unneeded semicolon
./drivers/staging/media/atomisp/pci/atomisp2/css2400/runtime/frame/src/frame.c:199:2-3: Unneeded semicolon
./drivers/staging/rtlwifi/phydm/rtl8822b/phydm_iqk_8822b.c:1314:2-3: Unneeded semicolon
./drivers/staging/rtlwifi/rtl8822be/phy.c:1254:2-3: Unneeded semicolon
./drivers/clk/qcom/clk-rcg2.c:307:2-3: Unneeded semicolon
./drivers/clk/qcom/clk-rcg2.c:202:2-3: Unneeded semicolon
./drivers/clk/clk.c:2621:2-3: Unneeded semicolon
./drivers/pcmcia/db1xxx_ss.c:450:2-3: Unneeded semicolon
./drivers/mtd/nand/mpc5121_nfc.c:453:2-3: Unneeded semicolon
./drivers/char/tpm/tpm2-space.c:375:2-3: Unneeded semicolon
./drivers/extcon/extcon-sm5502.c:408:2-3: Unneeded semicolon
./drivers/extcon/extcon-sm5502.c:360:3-4: Unneeded semicolon
./drivers/extcon/extcon-sm5502.c:366:2-3: Unneeded semicolon
./drivers/extcon/extcon-sm5502.c:252:2-3: Unneeded semicolon
./drivers/extcon/extcon-sm5502.c:271:2-3: Unneeded semicolon
./drivers/powercap/intel_rapl.c:730:2-3: Unneeded semicolon
./drivers/ide/ide-taskfile.c:165:2-3: Unneeded semicolon
./drivers/infiniband/hw/qedr/verbs.c:1684:3-4: Unneeded semicolon
./drivers/infiniband/hw/qedr/verbs.c:1703:3-4: Unneeded semicolon
./drivers/infiniband/hw/qedr/verbs.c:1716:3-4: Unneeded semicolon
./drivers/infiniband/hw/qedr/verbs.c:1729:3-4: Unneeded semicolon
./drivers/infiniband/hw/qedr/verbs.c:1741:3-4: Unneeded semicolon
./drivers/infiniband/hw/qedr/verbs.c:1759:3-4: Unneeded semicolon
./drivers/infiniband/hw/qedr/verbs.c:1764:2-3: Unneeded semicolon
./drivers/iio/adc/bcm_iproc_adc.c:322:3-4: Unneeded semicolon
./drivers/iio/adc/exynos_adc.c:636:2-3: Unneeded semicolon
./drivers/iio/temperature/maxim_thermocouple.c:203:3-4: Unneeded semicolon
./drivers/iio/light/lm3533-als.c:749:2-3: Unneeded semicolon
./drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:579:2-3: Unneeded semicolon
./drivers/gpu/drm/sun4i/sun8i_layer.c:127:3-4: Unneeded semicolon
./drivers/gpu/drm/sun4i/sun8i_layer.c:131:2-3: Unneeded semicolon
./drivers/gpu/drm/sun4i/sun4i_layer.c:166:3-4: Unneeded semicolon
./drivers/gpu/drm/sun4i/sun4i_layer.c:176:2-3: Unneeded semicolon
./drivers/gpu/drm/zte/zx_vga.c:163:2-3: Unneeded semicolon
./drivers/gpu/drm/zte/zx_vga.c:174:2-3: Unneeded semicolon
./drivers/gpu/drm/zte/zx_vga.c:182:2-3: Unneeded semicolon
./drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c:219:2-3: Unneeded semicolon
./drivers/gpu/drm/nouveau/nvkm/subdev/bios/iccsense.c:102:3-4: Unneeded semicolon
./drivers/gpu/drm/nouveau/nvkm/subdev/bios/iccsense.c:118:3-4: Unneeded semicolon
./drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c:90:2-3: Unneeded semicolon
./drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c:69:2-3: Unneeded semicolon
./drivers/gpu/drm/msm/hdmi/hdmi_connector.c:125:3-4: Unneeded semicolon
./drivers/gpu/drm/msm/hdmi/hdmi_hdcp.c:772:2-3: Unneeded semicolon
./drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c:683:16-17: Unneeded semicolon
./drivers/gpu/drm/meson/meson_plane.c:142:2-3: Unneeded semicolon
./drivers/gpu/drm/meson/meson_vclk.c:488:3-4: Unneeded semicolon
./drivers/gpu/drm/meson/meson_vclk.c:519:3-4: Unneeded semicolon
./drivers/gpu/drm/meson/meson_vclk.c:530:2-3: Unneeded semicolon
./drivers/gpu/drm/rockchip/cdn-dp-reg.c:712:2-3: Unneeded semicolon
./drivers/gpu/drm/rockchip/cdn-dp-reg.c:612:2-3: Unneeded semicolon
./drivers/gpu/drm/rockchip/cdn-dp-reg.c:630:2-3: Unneeded semicolon
./drivers/dma/pxa_dma.c:1428:3-4: Unneeded semicolon
./drivers/acpi/apei/erst.c:698:2-3: Unneeded semicolon
./drivers/acpi/acpica/nsalloc.c:329:2-3: Unneeded semicolon
./drivers/devfreq/event/rockchip-dfi.c:214:2-3: Unneeded semicolon
./drivers/devfreq/rk3399_dmc.c:359:2-3: Unneeded semicolon
./drivers/irqchip/irq-zevio.c:58:2-3: Unneeded semicolon
./drivers/irqchip/irq-gic-v3.c:107:2-3: Unneeded semicolon
./drivers/irqchip/irq-gic-v3.c:161:2-3: Unneeded semicolon
./drivers/s390/cio/vfio_ccw_drv.c:59:3-4: Unneeded semicolon
./drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c:155:3-4: Unneeded semicolon
./drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c:215:3-4: Unneeded semicolon
./drivers/media/platform/qcom/venus/vdec_ctrls.c:78:2-3: Unneeded semicolon
./drivers/media/platform/pxa_camera.c:1394:2-3: Unneeded semicolon
./drivers/media/i2c/ov13858.c:1224:2-3: Unneeded semicolon
./drivers/media/i2c/ov13858.c:1262:2-3: Unneeded semicolon
./drivers/media/v4l2-core/videobuf2-core.c:2525:34-35: Unneeded semicolon
./drivers/media/usb/pvrusb2/pvrusb2-encoder.c:298:2-3: Unneeded semicolon
./drivers/isdn/isdnloop/isdnloop.c:75:4-5: Unneeded semicolon
./drivers/isdn/hisax/q931.c:601:2-3: Unneeded semicolon
./drivers/isdn/hisax/netjet.c:335:2-3: Unneeded semicolon
./drivers/isdn/hisax/netjet.c:626:2-3: Unneeded semicolon
./drivers/isdn/hisax/netjet.c:418:2-3: Unneeded semicolon
./drivers/isdn/hisax/st5481.h:515:2-3: Unneeded semicolon
./drivers/video/fbdev/sis/sis_accel.h:156:72-73: Unneeded semicolon
./drivers/video/fbdev/sis/sis_accel.h:157:72-73: Unneeded semicolon
./drivers/video/fbdev/sis/sis_accel.h:158:72-73: Unneeded semicolon
./drivers/video/fbdev/sis/sis_accel.h:286:75-76: Unneeded semicolon
./drivers/video/fbdev/sis/sis_accel.h:287:75-76: Unneeded semicolon
./drivers/video/fbdev/sis/sis_accel.h:288:73-74: Unneeded semicolon
./drivers/video/fbdev/sis/sis_accel.h:289:75-76: Unneeded semicolon
./drivers/video/fbdev/ssd1307fb.c:316:2-3: Unneeded semicolon
./drivers/video/fbdev/ssd1307fb.c:332:2-3: Unneeded semicolon
./drivers/video/fbdev/ssd1307fb.c:718:2-3: Unneeded semicolon
./drivers/video/fbdev/ssd1307fb.c:742:2-3: Unneeded semicolon
./drivers/memstick/host/tifm_ms.c:536:2-3: Unneeded semicolon
./drivers/memstick/host/jmb38x_ms.c:758:2-3: Unneeded semicolon
./drivers/pwm/pwm-lpc18xx-sct.c:295:2-3: Unneeded semicolon
./drivers/power/supply/ab8500_charger.c:1077:2-3: Unneeded semicolon
./drivers/power/supply/ab8500_charger.c:787:2-3: Unneeded semicolon
./drivers/power/supply/ab8500_charger.c:2489:2-3: Unneeded semicolon
./drivers/power/supply/ipaq_micro_battery.c:191:2-3: Unneeded semicolon
./drivers/power/supply/ipaq_micro_battery.c:155:3-4: Unneeded semicolon
./drivers/power/supply/ipaq_micro_battery.c:174:2-3: Unneeded semicolon
./drivers/power/supply/abx500_chargalg.c:1888:2-3: Unneeded semicolon
./drivers/power/supply/ab8500_fg.c:2226:5-6: Unneeded semicolon
./drivers/power/supply/ab8500_fg.c:2229:4-5: Unneeded semicolon
./drivers/power/supply/ab8500_fg.c:2338:3-4: Unneeded semicolon
./drivers/power/supply/ab8500_fg.c:2346:3-4: Unneeded semicolon
./drivers/power/supply/ab8500_fg.c:2354:3-4: Unneeded semicolon
./drivers/power/supply/ab8500_fg.c:2362:3-4: Unneeded semicolon
./drivers/power/supply/ab8500_fg.c:2370:3-4: Unneeded semicolon
./drivers/power/reset/vexpress-poweroff.c:139:2-3: Unneeded semicolon
./drivers/usb/gadget/udc/omap_udc.c:2597:2-3: Unneeded semicolon
./drivers/usb/gadget/function/f_fs.c:2414:2-3: Unneeded semicolon
./drivers/usb/wusbcore/wa-xfer.c:731:2-3: Unneeded semicolon
./drivers/md/raid1.c:1113:40-41: Unneeded semicolon
./security/apparmor/path.c:149:3-4: Unneeded semicolon
./security/selinux/hooks.c:1232:3-4: Unneeded semicolon
coccicheck failed
INFO: Thu Oct  5 12:20:52 CEST 2017: make coccicheck end
================================================================================================
INFO: Applying SmPL 6: scripts/coccinelle/misc/boolreturn.cocci
INFO: make coccicheck COCCI=scripts/coccinelle/misc/boolreturn.cocci MODE=report
/bin/bash ./scripts/coccicheck

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

Processing boolreturn.cocci
with option(s) " --no-includes --include-headers"

Message example to submit a patch:
 Return statements in functions returning bool should use
 true/false instead of 1/0.
 The semantic patch that makes this report is available
 in scriptcoccinelle/misc/boolreturn.cocci.

 More information about semantic patching is available at
 http://coccinelle.lip6.fr/

Running (8 in parallel): /usr/bin/spatch -D report --no-show-diff --very-quiet --cocci-file scripts/coccinelle/misc/boolreturn.cocci --no-includes --include-headers --dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 8 --chunksize 1
./arch/arm/include/asm/dma-mapping.h:128:9-10: WARNING: return of 0/1 in function 'dma_capable' with return type bool
./arch/arm/include/asm/kvm_emulate.h:77:8-9: WARNING: return of 0/1 in function 'vcpu_mode_is_32bit' with return type bool
./arch/arm/mach-omap2/powerdomain.c:1181:9-10: WARNING: return of 0/1 in function 'pwrdm_can_ever_lose_context' with return type bool
./arch/arm/mm/nommu.c:309:8-9: WARNING: return of 0/1 in function 'security_extensions_enabled' with return type bool
./arch/arm64/kernel/alternative.c:48:9-10: WARNING: return of 0/1 in function 'branch_insn_requires_update' with return type bool
./arch/hexagon/include/asm/dma-mapping.h:46:9-10: WARNING: return of 0/1 in function 'dma_capable' with return type bool
./arch/ia64/include/asm/dma-mapping.h:32:9-10: WARNING: return of 0/1 in function 'dma_capable' with return type bool
./arch/mips/kernel/uprobes.c:263:8-9: WARNING: return of 0/1 in function 'arch_uprobe_skip_sstep' with return type bool
./arch/mips/kernel/uprobes.c:77:10-11: WARNING: return of 0/1 in function 'is_trap_insn' with return type bool
./arch/powerpc/sysdev/xive/spapr.c:415:8-9: WARNING: return of 0/1 in function 'xive_spapr_match' with return type bool
./arch/tile/include/asm/dma-mapping.h:62:9-10: WARNING: return of 0/1 in function 'dma_capable' with return type bool
./arch/tile/kernel/stack.c:62:9-10: WARNING: return of 0/1 in function 'read_memory_func' with return type bool
./arch/unicore32/include/asm/dma-mapping.h:36:8-9: WARNING: return of 0/1 in function 'dma_capable' with return type bool
./arch/sparc/mm/init_64.c:1676:9-10: WARNING: return of 0/1 in function 'kern_addr_valid' with return type bool
./arch/x86/include/asm/dma-mapping.h:54:9-10: WARNING: return of 0/1 in function 'dma_capable' with return type bool
./arch/x86/include/asm/irq_remapping.h:69:70-71: WARNING: return of 0/1 in function 'irq_remapping_cap' with return type bool
./arch/x86/include/asm/pgtable.h:1230:9-10: WARNING: return of 0/1 in function '__pte_access_permitted' with return type bool
./arch/x86/kernel/e820.c:87:9-10: WARNING: return of 0/1 in function 'e820__mapped_any' with return type bool
./arch/x86/kvm/x86.h:71:8-9: WARNING: return of 0/1 in function 'is_la57_mode' with return type bool
./arch/x86/pci/mmconfig-shared.c:462:9-10: WARNING: return of 0/1 in function 'is_mmconf_reserved' with return type bool
./arch/x86/pci/mmconfig-shared.c:502:10-11: WARNING: return of 0/1 in function 'pci_mmcfg_check_reserved' with return type bool
./block/blk-throttle.c:1027:9-10: WARNING: return of 0/1 in function 'tg_may_dispatch' with return type bool
./block/blk-throttle.c:977:8-9: WARNING: return of 0/1 in function 'tg_with_in_bps_limit' with return type bool
./block/blk-throttle.c:934:8-9: WARNING: return of 0/1 in function 'tg_with_in_iops_limit' with return type bool
./block/blk-throttle.c:824:8-9: WARNING: return of 0/1 in function 'throtl_slice_used' with return type bool
./drivers/block/xen-blkfront.c:1444:10-11: WARNING: return of 0/1 in function 'blkif_completion' with return type bool
./drivers/clk/qcom/clk-branch.c:29:9-10: WARNING: return of 0/1 in function 'clk_branch_in_hwcg_mode' with return type bool
./drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c:351:9-10: WARNING: return of 0/1 in function 'fiji_is_hw_avfs_present' with return type bool
./drivers/gpu/drm/i915/i915_gem_request.h:364:9-10: WARNING: return of 0/1 in function 'i915_spin_request' with return type bool
./drivers/gpu/drm/vmwgfx/vmwgfx_fence.c:499:9-10: WARNING: return of 0/1 in function 'vmw_fence_obj_signaled' with return type bool
./drivers/input/touchscreen/raydium_i2c_ts.c:469:8-9: WARNING: return of 0/1 in function 'raydium_i2c_boot_trigger' with return type bool
./drivers/input/touchscreen/raydium_i2c_ts.c:495:8-9: WARNING: return of 0/1 in function 'raydium_i2c_fw_trigger' with return type bool
./drivers/misc/genwqe/card_base.h:497:9-10: WARNING: return of 0/1 in function 'dma_mapping_used' with return type bool
./drivers/net/xen-netback/netback.c:1608:9-10: WARNING: return of 0/1 in function 'xenvif_ctrl_work_todo' with return type bool
./drivers/platform/x86/acer-wmi.c:675:9-10: WARNING: return of 0/1 in function 'has_cap' with return type bool
./drivers/scsi/csiostor/csio_scsi.c:150:9-10: WARNING: return of 0/1 in function 'csio_scsi_itnexus_loss_error' with return type bool
./drivers/scsi/mvumi.c:85:9-10: WARNING: return of 0/1 in function 'tag_is_empty' with return type bool
./drivers/soc/mediatek/mtk-pmic-wrap.c:773:9-10: WARNING: return of 0/1 in function 'pwrap_is_pmic_cipher_ready' with return type bool
./drivers/ssb/driver_gige.c:245:9-10: WARNING: return of 0/1 in function 'pdev_is_ssb_gige_core' with return type bool
./drivers/staging/ccree/ssi_cipher.h:78:8-9: WARNING: return of 0/1 in function 'ssi_is_hw_key' with return type bool
./drivers/ssb/main.c:1119:8-9: WARNING: return of 0/1 in function 'ssb_dma_translation_special_bit' with return type bool
./drivers/video/fbdev/omap2/omapfb/omapfb-main.c:290:9-10: WARNING: return of 0/1 in function 'cmp_var_to_colormode' with return type bool
./drivers/xen/biomerge.c:19:8-9: WARNING: return of 0/1 in function 'xen_biovec_phys_mergeable' with return type bool
./fs/buffer.c:1448:10-11: WARNING: return of 0/1 in function 'has_bh_in_lru' with return type bool
./fs/dcache.c:691:10-11: WARNING: return of 0/1 in function 'fast_dput' with return type bool
./fs/f2fs/f2fs.h:3028:8-9: WARNING: return of 0/1 in function 'f2fs_may_encrypt' with return type bool
./fs/f2fs/f2fs.h:1194:9-10: WARNING: return of 0/1 in function 'is_idle' with return type bool
./fs/nfs/pnfs.c:1518:9-10: WARNING: return of 0/1 in function 'pnfs_lseg_range_match' with return type bool
./fs/nfsd/nfsfh.c:443:10-11: WARNING: return of 0/1 in function 'fsid_type_ok_for_exp' with return type bool
./fs/nfsd/nfs4state.c:2888:9-10: WARNING: return of 0/1 in function 'nfsd4_compound_in_session' with return type bool
./include/linux/ide.h:1476:60-61: WARNING: return of 0/1 in function 'ide_port_acpi' with return type bool
./include/linux/ima.h:86:8-9: WARNING: return of 0/1 in function 'is_ima_appraise_enabled' with return type bool
./include/linux/kgdb.h:295:54-55: WARNING: return of 0/1 in function 'kgdb_nmi_poll_knock' with return type bool
./include/linux/mfd/db8500-prcmu.h:741:8-9: WARNING: return of 0/1 in function 'db8500_prcmu_is_ac_wake_requested' with return type bool
./include/linux/libata.h:1400:8-9: WARNING: return of 0/1 in function 'ata_is_host_link' with return type bool
./include/linux/mm.h:988:8-9: WARNING: return of 0/1 in function 'cpupid_pid_unset' with return type bool
./include/linux/page-flags.h:524:8-9: WARNING: return of 0/1 in function 'page_huge_active' with return type bool
./include/linux/power_supply.h:396:9-10: WARNING: return of 0/1 in function 'power_supply_is_amp_property' with return type bool
./include/linux/power_supply.h:424:9-10: WARNING: return of 0/1 in function 'power_supply_is_watt_property' with return type bool
./include/linux/random.h:174:8-9: WARNING: return of 0/1 in function 'arch_get_random_int' with return type bool
./include/linux/random.h:170:8-9: WARNING: return of 0/1 in function 'arch_get_random_long' with return type bool
./include/linux/random.h:186:8-9: WARNING: return of 0/1 in function 'arch_get_random_seed_int' with return type bool
./include/linux/random.h:182:8-9: WARNING: return of 0/1 in function 'arch_get_random_seed_long' with return type bool
./include/linux/random.h:178:8-9: WARNING: return of 0/1 in function 'arch_has_random' with return type bool
./include/linux/random.h:190:8-9: WARNING: return of 0/1 in function 'arch_has_random_seed' with return type bool
./include/linux/ssb/ssb_driver_gige.h:161:8-9: WARNING: return of 0/1 in function 'pdev_is_ssb_gige_core' with return type bool
./include/linux/ssb/ssb_driver_gige.h:78:8-9: WARNING: return of 0/1 in function 'ssb_gige_have_roboswitch' with return type bool
./include/linux/ssb/ssb_driver_extif.h:201:8-9: WARNING: return of 0/1 in function 'ssb_extif_available' with return type bool
./include/linux/ssb/ssb_driver_gige.h:173:8-9: WARNING: return of 0/1 in function 'ssb_gige_have_roboswitch' with return type bool
./include/linux/ssb/ssb_driver_gige.h:169:8-9: WARNING: return of 0/1 in function 'ssb_gige_is_rgmii' with return type bool
./include/linux/ssb/ssb_driver_gige.h:97:8-9: WARNING: return of 0/1 in function 'ssb_gige_must_flush_posted_writes' with return type bool
./include/linux/ssb/ssb_driver_gige.h:181:8-9: WARNING: return of 0/1 in function 'ssb_gige_must_flush_posted_writes' with return type bool
./include/linux/ssb/ssb_driver_gige.h:88:8-9: WARNING: return of 0/1 in function 'ssb_gige_one_dma_at_once' with return type bool
./include/linux/ssb/ssb_driver_gige.h:177:8-9: WARNING: return of 0/1 in function 'ssb_gige_one_dma_at_once' with return type bool
./include/sound/soc.h:1588:9-10: WARNING: return of 0/1 in function 'snd_soc_volsw_is_stereo' with return type bool
./kernel/sched/autogroup.h:49:8-9: WARNING: return of 0/1 in function 'task_group_is_autogroup' with return type bool
./kernel/sched/completion.c:299:9-10: WARNING: return of 0/1 in function 'try_wait_for_completion' with return type bool
./kernel/trace/ftrace.c:2973:9-10: WARNING: return of 0/1 in function 'ops_references_rec' with return type bool
./net/bridge/br_private.h:745:8-9: WARNING: return of 0/1 in function 'br_multicast_is_router' with return type bool
./net/ipv4/netfilter/ipt_ah.c:50:9-10: WARNING: return of 0/1 in function 'ah_mt' with return type bool
./net/netfilter/xt_connlimit.c:94:9-10: WARNING: return of 0/1 in function 'already_closed' with return type bool
./net/netfilter/xt_ipcomp.c:61:9-10: WARNING: return of 0/1 in function 'comp_mt' with return type bool
./net/netfilter/xt_hashlimit.c:356:8-9: WARNING: return of 0/1 in function 'select_all' with return type bool
./net/smc/smc.h:260:8-9: WARNING: return of 0/1 in function 'using_ipsec' with return type bool
./scripts/dtc/util.c:110:9-10: WARNING: return of 0/1 in function 'util_is_printable_string' with return type bool
./security/apparmor/file.c:165:9-10: WARNING: return of 0/1 in function 'is_deleted' with return type bool
./security/apparmor/file.c:369:9-10: WARNING: return of 0/1 in function 'xindex_is_subset' with return type bool
./security/apparmor/policy_unpack.c:225:9-10: WARNING: return of 0/1 in function 'unpack_X' with return type bool
./security/apparmor/policy_unpack.c:271:9-10: WARNING: return of 0/1 in function 'unpack_nameX' with return type bool
./security/apparmor/policy_unpack.c:558:8-9: WARNING: return of 0/1 in function 'unpack_rlimits' with return type bool
./security/apparmor/policy_unpack.c:523:8-9: WARNING: return of 0/1 in function 'unpack_trans_table' with return type bool
./security/apparmor/policy_unpack.c:282:10-11: WARNING: return of 0/1 in function 'unpack_u16' with return type bool
./security/apparmor/policy_unpack.c:295:10-11: WARNING: return of 0/1 in function 'unpack_u32' with return type bool
./security/apparmor/policy_unpack.c:308:10-11: WARNING: return of 0/1 in function 'unpack_u64' with return type bool
./security/apparmor/policy_unpack.c:407:10-11: WARNING: return of 0/1 in function 'verify_accept' with return type bool
./security/apparmor/policy_unpack.c:943:10-11: WARNING: return of 0/1 in function 'verify_dfa_xindex' with return type bool
./security/apparmor/policy_unpack.c:933:9-10: WARNING: return of 0/1 in function 'verify_xindex' with return type bool
./sound/soc/codecs/cs4270.c:222:9-10: WARNING: return of 0/1 in function 'cs4270_reg_is_volatile' with return type bool
./sound/soc/codecs/da7213.c:1143:9-10: WARNING: return of 0/1 in function 'da7213_volatile_register' with return type bool
./sound/soc/codecs/da7219.c:2030:9-10: WARNING: return of 0/1 in function 'da7219_volatile_register' with return type bool
./sound/soc/codecs/da9055.c:1044:9-10: WARNING: return of 0/1 in function 'da9055_volatile_register' with return type bool
./sound/soc/codecs/max9850.c:55:9-10: WARNING: return of 0/1 in function 'max9850_volatile_register' with return type bool
./sound/soc/codecs/rt5631.c:167:9-10: WARNING: return of 0/1 in function 'rt5631_readable_register' with return type bool
./sound/soc/codecs/rt5631.c:108:9-10: WARNING: return of 0/1 in function 'rt5631_volatile_register' with return type bool
./sound/soc/codecs/twl6040.c:149:9-10: WARNING: return of 0/1 in function 'twl6040_can_write_to_chip' with return type bool
./sound/soc/codecs/wm5100-tables.c:801:9-10: WARNING: return of 0/1 in function 'wm5100_readable_register' with return type bool
./sound/soc/codecs/wm5100-tables.c:33:9-10: WARNING: return of 0/1 in function 'wm5100_volatile_register' with return type bool
./sound/soc/codecs/wm8903.c:254:9-10: WARNING: return of 0/1 in function 'wm8903_volatile_register' with return type bool
./sound/soc/codecs/wm8990.c:43:9-10: WARNING: return of 0/1 in function 'wm8990_volatile_register' with return type bool
./sound/soc/codecs/wm8996.c:1502:9-10: WARNING: return of 0/1 in function 'wm8996_readable_register' with return type bool
./sound/soc/codecs/wm8996.c:1526:9-10: WARNING: return of 0/1 in function 'wm8996_volatile_register' with return type bool
./sound/usb/clock.c:147:9-10: WARNING: return of 0/1 in function 'uac_clock_source_is_valid' with return type bool
./tools/perf/util/machine.c:1614:9-10: WARNING: return of 0/1 in function 'symbol__match_regex' with return type bool
coccicheck failed
INFO: Thu Oct  5 12:25:24 CEST 2017: make coccicheck end
================================================================================================
INFO: Applying SmPL 7: scripts/coccinelle/misc/orplus.cocci
INFO: make coccicheck COCCI=scripts/coccinelle/misc/orplus.cocci MODE=report
/bin/bash ./scripts/coccicheck

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

Processing orplus.cocci
with option(s) " --no-includes --include-headers"

Message example to submit a patch:
 Check for constants that are added but are used elsewhere as bitmasks
 The results should be checked manually to ensure that the nonzero
 bits in the two constants are actually disjoint.

 The semantic patch that makes this report is available
 in scriptcoccinelle/misc/orplus.cocci.

 More information about semantic patching is available at
 http://coccinelle.lip6.fr/

Running (8 in parallel): /usr/bin/spatch -D report --no-show-diff --very-quiet --cocci-file scripts/coccinelle/misc/orplus.cocci --no-includes --include-headers --dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 8 --chunksize 1
./mm/workingset.c:157:53-54: WARNING: sum of probable bitmasks, consider |
./arch/powerpc/boot/stdio.c:115:20-21: WARNING: sum of probable bitmasks, consider |
./arch/powerpc/kernel/align.c:58:8-9: WARNING: sum of probable bitmasks, consider |
./arch/powerpc/kernel/align.c:62:8-9: WARNING: sum of probable bitmasks, consider |
./arch/powerpc/kernel/align.c:68:8-9: WARNING: sum of probable bitmasks, consider |
./arch/powerpc/kernel/align.c:69:8-9: WARNING: sum of probable bitmasks, consider |
./arch/powerpc/kernel/align.c:80:8-9: WARNING: sum of probable bitmasks, consider |
./arch/powerpc/kernel/align.c:82:8-9: WARNING: sum of probable bitmasks, consider |
./arch/powerpc/lib/sstep.c:974:20-21: WARNING: sum of probable bitmasks, consider |
./arch/powerpc/lib/sstep.c:1199:22-23: WARNING: sum of probable bitmasks, consider |
./arch/powerpc/lib/sstep.c:1237:22-23: WARNING: sum of probable bitmasks, consider |
./arch/powerpc/lib/sstep.c:1513:22-23: WARNING: sum of probable bitmasks, consider |
./arch/powerpc/lib/sstep.c:1783:22-23: WARNING: sum of probable bitmasks, consider |
./arch/powerpc/lib/sstep.c:1795:22-23: WARNING: sum of probable bitmasks, consider |
./arch/powerpc/lib/sstep.c:1824:22-23: WARNING: sum of probable bitmasks, consider |
./arch/powerpc/lib/sstep.c:1837:22-23: WARNING: sum of probable bitmasks, consider |
./arch/powerpc/lib/sstep.c:996:20-21: WARNING: sum of probable bitmasks, consider |
./arch/powerpc/lib/sstep.c:1015:20-21: WARNING: sum of probable bitmasks, consider |
./arch/powerpc/include/asm/book3s/64/radix.h:41:55-56: WARNING: sum of probable bitmasks, consider |
./arch/powerpc/include/asm/page.h:124:37-38: WARNING: sum of probable bitmasks, consider |
./arch/nios2/include/asm/page.h:32:24-25: WARNING: sum of probable bitmasks, consider |
./arch/x86/crypto/crc32-pclmul_glue.c:57:26-27: WARNING: sum of probable bitmasks, consider |
./arch/x86/boot/printf.c:90:23-24: WARNING: sum of probable bitmasks, consider |
./arch/mips/include/asm/mach-generic/spaces.h:91:31-32: WARNING: sum of probable bitmasks, consider |
./arch/arm/mach-iop13xx/include/mach/iop13xx.h:217:55-56: WARNING: sum of probable bitmasks, consider |
./arch/arm/mach-iop13xx/include/mach/iop13xx.h:219:59-60: WARNING: sum of probable bitmasks, consider |
./arch/arm/mach-ixp4xx/include/mach/io.h:361:36-37: WARNING: sum of probable bitmasks, consider |
./arch/arm/mach-ixp4xx/common-pci.c:371:56-57: WARNING: sum of probable bitmasks, consider |
./arch/arm/mach-ixp4xx/common-pci.c:372:56-57: WARNING: sum of probable bitmasks, consider |
./arch/arm/mach-ixp4xx/common-pci.c:374:17-18: WARNING: sum of probable bitmasks, consider |
./arch/arm/mach-ixp4xx/common-pci.c:380:56-57: WARNING: sum of probable bitmasks, consider |
./arch/alpha/boot/stdio.c:89:20-21: WARNING: sum of probable bitmasks, consider |
./arch/s390/crypto/crc32-vx.c:54:27-28: WARNING: sum of probable bitmasks, consider |
./arch/s390/net/bpf_jit_comp.c:1021:23-24: WARNING: sum of probable bitmasks, consider |
./arch/metag/include/asm/tbx.h:196:20-21: WARNING: sum of probable bitmasks, consider |
./arch/metag/include/asm/tbx.h:272:27-28: WARNING: sum of probable bitmasks, consider |
./lib/vsprintf.c:2048:33-34: WARNING: sum of probable bitmasks, consider |
./lib/vsprintf.c:2055:33-34: WARNING: sum of probable bitmasks, consider |
./lib/vsprintf.c:2058:34-35: WARNING: sum of probable bitmasks, consider |
./lib/vsprintf.c:2061:32-33: WARNING: sum of probable bitmasks, consider |
./tools/testing/selftests/net/psock_fanout.c:100:17-18: WARNING: sum of probable bitmasks, consider |
./kernel/rcu/tree_plugin.h:194:35-36: WARNING: sum of probable bitmasks, consider |
./kernel/rcu/tree_plugin.h:209:49-50: WARNING: sum of probable bitmasks, consider |
./kernel/rcu/tree_plugin.h:210:19-20: WARNING: sum of probable bitmasks, consider |
./kernel/rcu/tree_plugin.h:211:19-20: WARNING: sum of probable bitmasks, consider |
./kernel/rcu/tree_plugin.h:225:35-36: WARNING: sum of probable bitmasks, consider |
./kernel/rcu/tree_plugin.h:226:35-36: WARNING: sum of probable bitmasks, consider |
./kernel/rcu/tree_plugin.h:238:19-20: WARNING: sum of probable bitmasks, consider |
./sound/pci/cs46xx/dsp_spos_scb_lib.c:975:27-28: WARNING: sum of probable bitmasks, consider |
./sound/pci/cs46xx/dsp_spos_scb_lib.c:490:27-28: WARNING: sum of probable bitmasks, consider |
./sound/pci/cs46xx/dsp_spos_scb_lib.c:1143:35-36: WARNING: sum of probable bitmasks, consider |
./sound/pci/cs46xx/dsp_spos_scb_lib.c:789:35-36: WARNING: sum of probable bitmasks, consider |
./sound/pci/cs46xx/dsp_spos_scb_lib.c:817:26-27: WARNING: sum of probable bitmasks, consider |
./sound/pci/cs46xx/dsp_spos_scb_lib.c:542:29-30: WARNING: sum of probable bitmasks, consider |
./sound/pci/cs46xx/dsp_spos_scb_lib.c:931:27-28: WARNING: sum of probable bitmasks, consider |
./sound/pci/cs46xx/dsp_spos_scb_lib.c:665:28-29: WARNING: sum of probable bitmasks, consider |
./sound/pci/cs46xx/dsp_spos_scb_lib.c:671:28-29: WARNING: sum of probable bitmasks, consider |
./sound/pci/cs46xx/dsp_spos_scb_lib.c:878:27-28: WARNING: sum of probable bitmasks, consider |
./sound/pci/cs46xx/dsp_spos_scb_lib.c:887:27-28: WARNING: sum of probable bitmasks, consider |
./sound/drivers/portman2x4.c:473:34-35: WARNING: sum of probable bitmasks, consider |
./sound/ppc/pmac.c:766:57-58: WARNING: sum of probable bitmasks, consider |
./sound/ppc/pmac.c:260:37-38: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:4410:26-27: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:4411:26-27: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:4412:26-27: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:4430:20-21: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:4029:67-68: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:4047:68-69: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:4524:44-45: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:4547:19-20: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:4575:52-53: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:4576:52-53: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:4606:19-20: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:4619:19-20: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:5207:28-29: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:5212:27-28: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:5215:27-28: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:5218:27-28: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:2099:70-71: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:2170:20-21: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:2234:27-28: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:2236:43-44: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:2278:70-71: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:2287:20-21: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:4923:19-20: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:2978:44-45: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:4243:45-46: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:4277:27-28: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclinkmp.c:4279:43-44: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:4155:21-22: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:4195:21-22: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:4235:13-14: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:2222:20-21: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:2177:27-28: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:2247:20-21: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:2288:31-32: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:5026:26-27: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:4561:14-15: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:1870:29-30: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:3985:31-32: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:4014:31-32: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:4017:31-32: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:3970:31-32: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:3973:32-33: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:4287:15-16: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:4289:39-40: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:4300:48-49: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:4302:48-49: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:4303:48-49: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:4304:53-54: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:4310:37-38: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:4320:47-48: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:4362:15-16: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:4364:39-40: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:4373:48-49: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:4375:48-49: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:4376:48-49: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:4377:53-54: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:4383:37-38: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink_gt.c:4406:15-16: WARNING: sum of probable bitmasks, consider |
 ex3.cocci => tutorial/ex3.cocci                                                   |    0
 ex4_1.cocci => tutorial/ex4_1.cocci                                               |    0
 ex4_2.cocci => tutorial/ex4_2.cocci                                               |    0
 ex4_3.cocci => tutorial/ex4_3.cocci                                               |    0
 ex5.cocci => tutorial/ex5.cocci                                                   |    0
 ex6.cocci => tutorial/ex6.cocci                                                   |    0
 tutorial/ex8.cocci                                                                |   12 +
 fix_null_pointer_dereference.cocci => tutorial/fix_null_pointer_dereference.cocci |    0
 tutorial/kmalloc_check_v1.cocci                                                   |    6 +
 tutorial/kmalloc_check_v2.cocci                                                   |    7 +
 tutorial/kmalloc_check_v3.cocci                                                   |    9 +
 tutorial/kmalloc_check_v4.cocci                                                   |   12 +
 locks_on_blocking_functions.cocci => tutorial/locks_on_blocking_functions.cocci   |    0
 tutorial/position_v1.cocci                                                        |   25 ++
 tutorial/position_v2.cocci                                                        |   25 ++
 wk4/ex_2_1_1.cocci                                                                |   10 +
 wk4/ex_2_1_2.cocci                                                                |   10 +
 wk4/ex_2_1_3.cocci                                                                |   21 +
 wk4/ex_2_2_1.cocci                                                                |    8 +
 wk4/ex_2_2_2.cocci                                                                |   12 +
 wk4/ex_2_2_3.cocci                                                                |   22 +
 wk4/ex_2_3_1.cocci                                                                |   28 ++
 wk4/ex_2_3_2.cocci                                                                |   28 ++
 wk4/ex_2_4_1.cocci                                                                |   18 +
 wk4/ex_2_4_2.cocci                                                                |   62 +++
 wk4/ex_2_4_3.cocci                                                                |   69 +++
 wk4/ex_3_1_1.cocci                                                                |   19 +
 wk4/ex_4_1.cocci                                                                  |   15 +
 wk4/ex_4_2.cocci                                                                  |   25 ++
 wk4/ex_4_2b.cocci                                                                 |   33 ++
 wk4/ex_4_3.cocci                                                                  |   94 ++++
 wk4/ex_4_4.cocci                                                                  |   33 ++
 wk4/ex_4_5.cocci                                                                  |   60 +++
 wk4/ex_4_6.cocci                                                                  |   62 +++
 wk4/my_3_1_1.cocci                                                                |   20 +
./drivers/misc/sgi-gru/grumain.c:680:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/misc/sgi-gru/grumain.c:176:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/misc/sgi-gru/grukservices.c:1169:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/message/fusion/mptsas.c:3422:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/message/fusion/mptsas.c:3428:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/net/bonding/bond_alb.c:988:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/net/ethernet/broadcom/genet/bcmgenet.c:1588:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/net/ethernet/faraday/ftmac100.c:420:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/net/tap.c:787:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/net/virtio_net.c:1235:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/net/xen-netback/netback.c:1069:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/pinctrl/bcm/pinctrl-bcm2835.c:408:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/scsi/scsi_lib.c:798:4-7: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/scsi/scsi_lib.c:855:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/sh/intc/handle.c:132:5-8: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/scsi/advansys.c:9791:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/staging/media/atomisp/pci/atomisp2/css2400/hive_isp_css_include/assert_support.h:75:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/video/fbdev/omap2/omapfb/dss/dss_features.c:895:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/virtio/virtio_balloon.c:437:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/xen/evtchn.c:407:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/xen/time.c:99:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/xen/events/events_base.c:892:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/xen/events/events_base.c:1483:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/xen/events/events_base.c:1459:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/xen/events/events_base.c:453:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/xen/events/events_base.c:1534:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/xen/grant-table.c:771:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/xen/grant-table.c:758:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/xen/xenbus/xenbus_client.c:509:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/xen/xenbus/xenbus_client.c:890:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/xen/xenbus/xenbus_client.c:767:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/9p/vfs_file.c:162:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/afs/flock.c:243:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/afs/flock.c:245:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/afs/flock.c:143:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/afs/flock.c:177:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./drivers/xen/xen-scsiback.c:1887:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/attr.c:265:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/afs/write.c:357:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/afs/write.c:395:4-7: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/afs/write.c:397:4-7: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/afs/write.c:543:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/btrfs/print-tree.c:380:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/btrfs/print-tree.c:383:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/btrfs/ctree.c:2080:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/btrfs/volumes.c:3587:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/ext4/inline.c:1003:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/ext4/ext4.h:2000:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/fscache/cache.c:376:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/gfs2/glock.c:1020:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/iomap.c:832:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/jbd2/transaction.c:2293:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/ntfs/aops.c:1199:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/ntfs/inode.c:348:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/ntfs/inode.c:371:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/ntfs/mft.c:591:4-7: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/ntfs/mft.c:784:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/ocfs2/dlm/dlmthread.c:245:4-7: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/ocfs2/dlmfs/dlmfs.c:140:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/ocfs2/dlmfs/dlmfs.c:187:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/ocfs2/dlmfs/userdlm.c:174:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/ocfs2/dlm/dlmrecovery.c:1656:4-7: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/ocfs2/dlm/dlmrecovery.c:1341:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/ocfs2/dlm/dlmmaster.c:2271:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/ocfs2/dlm/dlmmaster.c:2214:4-7: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/ocfs2/journal.c:988:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/ocfs2/journal.c:1647:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/ocfs2/journal.c:1677:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/ocfs2/namei.c:1259:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/proc/base.c:2180:4-7: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/reiserfs/journal.c:1110:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/reiserfs/journal.c:1397:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/reiserfs/journal.c:740:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/reiserfs/journal.c:652:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/reiserfs/journal.c:654:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/reiserfs/journal.c:664:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/reiserfs/journal.c:1666:5-8: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./include/asm-generic/bug.h:57:56-59: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./include/asm-generic/bug.h:171:46-49: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/userfaultfd.c:142:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/reiserfs/reiserfs.h:2900:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./fs/xfs/xfs_icache.c:500:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./include/linux/transport_class.h:93:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./kernel/notifier.c:527:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./kernel/softirq.c:518:5-8: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./kernel/softirq.c:554:5-8: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./lib/percpu_ida.c:74:4-7: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./kernel/module.c:1060:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./mm/balloon_compaction.c:99:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./mm/bootmem.c:303:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./mm/bootmem.c:582:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./kernel/sched/core.c:5749:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./mm/filemap.c:1123:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./mm/memory_hotplug.c:1910:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./mm/readahead.c:49:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./mm/mmap.c:636:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./mm/mmap.c:3360:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./mm/mmap.c:3377:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./mm/mmap.c:3476:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./mm/mmap.c:3491:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./mm/zsmalloc.c:2029:4-7: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./mm/zsmalloc.c:2064:4-7: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./mm/slab.c:1325:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/ipv4/esp4.c:525:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/ipv4/icmp.c:963:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/ipv4/devinet.c:1786:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/core/rtnetlink.c:2194:4-7: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/ipv4/tcp_minisocks.c:302:5-8: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/ipv4/ip_output.c:773:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/ipv4/ping.c:612:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/core/skbuff.c:1880:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/core/skbuff.c:1453:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/core/skbuff.c:1354:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/core/skbuff.c:1598:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/ipv6/esp6.c:487:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/ipv6/netfilter/nf_conntrack_reasm.c:543:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/ipv4/tcp_output.c:2786:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/netfilter/nfnetlink_log.c:598:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/netfilter/xt_u32.c:42:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/netfilter/xt_u32.c:70:5-8: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/key/af_key.c:911:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/key/af_key.c:927:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/key/af_key.c:3165:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/key/af_key.c:3180:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/key/af_key.c:3377:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/key/af_key.c:3399:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/key/af_key.c:2068:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/ipv4/tcp_input.c:4845:5-8: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/ipv4/tcp_input.c:5193:4-7: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/rxrpc/call_accept.c:547:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/rxrpc/call_accept.c:391:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/rxrpc/call_object.c:461:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/ipv6/addrconf.c:5312:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/rxrpc/conn_client.c:1074:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/rxrpc/recvmsg.c:507:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/rxrpc/recvmsg.c:247:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/rxrpc/key.c:855:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/rxrpc/rxkad.c:1027:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/rxrpc/rxkad.c:75:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/rxrpc/rxkad.c:574:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/rxrpc/rxkad.c:588:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/rxrpc/rxkad.c:1070:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/sunrpc/auth_gss/svcauth_gss.c:1615:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/sunrpc/auth_gss/svcauth_gss.c:859:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/sunrpc/auth_gss/svcauth_gss.c:862:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/sunrpc/svc_xprt.c:1059:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./security/selinux/ss/conditional.c:209:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/xfrm/xfrm_policy.c:294:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/xfrm/xfrm_user.c:2626:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/xfrm/xfrm_user.c:2953:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/xfrm/xfrm_user.c:1961:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/xfrm/xfrm_user.c:1213:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/xfrm/xfrm_user.c:1155:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/xfrm/xfrm_user.c:2838:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/xfrm/xfrm_user.c:3166:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/xfrm/xfrm_user.c:2396:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./net/xfrm/xfrm_user.c:3113:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./security/selinux/ss/policydb.c:483:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./security/selinux/ss/policydb.c:371:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./security/selinux/ss/policydb.c:354:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./security/selinux/ss/policydb.c:392:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./security/selinux/ss/policydb.c:462:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./security/selinux/ss/policydb.c:414:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./security/selinux/ss/policydb.c:419:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
./security/selinux/ss/policydb.c:441:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
coccicheck failed
INFO: Thu Oct  5 12:47:42 CEST 2017: make coccicheck end
================================================================================================
INFO: Applying SmPL 11: scripts/coccinelle/misc/returnvar.cocci
INFO: make coccicheck COCCI=scripts/coccinelle/misc/returnvar.cocci MODE=report
/bin/bash ./scripts/coccicheck

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

Processing returnvar.cocci
with option(s) " --no-includes --include-headers"

Message example to submit a patch:

 Remove unneeded variable used to store return value.

 The semantic patch that makes this report is available
 in scriptcoccinelle/misc/returnvar.cocci.

 More information about semantic patching is available at
 http://coccinelle.lip6.fr/

Running (8 in parallel): /usr/bin/spatch -D report --no-show-diff --very-quiet --cocci-file scripts/coccinelle/misc/returnvar.cocci --no-includes --include-headers --dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 8 --chunksize 1
./scripts/gcc-plugins/structleak_plugin.c:172:14-17: Unneeded variable: "ret". Return "0" on line 202
./net/sunrpc/xprtrdma/svc_rdma_transport.c:553:5-8: Unneeded variable: "ret". Return "0" on line 583
./net/dccp/proto.c:262:5-8: Unneeded variable: "err". Return "0" on line 304
./net/rds/ib_recv.c:1028:5-8: Unneeded variable: "ret". Return "0" on line 1037
./net/ipv4/route.c:3035:5-7: Unneeded variable: "rc". Return "0" on line 3092
./net/ipv4/tcp.c:2312:5-8: Unneeded variable: "err". Return "0" on line 2379
./net/9p/mod.c:174:5-8: Unneeded variable: "ret". Return "0" on line 180
./net/ipv6/icmp.c:258:5-8: Unneeded variable: "err". Return "0" on line 291
./net/bridge/br_multicast.c:1412:5-8: Unneeded variable: "err". Return "0" on line 1471
./net/iucv/af_iucv.c:153:5-8: Unneeded variable: "err". Return "0" on line 178
./arch/powerpc/oprofile/op_model_cell.c:1343:5-8: Unneeded variable: "rtn". Return "0" on line 1399
./arch/powerpc/oprofile/op_model_cell.c:1121:5-8: Unneeded variable: "ret". Return "0" on line 1126
./arch/powerpc/kvm/book3s_pr.c:240:5-6: Unneeded variable: "r". Return "1" on line 247
./arch/microblaze/kernel/signal.c:62:14-17: Unneeded variable: "err". Return "0" on line 80
./arch/x86/mm/pf_in.c:148:18-20: Unneeded variable: "rv". Return "OTHERS" on line 159
./arch/x86/kvm/emulate.c:1354:5-7: Unneeded variable: "rc". Return "X86EMUL_CONTINUE" on line 1369
./arch/x86/kvm/emulate.c:4781:5-7: Unneeded variable: "rc". Return "X86EMUL_CONTINUE" on line 4815
./arch/x86/kvm/emulate.c:1219:5-7: Unneeded variable: "rc". Return "X86EMUL_CONTINUE" on line 1241
./arch/mips/cavium-octeon/executive/cvmx-spi.c:152:5-8: Unneeded variable: "res". Return "- 1" on line 155
./arch/mips/cavium-octeon/executive/cvmx-spi.c:108:5-8: Unneeded variable: "res". Return "- 1" on line 111
./arch/mips/sibyte/bcm1480/setup.c:50:5-8: Unneeded variable: "ret". Return "0" on line 80
./arch/mips/oprofile/op_model_mipsxx.c:233:5-12: Unneeded variable: "handled". Return "IRQ_NONE" on line 236
./arch/tile/kernel/hardwall.c:949:5-6: Unneeded variable: "n". Return "0" on line 955
./arch/arm/mach-s3c24xx/mach-gta02.c:98:6-11: Unneeded variable: "delay". Return "0" on line 104
./arch/arm/mach-orion5x/ts78xx-setup.c:406:5-8: Unneeded variable: "ret". Return "0" on line 415
./arch/arm/mach-omap2/dma.c:125:10-16: Unneeded variable: "errata". Return "0" on line 204
./arch/arm/mach-omap1/dma.c:247:10-16: Unneeded variable: "errata". Return "0" on line 256
./arch/um/drivers/hostaudio_kern.c:125:14-18: Unneeded variable: "mask". Return "0" on line 131
./arch/alpha/kernel/err_titan.c:591:5-11: Unneeded variable: "status". Return "MCHK_DISPOSITION_UNKNOWN_ERROR" on line 600
./arch/c6x/kernel/signal.c:40:5-8: Unneeded variable: "err". Return "0" on line 62
./arch/arc/kernel/ptrace.c:115:5-8: Unneeded variable: "ret". Return "0" on line 184
./fs/ext4/mballoc.c:3834:5-8: Unneeded variable: "err". Return "0" on line 3875
./fs/ecryptfs/crypto.c:897:5-7: Unneeded variable: "rc". Return "0" on line 911
./fs/ocfs2/dlmglue.c:4182:5-11: Unneeded variable: "status". Return "0" on line 4200
./fs/ocfs2/stack_o2cb.c:77:5-16: Unneeded variable: "o2dlm_flags". Return "0" on line 92
./fs/jfs/jfs_txnmgr.c:1383:5-7: Unneeded variable: "rc". Return "0" on line 1430
./fs/cifs/cifssmb.c:3438:7-9: Unneeded variable: "rc". Return "0" on line 3452
./fs/reiserfs/journal.c:1688:5-8: Unneeded variable: "ret". Return "0" on line 1717
./fs/xfs/xfs_log_recover.c:4893:7-12: Unneeded variable: "error". Return "0" on line 4933
./fs/btrfs/compression.c:1088:5-8: Unneeded variable: "ret". Return "1" on line 1098
./fs/btrfs/extent-tree.c:6685:5-8: Unneeded variable: "ret". Return "0" on line 6698
./fs/btrfs/tree-log.c:221:5-8: Unneeded variable: "ret". Return "- ENOENT" on line 226
./fs/btrfs/extent_map.c:432:5-8: Unneeded variable: "ret". Return "0" on line 439
./fs/btrfs/extent_map.c:278:5-8: Unneeded variable: "ret". Return "0" on line 310
./tools/thermal/tmon/pid.c:68:5-8: Unneeded variable: "ret". Return "0" on line 79
./fs/btrfs/disk-io.c:4262:5-8: Unneeded variable: "ret". Return "0" on line 4270
./tools/perf/builtin-trace.c:2021:5-8: Unneeded variable: "err". Return "0" on line 2037
./tools/perf/util/evlist.c:1633:5-8: Unneeded variable: "err". Return "- ENOMEM" on line 1654
./tools/perf/util/symbol_fprintf.c:62:8-11: Unneeded variable: "ret". Return "0" on line 71
./tools/perf/util/evsel.c:1532:5-8: Unneeded variable: "ret". Return "0" on line 1581
...
```

TODO

<!-- EOF -->
