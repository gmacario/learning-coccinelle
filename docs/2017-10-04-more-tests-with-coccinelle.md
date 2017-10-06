# More tests with Coccinelle

<!-- 2017-10-04 09:00 CEST -->

Logged as gmacario@ies-genbld01-ub16

```
[ ! -e linux-mainline ] && git clone https://github.com/torvalds/linux linux-mainline
cd ~/linux-mainline
git checkout master && git pull
git checkout v4.14-rc3
```

List all the semantic patches available inside the Linux source tree (59 patches as of v4.14-rc3)

```
gmacario@ies-genbld01-ub16:~/linux-mainline (detached*)*$ find . -name "*.cocci"
./scripts/coccinelle/tests/doubletest.cocci
./scripts/coccinelle/tests/doublebitand.cocci
./scripts/coccinelle/tests/odd_ptr_err.cocci
./scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci
./scripts/coccinelle/null/eno.cocci
./scripts/coccinelle/null/kmerr.cocci
./scripts/coccinelle/null/badzero.cocci
./scripts/coccinelle/null/deref_null.cocci
./scripts/coccinelle/locks/call_kern.cocci
./scripts/coccinelle/locks/double_lock.cocci
./scripts/coccinelle/locks/mini_lock.cocci
./scripts/coccinelle/locks/flags.cocci
./scripts/coccinelle/api/alloc/pool_zalloc-simple.cocci
./scripts/coccinelle/api/alloc/kzalloc-simple.cocci
./scripts/coccinelle/api/alloc/alloc_cast.cocci
./scripts/coccinelle/api/memdup_user.cocci
./scripts/coccinelle/api/platform_no_drv_owner.cocci
./scripts/coccinelle/api/resource_size.cocci
./scripts/coccinelle/api/simple_open.cocci
./scripts/coccinelle/api/drm-get-put.cocci
./scripts/coccinelle/api/pm_runtime.cocci
./scripts/coccinelle/api/d_find_alias.cocci
./scripts/coccinelle/api/ptr_ret.cocci
./scripts/coccinelle/api/setup_timer.cocci
./scripts/coccinelle/api/memdup.cocci
./scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
./scripts/coccinelle/api/kstrdup.cocci
./scripts/coccinelle/api/err_cast.cocci
./scripts/coccinelle/api/vma_pages.cocci
./scripts/coccinelle/free/pci_free_consistent.cocci
./scripts/coccinelle/free/clk_put.cocci
./scripts/coccinelle/free/kfreeaddr.cocci
./scripts/coccinelle/free/kfree.cocci
./scripts/coccinelle/free/ifnullfree.cocci
./scripts/coccinelle/free/iounmap.cocci
./scripts/coccinelle/free/devm_free.cocci
./scripts/coccinelle/misc/badty.cocci
./scripts/coccinelle/misc/boolinit.cocci
./scripts/coccinelle/misc/bugon.cocci
./scripts/coccinelle/misc/orplus.cocci
./scripts/coccinelle/misc/semicolon.cocci
./scripts/coccinelle/misc/cstptr.cocci
./scripts/coccinelle/misc/of_table.cocci
./scripts/coccinelle/misc/doubleinit.cocci
./scripts/coccinelle/misc/cond_no_effect.cocci
./scripts/coccinelle/misc/ifcol.cocci
./scripts/coccinelle/misc/boolconv.cocci
./scripts/coccinelle/misc/array_size.cocci
./scripts/coccinelle/misc/boolreturn.cocci
./scripts/coccinelle/misc/irqf_oneshot.cocci
./scripts/coccinelle/misc/returnvar.cocci
./scripts/coccinelle/misc/ifaddr.cocci
./scripts/coccinelle/misc/noderef.cocci
./scripts/coccinelle/misc/warn.cocci
./scripts/coccinelle/iterators/use_after_iter.cocci
./scripts/coccinelle/iterators/device_node_continue.cocci
./scripts/coccinelle/iterators/itnull.cocci
./scripts/coccinelle/iterators/list_entry_update.cocci
./scripts/coccinelle/iterators/fen.cocci
gmacario@ies-genbld01-ub16:~/linux-mainline (detached*)*$ find . -name "*.cocci" | wc -l
59
gmacario@ies-genbld01-ub16:~/linux-mainline (detached*)*$
```

Run `make coccicheck` against the complete Linux v4.14-rc3 source tree

<!-- 2017-10-04 11:14 -->

```
gmacario@ies-genbld01-ub16:~/linux-mainline (detached*)*$ make coccicheck
You have not explicitly specified the mode to use. Using default "report" mode.
Available modes are the following: patch, report, context, org
You can specify the mode with "make coccicheck MODE=<mode>"
Note however that some modes are not implemented by some semantic patches.

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

./drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c:731:14-62: WARNING: casting value returned by memory allocation function to (struct phm_ppt_v1_clock_voltage_dependency_table *) is useless.
./drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c:599:14-62: WARNING: casting value returned by memory allocation function to (struct phm_ppt_v1_clock_voltage_dependency_table *) is useless.
./drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c:666:14-62: WARNING: casting value returned by memory allocation function to (struct phm_ppt_v1_clock_voltage_dependency_table *) is useless.
./drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c:775:15-43: WARNING: casting value returned by memory allocation function to (struct phm_ppt_v1_pcie_table *) is useless.
./drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c:557:15-56: WARNING: casting value returned by memory allocation function to (phm_ppt_v1_clock_voltage_dependency_table *) is useless.
./drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c:522:14-55: WARNING: casting value returned by memory allocation function to (phm_ppt_v1_clock_voltage_dependency_table *) is useless.
./drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c:294:13-57: WARNING: casting value returned by memory allocation function to (phm_ppt_v1_mm_clock_voltage_dependency_table *) is useless.
./drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c:1029:10-41: WARNING: casting value returned by memory allocation function to (phm_ppt_v1_voltage_lookup_table *) is useless.
./fs/ncpfs/inode.c:56:7-28: WARNING: casting value returned by memory allocation function to (struct ncp_inode_info *) is useless.
./drivers/net/ethernet/qlogic/qed/qed_dcbx.c:1280:13-20: WARNING: kzalloc should be used for dcbx_info, instead of kmalloc/memset
./drivers/scsi/lpfc/lpfc_debugfs.c:5460:22-29: WARNING: kzalloc should be used for phba -> nvmeio_trc, instead of kmalloc/memset
./drivers/scsi/lpfc/lpfc_debugfs.c:2230:20-27: WARNING: kzalloc should be used for phba -> nvmeio_trc, instead of kmalloc/memset
./drivers/s390/crypto/pkey_api.c:128:11-18: WARNING: kzalloc should be used for cprbmem, instead of kmalloc/memset
./drivers/scsi/qla4xxx/ql4_mbx.c:1654:12-13: WARNING: *_pool_zalloc should be used for chap_table, instead of *_pool_alloc/memset
./drivers/scsi/qla2xxx/qla_mbx.c:3101:5-6: WARNING: *_pool_zalloc should be used for tsk, instead of *_pool_alloc/memset
./drivers/scsi/qla2xxx/qla_mbx.c:3017:5-6: WARNING: *_pool_zalloc should be used for abt, instead of *_pool_alloc/memset
./drivers/scsi/qla2xxx/qla_mbx.c:3937:5-6: WARNING: *_pool_zalloc should be used for vce, instead of *_pool_alloc/memset
./drivers/scsi/qla2xxx/qla_mbx.c:2528:4-5: WARNING: *_pool_zalloc should be used for lg, instead of *_pool_alloc/memset
./drivers/scsi/qla2xxx/qla_mbx.c:6028:4-5: WARNING: *_pool_zalloc should be used for pd, instead of *_pool_alloc/memset
./drivers/scsi/qla2xxx/qla_mbx.c:2258:4-5: WARNING: *_pool_zalloc should be used for lg, instead of *_pool_alloc/memset
./drivers/scsi/qla2xxx/qla_mbx.c:3859:7-8: WARNING: *_pool_zalloc should be used for vpmod, instead of *_pool_alloc/memset
./drivers/scsi/qla2xxx/qla_mbx.c:2823:6-7: WARNING: *_pool_zalloc should be used for pmap, instead of *_pool_alloc/memset
./drivers/scsi/qla2xxx/qla_mbx.c:1785:4-5: WARNING: *_pool_zalloc should be used for pd, instead of *_pool_alloc/memset
./drivers/scsi/qla2xxx/qla_init.c:815:4-5: WARNING: *_pool_zalloc should be used for pd, instead of *_pool_alloc/memset
./drivers/scsi/mpt3sas/mpt3sas_base.c:3454:37-38: WARNING: *_pool_zalloc should be used for ioc -> reply_post [ i ] . reply_post_free, instead of *_pool_alloc/memset
./drivers/scsi/mpt3sas/mpt3sas_base.c:3685:17-18: WARNING: *_pool_zalloc should be used for ioc -> reply_free, instead of *_pool_alloc/memset
./drivers/scsi/aic94xx/aic94xx_hwi.c:1061:22-23: WARNING: *_pool_zalloc should be used for ascb -> dma_scb . vaddr, instead of *_pool_alloc/memset
./drivers/net/ethernet/intel/e100.c:1913:10-11: WARNING: *_pool_zalloc should be used for nic -> cbs, instead of *_pool_alloc/memset
./drivers/mailbox/bcm-flexrm-mailbox.c:1261:17-18: WARNING: *_pool_zalloc should be used for ring -> cmpl_base, instead of *_pool_alloc/memset
./drivers/scsi/qla4xxx/ql4_os.c:828:12-13: WARNING: *_pool_zalloc should be used for chap_table, instead of *_pool_alloc/memset
./drivers/scsi/qla2xxx/qla_bsg.c:1119:4-5: WARNING: *_pool_zalloc should be used for mn, instead of *_pool_alloc/memset
./drivers/scsi/pmcraid.c:4725:33-34: WARNING: *_pool_zalloc should be used for pinstance -> cmd_list [ i ] -> ioa_cb, instead of *_pool_alloc/memset
./drivers/scsi/mvsas/mv_sas.c:793:11-12: WARNING: *_pool_zalloc should be used for slot -> buf, instead of *_pool_alloc/memset
./drivers/scsi/lpfc/lpfc_nvme.c:1941:18-19: WARNING: *_pool_zalloc should be used for lpfc_ncmd -> data, instead of *_pool_alloc/memset
./drivers/scsi/ipr.c:9687:10-11: WARNING: *_pool_zalloc should be used for ipr_cmd, instead of *_pool_alloc/memset
./mm/huge_memory.c:2818:0-23: WARNING: split_huge_pages_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/net/wireless/ath/wil6210/debugfs.c:281:0-23: WARNING: fops_iomem_x32 should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/net/wireless/ath/wil6210/debugfs.c:305:0-23: WARNING: wil_fops_ulong should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/net/wimax/i2400m/debugfs.c:218:0-23: WARNING: fops_i2400m_reset should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/net/wimax/i2400m/debugfs.c:180:0-23: WARNING: fops_i2400m_suspend should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/net/wimax/i2400m/debugfs.c:43:0-23: WARNING: fops_netdev_queue_stopped should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/mmc/core/debugfs.c:236:0-23: WARNING: mmc_clock_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/mmc/core/block.c:2330:0-23: WARNING: mmc_dbg_card_status_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/memory/tegra/tegra124-emc.c:1027:0-23: WARNING: emc_debug_rate_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/iio/imu/adis16480.c:233:0-23: WARNING: adis16480_flash_count_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/iio/imu/adis16480.c:215:0-23: WARNING: adis16480_product_id_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/iio/imu/adis16480.c:197:0-23: WARNING: adis16480_serial_number_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/iio/gyro/adis16136.c:145:0-23: WARNING: adis16136_flash_count_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/iio/gyro/adis16136.c:127:0-23: WARNING: adis16136_product_id_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/hwmon/asus_atk0110.c:691:0-23: WARNING: atk_debugfs_gitm should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/gpu/drm/sti/sti_drv.c:70:0-23: WARNING: sti_drm_fps_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/powerpc/platforms/powernv/pci-ioda.c:3257:0-23: WARNING: pnv_pci_diag_data_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/powerpc/platforms/cell/axon_msi.c:466:0-23: WARNING: fops_msic should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/powerpc/mm/hash_utils_64.c:1855:0-23: WARNING: fops_hpt_order should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/mips/kernel/spinlock_test.c:116:0-23: WARNING: fops_multi should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/mips/kernel/spinlock_test.c:37:0-23: WARNING: fops_ss should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/mips/cavium-octeon/oct_ilm.c:64:0-23: WARNING: reset_statistics_ops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/arm/mach-omap2/pm-debug.c:254:0-23: WARNING: pm_dbg_option_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/arm/mach-omap2/pm-debug.c:200:0-23: WARNING: pwrdm_suspend_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./net/bluetooth/hci_debugfs.c:1050:0-23: WARNING: adv_channel_map_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./net/bluetooth/hci_debugfs.c:1106:0-23: WARNING: adv_max_interval_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./net/bluetooth/hci_debugfs.c:1078:0-23: WARNING: adv_min_interval_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./net/bluetooth/hci_debugfs.c:562:0-23: WARNING: auto_accept_delay_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./net/bluetooth/hci_debugfs.c:337:0-23: WARNING: conn_info_max_age_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./net/bluetooth/hci_debugfs.c:309:0-23: WARNING: conn_info_min_age_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./net/bluetooth/hci_debugfs.c:994:0-23: WARNING: conn_latency_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./net/bluetooth/hci_debugfs.c:966:0-23: WARNING: conn_max_interval_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./net/bluetooth/hci_debugfs.c:938:0-23: WARNING: conn_min_interval_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./net/bluetooth/hci_debugfs.c:590:0-23: WARNING: idle_timeout_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./net/bluetooth/hci_debugfs.c:735:0-23: WARNING: rpa_timeout_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./net/bluetooth/hci_debugfs.c:646:0-23: WARNING: sniff_max_interval_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./net/bluetooth/hci_debugfs.c:618:0-23: WARNING: sniff_min_interval_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./net/bluetooth/hci_debugfs.c:1022:0-23: WARNING: supervision_timeout_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./net/bluetooth/hci_debugfs.c:519:0-23: WARNING: voice_setting_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./net/bluetooth/6lowpan.c:1111:0-23: WARNING: lowpan_enable_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./net/6lowpan/debugfs.c:44:0-23: WARNING: lowpan_ctx_flag_active_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./net/6lowpan/debugfs.c:69:0-23: WARNING: lowpan_ctx_flag_c_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./net/6lowpan/debugfs.c:100:0-23: WARNING: lowpan_ctx_plen_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./net/6lowpan/debugfs.c:259:0-23: WARNING: lowpan_short_addr_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./mm/hwpoison-inject.c:69:0-23: WARNING: hwpoison_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./mm/hwpoison-inject.c:70:0-23: WARNING: unpoison_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./mm/cma_debug.c:162:0-23: WARNING: cma_alloc_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./mm/cma_debug.c:33:0-23: WARNING: cma_debugfs_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./mm/cma_debug.c:130:0-23: WARNING: cma_free_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./mm/cma_debug.c:70:0-23: WARNING: cma_maxchunk_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./mm/cma_debug.c:48:0-23: WARNING: cma_used_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./lib/notifier-error-inject.c:17:0-23: WARNING: fops_errno should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./lib/fault-inject.c:190:0-23: WARNING: fops_stacktrace_depth should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./lib/fault-inject.c:172:0-23: WARNING: fops_ul should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./fs/ocfs2/blockcheck.c:240:0-23: WARNING: blockcheck_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./fs/ceph/debugfs.c:220:0-23: WARNING: congestion_kb_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/staging/android/ion/ion.c:537:0-23: WARNING: debug_shrink_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/power/avs/smartreflex.c:838:0-23: WARNING: pm_sr_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/net/wireless/mediatek/mt7601u/debugfs.c:38:0-23: WARNING: fops_regval should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/net/wireless/mac80211_hwsim.c:782:0-23: WARNING: hwsim_fops_group should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/net/wireless/mac80211_hwsim.c:753:0-23: WARNING: hwsim_fops_ps should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/net/wireless/mac80211_hwsim.c:765:0-23: WARNING: hwsim_simulate_radar should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/input/touchscreen/edt-ft5x06.c:634:0-23: WARNING: debugfs_mode_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/iio/imu/adis16400_core.c:105:0-23: WARNING: adis16400_flash_count_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/iio/imu/adis16400_core.c:88:0-23: WARNING: adis16400_product_id_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/hsi/controllers/omap_ssi_port.c:174:0-23: WARNING: ssi_sst_div_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/edac/skx_edac.c:852:0-23: WARNING: fops_u64_wo should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/clk/tegra/clk-dfll.c:1115:0-23: WARNING: enable_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/clk/tegra/clk-dfll.c:1132:0-23: WARNING: lock_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/clk/tegra/clk-dfll.c:1150:0-23: WARNING: rate_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/acpi/apei/einj.c:669:0-23: WARNING: error_inject_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/acpi/apei/einj.c:657:0-23: WARNING: error_type_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/x86/platform/intel/iosf_mbi.c:278:0-23: WARNING: iosf_mcr_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/x86/kvm/debugfs.c:25:0-23: WARNING: vcpu_tsc_offset_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/x86/kvm/debugfs.c:34:0-23: WARNING: vcpu_tsc_scaling_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/x86/kvm/debugfs.c:42:0-23: WARNING: vcpu_tsc_scaling_frac_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/x86/kernel/cpu/mcheck/mce.c:2407:0-23: WARNING: fake_panic_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/powerpc/xmon/xmon.c:3509:0-23: WARNING: xmon_dbgfs_ops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/powerpc/platforms/powernv/memtrace.c:267:0-23: WARNING: memtrace_init_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/powerpc/kernel/eeh.c:1788:0-23: WARNING: eeh_enable_dbgfs_ops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/powerpc/kernel/eeh.c:1790:0-23: WARNING: eeh_freeze_dbgfs_ops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/blackfin/kernel/debug-mmrs.c:74:0-23: WARNING: fops_debug_cclk should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/blackfin/kernel/debug-mmrs.c:81:0-23: WARNING: fops_debug_sclk should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./drivers/gpu/drm/arm/malidp_planes.c:60:2-29: WARNING: use get/put helpers to reference and dereference mp -> base . fb
./drivers/gpu/drm/armada/armada_drv.c:29:2-29: WARNING: use get/put helpers to reference and dereference fb
./drivers/gpu/drm/armada/armada_fb.c:98:1-25: WARNING: use get/put helpers to reference and dereference & obj -> obj
./drivers/gpu/drm/armada/armada_gem.c:564:3-27: WARNING: use get/put helpers to reference and dereference obj
./drivers/gpu/drm/i915/intel_dp_mst.c:507:1-26: WARNING: use get/put helpers to reference and dereference connector
./drivers/gpu/drm/i915/intel_fbdev.c:192:2-29: WARNING: use get/put helpers to reference and dereference & intel_fb -> base
./drivers/gpu/drm/i915/intel_fbdev.c:627:1-26: WARNING: use get/put helpers to reference and dereference & ifbdev -> fb -> base
./drivers/gpu/drm/imx/ipuv3-crtc.c:118:3-32: WARNING: use get/put helpers to reference and dereference crtc -> state -> mode_blob
./drivers/gpu/drm/msm/adreno/a5xx_power.c:327:2-28: WARNING: use get/put helpers to reference and dereference a5xx_gpu -> gpmu_bo
./drivers/gpu/drm/msm/mdp/mdp4/mdp4_crtc.c:378:3-27: WARNING: use get/put helpers to reference and dereference next_bo
./drivers/gpu/drm/msm/mdp/mdp5/mdp5_plane.c:240:2-29: WARNING: use get/put helpers to reference and dereference state -> fb
./drivers/gpu/drm/msm/mdp/mdp5/mdp5_plane.c:197:2-29: WARNING: use get/put helpers to reference and dereference plane -> state -> fb
./drivers/gpu/drm/msm/msm_drv.c:783:1-27: WARNING: use get/put helpers to reference and dereference obj
./drivers/gpu/drm/msm/msm_gem.c:1042:3-29: WARNING: use get/put helpers to reference and dereference obj
./drivers/gpu/drm/msm/msm_gem.c:1050:2-28: WARNING: use get/put helpers to reference and dereference obj
./drivers/gpu/drm/msm/msm_gem_submit.c:142:2-26: WARNING: use get/put helpers to reference and dereference obj
./drivers/gpu/drm/msm/msm_gem_submit.c:378:2-28: WARNING: use get/put helpers to reference and dereference & msm_obj -> base
./drivers/gpu/drm/msm/msm_gpu.c:499:2-26: WARNING: use get/put helpers to reference and dereference & msm_obj -> base
./drivers/gpu/drm/msm/msm_gpu.c:420:2-28: WARNING: use get/put helpers to reference and dereference & msm_obj -> base
./drivers/gpu/drm/nouveau/nouveau_fbcon.c:434:2-29: WARNING: use get/put helpers to reference and dereference & nouveau_fb -> base
./drivers/gpu/drm/nouveau/nv50_display.c:3224:1-26: WARNING: use get/put helpers to reference and dereference & mstc -> connector
./drivers/gpu/drm/vmwgfx/vmwgfx_fb.c:503:2-29: WARNING: use get/put helpers to reference and dereference cur_fb
./drivers/gpu/drm/armada/armada_crtc.c:301:2-29: WARNING: use get/put helpers to reference and dereference fb
./drivers/gpu/drm/armada/armada_crtc.c:324:1-28: WARNING: use get/put helpers to reference and dereference fb
./drivers/gpu/drm/armada/armada_crtc.c:1048:1-26: WARNING: use get/put helpers to reference and dereference fb
./drivers/gpu/drm/armada/armada_crtc.c:1053:2-29: WARNING: use get/put helpers to reference and dereference fb
./drivers/gpu/drm/armada/armada_crtc.c:745:2-29: WARNING: use get/put helpers to reference and dereference plane -> fb
./drivers/gpu/drm/armada/armada_crtc.c:580:1-26: WARNING: use get/put helpers to reference and dereference crtc -> primary -> fb
./drivers/gpu/drm/armada/armada_crtc.c:721:1-26: WARNING: use get/put helpers to reference and dereference crtc -> primary -> fb
./drivers/gpu/drm/armada/armada_overlay.c:281:2-29: WARNING: use get/put helpers to reference and dereference fb
./drivers/gpu/drm/armada/armada_overlay.c:180:2-27: WARNING: use get/put helpers to reference and dereference fb
./drivers/gpu/drm/exynos/exynos_drm_plane.c:135:3-30: WARNING: use get/put helpers to reference and dereference exynos_state -> base . fb
./drivers/gpu/drm/i915/i915_gem_object.h:286:1-25: WARNING: use get/put helpers to reference and dereference & obj -> base
./drivers/gpu/drm/i915/intel_display.c:2859:3-28: WARNING: use get/put helpers to reference and dereference fb
./drivers/gpu/drm/i915/intel_display.c:2890:2-29: WARNING: use get/put helpers to reference and dereference fb
./drivers/gpu/drm/i915/intel_display.c:2911:1-26: WARNING: use get/put helpers to reference and dereference fb
./drivers/gpu/drm/i915/intel_display.c:10031:1-28: WARNING: use get/put helpers to reference and dereference fb
./drivers/gpu/drm/i915/intel_display.c:9850:1-26: WARNING: use get/put helpers to reference and dereference fb
./drivers/gpu/drm/i915/intel_display.c:10581:3-28: WARNING: use get/put helpers to reference and dereference & connector -> base
./drivers/gpu/drm/i915/intel_display.c:10589:3-26: WARNING: use get/put helpers to reference and dereference & connector -> base
./drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c:192:3-27: WARNING: use get/put helpers to reference and dereference obj
./drivers/gpu/drm/qxl/qxl_object.c:220:1-25: WARNING: use get/put helpers to reference and dereference & bo -> gem_base
./drivers/gpu/drm/tilcdc/tilcdc_crtc.c:459:1-26: WARNING: use get/put helpers to reference and dereference fb
./drivers/gpu/drm/tilcdc/tilcdc_crtc.c:636:1-26: WARNING: use get/put helpers to reference and dereference fb
./drivers/gpu/drm/tilcdc/tilcdc_crtc.c:78:1-28: WARNING: use get/put helpers to reference and dereference val
./drivers/gpu/drm/virtio/virtgpu_ioctl.c:264:2-26: WARNING: use get/put helpers to reference and dereference & qobj -> gem_base
./drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c:319:1-28: WARNING: use get/put helpers to reference and dereference fb
./drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c:396:1-28: WARNING: use get/put helpers to reference and dereference fb
./drivers/net/ethernet/ti/cpts.c:567:9-16: WARNING: ERR_CAST can be used with cpts -> refclk
./drivers/gpu/drm/mediatek/mtk_drm_gem.c:223:9-16: WARNING: ERR_CAST can be used with mtk_gem
./drivers/ide/ide-taskfile.c:499:11-18: WARNING opportunity for memdup_user
./drivers/ide/ide-taskfile.c:512:10-17: WARNING opportunity for memdup_user
./drivers/misc/mic/vop/vop_vringh.c:940:14-21: WARNING opportunity for memdup_user
./drivers/misc/mic/vop/vop_vringh.c:998:8-15: WARNING opportunity for memdup_user
./drivers/mmc/core/block.c:332:14-21: WARNING opportunity for memdup_user
./drivers/misc/vmw_vmci/vmci_host.c:757:11-18: WARNING opportunity for memdup_user
./drivers/net/wan/lmc/lmc_main.c:497:27-34: WARNING opportunity for memdup_user
./drivers/s390/cio/chsc_sch.c:741:7-14: WARNING opportunity for memdup_user
./drivers/s390/cio/chsc_sch.c:670:6-13: WARNING opportunity for memdup_user
./drivers/s390/cio/chsc_sch.c:841:8-15: WARNING opportunity for memdup_user
./drivers/s390/cio/chsc_sch.c:483:6-13: WARNING opportunity for memdup_user
./drivers/s390/cio/chsc_sch.c:545:6-13: WARNING opportunity for memdup_user
./drivers/s390/cio/chsc_sch.c:608:7-14: WARNING opportunity for memdup_user
./drivers/scsi/aacraid/commctrl.c:531:15-22: WARNING opportunity for memdup_user
./drivers/scsi/hpsa.c:6272:7-14: WARNING opportunity for memdup_user
./arch/arm/mach-zx/zx296702-pm-domain.c:192:3-8: No need to set .owner here. The core will do it.
./drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c:155:3-8: No need to set .owner here. The core will do it.
./drivers/iio/adc/max9611.c:576:6-11: No need to set .owner here. The core will do it.
./drivers/mailbox/hi6220-mailbox.c:374:3-8: No need to set .owner here. The core will do it.
./drivers/media/dvb-frontends/si2165.c:1166:3-8: No need to set .owner here. The core will do it.
./drivers/nfc/nfcmrvl/i2c.c:281:3-8: No need to set .owner here. The core will do it.
./drivers/nfc/pn533/i2c.c:276:6-11: No need to set .owner here. The core will do it.
./drivers/pinctrl/ti/pinctrl-ti-iodelay.c:930:6-11: No need to set .owner here. The core will do it.
./drivers/staging/greybus/audio_codec.c:1094:3-8: No need to set .owner here. The core will do it.
./drivers/uio/uio_fsl_elbc_gpcm.c:478:3-8: No need to set .owner here. The core will do it.
./drivers/crypto/axis/artpec6_crypto.c:3183:3-8: No need to set .owner here. The core will do it.
./drivers/media/i2c/ov13858.c:1818:3-8: No need to set .owner here. The core will do it.
./drivers/mtd/maps/pismo.c:268:3-8: No need to set .owner here. The core will do it.
./drivers/nfc/s3fwrn5/i2c.c:293:3-8: No need to set .owner here. The core will do it.
./drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c:950:3-8: No need to set .owner here. The core will do it.
./drivers/staging/media/atomisp/i2c/ov2680.c:1530:3-8: No need to set .owner here. The core will do it.
./drivers/staging/vc04_services/bcm2835-audio/bcm2835.c:446:3-8: No need to set .owner here. The core will do it.
./drivers/usb/gadget/udc/bdc/bdc_core.c:650:3-8: No need to set .owner here. The core will do it.
./sound/soc/mediatek/mt2701/mt2701-wm8960.c:161:3-8: No need to set .owner here. The core will do it.
./sound/soc/rockchip/rk3288_hdmi_analog.c:289:3-8: No need to set .owner here. The core will do it.
./virt/kvm/arm/vgic/vgic-its.c:971:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./include/linux/err.h:58:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./fs/sysfs/group.c:409:8-14: WARNING: PTR_ERR_OR_ZERO can be used
./fs/overlayfs/overlayfs.h:179:11-17: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/scsi/qla2xxx/tcm_qla2xxx.c:1525:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/rtc/rtc-ds1347.c:158:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/remoteproc/qcom_common.c:60:8-14: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/pci/dwc/pcie-kirin.c:145:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/pci/dwc/pcie-kirin.c:181:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/media/platform/exynos4-is/fimc-lite.c:1465:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/md/bcache/btree.c:1799:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/infiniband/core/uverbs_cmd.c:1156:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/hwtracing/coresight/coresight-tpiu.c:163:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/hwtracing/coresight/coresight-funnel.c:217:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/hwtracing/coresight/coresight-dynamic-replicator.c:166:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/gpu/drm/tegra/gem.c:420:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/gpu/drm/omapdrm/dss/hdmi_phy.c:197:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/gpu/drm/omapdrm/dss/hdmi5_core.c:914:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/gpu/drm/omapdrm/dss/hdmi4_core.c:925:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/firmware/efi/efi.c:610:8-14: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/dma/mic_x100_dma.c:483:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/dca/dca-sysfs.c:43:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/crypto/qce/ablkcipher.c:251:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/clk/mvebu/armada-37xx-periph.c:362:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./arch/x86/platform/olpc/olpc.c:314:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./arch/arm/mach-davinci/dm646x.c:952:8-14: WARNING: PTR_ERR_OR_ZERO can be used
./arch/arm/mach-davinci/devices-da8xx.c:255:8-14: WARNING: PTR_ERR_OR_ZERO can be used
./arch/arm/mach-davinci/devices-da8xx.c:300:8-14: WARNING: PTR_ERR_OR_ZERO can be used
./arch/arm/crypto/aes-neonbs-glue.c:184:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./arch/arm/crypto/aes-neonbs-glue.c:261:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./tools/lib/bpf/libbpf.c:1744:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./mm/page_owner.c:638:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/virtio/virtio_mmio.c:653:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c:676:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/rtc/rtc-digicolor.c:205:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/pnp/pnpbios/core.c:584:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/phy/lantiq/phy-lantiq-rcu-usb2.c:199:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/pcmcia/at91_cf.c:239:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/pci/host/pci-tegra.c:1159:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/pci/dwc/pcie-qcom.c:718:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/pci/dwc/pci-exynos.c:155:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/misc/vexpress-syscfg.c:273:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/misc/mic/scif/scif_epd.h:168:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/gpu/drm/tegra/drm.c:597:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c:221:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c:123:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/gpu/drm/sun4i/sun4i_dotclock.c:181:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/gpu/drm/omapdrm/dss/hdmi4.c:679:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c:928:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/crypto/mv_cesa.c:1055:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/crypto/marvell/tdma.c:307:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./drivers/clk/sunxi/clk-sun8i-apb0.c:101:1-3: WARNING: PTR_ERR_OR_ZERO can be used
./arch/x86/kernel/pcspeaker.c:11:8-14: WARNING: PTR_ERR_OR_ZERO can be used
./arch/powerpc/sysdev/fsl_pci.c:1307:1-3: WARNING: PTR_ERR_OR_ZERO can be used
...
./drivers/net/ethernet/broadcom/b44.c:1477:1-11: Use setup_timer function for function on line 1480.
./drivers/net/ethernet/amd/sunlance.c:1462:1-11: Use setup_timer function for function on line 1463.
./drivers/net/ethernet/amd/sunlance.c:1462:1-11: Use setup_timer function for function on line 1463.
./drivers/net/ethernet/amd/sunlance.c:1462:1-11: Use setup_timer function for function on line 1464.
./drivers/net/ethernet/amd/declance.c:1249:1-11: Use setup_timer function for function on line 1250.
./drivers/net/ethernet/amd/declance.c:1249:1-11: Use setup_timer function for function on line 1250.
./drivers/net/ethernet/amd/declance.c:1249:1-11: Use setup_timer function for function on line 1251.
./drivers/net/ethernet/amd/amd8111e.c:1886:2-12: Use setup_timer function for function on line 1887.
./drivers/net/ethernet/amd/amd8111e.c:1886:2-12: Use setup_timer function for function on line 1887.
./drivers/net/ethernet/amd/amd8111e.c:1886:2-12: Use setup_timer function for function on line 1888.
./drivers/net/ethernet/amd/am79c961a.c:731:1-11: Use setup_timer function for function on line 732.
./drivers/net/ethernet/amd/am79c961a.c:731:1-11: Use setup_timer function for function on line 732.
./drivers/net/ethernet/amd/am79c961a.c:731:1-11: Use setup_timer function for function on line 733.
./drivers/net/ethernet/amd/a2065.c:736:1-11: Use setup_timer function for function on line 737.
./drivers/net/ethernet/amd/a2065.c:736:1-11: Use setup_timer function for function on line 737.
./drivers/net/ethernet/amd/a2065.c:736:1-11: Use setup_timer function for function on line 738.
./drivers/net/ethernet/adi/bfin_mac.c:1653:1-11: Use setup_timer function for function on line 1654.
./drivers/net/ethernet/adi/bfin_mac.c:1653:1-11: Use setup_timer function for function on line 1654.
./drivers/net/ethernet/adi/bfin_mac.c:1653:1-11: Use setup_timer function for function on line 1655.
./drivers/net/can/usb/peak_usb/pcan_usb.c:801:1-11: Use setup_timer function for function on line 802.
./drivers/net/can/usb/peak_usb/pcan_usb.c:801:1-11: Use setup_timer function for function on line 802.
./drivers/net/can/usb/peak_usb/pcan_usb.c:801:1-11: Use setup_timer function for function on line 802.
./drivers/net/can/grcan.c:1629:2-12: Use setup_timer function for function on line 1630.
./drivers/net/can/grcan.c:1633:2-12: Use setup_timer function for function on line 1634.
./drivers/net/can/grcan.c:1629:2-12: Use setup_timer function for function on line 1630.
./drivers/net/can/grcan.c:1633:2-12: Use setup_timer function for function on line 1634.
./drivers/net/can/grcan.c:1629:2-12: Use setup_timer function for function on line 1630.
./drivers/net/can/grcan.c:1633:2-12: Use setup_timer function for function on line 1634.
./drivers/net/appletalk/ltpc.c:1168:2-12: Use setup_timer function for function on line 1169.
./drivers/net/appletalk/cops.c:427:6-16: Use setup_timer function for function on line 428.
./drivers/net/appletalk/cops.c:427:6-16: Use setup_timer function for function on line 428.
./drivers/net/appletalk/cops.c:427:6-16: Use setup_timer function for function on line 428.
./drivers/mmc/host/vub300.c:2326:1-11: Use setup_timer function for function on line 2327.
./drivers/mmc/host/vub300.c:2330:1-11: Use setup_timer function for function on line 2331.
./drivers/mmc/host/vub300.c:2326:1-11: Use setup_timer function for function on line 2327.
./drivers/mmc/host/vub300.c:2330:1-11: Use setup_timer function for function on line 2331.
./drivers/mmc/host/vub300.c:2326:1-11: Use setup_timer function for function on line 2328.
./drivers/mmc/host/vub300.c:2330:1-11: Use setup_timer function for function on line 2332.
./drivers/media/platform/s5p-mfc/s5p_mfc.c:1323:1-11: Use setup_timer function for function on line 1324.
./drivers/media/platform/s5p-mfc/s5p_mfc.c:1323:1-11: Use setup_timer function for function on line 1324.
./drivers/media/platform/s5p-mfc/s5p_mfc.c:1323:1-11: Use setup_timer function for function on line 1325.
./drivers/isdn/isdnloop/isdnloop.c:1116:1-11: Use setup_timer function for function on line 1118.
./drivers/isdn/isdnloop/isdnloop.c:620:1-11: Use setup_timer function for function on line 623.
./drivers/isdn/isdnloop/isdnloop.c:620:1-11: Use setup_timer function for function on line 625.
./drivers/isdn/isdnloop/isdnloop.c:1116:1-11: Use setup_timer function for function on line 1118.
./drivers/isdn/isdnloop/isdnloop.c:620:1-11: Use setup_timer function for function on line 623.
./drivers/isdn/isdnloop/isdnloop.c:620:1-11: Use setup_timer function for function on line 625.
./drivers/isdn/i4l/isdn_common.c:2297:1-11: Use setup_timer function for function on line 2298.
./drivers/input/serio/hp_sdc.c:912:1-11: Use setup_timer function for function on line 914.
./drivers/infiniband/hw/qib/qib_sd7220.c:1443:3-13: Use setup_timer function for function on line 1444.
./drivers/infiniband/hw/qib/qib_sd7220.c:1443:3-13: Use setup_timer function for function on line 1444.
./drivers/infiniband/hw/qib/qib_sd7220.c:1443:3-13: Use setup_timer function for function on line 1444.
./drivers/infiniband/hw/qib/qib_iba7220.c:4098:1-11: Use setup_timer function for function on line 4099.
./drivers/infiniband/hw/qib/qib_iba7220.c:4098:1-11: Use setup_timer function for function on line 4099.
./drivers/infiniband/hw/qib/qib_iba7220.c:4098:1-11: Use setup_timer function for function on line 4099.
./drivers/infiniband/hw/nes/nes_hw.c:601:2-12: Use setup_timer function for function on line 602.
./drivers/infiniband/hw/nes/nes_hw.c:610:1-11: Use setup_timer function for function on line 611.
./drivers/infiniband/hw/nes/nes_hw.c:601:2-12: Use setup_timer function for function on line 602.
./drivers/infiniband/hw/nes/nes_hw.c:610:1-11: Use setup_timer function for function on line 611.
./drivers/dma/imx-dma.c:1156:3-13: Use setup_timer function for function on line 1157.
./drivers/dma/imx-dma.c:1156:3-13: Use setup_timer function for function on line 1157.
./drivers/dma/imx-dma.c:1156:3-13: Use setup_timer function for function on line 1157.
./drivers/block/umem.c:741:1-11: Use setup_timer function for function on line 742.
./drivers/block/aoe/aoemain.c:31:2-12: Use setup_timer function for function on line 33.
./drivers/block/aoe/aoemain.c:31:2-12: Use setup_timer function for function on line 34.
./drivers/block/aoe/aoedev.c:469:1-11: Use setup_timer function for function on line 470.
./drivers/block/aoe/aoedev.c:469:1-11: Use setup_timer function for function on line 470.
./drivers/block/aoe/aoedev.c:469:1-11: Use setup_timer function for function on line 471.
./drivers/block/amiflop.c:1795:1-11: Use setup_timer function for function on line 1797.
./drivers/block/amiflop.c:1800:2-12: Use setup_timer function for function on line 1802.
./drivers/block/amiflop.c:1804:2-12: Use setup_timer function for function on line 1806.
./drivers/block/amiflop.c:1812:1-11: Use setup_timer function for function on line 1814.
./drivers/auxdisplay/img-ascii-lcd.c:398:1-11: Use setup_timer function for function on line 399.
./drivers/auxdisplay/img-ascii-lcd.c:398:1-11: Use setup_timer function for function on line 399.
./drivers/auxdisplay/img-ascii-lcd.c:398:1-11: Use setup_timer function for function on line 399.
./drivers/atm/suni.c:328:2-12: Use setup_timer function for function on line 330.
./drivers/atm/suni.c:328:2-12: Use setup_timer function for function on line 330.
./drivers/atm/nicstar.c:287:2-12: Use setup_timer function for function on line 289.
./drivers/atm/nicstar.c:287:2-12: Use setup_timer function for function on line 290.
./drivers/atm/lanai.c:1793:1-11: Use setup_timer function for function on line 1795.
./drivers/atm/lanai.c:1793:1-11: Use setup_timer function for function on line 1796.
./drivers/atm/firestream.c:1888:1-11: Use setup_timer function for function on line 1889.
./drivers/atm/firestream.c:1888:1-11: Use setup_timer function for function on line 1889.
./drivers/atm/firestream.c:1888:1-11: Use setup_timer function for function on line 1890.
./arch/sh/drivers/push-switch.c:81:1-11: Use setup_timer function for function on line 83.
./arch/sh/drivers/push-switch.c:81:1-11: Use setup_timer function for function on line 83.
./arch/sh/drivers/push-switch.c:81:1-11: Use setup_timer function for function on line 83.
./arch/sh/drivers/pci/common.c:108:2-12: Use setup_timer function for function on line 109.
./arch/sh/drivers/pci/common.c:114:2-12: Use setup_timer function for function on line 115.
./arch/sh/drivers/pci/common.c:108:2-12: Use setup_timer function for function on line 109.
./arch/sh/drivers/pci/common.c:114:2-12: Use setup_timer function for function on line 115.
./arch/sh/drivers/pci/common.c:108:2-12: Use setup_timer function for function on line 110.
./arch/sh/drivers/pci/common.c:114:2-12: Use setup_timer function for function on line 116.
./arch/powerpc/platforms/powermac/low_i2c.c:516:1-11: Use setup_timer function for function on line 517.
./arch/powerpc/platforms/powermac/low_i2c.c:516:1-11: Use setup_timer function for function on line 517.
./arch/powerpc/platforms/powermac/low_i2c.c:516:1-11: Use setup_timer function for function on line 517.
./arch/powerpc/kernel/tau_6xx.c:232:1-11: Use setup_timer function for function on line 233.
./arch/ia64/sn/kernel/mca.c:83:1-11: Use setup_timer function for function on line 85.
./arch/ia64/kernel/salinfo.c:626:1-11: Use setup_timer function for function on line 628.
./arch/arm/mach-footbridge/dc21285.c:326:1-11: Use setup_timer function for function on line 329.
./arch/arm/mach-footbridge/dc21285.c:327:1-11: Use setup_timer function for function on line 331.
./arch/arm/mach-footbridge/dc21285.c:326:1-11: Use setup_timer function for function on line 330.
./arch/arm/mach-footbridge/dc21285.c:327:1-11: Use setup_timer function for function on line 332.
...
./drivers/block/drbd/drbd_main.c:2123:2-20: WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
./drivers/block/drbd/drbd_main.c:2125:2-20: WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
./drivers/block/drbd/drbd_main.c:2127:2-20: WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
./drivers/block/mtip32xx/mtip32xx.c:2585:2-26: WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
./drivers/md/bcache/bset.c:1121:2-17: WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
./drivers/md/bcache/request.c:1142:2-20: WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
./drivers/scsi/csiostor/csio_init.c:161:2-26: WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
./drivers/scsi/libfc/fc_fcp.c:2300:2-20: WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
./drivers/scsi/megaraid/megaraid_mbox.c:1254:2-18: WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
./drivers/scsi/megaraid/megaraid_mbox.c:1263:2-18: WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
./drivers/scsi/megaraid/megaraid_mbox.c:1272:2-18: WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
./drivers/scsi/megaraid/megaraid_sas_fusion.c:612:2-18: WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
./drivers/scsi/megaraid/megaraid_sas_fusion.c:633:2-18: WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
./drivers/scsi/qla2xxx/qla_os.c:6741:2-20: WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
./drivers/thunderbolt/ctl.c:675:2-18: WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
./drivers/video/fbdev/omap2/omapfb/dss/core.c:141:2-26: WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
./fs/dlm/memory.c:90:4-9: WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
./fs/dlm/memory.c:42:2-20: WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
./fs/dlm/memory.c:44:2-20: WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
./fs/ext4/extents_status.c:165:2-20: WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
./fs/xfs/kmem.h:123:2-20: WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values.
./drivers/net/ethernet/8390/ax88796.c:927:1-7: ERROR: missing iounmap; ioremap on line 894 and execution via conditional on line 909
./drivers/mtd/maps/sc520cdp.c:252:3-9: ERROR: missing iounmap; ioremap on line 242 and execution via conditional on line 244
./drivers/memstick/host/jmb38x_ms.c:904:2-8: ERROR: missing iounmap; ioremap on line 882 and execution via conditional on line 902
./drivers/bus/mvebu-mbus.c:1115:2-8: ERROR: missing iounmap; ioremap on line 1108 and execution via conditional on line 1113
./arch/mips/txx9/generic/setup.c:969:1-7: ERROR: missing iounmap; ioremap on line 943 and execution via conditional on line 958
./drivers/acpi/scan.c:675:23-33: ERROR: reference preceded by free on line 670
./drivers/crypto/n2_core.c:1496:13-14: ERROR: reference preceded by free on line 1492
./drivers/gpu/drm/ast/ast_mode.c:792:64-68: ERROR: reference preceded by free on line 787
./drivers/gpu/drm/etnaviv/etnaviv_gem.c:362:8-15: ERROR: reference preceded by free on line 350
./drivers/gpu/drm/exynos/exynos_drm_ipp.c:677:6-7: ERROR: reference preceded by free on line 672
./drivers/infiniband/core/umem.c:244:33-37: ERROR: reference preceded by free on line 235
./drivers/mtd/devices/phram.c:256:8-12: ERROR: reference preceded by free on line 250
./drivers/mtd/devices/phram.c:260:23-27: ERROR: reference preceded by free on line 250
./drivers/mtd/devices/phram.c:260:23-27: ERROR: reference preceded by free on line 256
./drivers/s390/block/dasd_eckd.c:1787:14-39: ERROR: reference preceded by free on line 1786
./fs/fuse/dev.c:2120:9-37: ERROR: reference preceded by free on line 2120
./fs/squashfs/decompressor_multi.c:181:8-19: ERROR: reference preceded by free on line 161
./kernel/kthread.c:210:2-8: ERROR: reference preceded by free on line 205
./kernel/kthread.c:223:1-7: ERROR: reference preceded by free on line 205
./kernel/rcu/rcuperf.c:449:19-22: ERROR: reference preceded by free on line 456
./kernel/rcu/rcuperf.c:456:10-13: ERROR: reference preceded by free on line 456
./lib/test_kasan.c:268:3-6: ERROR: reference preceded by free on line 267
./lib/test_kasan.c:306:1-5: ERROR: reference preceded by free on line 299
./lib/test_kasan.c:284:8-11: ERROR: reference preceded by free on line 283
./net/sctp/endpointola.c:282:21-23: ERROR: reference preceded by free on line 281
./net/sctp/transport.c:167:21-30: ERROR: reference preceded by free on line 166
./sound/pci/asihpi/asihpi.c:1243:14-18: ERROR: reference preceded by free on line 1237
./sound/pci/asihpi/asihpi.c:1244:22-26: ERROR: reference preceded by free on line 1237
./sound/pci/asihpi/asihpi.c:1062:14-18: ERROR: reference preceded by free on line 1051
./sound/pci/asihpi/asihpi.c:1063:22-26: ERROR: reference preceded by free on line 1051
./drivers/bcma/sprom.c:641:29-34: ERROR: reference preceded by free on line 630
./drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c:644:28-37: ERROR: reference preceded by free on line 638
./drivers/gpu/drm/drm_crtc.c:702:18-31: ERROR: reference preceded by free on line 717
./drivers/gpu/drm/drm_crtc.c:713:7-20: ERROR: reference preceded by free on line 717
./drivers/gpu/drm/drm_crtc.c:717:7-20: ERROR: reference preceded by free on line 717
./drivers/gpu/drm/vmwgfx/vmwgfx_msg.c:307:12-17: ERROR: reference preceded by free on line 266
./drivers/gpu/drm/vmwgfx/vmwgfx_msg.c:307:12-17: ERROR: reference preceded by free on line 290
./drivers/infiniband/hw/mlx5/main.c:2455:29-36: ERROR: reference preceded by free on line 2453
./drivers/misc/lkdtm_heap.c:78:7-11: ERROR: reference preceded by free on line 75
./drivers/misc/lkdtm_heap.c:39:1-5: ERROR: reference preceded by free on line 38
./drivers/mtd/nand/pxa3xx_nand.c:1753:18-33: ERROR: reference preceded by free on line 1746
./drivers/net/ethernet/mellanox/mlx4/resource_tracker.c:4817:15-17: ERROR: reference preceded by free on line 4823
./drivers/net/ethernet/mellanox/mlx4/resource_tracker.c:4836:17-19: ERROR: reference preceded by free on line 4823
./drivers/net/ethernet/mellanox/mlx4/resource_tracker.c:5134:15-17: ERROR: reference preceded by free on line 5138
./drivers/net/ethernet/mellanox/mlx4/resource_tracker.c:5150:17-19: ERROR: reference preceded by free on line 5138
./drivers/net/ethernet/mellanox/mlx4/resource_tracker.c:5088:15-22: ERROR: reference preceded by free on line 5092
./drivers/net/ethernet/mellanox/mlx4/resource_tracker.c:4878:29-32: ERROR: reference preceded by free on line 4886
./drivers/net/ethernet/mellanox/mlx4/resource_tracker.c:4891:30-33: ERROR: reference preceded by free on line 4886
./drivers/net/ethernet/mellanox/mlx4/resource_tracker.c:4904:9-12: ERROR: reference preceded by free on line 4886
./drivers/net/ethernet/mellanox/mlx4/resource_tracker.c:4947:13-16: ERROR: reference preceded by free on line 4955
./drivers/net/ethernet/mellanox/mlx4/resource_tracker.c:4677:15-17: ERROR: reference preceded by free on line 4686
./drivers/net/ethernet/mellanox/mlx4/resource_tracker.c:4697:13-15: ERROR: reference preceded by free on line 4686
./drivers/net/ethernet/mellanox/mlx4/resource_tracker.c:4751:15-18: ERROR: reference preceded by free on line 4757
./drivers/net/ethernet/mellanox/mlx4/resource_tracker.c:4771:17-20: ERROR: reference preceded by free on line 4757
./drivers/net/ethernet/rocker/rocker_ofdpa.c:1940:8-11: ERROR: reference preceded by free on line 1928
./fs/ocfs2/filecheck.c:601:36-41: ERROR: reference preceded by free on line 580
./mm/slub.c:4711:2-3: ERROR: reference preceded by free on line 4710
./mm/slub.c:4717:1-2: ERROR: reference preceded by free on line 4716
./mm/slub.c:4723:1-2: ERROR: reference preceded by free on line 4722
./net/batman-adv/tp_meter.c:1292:12-15: ERROR: reference preceded by free on line 1272
./drivers/message/fusion/mptctl.c:2654:2-8: ERROR: missing pci_free_consistent; pci_alloc_consistent on line 2522 and return without freeing on line 2654
./drivers/scsi/BusLogic.c:213:1-7: ERROR: missing pci_free_consistent; pci_alloc_consistent on line 204 and return without freeing on line 213
./drivers/scsi/be2iscsi/be_main.c:3115:1-7: ERROR: missing pci_free_consistent; pci_alloc_consistent on line 3074 and return without freeing on line 3115
./drivers/scsi/hpsa.c:6924:2-8: ERROR: missing pci_free_consistent; pci_alloc_consistent on line 6878 and return without freeing on line 6924
./drivers/scsi/qla1280.c:1760:2-8: ERROR: missing pci_free_consistent; pci_alloc_consistent on line 1753 and return without freeing on line 1760
./drivers/net/ethernet/cisco/enic/vnic_dev.c:861:1-7: ERROR: missing pci_free_consistent; pci_alloc_consistent on line 855 and return without freeing on line 861
./drivers/gpu/drm/zte/zx_drm_drv.c:201:2-13: ERROR: probable double put.
./drivers/thermal/tegra/soctherm.c:1017:2-13: ERROR: probable double put.
./drivers/pci/hotplug/pnv_php.c:163:2-13: ERROR: probable double put.
./arch/powerpc/platforms/powermac/feature.c:2893:1-12: ERROR: of_node_put not needed after iterator on line 2817
./arch/powerpc/platforms/powermac/feature.c:2893:1-12: ERROR: of_node_put not needed after iterator on line 2866
./net/bridge/netfilter/ebtables.c:901:11-12: ERROR: iterator variable bound on line 897 cannot be NULL
./net/wireless/core.c:1208:15-18: ERROR: iterator variable bound on line 1206 cannot be NULL
./drivers/md/bcache/super.c:1341:6-8: ERROR: iterator variable bound on line 1340 cannot be NULL
./drivers/s390/block/dasd.c:2932:14-17: ERROR: iterator variable bound on line 2920 cannot be NULL
./drivers/dma/sh/sudmac.c:299:10-15: ERROR: iterator variable bound on line 298 cannot be NULL
./drivers/dma/sh/shdmac.c:576:10-15: ERROR: iterator variable bound on line 575 cannot be NULL
./drivers/irqchip/irq-bcm7038-l1.c:327:7-10: ERROR: iterator variable bound on line 324 cannot be NULL
./drivers/gpu/drm/exynos/exynos_drm_gsc.c:1497:3-4: ERROR: iterator variable bound on line 1487 cannot be NULL
./drivers/gpu/drm/exynos/exynos_drm_fimc.c:1364:3-4: ERROR: iterator variable bound on line 1354 cannot be NULL
./drivers/base/firmware_class.c:1627:6-9: ERROR: iterator variable bound on line 1614 cannot be NULL
./drivers/base/node.c:215:36-37: ERROR: iterator variable bound on line 214 cannot be NULL
./kernel/irq/spurious.c:130:7-8: ERROR: iterator variable bound on line 129 cannot be NULL
./kernel/irq/spurious.c:157:7-8: ERROR: iterator variable bound on line 154 cannot be NULL
./arch/x86/oprofile/nmi_int.c:463:7-10: ERROR: iterator variable bound on line 462 cannot be NULL
./arch/ia64/sn/kernel/sn2/sn_hwperf.c:462:18-19: ERROR: iterator variable bound on line 461 cannot be NULL
./arch/ia64/sn/kernel/sn2/sn_hwperf.c:482:19-20: ERROR: iterator variable bound on line 481 cannot be NULL
./tools/perf/util/header.c:2272:6-9: ERROR: iterator variable bound on line 2271 cannot be NULL
./net/bridge/br_mdb.c:33:7-8: ERROR: iterator variable bound on line 32 cannot be NULL
./drivers/dma/sh/shdma-base.c:867:7-12: ERROR: iterator variable bound on line 863 cannot be NULL
./drivers/gpu/drm/exynos/exynos_drm_ipp.c:1414:35-36: ERROR: iterator variable bound on line 1413 cannot be NULL
./drivers/gpu/drm/exynos/exynos_drm_ipp.c:1452:4-5: ERROR: iterator variable bound on line 1443 cannot be NULL
./drivers/iio/humidity/am2315.c:179:22-25: ERROR: iterator variable bound on line 177 cannot be NULL
./fs/ext4/dir.c:399:9-14: ERROR: iterator variable bound on line 398 cannot be NULL
./arch/xtensa/kernel/setup.c:414:24-25: ERROR: iterator variable bound on line 412 cannot be NULL
./arch/x86/kernel/apic/io_apic.c:1218:6-12: ERROR: iterator variable bound on line 1210 cannot be NULL
./drivers/block/drbd/drbd_debugfs.c:308:1-20: iterator with update on line 322
./drivers/gpu/drm/ttm/ttm_execbuf_util.c:110:1-20: iterator with update on line 121
./fs/btrfs/extent-tree.c:7656:1-20: iterator with update on line 7737
./net/ipv6/addrconf.c:1562:1-20: iterator with update on line 1621
./drivers/gpu/drm/gma500/oaktrail_crtc.c:435:33-42: ERROR: invalid reference to the index variable of the iterator on line 402
./drivers/gpu/drm/gma500/oaktrail_lvds.c:130:6-15: ERROR: invalid reference to the index variable of the iterator on line 125
./drivers/gpu/drm/i915/intel_lrc.c:780:28-29: ERROR: invalid reference to the index variable of the iterator on line 774
./drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c:473:43-47: ERROR: invalid reference to the index variable of the iterator on line 468
./drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c:98:7-12: ERROR: invalid reference to the index variable of the iterator on line 89
./drivers/net/ethernet/intel/i40e/i40e_ethtool.c:3196:32-37: ERROR: invalid reference to the index variable of the iterator on line 3150
./drivers/net/ethernet/mellanox/mlx5/core/fs_core.c:1524:50-54: ERROR: invalid reference to the index variable of the iterator on line 1503
./drivers/net/wireless/ath/ath6kl/htc_mbox.c:107:32-43: ERROR: invalid reference to the index variable of the iterator on line 64
./drivers/scsi/mpt3sas/mpt3sas_transport.c:841:6-18: ERROR: invalid reference to the index variable of the iterator on line 818
./drivers/staging/lustre/lnet/lnet/nidstrings.c:227:14-16: ERROR: invalid reference to the index variable of the iterator on line 219
./drivers/staging/lustre/lustre/obdclass/lu_object.c:156:9-10: ERROR: invalid reference to the index variable of the iterator on line 145
./drivers/usb/gadget/legacy/hid.c:200:11-12: ERROR: invalid reference to the index variable of the iterator on line 149
./kernel/trace/trace_events.c:1434:21-23: ERROR: invalid reference to the index variable of the iterator on line 1411
./kernel/trace/trace_events.c:1431:10-13: ERROR: invalid reference to the index variable of the iterator on line 1412
./net/ipv4/ipmr.c:2485:26-29: ERROR: invalid reference to the index variable of the iterator on line 2501
./arch/powerpc/sysdev/fsl_gtm.c:110:5-8: ERROR: invalid reference to the index variable of the iterator on line 96
./drivers/char/agp/sgi-agp.c:306:35-39: ERROR: invalid reference to the index variable of the iterator on line 293
./drivers/gpu/drm/gma500/mdfld_intel_display.c:801:33-42: ERROR: invalid reference to the index variable of the iterator on line 739
./drivers/gpu/drm/virtio/virtgpu_ioctl.c:516:7-16: ERROR: invalid reference to the index variable of the iterator on line 504
./drivers/infiniband/core/cma.c:705:29-36: ERROR: invalid reference to the index variable of the iterator on line 680
./drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c:1748:35-38: ERROR: invalid reference to the index variable of the iterator on line 1630
./drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c:1950:48-52: ERROR: invalid reference to the index variable of the iterator on line 1906
./drivers/staging/lustre/lnet/selftest/console.c:168:14-17: ERROR: invalid reference to the index variable of the iterator on line 151
./drivers/staging/media/atomisp/pci/atomisp2/atomisp_acc.c:501:6-12: ERROR: invalid reference to the index variable of the iterator on line 456
./fs/dlm/recover.c:801:18-21: ERROR: invalid reference to the index variable of the iterator on line 769
./kernel/exit.c:450:21-22: ERROR: invalid reference to the index variable of the iterator on line 439
./kernel/rcu/update.c:773:29-30: ERROR: invalid reference to the index variable of the iterator on line 814
...
./drivers/net/ethernet/8390/lib8390.c:820:71-72: WARNING: sum of probable bitmasks, consider |
./drivers/net/ethernet/8390/lib8390.c:537:49-50: WARNING: sum of probable bitmasks, consider |
./drivers/net/ethernet/fealnx.c:716:29-30: WARNING: sum of probable bitmasks, consider |
./drivers/net/ethernet/fealnx.c:736:30-31: WARNING: sum of probable bitmasks, consider |
./drivers/net/ethernet/fealnx.c:807:30-31: WARNING: sum of probable bitmasks, consider |
./drivers/net/ethernet/fealnx.c:459:32-33: WARNING: sum of probable bitmasks, consider |
./drivers/net/ethernet/fealnx.c:461:48-49: WARNING: sum of probable bitmasks, consider |
./drivers/net/ethernet/fealnx.c:462:24-25: WARNING: sum of probable bitmasks, consider |
./drivers/net/ethernet/amd/lance.c:270:17-18: WARNING: sum of probable bitmasks, consider |
./drivers/net/ethernet/amd/lance.c:272:26-27: WARNING: sum of probable bitmasks, consider |
./drivers/net/ethernet/amd/lance.c:275:26-27: WARNING: sum of probable bitmasks, consider |
./drivers/net/ethernet/amd/lance.c:278:26-27: WARNING: sum of probable bitmasks, consider |
./drivers/net/ethernet/amd/lance.c:283:26-27: WARNING: sum of probable bitmasks, consider |
./drivers/net/ethernet/amd/lance.c:286:40-41: WARNING: sum of probable bitmasks, consider |
./drivers/net/ethernet/amd/lance.c:289:26-27: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink.c:6018:46-47: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink.c:6021:48-49: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink.c:5579:50-51: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink.c:5664:48-49: WARNING: sum of probable bitmasks, consider |
./drivers/tty/synclink.c:5665:46-47: WARNING: sum of probable bitmasks, consider |
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
./drivers/isdn/hisax/hfc_sx.c:601:50-51: WARNING: sum of probable bitmasks, consider |
./drivers/isdn/hisax/hfc_sx.c:1070:47-48: WARNING: sum of probable bitmasks, consider |
./drivers/isdn/hisax/hfc_sx.c:1084:46-47: WARNING: sum of probable bitmasks, consider |
./drivers/isdn/hisax/hfc_sx.c:1102:46-47: WARNING: sum of probable bitmasks, consider |
./drivers/isdn/hisax/hfc_sx.c:1116:47-48: WARNING: sum of probable bitmasks, consider |
./drivers/isdn/hardware/eicon/capifunc.c:23:34-35: WARNING: sum of probable bitmasks, consider |
./drivers/firewire/core-device.c:965:22-23: WARNING: sum of probable bitmasks, consider |
./drivers/firewire/core-device.c:984:22-23: WARNING: sum of probable bitmasks, consider |
./drivers/gpu/drm/amd/powerplay/smumgr/tonga_smc.c:2618:27-28: WARNING: sum of probable bitmasks, consider |
./drivers/gpu/drm/amd/powerplay/smumgr/iceland_smc.c:2078:27-28: WARNING: sum of probable bitmasks, consider |
./drivers/block/skd_main.c:2027:31-32: WARNING: sum of probable bitmasks, consider |
./drivers/block/skd_main.c:1273:29-30: WARNING: sum of probable bitmasks, consider |
./drivers/scsi/qla1280.c:3797:33-34: WARNING: sum of probable bitmasks, consider |
./drivers/scsi/dc395x.c:3061:32-33: WARNING: sum of probable bitmasks, consider |
./drivers/scsi/dc395x.c:3063:28-29: WARNING: sum of probable bitmasks, consider |
./drivers/scsi/dc395x.c:1846:38-39: WARNING: sum of probable bitmasks, consider |
./drivers/scsi/dc395x.c:1280:37-38: WARNING: sum of probable bitmasks, consider |
./drivers/scsi/dc395x.c:965:36-37: WARNING: sum of probable bitmasks, consider |
./drivers/scsi/dc395x.c:882:39-40: WARNING: sum of probable bitmasks, consider |
./drivers/scsi/FlashPoint.c:2858:42-43: WARNING: sum of probable bitmasks, consider |
./drivers/scsi/FlashPoint.c:4230:41-42: WARNING: sum of probable bitmasks, consider |
./drivers/scsi/FlashPoint.c:6165:18-19: WARNING: sum of probable bitmasks, consider |
./drivers/scsi/FlashPoint.c:2250:40-41: WARNING: sum of probable bitmasks, consider |
./drivers/scsi/FlashPoint.c:2257:42-43: WARNING: sum of probable bitmasks, consider |
./drivers/scsi/FlashPoint.c:2284:43-44: WARNING: sum of probable bitmasks, consider |
./drivers/scsi/FlashPoint.c:2289:41-42: WARNING: sum of probable bitmasks, consider |
./drivers/scsi/FlashPoint.c:3192:19-20: WARNING: sum of probable bitmasks, consider |
./drivers/scsi/FlashPoint.c:3359:47-48: WARNING: sum of probable bitmasks, consider |
./drivers/scsi/FlashPoint.c:3514:47-48: WARNING: sum of probable bitmasks, consider |
./drivers/scsi/FlashPoint.c:7395:21-22: WARNING: sum of probable bitmasks, consider |
./drivers/scsi/FlashPoint.c:7413:22-23: WARNING: sum of probable bitmasks, consider |
./drivers/scsi/FlashPoint.c:7315:21-22: WARNING: sum of probable bitmasks, consider |
./sound/ppc/pmac.c:766:57-58: WARNING: sum of probable bitmasks, consider |
./sound/ppc/pmac.c:260:37-38: WARNING: sum of probable bitmasks, consider |
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
./arch/mips/include/asm/mach-generic/spaces.h:91:31-32: WARNING: sum of probable bitmasks, consider |
./arch/s390/crypto/crc32-vx.c:54:27-28: WARNING: sum of probable bitmasks, consider |
./arch/x86/boot/printf.c:90:23-24: WARNING: sum of probable bitmasks, consider |
./arch/arm/mach-ixp4xx/include/mach/io.h:361:36-37: WARNING: sum of probable bitmasks, consider |
./arch/arm/mach-iop13xx/include/mach/iop13xx.h:217:55-56: WARNING: sum of probable bitmasks, consider |
./arch/arm/mach-iop13xx/include/mach/iop13xx.h:219:59-60: WARNING: sum of probable bitmasks, consider |
./arch/powerpc/include/asm/page.h:124:37-38: WARNING: sum of probable bitmasks, consider |
./tools/testing/selftests/net/psock_fanout.c:100:17-18: WARNING: sum of probable bitmasks, consider |
./mm/workingset.c:157:53-54: WARNING: sum of probable bitmasks, consider |
./net/ipv4/tcp.c:2312:5-8: Unneeded variable: "err". Return "0" on line 2379
./net/ipv4/route.c:3035:5-7: Unneeded variable: "rc". Return "0" on line 3092
./net/bridge/br_multicast.c:1412:5-8: Unneeded variable: "err". Return "0" on line 1471
./net/ipv6/icmp.c:258:5-8: Unneeded variable: "err". Return "0" on line 291
./net/rds/ib_recv.c:1028:5-8: Unneeded variable: "ret". Return "0" on line 1037
./drivers/net/usb/r8152.c:4405:5-8: Unneeded variable: "ret". Return "0" on line 4420
./drivers/net/wireless/intel/ipw2x00/libipw_rx.c:1012:5-7: Unneeded variable: "rc". Return "0" on line 1037
./drivers/net/wireless/intel/iwlegacy/3945-mac.c:247:5-8: Unneeded variable: "ret". Return "- EOPNOTSUPP" on line 249
./drivers/net/wireless/intel/iwlegacy/4965.c:433:5-8: Unneeded variable: "ret". Return "0" on line 450
./drivers/net/wireless/intersil/orinoco/spectrum_cs.c:281:5-8: Unneeded variable: "err". Return "0" on line 286
./drivers/net/wireless/st/cw1200/cw1200_spi.c:276:5-8: Unneeded variable: "ret". Return "0" on line 282
./drivers/net/wireless/marvell/libertas/cmdresp.c:224:5-8: Unneeded variable: "ret". Return "0" on line 354
./drivers/net/wireless/ath/ath9k/htc_drv_init.c:474:5-8: Unneeded variable: "val". Return "0" on line 488
./drivers/net/wireless/broadcom/b43/debugfs.c:366:9-14: Unneeded variable: "count". Return "0" on line 404
./drivers/net/ethernet/intel/i40e/i40e_adminq.c:641:13-21: Unneeded variable: "ret_code". Return "0" on line 652
./drivers/net/ethernet/intel/igb/e1000_i210.c:814:5-12: Unneeded variable: "ret_val". Return "0" on line 835
./drivers/net/ethernet/intel/i40evf/i40e_adminq.c:587:13-21: Unneeded variable: "ret_code". Return "0" on line 598
./drivers/net/ethernet/qlogic/qed/qed_dcbx.c:754:5-7: Unneeded variable: "rc". Return "0" on line 763
./drivers/net/ethernet/qlogic/qed/qed_dcbx.c:823:5-7: Unneeded variable: "rc". Return "0" on line 832
./drivers/net/ethernet/qlogic/qlge/qlge_dbg.c:391:5-11: Unneeded variable: "status". Return "0" on line 404
./drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c:559:5-8: Unneeded variable: "ret". Return "0" on line 580
./drivers/crypto/chelsio/chcr_algo.c:2159:5-7: Unneeded variable: "rc". Return "0" on line 2176
./drivers/crypto/chelsio/chcr_algo.c:1216:5-8: Unneeded variable: "err". Return "0" on line 1243
./drivers/tty/mxser.c:644:5-8: Unneeded variable: "ret". Return "0" on line 649
./drivers/video/fbdev/fsl-diu-fb.c:1428:5-8: Unneeded variable: "res". Return "0" on line 1450
./drivers/pcmcia/pcmcia_resource.c:400:5-8: Unneeded variable: "ret". Return "- EINVAL" on line 420
./drivers/isdn/mISDN/dsp_core.c:958:6-9: Unneeded variable: "err". Return "0" on line 1003
./drivers/virt/fsl_hypervisor.c:688:5-8: Unneeded variable: "ret". Return "0" on line 696
./drivers/mmc/host/sdhci-pic32.c:127:5-8: Unneeded variable: "ret". Return "0" on line 137
./drivers/clocksource/timer-atmel-st.c:155:6-12: Unneeded variable: "status". Return "0" on line 179
./drivers/usb/gadget/function/f_eem.c:173:7-12: Unneeded variable: "value". Return "- EOPNOTSUPP" on line 183
./drivers/usb/gadget/udc/at91_udc.c:818:6-12: Unneeded variable: "status". Return "- EINVAL" on line 837
./drivers/usb/gadget/udc/omap_udc.c:2108:6-12: Unneeded variable: "status". Return "- ENODEV" on line 2130
./drivers/usb/host/u132-hcd.c:2560:6-11: Unneeded variable: "frame". Return "0" on line 2563
./drivers/hwtracing/coresight/coresight-tmc-etf.c:338:5-8: Unneeded variable: "ret". Return "0" on line 353
./drivers/hwtracing/coresight/coresight-etb10.c:312:5-8: Unneeded variable: "ret". Return "0" on line 327
./drivers/md/dm-snap-persistent.c:910:10-12: Unneeded variable: "sz". Return "0" on line 920
./drivers/power/supply/pm2301_charger.c:466:5-8: Unneeded variable: "ret". Return "0" on line 479
./drivers/staging/media/imx/imx-media-capture.c:546:5-8: Unneeded variable: "ret". Return "0" on line 559
./drivers/staging/media/atomisp/pci/atomisp2/css2400/sh_css.c:5592:17-20: Unneeded variable: "err". Return "IA_CSS_SUCCESS" on line 5606
./drivers/staging/media/atomisp/pci/atomisp2/css2400/sh_css.c:3692:17-20: Unneeded variable: "err". Return "IA_CSS_SUCCESS" on line 3718
./drivers/staging/media/atomisp/pci/atomisp2/css2400/runtime/isys/src/isys_init.c:108:22-27: Unneeded variable: "error". Return "INPUT_SYSTEM_ERR_NO_ERROR" on line 123
./drivers/staging/media/atomisp/pci/atomisp2/css2400/sh_css_mipi.c:282:17-20: Unneeded variable: "err". Return "IA_CSS_ERR_INTERNAL_ERROR" on line 381
./drivers/staging/media/atomisp/pci/atomisp2/css2400/sh_css_mipi.c:40:17-20: Unneeded variable: "err". Return "IA_CSS_SUCCESS" on line 45
./drivers/staging/rtl8723bs/os_dep/recv_linux.c:34:5-8: Unneeded variable: "res". Return "_SUCCESS" on line 38
./drivers/staging/rtl8723bs/os_dep/recv_linux.c:62:5-8: Unneeded variable: "ret". Return "_SUCCESS" on line 68
./drivers/staging/rtl8723bs/os_dep/os_intfs.c:238:6-12: Unneeded variable: "status". Return "_SUCCESS" on line 346
./drivers/staging/rtl8723bs/os_dep/os_intfs.c:625:4-7: Unneeded variable: "ret". Return "_SUCCESS" on line 687
./drivers/staging/rtl8723bs/os_dep/os_intfs.c:730:4-8: Unneeded variable: "ret8". Return "_SUCCESS" on line 760
./drivers/staging/rtl8723bs/os_dep/os_intfs.c:1431:5-8: Unneeded variable: "ret". Return "_SUCCESS" on line 1473
./drivers/staging/rtl8723bs/os_dep/os_intfs.c:1481:5-8: Unneeded variable: "ret". Return "_SUCCESS" on line 1505
./drivers/staging/rtl8723bs/os_dep/os_intfs.c:1348:5-8: Unneeded variable: "ret". Return "_SUCCESS" on line 1420
./drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:2784:5-8: Unneeded variable: "ret". Return "0" on line 3365
./drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:4592:5-8: Unneeded variable: "err". Return "0" on line 4593
./drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:4600:5-8: Unneeded variable: "err". Return "0" on line 4601
./drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:2535:5-8: Unneeded variable: "ret". Return "0" on line 2536
./drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:2714:5-8: Unneeded variable: "ret". Return "0" on line 2716
./drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:2725:5-8: Unneeded variable: "ret". Return "0" on line 2727
./drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:2703:5-8: Unneeded variable: "ret". Return "0" on line 2705
./drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:4608:5-8: Unneeded variable: "ret". Return "0" on line 4609
./drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:4617:5-8: Unneeded variable: "ret". Return "0" on line 4618
./drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:4630:5-8: Unneeded variable: "ret". Return "0" on line 4635
./drivers/staging/rtlwifi/phydm/phydm_hwconfig.c:507:4-6: Unneeded variable: "sq". Return "0" on line 508
./drivers/staging/rtlwifi/phydm/phydm_hwconfig.c:1911:5-12: Unneeded variable: "value32". Return "0xFFFFFFFF" on line 1913
./drivers/staging/rtlwifi/phydm/phydm_hwconfig.c:1904:5-12: Unneeded variable: "value32". Return "0xFFFFFFFF" on line 1906
./drivers/staging/rtlwifi/phydm/phydm_hwconfig.c:1897:5-12: Unneeded variable: "value32". Return "0xFFFFFFFF" on line 1899
./drivers/staging/rtlwifi/phydm/phydm_hwconfig.c:1925:5-12: Unneeded variable: "value32". Return "0xFFFFFFFF" on line 1927
./drivers/staging/rtlwifi/phydm/phydm_hwconfig.c:1918:5-12: Unneeded variable: "value32". Return "0xFFFFFFFF" on line 1920
./drivers/gpu/drm/i915/i915_debugfs.c:1029:5-8: Unneeded variable: "ret". Return "0" on line 1219
./drivers/gpu/drm/i810/i810_dma.c:853:8-11: Unneeded variable: "ret". Return "0" on line 878
./drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c:4727:5-8: Unneeded variable: "ret". Return "0" on line 4735
./drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c:1185:5-11: Unneeded variable: "result". Return "0" on line 1228
./drivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c:893:5-11: Unneeded variable: "result". Return "0" on line 932
./drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c:4570:5-11: Unneeded variable: "result". Return "0" on line 4618
./drivers/pci/hotplug/pcihp_skeleton.c:112:5-11: Unneeded variable: "retval". Return "0" on line 120
./drivers/pci/hotplug/pcihp_skeleton.c:98:5-11: Unneeded variable: "retval". Return "0" on line 106
./drivers/pci/hotplug/pcihp_skeleton.c:215:5-11: Unneeded variable: "retval". Return "0" on line 224
./drivers/pci/hotplug/pcihp_skeleton.c:185:5-11: Unneeded variable: "retval". Return "0" on line 194
./drivers/pci/hotplug/pcihp_skeleton.c:200:5-11: Unneeded variable: "retval". Return "0" on line 209
./drivers/pci/hotplug/pcihp_skeleton.c:170:5-11: Unneeded variable: "retval". Return "0" on line 179
./drivers/pci/hotplug/pcihp_skeleton.c:151:5-11: Unneeded variable: "retval". Return "0" on line 164
./drivers/pci/hotplug/pcihp_skeleton.c:126:5-11: Unneeded variable: "retval". Return "0" on line 145
./drivers/media/i2c/ov2659.c:1186:5-8: Unneeded variable: "ret". Return "0" on line 1212
./drivers/media/dvb-frontends/lgdt3306a.c:688:5-8: Unneeded variable: "ret". Return "0" on line 713
./drivers/input/serio/i8042.c:1113:6-11: Unneeded variable: "delay". Return "0" on line 1129
./drivers/scsi/ipr.c:10069:13-15: Unneeded variable: "rc". Return "IRQ_HANDLED" on line 10078
./drivers/scsi/ipr.c:9490:5-7: Unneeded variable: "rc". Return "0" on line 9506
./drivers/scsi/lpfc/lpfc_sli.c:2827:5-7: Unneeded variable: "rc". Return "1" on line 2956
./drivers/scsi/isci/request.c:2157:17-23: Unneeded variable: "status". Return "SCI_SUCCESS" on line 2177
./drivers/scsi/isci/request.c:1483:17-23: Unneeded variable: "status". Return "SCI_SUCCESS" on line 1503
./drivers/scsi/isci/request.c:2106:17-23: Unneeded variable: "status". Return "SCI_SUCCESS" on line 2151
./drivers/scsi/qla4xxx/ql4_os.c:3600:5-7: Unneeded variable: "rc". Return "0" on line 3699
./drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:2358:6-8: Unneeded variable: "rc". Return "ADAPT_SUCCESS" on line 2374
./drivers/i2c/busses/i2c-s3c2410.c:403:5-8: Unneeded variable: "ret". Return "0" on line 563
./drivers/infiniband/hw/qib/qib_iba7322.c:6913:8-11: Unneeded variable: "ret". Return "0" on line 6943
./drivers/infiniband/hw/qib/qib_iba7322.c:2375:5-8: Unneeded variable: "ret". Return "0" on line 2510
./drivers/char/mwave/tp3780i.c:182:5-11: Unneeded variable: "retval". Return "0" on line 187
./drivers/char/mwave/tp3780i.c:477:5-11: Unneeded variable: "retval". Return "0" on line 509
./sound/ppc/snd_ps3.c:647:5-8: Unneeded variable: "ret". Return "0" on line 684
./sound/soc/intel/baytrail/sst-baytrail-ipc.c:281:5-12: Unneeded variable: "handled". Return "1" on line 301
./sound/soc/bcm/cygnus-pcm.c:642:5-8: Unneeded variable: "ret". Return "0" on line 650
./sound/pci/au88x0/au88x0_a3d.c:833:8-15: Unneeded variable: "changed". Return "1" on line 846
./sound/pci/au88x0/au88x0_a3d.c:780:5-12: Unneeded variable: "changed". Return "1" on line 789
./sound/pci/au88x0/au88x0_a3d.c:816:5-12: Unneeded variable: "changed". Return "1" on line 825
./sound/pci/au88x0/au88x0_a3d.c:798:8-15: Unneeded variable: "changed". Return "1" on line 808
./sound/pci/lx6464es/lx6464es.c:272:5-8: Unneeded variable: "err". Return "0" on line 274
./fs/ext4/mballoc.c:3834:5-8: Unneeded variable: "err". Return "0" on line 3875
./fs/cifs/cifssmb.c:3438:7-9: Unneeded variable: "rc". Return "0" on line 3452
./fs/reiserfs/journal.c:1688:5-8: Unneeded variable: "ret". Return "0" on line 1717
./fs/ecryptfs/crypto.c:897:5-7: Unneeded variable: "rc". Return "0" on line 911
./fs/btrfs/tree-log.c:221:5-8: Unneeded variable: "ret". Return "- ENOENT" on line 226
./fs/btrfs/compression.c:1088:5-8: Unneeded variable: "ret". Return "1" on line 1098
./arch/um/drivers/hostaudio_kern.c:125:14-18: Unneeded variable: "mask". Return "0" on line 131
./arch/c6x/kernel/signal.c:40:5-8: Unneeded variable: "err". Return "0" on line 62
./arch/alpha/kernel/err_titan.c:591:5-11: Unneeded variable: "status". Return "MCHK_DISPOSITION_UNKNOWN_ERROR" on line 600
./arch/x86/mm/pf_in.c:148:18-20: Unneeded variable: "rv". Return "OTHERS" on line 159
./arch/arm/mach-s3c24xx/mach-gta02.c:98:6-11: Unneeded variable: "delay". Return "0" on line 104
./arch/arm/mach-omap1/dma.c:247:10-16: Unneeded variable: "errata". Return "0" on line 256
./arch/tile/kernel/hardwall.c:949:5-6: Unneeded variable: "n". Return "0" on line 955
./arch/microblaze/kernel/signal.c:62:14-17: Unneeded variable: "err". Return "0" on line 80
./arch/powerpc/oprofile/op_model_cell.c:1343:5-8: Unneeded variable: "rtn". Return "0" on line 1399
./arch/powerpc/oprofile/op_model_cell.c:1121:5-8: Unneeded variable: "ret". Return "0" on line 1126
./arch/powerpc/kvm/book3s_pr.c:240:5-6: Unneeded variable: "r". Return "1" on line 247
./tools/perf/util/evsel.c:1532:5-8: Unneeded variable: "ret". Return "0" on line 1581
./net/9p/mod.c:174:5-8: Unneeded variable: "ret". Return "0" on line 180
./net/iucv/af_iucv.c:153:5-8: Unneeded variable: "err". Return "0" on line 178
./net/sunrpc/xprtrdma/svc_rdma_transport.c:553:5-8: Unneeded variable: "ret". Return "0" on line 583
./net/dccp/proto.c:262:5-8: Unneeded variable: "err". Return "0" on line 304
./samples/bpf/xdp1_kern.c:48:5-7: Unneeded variable: "rc". Return "XDP_DROP" on line 56
./drivers/net/wireless/intel/ipw2x00/ipw2200.c:10672:5-8: Unneeded variable: "ret". Return "0" on line 10708
./drivers/net/wireless/intel/iwlegacy/4965-mac.c:3353:5-8: Unneeded variable: "ret". Return "0" on line 3390
./drivers/net/wireless/realtek/rtlwifi/pci.c:949:13-16: Unneeded variable: "ret". Return "IRQ_HANDLED" on line 952
./drivers/net/wireless/ath/wcn36xx/main.c:1116:5-8: Unneeded variable: "ret". Return "0" on line 1165
./drivers/net/wireless/ath/ath5k/eeprom.c:1710:5-8: Unneeded variable: "ret". Return "0" on line 1733
./drivers/net/wireless/ath/ath9k/gpio.c:503:5-8: Unneeded variable: "len". Return "0" on line 510
./drivers/net/wireless/broadcom/b43legacy/debugfs.c:81:9-14: Unneeded variable: "count". Return "0" on line 89
./drivers/net/wireless/broadcom/b43legacy/debugfs.c:141:9-14: Unneeded variable: "count". Return "0" on line 182
./drivers/net/wireless/broadcom/b43legacy/debugfs.c:107:9-14: Unneeded variable: "count". Return "0" on line 115
./drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c:5110:6-15: Unneeded variable: "callbacks". Return "0" on line 5112
./drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c:3780:5-8: Unneeded variable: "err". Return "0" on line 3788
./drivers/net/wireless/broadcom/brcm80211/brcmsmac/stf.c:309:5-13: Unneeded variable: "ret_code". Return "0" on line 328
./drivers/net/ethernet/microchip/encx24j600.c:614:5-8: Unneeded variable: "ret". Return "0" on line 658
./drivers/net/ethernet/intel/igb/e1000_mac.c:748:5-12: Unneeded variable: "ret_val". Return "0" on line 771
./drivers/net/ethernet/intel/i40evf/i40evf_main.c:442:5-8: Unneeded variable: "err". Return "0" on line 483
./drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:3849:17-23: Unneeded variable: "caps32". Return "0" on line 3875
./drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:3888:17-23: Unneeded variable: "caps16". Return "0" on line 3914
./drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:3162:5-8: Unneeded variable: "ret". Return "0" on line 3179
./drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c:683:14-21: Unneeded variable: "fw_caps". Return "0" on line 702
./drivers/net/ethernet/chelsio/cxgb4vf/t4vf_hw.c:327:17-23: Unneeded variable: "caps32". Return "0" on line 353
./drivers/net/ethernet/mellanox/mlx4/en_ethtool.c:1352:5-8: Unneeded variable: "err". Return "0" on line 1367
./drivers/net/ethernet/mellanox/mlx4/en_ethtool.c:1194:5-8: Unneeded variable: "err". Return "0" on line 1208
./drivers/net/ethernet/mellanox/mlx4/port.c:1823:5-8: Unneeded variable: "err". Return "0" on line 1825
./drivers/net/ethernet/mellanox/mlx4/port.c:1843:5-8: Unneeded variable: "err". Return "0" on line 1845
./drivers/net/ethernet/myricom/myri10ge/myri10ge.c:3043:5-10: Unneeded variable: "error". Return "0" on line 3055
./drivers/net/ethernet/qlogic/qed/qed_int.c:843:5-7: Unneeded variable: "rc". Return "0" on line 978
./drivers/net/ethernet/neterion/vxge/vxge-main.c:1977:21-27: Unneeded variable: "status". Return "VXGE_HW_OK" on line 1992
./drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:2478:5-11: Unneeded variable: "retval". Return "0" on line 2498
./drivers/tty/serial/amba-pl011.c:1556:14-20: Unneeded variable: "result". Return "0" on line 1568
./drivers/video/fbdev/pxa168fb.c:568:5-8: Unneeded variable: "ret". Return "0" on line 600
./drivers/mmc/core/sdio_bus.c:182:5-8: Unneeded variable: "ret". Return "0" on line 208
./drivers/spi/spi-armada-3700.c:289:8-11: Unneeded variable: "ret". Return "0" on line 321
./drivers/usb/image/microtek.c:572:5-8: Unneeded variable: "err". Return "0" on line 619
./drivers/usb/gadget/udc/fotg210-udc.c:490:5-8: Unneeded variable: "ret". Return "0" on line 513
./drivers/usb/misc/sisusbvga/sisusb.c:1752:5-8: Unneeded variable: "ret". Return "0" on line 1876
./drivers/usb/wusbcore/wa-rpipe.c:400:5-11: Unneeded variable: "result". Return "0" on line 422
./drivers/md/dm-log.c:784:5-7: Unneeded variable: "sz". Return "0" on line 798
./drivers/md/dm-log.c:804:5-7: Unneeded variable: "sz". Return "0" on line 822
./drivers/md/persistent-data/dm-btree-spine.c:137:5-6: Unneeded variable: "r". Return "0" on line 143
./drivers/md/persistent-data/dm-btree-spine.c:190:5-6: Unneeded variable: "r". Return "0" on line 196
./drivers/md/bcache/debug.c:253:5-8: Unneeded variable: "ret". Return "0" on line 256
./drivers/md/dm-snap-transient.c:91:10-12: Unneeded variable: "sz". Return "0" on line 100
./drivers/md/dm-cache-metadata.c:1491:5-6: Unneeded variable: "r". Return "0" on line 1499
./drivers/of/dynamic.c:299:5-7: Unneeded variable: "rc". Return "0" on line 314
./drivers/uio/uio_dmem_genirq.c:50:5-8: Unneeded variable: "ret". Return "0" on line 74
./drivers/dma/ppc4xx/adma.c:3257:5-9: Unneeded variable: "rval". Return "0" on line 3365
./drivers/staging/media/atomisp/pci/atomisp2/css2400/sh_css_sp.c:820:17-20: Unneeded variable: "err". Return "IA_CSS_SUCCESS" on line 844
./drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:2469:5-8: Unneeded variable: "ret". Return "0" on line 2473
./drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:2460:5-8: Unneeded variable: "ret". Return "0" on line 2464
./drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:2625:5-8: Unneeded variable: "ret". Return "0" on line 2629
./drivers/staging/rtl8723bs/hal/odm_HWConfig.c:509:4-10: Unneeded variable: "result". Return "HAL_STATUS_SUCCESS" on line 534
./drivers/staging/rtl8723bs/core/rtw_recv.c:1629:6-9: Unneeded variable: "ret". Return "_SUCCESS" on line 1716
./drivers/staging/rtl8723bs/core/rtw_cmd.c:216:6-9: Unneeded variable: "res". Return "_SUCCESS" on line 226
./drivers/staging/rtl8723bs/core/rtw_ap.c:1529:5-8: Unneeded variable: "ret". Return "0" on line 1573
./drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:471:5-8: Unneeded variable: "res". Return "_SUCCESS" on line 502
./drivers/staging/rtlwifi/pci.c:953:13-16: Unneeded variable: "ret". Return "IRQ_HANDLED" on line 956
./drivers/gpu/drm/i915/intel_dp.c:4151:9-20: Unneeded variable: "test_result". Return "DP_TEST_NAK" on line 4152
./drivers/gpu/drm/i915/intel_pipe_crc.c:251:5-8: Unneeded variable: "ret". Return "0" on line 294
./drivers/gpu/drm/ast/ast_drv.c:92:5-10: Unneeded variable: "error". Return "0" on line 102
./drivers/gpu/drm/tegra/dpaux.c:264:13-16: Unneeded variable: "ret". Return "IRQ_HANDLED" on line 281
./drivers/gpu/drm/vc4/vc4_gem.c:903:5-8: Unneeded variable: "ret". Return "0" on line 918
./drivers/gpu/drm/nouveau/nouveau_bios.c:2043:5-8: Unneeded variable: "ret". Return "0" on line 2056
./drivers/gpu/drm/amd/amdgpu/vega10_ih.c:91:5-8: Unneeded variable: "ret". Return "0" on line 173
./drivers/scsi/lpfc/lpfc_scsi.c:1787:9-12: Unneeded variable: "ret". Return "0" on line 1840
./drivers/scsi/lpfc/lpfc_attr.c:4679:5-11: Unneeded variable: "status". Return "- EINVAL" on line 4680
./drivers/scsi/bnx2fc/bnx2fc_io.c:1086:5-7: Unneeded variable: "rc". Return "SUCCESS" on line 1103
./drivers/scsi/osst.c:4920:12-18: Unneeded variable: "result". Return "0" on line 4936
./drivers/scsi/qla2xxx/qla_mr.c:1715:5-9: Unneeded variable: "rval". Return "0" on line 1767
./drivers/scsi/qla2xxx/qla_iocb.c:3183:9-13: Unneeded variable: "rval". Return "QLA_SUCCESS" on line 3206
./drivers/scsi/3w-sas.c:866:5-11: Unneeded variable: "retval". Return "1" on line 898
./drivers/scsi/ufs/ufs-qcom.c:563:5-8: Unneeded variable: "ret". Return "0" on line 589
./drivers/scsi/st.c:1459:5-11: Unneeded variable: "result". Return "0" on line 1472
./drivers/misc/ti-st/st_core.c:724:5-8: Unneeded variable: "err". Return "0" on line 747
./drivers/devfreq/tegra-devfreq.c:576:5-8: Unneeded variable: "ret". Return "0" on line 602
./drivers/infiniband/hw/qedr/verbs.c:415:5-11: Unneeded variable: "status". Return "0" on line 430
./drivers/infiniband/hw/qedr/verbs.c:2109:5-7: Unneeded variable: "rc". Return "0" on line 2132
./sound/soc/ux500/ux500_msp_i2s.c:539:5-11: Unneeded variable: "status". Return "0" on line 572
./sound/pci/asihpi/asihpi.c:1574:5-11: Unneeded variable: "change". Return "1" on line 1580
./sound/pci/emu10k1/emu10k1x.c:1097:5-11: Unneeded variable: "change". Return "0" on line 1112
./sound/pci/rme9652/rme9652.c:2175:5-11: Unneeded variable: "result". Return "0" on line 2181
./fs/jfs/jfs_txnmgr.c:1383:5-7: Unneeded variable: "rc". Return "0" on line 1430
./fs/ocfs2/stack_o2cb.c:77:5-16: Unneeded variable: "o2dlm_flags". Return "0" on line 92
./fs/btrfs/extent-tree.c:6685:5-8: Unneeded variable: "ret". Return "0" on line 6698
./fs/btrfs/extent_map.c:432:5-8: Unneeded variable: "ret". Return "0" on line 439
./fs/btrfs/extent_map.c:278:5-8: Unneeded variable: "ret". Return "0" on line 310
./arch/mips/cavium-octeon/executive/cvmx-spi.c:152:5-8: Unneeded variable: "res". Return "- 1" on line 155
./arch/mips/cavium-octeon/executive/cvmx-spi.c:108:5-8: Unneeded variable: "res". Return "- 1" on line 111
./arch/mips/sibyte/bcm1480/setup.c:50:5-8: Unneeded variable: "ret". Return "0" on line 80
./arch/mips/oprofile/op_model_mipsxx.c:233:5-12: Unneeded variable: "handled". Return "IRQ_NONE" on line 236
./arch/arm/mach-orion5x/ts78xx-setup.c:406:5-8: Unneeded variable: "ret". Return "0" on line 415
./arch/arm/mach-omap2/dma.c:125:10-16: Unneeded variable: "errata". Return "0" on line 204
./arch/arc/kernel/ptrace.c:115:5-8: Unneeded variable: "ret". Return "0" on line 184
./tools/thermal/tmon/pid.c:68:5-8: Unneeded variable: "ret". Return "0" on line 79
./tools/perf/builtin-trace.c:2021:5-8: Unneeded variable: "err". Return "0" on line 2037
./tools/perf/util/evlist.c:1633:5-8: Unneeded variable: "err". Return "- ENOMEM" on line 1654
./tools/perf/util/symbol_fprintf.c:62:8-11: Unneeded variable: "ret". Return "0" on line 71
./net/netfilter/ipvs/ip_vs_ctl.c:137:3-4: Unneeded semicolon
./net/netfilter/nft_dynset.c:167:61-62: Unneeded semicolon
./net/packet/af_packet.c:1627:2-3: Unneeded semicolon
./net/mac80211/debugfs_sta.c:423:3-4: Unneeded semicolon
./net/mac80211/debugfs_sta.c:441:3-4: Unneeded semicolon
./crypto/tgr192.c:563:43-44: Unneeded semicolon
./crypto/tgr192.c:591:44-45: Unneeded semicolon
./samples/bpf/cookie_uid_helper_example.c:316:3-4: Unneeded semicolon
./lib/decompress_bunzip2.c:387:3-4: Unneeded semicolon
./virt/kvm/arm/vgic/vgic-init.c:491:2-3: Unneeded semicolon
./drivers/memstick/host/jmb38x_ms.c:758:2-3: Unneeded semicolon
./drivers/memstick/host/tifm_ms.c:536:2-3: Unneeded semicolon
./drivers/net/dsa/mt7530.c:640:3-4: Unneeded semicolon
./drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c:696:2-3: Unneeded semicolon
./drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c:376:3-4: Unneeded semicolon
./drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c:334:3-4: Unneeded semicolon
./drivers/net/wireless/ath/ath10k/wmi.h:1915:2-3: Unneeded semicolon
./drivers/net/wireless/ray_cs.c:2219:2-3: Unneeded semicolon
./drivers/net/ethernet/mellanox/mlx4/cmd.c:3274:2-3: Unneeded semicolon
./drivers/net/ethernet/mellanox/mlx4/eq.c:822:3-4: Unneeded semicolon
./drivers/net/ethernet/cisco/enic/enic_clsf.c:34:2-3: Unneeded semicolon
./drivers/extcon/extcon-sm5502.c:408:2-3: Unneeded semicolon
./drivers/extcon/extcon-sm5502.c:360:3-4: Unneeded semicolon
./drivers/extcon/extcon-sm5502.c:366:2-3: Unneeded semicolon
./drivers/extcon/extcon-sm5502.c:252:2-3: Unneeded semicolon
./drivers/extcon/extcon-sm5502.c:271:2-3: Unneeded semicolon
./drivers/video/fbdev/ssd1307fb.c:316:2-3: Unneeded semicolon
./drivers/video/fbdev/ssd1307fb.c:332:2-3: Unneeded semicolon
./drivers/video/fbdev/ssd1307fb.c:718:2-3: Unneeded semicolon
./drivers/video/fbdev/ssd1307fb.c:742:2-3: Unneeded semicolon
./drivers/isdn/hisax/st5481.h:515:2-3: Unneeded semicolon
./drivers/ide/ide-taskfile.c:165:2-3: Unneeded semicolon
./drivers/soc/imx/gpc.c:337:35-36: Unneeded semicolon
./drivers/soc/fsl/guts.c:113:2-3: Unneeded semicolon
./drivers/spi/spi-topcliff-pch.c:875:47-48: Unneeded semicolon
./drivers/spi/spi-topcliff-pch.c:890:53-54: Unneeded semicolon
./drivers/usb/wusbcore/wa-xfer.c:731:2-3: Unneeded semicolon
./drivers/power/supply/ipaq_micro_battery.c:191:2-3: Unneeded semicolon
./drivers/power/supply/ipaq_micro_battery.c:155:3-4: Unneeded semicolon
./drivers/power/supply/ipaq_micro_battery.c:174:2-3: Unneeded semicolon
./drivers/power/supply/abx500_chargalg.c:1888:2-3: Unneeded semicolon
./drivers/platform/goldfish/pdev_bus.c:100:2-3: Unneeded semicolon
./drivers/rtc/rtc-omap.c:599:2-3: Unneeded semicolon
./drivers/irqchip/irq-gic-v3.c:107:2-3: Unneeded semicolon
./drivers/irqchip/irq-gic-v3.c:161:2-3: Unneeded semicolon
./drivers/irqchip/irq-zevio.c:58:2-3: Unneeded semicolon
./drivers/staging/media/atomisp/pci/atomisp2/css2400/runtime/frame/src/frame.c:199:2-3: Unneeded semicolon
./drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c:156:89-90: Unneeded semicolon
./drivers/staging/rtl8723bs/hal/hal_com_phycfg.c:1456:2-3: Unneeded semicolon
./drivers/staging/rtl8723bs/hal/hal_com_phycfg.c:338:3-4: Unneeded semicolon
./drivers/staging/rtl8723bs/hal/hal_com_phycfg.c:728:2-3: Unneeded semicolon
./drivers/staging/rtl8723bs/hal/hal_com_phycfg.c:69:3-4: Unneeded semicolon
./drivers/staging/rtl8723bs/hal/hal_com_phycfg.c:103:3-4: Unneeded semicolon
./drivers/staging/rtl8723bs/hal/hal_com_phycfg.c:163:3-4: Unneeded semicolon
./drivers/staging/rtl8723bs/hal/hal_com_phycfg.c:197:3-4: Unneeded semicolon
./drivers/staging/rtl8723bs/core/rtw_recv.c:1791:2-3: Unneeded semicolon
./drivers/staging/rtlwifi/rtl8822be/phy.c:1254:2-3: Unneeded semicolon
./drivers/gpu/drm/sun4i/sun4i_layer.c:166:3-4: Unneeded semicolon
./drivers/gpu/drm/sun4i/sun4i_layer.c:176:2-3: Unneeded semicolon
./drivers/gpu/drm/sun4i/sun8i_layer.c:127:3-4: Unneeded semicolon
./drivers/gpu/drm/sun4i/sun8i_layer.c:131:2-3: Unneeded semicolon
./drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c:90:2-3: Unneeded semicolon
./drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c:69:2-3: Unneeded semicolon
./drivers/gpu/drm/zte/zx_vga.c:163:2-3: Unneeded semicolon
./drivers/gpu/drm/zte/zx_vga.c:174:2-3: Unneeded semicolon
./drivers/gpu/drm/zte/zx_vga.c:182:2-3: Unneeded semicolon
./drivers/gpu/drm/msm/hdmi/hdmi_connector.c:125:3-4: Unneeded semicolon
./drivers/gpu/drm/msm/hdmi/hdmi_hdcp.c:772:2-3: Unneeded semicolon
./drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c:683:16-17: Unneeded semicolon
./drivers/media/usb/pvrusb2/pvrusb2-encoder.c:298:2-3: Unneeded semicolon
./drivers/media/platform/qcom/venus/vdec_ctrls.c:78:2-3: Unneeded semicolon
./drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c:155:3-4: Unneeded semicolon
./drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c:215:3-4: Unneeded semicolon
./drivers/media/i2c/ov13858.c:1224:2-3: Unneeded semicolon
./drivers/media/i2c/ov13858.c:1262:2-3: Unneeded semicolon
./drivers/cpufreq/longhaul.c:854:2-3: Unneeded semicolon
./drivers/acpi/apei/erst.c:698:2-3: Unneeded semicolon
./drivers/block/drbd/drbd_req.c:899:2-3: Unneeded semicolon
./drivers/block/sunvdc.c:614:2-3: Unneeded semicolon
./drivers/block/ataflop.c:779:53-54: Unneeded semicolon
./drivers/scsi/bfa/bfa_fcs_rport.c:2465:2-3: Unneeded semicolon
./drivers/scsi/bfa/bfa_fcs_rport.c:1591:3-4: Unneeded semicolon
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
./drivers/scsi/nsp32.c:1260:4-5: Unneeded semicolon
./drivers/scsi/nsp32.c:1852:2-3: Unneeded semicolon
./drivers/scsi/fnic/fnic_main.c:439:2-3: Unneeded semicolon
./drivers/scsi/pmcraid.c:5172:2-3: Unneeded semicolon
./drivers/scsi/fcoe/fcoe_sysfs.c:361:2-3: Unneeded semicolon
./drivers/scsi/fcoe/fcoe.c:1929:3-4: Unneeded semicolon
./drivers/scsi/fcoe/fcoe.c:1941:3-4: Unneeded semicolon
./drivers/scsi/sgiwd93.c:190:2-3: Unneeded semicolon
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
./drivers/pinctrl/mvebu/pinctrl-armada-37xx.c:724:2-3: Unneeded semicolon
./drivers/pinctrl/mvebu/pinctrl-armada-37xx.c:659:2-3: Unneeded semicolon
./drivers/devfreq/event/rockchip-dfi.c:214:2-3: Unneeded semicolon
./drivers/devfreq/rk3399_dmc.c:359:2-3: Unneeded semicolon
./drivers/firmware/iscsi_ibft.c:807:2-3: Unneeded semicolon
./drivers/firmware/psci.c:145:2-3: Unneeded semicolon
./drivers/infiniband/hw/qedr/verbs.c:1684:3-4: Unneeded semicolon
./drivers/infiniband/hw/qedr/verbs.c:1703:3-4: Unneeded semicolon
./drivers/infiniband/hw/qedr/verbs.c:1716:3-4: Unneeded semicolon
./drivers/infiniband/hw/qedr/verbs.c:1729:3-4: Unneeded semicolon
./drivers/infiniband/hw/qedr/verbs.c:1741:3-4: Unneeded semicolon
./drivers/infiniband/hw/qedr/verbs.c:1759:3-4: Unneeded semicolon
./drivers/infiniband/hw/qedr/verbs.c:1764:2-3: Unneeded semicolon
./sound/soc/intel/haswell/sst-haswell-pcm.c:547:2-3: Unneeded semicolon
./sound/soc/soc-topology.c:2113:2-3: Unneeded semicolon
./fs/xfs/xfs_itable.c:384:54-55: Unneeded semicolon
./fs/dlm/rcom.c:580:2-3: Unneeded semicolon
./fs/9p/vfs_inode.c:161:3-4: Unneeded semicolon
./fs/gfs2/glops.c:349:2-3: Unneeded semicolon
./fs/ocfs2/dlmglue.c:560:2-3: Unneeded semicolon
./fs/ocfs2/cluster/quorum.c:89:2-3: Unneeded semicolon
./arch/arm64/kernel/probes/kprobes.c:110:2-3: Unneeded semicolon
./arch/arm64/kvm/guest.c:296:3-4: Unneeded semicolon
./arch/arm64/kvm/guest.c:302:3-4: Unneeded semicolon
./arch/arm64/kvm/guest.c:304:2-3: Unneeded semicolon
./arch/m68k/include/asm/sun3xflop.h:108:2-3: Unneeded semicolon
./arch/mips/mti-malta/malta-time.c:153:2-3: Unneeded semicolon
./arch/mips/oprofile/common.c:113:2-3: Unneeded semicolon
./arch/mips/kvm/tlb.c:472:2-3: Unneeded semicolon
./arch/mips/kvm/tlb.c:489:2-3: Unneeded semicolon
./arch/mips/kvm/emulate.c:1969:3-4: Unneeded semicolon
./arch/mips/netlogic/xlr/fmn.c:106:2-3: Unneeded semicolon
./arch/alpha/kernel/sys_eiger.c:178:2-3: Unneeded semicolon
./arch/s390/kernel/perf_cpum_cf.c:401:2-3: Unneeded semicolon
./arch/powerpc/crypto/sha256-spe-glue.c:138:2-3: Unneeded semicolon
./arch/powerpc/platforms/powernv/pci-ioda.c:1825:17-18: Unneeded semicolon
./arch/powerpc/kernel/prom_init.c:2801:2-3: Unneeded semicolon
./arch/powerpc/kvm/booke.c:703:2-3: Unneeded semicolon
./arch/powerpc/sysdev/tsi108_dev.c:54:2-3: Unneeded semicolon
./include/linux/nfs4.h:296:2-3: Unneeded semicolon
./tools/power/cpupower/utils/cpupower-info.c:57:2-3: Unneeded semicolon
./tools/power/cpupower/utils/cpupower-set.c:67:2-3: Unneeded semicolon
./tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c:121:2-3: Unneeded semicolon
./tools/power/cpupower/utils/idle_monitor/nhm_idle.c:95:2-3: Unneeded semicolon
./tools/power/cpupower/utils/idle_monitor/snb_idle.c:81:2-3: Unneeded semicolon
./tools/perf/builtin-mem.c:120:2-3: Unneeded semicolon
./tools/perf/util/evlist.c:1996:18-19: Unneeded semicolon
./tools/perf/builtin-diff.c:1040:2-3: Unneeded semicolon
./tools/testing/selftests/x86/ldt_gdt.c:558:2-3: Unneeded semicolon
./tools/virtio/virtio-trace/trace-agent-ctl.c:80:2-3: Unneeded semicolon
./net/sunrpc/auth_gss/auth_gss.c:520:2-3: Unneeded semicolon
./net/core/utils.c:400:2-3: Unneeded semicolon
./net/openvswitch/flow_netlink.c:2199:2-3: Unneeded semicolon
./net/openvswitch/flow_netlink.c:2166:2-3: Unneeded semicolon
./net/sched/act_pedit.c:266:2-3: Unneeded semicolon
./crypto/af_alg.c:493:2-3: Unneeded semicolon
./security/selinux/hooks.c:1232:3-4: Unneeded semicolon
./virt/kvm/arm/vgic/vgic.c:132:2-3: Unneeded semicolon
./drivers/net/usb/sr9700.c:437:2-3: Unneeded semicolon
./drivers/net/wireless/intel/iwlwifi/mvm/d3.c:559:2-3: Unneeded semicolon
./drivers/net/wireless/ath/ath6kl/init.c:1143:2-3: Unneeded semicolon
./drivers/net/ethernet/faraday/ftgmac100.c:1649:2-3: Unneeded semicolon
./drivers/net/ethernet/ti/cpsw-phy-sel.c:81:2-3: Unneeded semicolon
./drivers/net/ethernet/ti/cpsw-phy-sel.c:136:2-3: Unneeded semicolon
./drivers/net/ethernet/mediatek/mtk_eth_soc.c:228:2-3: Unneeded semicolon
./drivers/watchdog/riowd.c:143:2-3: Unneeded semicolon
./drivers/video/fbdev/sis/sis_accel.h:156:72-73: Unneeded semicolon
./drivers/video/fbdev/sis/sis_accel.h:157:72-73: Unneeded semicolon
./drivers/video/fbdev/sis/sis_accel.h:158:72-73: Unneeded semicolon
./drivers/video/fbdev/sis/sis_accel.h:286:75-76: Unneeded semicolon
./drivers/video/fbdev/sis/sis_accel.h:287:75-76: Unneeded semicolon
./drivers/video/fbdev/sis/sis_accel.h:288:73-74: Unneeded semicolon
./drivers/video/fbdev/sis/sis_accel.h:289:75-76: Unneeded semicolon
./drivers/pcmcia/db1xxx_ss.c:450:2-3: Unneeded semicolon
./drivers/isdn/isdnloop/isdnloop.c:75:4-5: Unneeded semicolon
./drivers/isdn/hisax/netjet.c:335:2-3: Unneeded semicolon
./drivers/isdn/hisax/netjet.c:626:2-3: Unneeded semicolon
./drivers/isdn/hisax/netjet.c:418:2-3: Unneeded semicolon
./drivers/isdn/hisax/q931.c:601:2-3: Unneeded semicolon
./drivers/uwb/i1480/dfu/mac.c:141:2-3: Unneeded semicolon
./drivers/uwb/ie.c:94:2-3: Unneeded semicolon
./drivers/soc/sunxi/sunxi_sram.c:196:2-3: Unneeded semicolon
./drivers/usb/gadget/function/f_fs.c:2405:2-3: Unneeded semicolon
./drivers/atm/firestream.c:1088:3-4: Unneeded semicolon
./drivers/md/raid1.c:1113:40-41: Unneeded semicolon
./drivers/power/reset/vexpress-poweroff.c:139:2-3: Unneeded semicolon
./drivers/power/supply/ab8500_charger.c:1077:2-3: Unneeded semicolon
./drivers/power/supply/ab8500_charger.c:787:2-3: Unneeded semicolon
./drivers/power/supply/ab8500_charger.c:2489:2-3: Unneeded semicolon
./drivers/power/supply/ab8500_fg.c:2226:5-6: Unneeded semicolon
./drivers/power/supply/ab8500_fg.c:2229:4-5: Unneeded semicolon
./drivers/power/supply/ab8500_fg.c:2338:3-4: Unneeded semicolon
./drivers/power/supply/ab8500_fg.c:2346:3-4: Unneeded semicolon
./drivers/power/supply/ab8500_fg.c:2354:3-4: Unneeded semicolon
./drivers/power/supply/ab8500_fg.c:2362:3-4: Unneeded semicolon
./drivers/power/supply/ab8500_fg.c:2370:3-4: Unneeded semicolon
./drivers/target/sbp/sbp_target.c:1023:2-3: Unneeded semicolon
./drivers/s390/cio/vfio_ccw_drv.c:59:3-4: Unneeded semicolon
./drivers/clk/qcom/clk-rcg2.c:307:2-3: Unneeded semicolon
./drivers/clk/qcom/clk-rcg2.c:202:2-3: Unneeded semicolon
./drivers/clk/clk.c:2621:2-3: Unneeded semicolon
./drivers/dma/pxa_dma.c:1428:3-4: Unneeded semicolon
./drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c:1055:81-82: Unneeded semicolon
./drivers/staging/rtlwifi/phydm/rtl8822b/phydm_iqk_8822b.c:1314:2-3: Unneeded semicolon
./drivers/gpu/drm/rockchip/cdn-dp-reg.c:712:2-3: Unneeded semicolon
./drivers/gpu/drm/rockchip/cdn-dp-reg.c:612:2-3: Unneeded semicolon
./drivers/gpu/drm/rockchip/cdn-dp-reg.c:630:2-3: Unneeded semicolon
./drivers/gpu/drm/nouveau/nvkm/subdev/bios/iccsense.c:102:3-4: Unneeded semicolon
./drivers/gpu/drm/nouveau/nvkm/subdev/bios/iccsense.c:118:3-4: Unneeded semicolon
./drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c:219:2-3: Unneeded semicolon
./drivers/gpu/drm/meson/meson_plane.c:142:2-3: Unneeded semicolon
./drivers/gpu/drm/meson/meson_vclk.c:488:3-4: Unneeded semicolon
./drivers/gpu/drm/meson/meson_vclk.c:519:3-4: Unneeded semicolon
./drivers/gpu/drm/meson/meson_vclk.c:530:2-3: Unneeded semicolon
./drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:579:2-3: Unneeded semicolon
./drivers/pwm/pwm-lpc18xx-sct.c:295:2-3: Unneeded semicolon
./drivers/remoteproc/qcom_wcnss.c:512:2-3: Unneeded semicolon
./drivers/pci/host/pcie-rcar.c:441:2-3: Unneeded semicolon
./drivers/media/platform/pxa_camera.c:1394:2-3: Unneeded semicolon
./drivers/cpufreq/pcc-cpufreq.c:271:2-3: Unneeded semicolon
./drivers/acpi/acpica/nsalloc.c:329:2-3: Unneeded semicolon
./drivers/scsi/bfa/bfa_fcs_lport.c:4369:3-4: Unneeded semicolon
./drivers/scsi/qla4xxx/ql4_os.c:954:3-4: Unneeded semicolon
./drivers/scsi/sym53c8xx_2/sym_fw.c:389:3-4: Unneeded semicolon
./drivers/scsi/sym53c8xx_2/sym_fw.c:497:3-4: Unneeded semicolon
./drivers/scsi/sym53c8xx_2/sym_fw.c:553:2-3: Unneeded semicolon
./drivers/scsi/qlogicpti.c:1142:3-4: Unneeded semicolon
./drivers/scsi/ipr.h:1983:2-3: Unneeded semicolon
./drivers/misc/mic/vop/vop_main.c:411:2-3: Unneeded semicolon
./drivers/misc/mic/vop/vop_main.c:216:2-3: Unneeded semicolon
./drivers/misc/mic/cosm/cosm_scif_server.c:129:2-3: Unneeded semicolon
./drivers/iio/light/lm3533-als.c:749:2-3: Unneeded semicolon
./drivers/iio/temperature/maxim_thermocouple.c:203:3-4: Unneeded semicolon
./drivers/iio/adc/bcm_iproc_adc.c:322:3-4: Unneeded semicolon
./drivers/iio/adc/exynos_adc.c:636:2-3: Unneeded semicolon
./sound/soc/sunxi/sun4i-codec.c:1280:2-3: Unneeded semicolon
./sound/soc/sunxi/sun4i-codec.c:1318:2-3: Unneeded semicolon
./sound/soc/sunxi/sun4i-codec.c:1356:2-3: Unneeded semicolon
./fs/nfsd/nfs4state.c:2823:2-3: Unneeded semicolon
./fs/nfs/super.c:2516:3-4: Unneeded semicolon
./fs/nfs/super.c:1569:4-5: Unneeded semicolon
./fs/nfs/super.c:1602:4-5: Unneeded semicolon
./fs/nfs/nfs4proc.c:7984:2-3: Unneeded semicolon
./fs/nfs/nfs4proc.c:6253:2-3: Unneeded semicolon
./fs/nfs/nfs4state.c:1103:2-3: Unneeded semicolon
./fs/ntfs/super.c:1629:2-3: Unneeded semicolon
./fs/ntfs/super.c:1698:2-3: Unneeded semicolon
./fs/ntfs/lcnalloc.c:916:2-3: Unneeded semicolon
./fs/gfs2/inode.c:1478:3-4: Unneeded semicolon
./fs/gfs2/recovery.c:485:3-4: Unneeded semicolon
./fs/f2fs/checkpoint.c:989:2-3: Unneeded semicolon
./fs/ubifs/sb.c:606:2-3: Unneeded semicolon
./arch/cris/arch-v32/drivers/cryptocop.c:3009:3-4: Unneeded semicolon
./arch/cris/arch-v32/drivers/cryptocop.c:1776:2-3: Unneeded semicolon
./arch/mips/kvm/vz.c:1186:4-5: Unneeded semicolon
./arch/mips/kvm/vz.c:1195:3-4: Unneeded semicolon
./arch/mips/kvm/vz.c:1949:3-4: Unneeded semicolon
./arch/mips/kvm/vz.c:2188:3-4: Unneeded semicolon
./arch/alpha/kernel/osf_sys.c:682:2-3: Unneeded semicolon
./arch/blackfin/include/asm/dma.h:244:2-3: Unneeded semicolon
./arch/arm/mach-artpec/board-artpec6.c:45:2-3: Unneeded semicolon
./arch/arc/kernel/unwind.c:369:51-52: Unneeded semicolon
./arch/powerpc/crypto/sha1-spe-glue.c:116:2-3: Unneeded semicolon
./arch/powerpc/platforms/pseries/lpar.c:682:2-3: Unneeded semicolon
./arch/powerpc/platforms/ps3/system-bus.c:619:2-3: Unneeded semicolon
./arch/powerpc/platforms/ps3/system-bus.c:777:2-3: Unneeded semicolon
./arch/powerpc/kernel/eeh.c:790:2-3: Unneeded semicolon
./arch/powerpc/boot/cuboot-c2k.c:118:2-3: Unneeded semicolon
./tools/lib/traceevent/kbuffer-parse.c:456:2-3: Unneeded semicolon
./tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c:159:2-3: Unneeded semicolon
./tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c:58:2-3: Unneeded semicolon
./tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c:77:2-3: Unneeded semicolon
./tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c:84:2-3: Unneeded semicolon
./tools/perf/builtin-c2c.c:1611:2-3: Unneeded semicolon
./tools/perf/builtin-c2c.c:1827:2-3: Unneeded semicolon
./tools/perf/builtin-c2c.c:2740:2-3: Unneeded semicolon
./tools/perf/util/ordered-events.c:271:2-3: Unneeded semicolon
./tools/perf/util/trace-event-read.c:97:2-3: Unneeded semicolon
./tools/testing/selftests/timers/nsleep-lat.c:75:2-3: Unneeded semicolon
./tools/testing/selftests/timers/inconsistency-check.c:75:2-3: Unneeded semicolon
./tools/testing/selftests/timers/alarmtimer-suspend.c:82:2-3: Unneeded semicolon
./tools/testing/selftests/timers/nanosleep.c:75:2-3: Unneeded semicolon
./tools/testing/selftests/timers/set-timer-lat.c:83:2-3: Unneeded semicolon
./tools/testing/selftests/ipc/msgque.c:181:2-3: Unneeded semicolon
./tools/testing/selftests/ipc/msgque.c:189:2-3: Unneeded semicolon
./tools/testing/selftests/ipc/msgque.c:70:3-4: Unneeded semicolon
./tools/testing/selftests/nsfs/pidns.c:72:36-37: Unneeded semicolon
./scripts/gcc-plugins/latent_entropy_plugin.c:546:2-3: Unneeded semicolon
./kernel/trace/trace_output.c:772:2-8: SUGGESTION: printk + WARN_ON can be just WARN
./kernel/trace/trace_output.c:1406:3-9: SUGGESTION: printk + WARN_ON_ONCE can be just WARN_ONCE
./kernel/trace/trace.c:8334:2-8: SUGGESTION: printk + WARN_ON can be just WARN
./include/linux/wimax/debug.h:178:2-8: SUGGESTION: printk + WARN_ON can be just WARN
./fs/dcache.c:1469:1-7: SUGGESTION: printk + WARN_ON can be just WARN
./drivers/usb/wusbcore/wusbhc.c:496:2-8: SUGGESTION: printk + WARN_ON can be just WARN
./drivers/usb/wusbcore/wa-xfer.c:2001:3-9: SUGGESTION: printk + WARN_ON can be just WARN
./drivers/scsi/scsi_lib.c:3245:2-8: SUGGESTION: printk + WARN_ON can be just WARN
./drivers/scsi/initio.c:2761:2-8: SUGGESTION: printk + WARN_ON can be just WARN
./drivers/scsi/gdth.c:2314:8-14: SUGGESTION: printk + WARN_ON can be just WARN
./fs/jbd2/transaction.c:1431:3-9: SUGGESTION: printk + WARN_ON can be just WARN
./fs/jbd2/transaction.c:294:2-8: SUGGESTION: printk + WARN_ON can be just WARN
./drivers/misc/kgdbts.c:120:2-8: SUGGESTION: printk + WARN_ON can be just WARN
./arch/ia64/kernel/iosapic.c:801:2-8: SUGGESTION: printk + WARN_ON can be just WARN
./arch/ia64/kernel/iosapic.c:809:2-8: SUGGESTION: printk + WARN_ON can be just WARN
./arch/arm/mach-omap1/mux.c:477:2-8: SUGGESTION: printk + WARN_ON can be just WARN
./drivers/macintosh/via-pmu.c:2083:11-12: WARNING comparing pointer to 0, suggest !E
./drivers/macintosh/via-pmu.c:276:12-13: WARNING comparing pointer to 0
./drivers/macintosh/via-pmu.c:2166:11-12: WARNING comparing pointer to 0
./drivers/macintosh/via-pmu.c:1384:14-15: WARNING comparing pointer to 0
./drivers/macintosh/via-pmu.c:2083:11-12: WARNING comparing pointer to 0
./drivers/macintosh/via-pmu.c:1751:15-16: WARNING comparing pointer to 0
./drivers/macintosh/via-pmu.c:1154:20-21: WARNING comparing pointer to 0
./drivers/macintosh/via-pmu.c:2109:24-25: WARNING comparing pointer to 0
./drivers/macintosh/via-pmu.c:2182:11-12: WARNING comparing pointer to 0
./drivers/macintosh/via-pmu.c:1229:12-13: WARNING comparing pointer to 0
./drivers/macintosh/adb-iop.c:246:20-21: WARNING comparing pointer to 0
./drivers/macintosh/via-cuda.c:241:16-17: WARNING comparing pointer to 0, suggest !E
./drivers/macintosh/via-cuda.c:519:23-24: WARNING comparing pointer to 0
./drivers/macintosh/via-cuda.c:238:16-17: WARNING comparing pointer to 0
./drivers/macintosh/via-cuda.c:241:16-17: WARNING comparing pointer to 0
./drivers/macintosh/macio-adb.c:214:29-30: WARNING comparing pointer to 0
./drivers/macintosh/macio-adb.c:101:13-14: WARNING comparing pointer to 0
./drivers/macintosh/macio-adb.c:184:20-21: WARNING comparing pointer to 0
./drivers/macintosh/windfarm_pm91.c:152:12-13: WARNING comparing pointer to 0
./drivers/net/ethernet/nxp/lpc_eth.c:1353:31-32: WARNING comparing pointer to 0
./drivers/net/ethernet/amd/declance.c:609:14-15: WARNING comparing pointer to 0, suggest !E
./drivers/net/ethernet/amd/declance.c:609:14-15: WARNING comparing pointer to 0
./drivers/video/fbdev/controlfb.c:700:10-11: WARNING comparing pointer to 0, suggest !E
./drivers/video/fbdev/controlfb.c:597:11-12: WARNING comparing pointer to 0
./drivers/video/fbdev/controlfb.c:187:11-12: WARNING comparing pointer to 0
./drivers/video/fbdev/controlfb.c:597:11-12: WARNING comparing pointer to 0
./drivers/video/fbdev/controlfb.c:700:10-11: WARNING comparing pointer to 0
./drivers/video/fbdev/controlfb.c:187:11-12: WARNING comparing pointer to 0
./drivers/mmc/host/android-goldfish.c:477:24-25: WARNING comparing pointer to 0, suggest !E
./drivers/mmc/host/android-goldfish.c:477:24-25: WARNING comparing pointer to 0
./drivers/ide/pmac.c:1685:38-39: WARNING comparing pointer to 0
./drivers/scsi/bfa/bfad_bsg.c:3426:29-30: WARNING comparing pointer to 0
./drivers/scsi/qla1280.c:3114:37-38: WARNING comparing pointer to 0
./drivers/scsi/mac53c94.c:469:29-30: WARNING comparing pointer to 0, suggest !E
./drivers/scsi/mac53c94.c:349:12-13: WARNING comparing pointer to 0
./drivers/scsi/mac53c94.c:238:12-13: WARNING comparing pointer to 0
./drivers/scsi/mac53c94.c:469:29-30: WARNING comparing pointer to 0
./drivers/ata/pata_macio.c:973:31-32: WARNING comparing pointer to 0, suggest !E
./drivers/ata/pata_macio.c:973:31-32: WARNING comparing pointer to 0
./arch/alpha/kernel/smp.c:273:39-40: WARNING comparing pointer to 0
./arch/alpha/kernel/smp.c:273:39-40: WARNING comparing pointer to 0
./arch/alpha/mm/fault.c:196:52-53: WARNING comparing pointer to 0
./arch/alpha/mm/fault.c:196:52-53: WARNING comparing pointer to 0
./arch/xtensa/platforms/iss/console.c:243:10-11: WARNING comparing pointer to 0
./arch/xtensa/kernel/pci.c:294:17-18: WARNING comparing pointer to 0
./arch/tile/kernel/machine_kexec.c:193:21-22: WARNING comparing pointer to 0
./arch/frv/mm/dma-alloc.c:103:13-14: WARNING comparing pointer to 0, suggest !E
./arch/frv/mm/dma-alloc.c:65:12-13: WARNING comparing pointer to 0
./arch/frv/mm/dma-alloc.c:103:13-14: WARNING comparing pointer to 0
./arch/frv/mm/dma-alloc.c:65:12-13: WARNING comparing pointer to 0
./arch/powerpc/platforms/powermac/setup.c:247:12-13: WARNING comparing pointer to 0, suggest !E
./arch/powerpc/platforms/powermac/setup.c:249:12-13: WARNING comparing pointer to 0
./arch/powerpc/platforms/powermac/setup.c:252:15-16: WARNING comparing pointer to 0
./arch/powerpc/platforms/powermac/setup.c:247:12-13: WARNING comparing pointer to 0
./arch/powerpc/platforms/powermac/setup.c:249:12-13: WARNING comparing pointer to 0
./arch/powerpc/platforms/powermac/setup.c:252:15-16: WARNING comparing pointer to 0
./arch/powerpc/platforms/powermac/pci.c:65:16-17: WARNING comparing pointer to 0
./arch/powerpc/platforms/powermac/pci.c:1222:15-16: WARNING comparing pointer to 0
./arch/powerpc/platforms/maple/setup.c:240:15-16: WARNING comparing pointer to 0
./arch/powerpc/platforms/maple/setup.c:240:15-16: WARNING comparing pointer to 0
./arch/powerpc/kernel/btext.c:166:14-15: WARNING comparing pointer to 0, suggest !E
./arch/powerpc/kernel/btext.c:159:23-24: WARNING comparing pointer to 0
./arch/powerpc/kernel/btext.c:166:14-15: WARNING comparing pointer to 0
./arch/powerpc/kernel/btext.c:283:23-24: WARNING comparing pointer to 0
./arch/powerpc/kernel/btext.c:272:13-14: WARNING comparing pointer to 0
./arch/powerpc/boot/cuboot-c2k.c:141:20-21: WARNING comparing pointer to 0
./arch/powerpc/mm/tlb_hash32.c:44:13-14: WARNING comparing pointer to 0
./arch/powerpc/mm/tlb_hash32.c:87:13-14: WARNING comparing pointer to 0
./arch/powerpc/mm/tlb_hash32.c:127:13-14: WARNING comparing pointer to 0
./arch/powerpc/mm/tlb_hash32.c:148:13-14: WARNING comparing pointer to 0
./arch/powerpc/mm/tlb_hash32.c:57:13-14: WARNING comparing pointer to 0
./arch/powerpc/mm/ppc_mmu_32.c:170:13-14: WARNING comparing pointer to 0
./arch/powerpc/mm/pgtable_32.c:179:14-15: WARNING comparing pointer to 0, suggest !E
./arch/powerpc/mm/pgtable_32.c:229:11-12: WARNING comparing pointer to 0
./arch/powerpc/mm/pgtable_32.c:179:14-15: WARNING comparing pointer to 0
./arch/powerpc/mm/pgtable_32.c:229:11-12: WARNING comparing pointer to 0
./arch/hexagon/kernel/traps.c:158:6-7: WARNING comparing pointer to 0
./scripts/recordmcount.c:181:13-14: WARNING comparing pointer to 0, suggest !E
./scripts/recordmcount.c:181:13-14: WARNING comparing pointer to 0
./drivers/macintosh/via-pmu68k.c:709:14-15: WARNING comparing pointer to 0
./drivers/macintosh/via-pmu68k.c:494:20-21: WARNING comparing pointer to 0
./drivers/macintosh/via-pmu68k.c:536:12-13: WARNING comparing pointer to 0
./drivers/macintosh/windfarm_pm121.c:663:12-13: WARNING comparing pointer to 0
./drivers/macintosh/windfarm_pm121.c:982:12-13: WARNING comparing pointer to 0
./drivers/macintosh/windfarm_pm81.c:708:12-13: WARNING comparing pointer to 0
./drivers/macintosh/windfarm_pm81.c:404:12-13: WARNING comparing pointer to 0
./drivers/macintosh/adb.c:675:14-15: WARNING comparing pointer to 0, suggest !E
./drivers/macintosh/adb.c:675:14-15: WARNING comparing pointer to 0
./drivers/macintosh/adb.c:481:33-34: WARNING comparing pointer to 0
./drivers/macintosh/smu.c:1089:11-12: WARNING comparing pointer to 0, suggest !E
./drivers/macintosh/smu.c:1256:11-12: WARNING comparing pointer to 0
./drivers/macintosh/smu.c:1089:11-12: WARNING comparing pointer to 0
./drivers/macintosh/smu.c:1279:11-12: WARNING comparing pointer to 0
./drivers/video/fbdev/valkyriefb.c:347:12-13: WARNING comparing pointer to 0, suggest !E
./drivers/video/fbdev/valkyriefb.c:362:10-11: WARNING comparing pointer to 0, suggest !E
./drivers/video/fbdev/valkyriefb.c:347:12-13: WARNING comparing pointer to 0
./drivers/video/fbdev/valkyriefb.c:362:10-11: WARNING comparing pointer to 0
./drivers/video/fbdev/offb.c:412:13-14: WARNING comparing pointer to 0, suggest !E
./drivers/video/fbdev/offb.c:412:13-14: WARNING comparing pointer to 0
./drivers/block/ataflop.c:1358:20-21: WARNING comparing pointer to 0
./arch/cris/mm/fault.c:381:14-15: WARNING comparing pointer to 0
./arch/cris/mm/fault.c:381:14-15: WARNING comparing pointer to 0
./arch/sparc/prom/tree_64.c:334:15-16: WARNING comparing pointer to 0
./arch/sparc/prom/tree_64.c:334:31-32: WARNING comparing pointer to 0
./arch/mips/kernel/ftrace.c:363:23-24: WARNING comparing pointer to 0
./arch/blackfin/kernel/dumpstack.c:87:13-14: WARNING comparing pointer to 0
./arch/powerpc/xmon/spu-dis.c:62:34-35: WARNING comparing pointer to 0
./arch/powerpc/xmon/spu-dis.c:65:57-58: WARNING comparing pointer to 0
./arch/powerpc/xmon/spu-dis.c:69:57-58: WARNING comparing pointer to 0
./arch/powerpc/xmon/spu-dis.c:73:57-58: WARNING comparing pointer to 0
./arch/powerpc/xmon/spu-dis.c:77:57-58: WARNING comparing pointer to 0
./arch/powerpc/xmon/spu-dis.c:81:57-58: WARNING comparing pointer to 0
./arch/powerpc/xmon/spu-dis.c:85:57-58: WARNING comparing pointer to 0
./arch/powerpc/xmon/spu-dis.c:48:38-39: WARNING comparing pointer to 0
./arch/powerpc/xmon/spu-dis.c:103:15-16: WARNING comparing pointer to 0
./arch/powerpc/platforms/powermac/pfunc_core.c:687:40-41: WARNING comparing pointer to 0
./arch/powerpc/platforms/maple/pci.c:41:16-17: WARNING comparing pointer to 0
./tools/usb/testusb.c:496:35-36: WARNING comparing pointer to 0
./tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c:1387:26-27: WARNING comparing pointer to 0
./tools/power/cpupower/utils/helpers/bitmask.c:28:12-13: WARNING comparing pointer to 0, suggest !E
./tools/power/cpupower/utils/helpers/bitmask.c:28:12-13: WARNING comparing pointer to 0
./tools/power/cpupower/utils/helpers/bitmask.c:42:12-13: WARNING comparing pointer to 0
./tools/testing/radix-tree/multiorder.c:159:17-18: WARNING comparing pointer to 0
./tools/testing/radix-tree/multiorder.c:174:17-18: WARNING comparing pointer to 0
./tools/testing/radix-tree/multiorder.c:205:17-18: WARNING comparing pointer to 0
...
./lib/zlib_deflate/deflate.c:662:40-59: duplicated argument to && or ||
./lib/zlib_deflate/deflate.c:663:17-36: duplicated argument to && or ||
./lib/zlib_deflate/deflate.c:663:40-59: duplicated argument to && or ||
./lib/zlib_deflate/deflate.c:664:17-36: duplicated argument to && or ||
./lib/zlib_deflate/deflate.c:664:40-59: duplicated argument to && or ||
./lib/zlib_deflate/deflate.c:665:17-36: duplicated argument to && or ||
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b1ant.c:1107:5-18: duplicated argument to && or ||
./drivers/net/ethernet/chelsio/cxgb3/t3_hw.c:3265:5-52: duplicated argument to && or ||
./drivers/net/ethernet/freescale/fec_main.c:738:5-36: duplicated argument to && or ||
./drivers/net/ethernet/freescale/fec_main.c:739:5-36: duplicated argument to && or ||
./drivers/net/ethernet/freescale/fec_main.c:740:5-36: duplicated argument to && or ||
./drivers/ide/cmd640.c:680:5-23: duplicated argument to && or ||
./drivers/usb/storage/usb.c:513:4-13: duplicated argument to && or ||
./drivers/pci/pci.c:5471:6-10: duplicated argument to && or ||
./drivers/media/usb/go7007/go7007-usb.c:664:6-63: duplicated argument to && or ||
./drivers/input/mouse/hgpk.c:1022:5-55: duplicated argument to && or ||
./drivers/input/mouse/hgpk.c:1023:5-55: duplicated argument to && or ||
./drivers/input/mouse/hgpk.c:616:6-37: duplicated argument to && or ||
./drivers/input/mouse/hgpk.c:617:6-37: duplicated argument to && or ||
./drivers/input/mouse/hgpk.c:733:6-37: duplicated argument to && or ||
./drivers/input/mouse/alps.c:1871:5-51: duplicated argument to && or ||
./drivers/input/mouse/alps.c:1872:5-51: duplicated argument to && or ||
./drivers/input/mouse/alps.c:1873:5-51: duplicated argument to && or ||
./drivers/input/mouse/alps.c:2590:5-51: duplicated argument to && or ||
./drivers/input/mouse/alps.c:2592:5-56: duplicated argument to && or ||
./drivers/input/mouse/alps.c:2463:6-54: duplicated argument to && or ||
./drivers/input/mouse/alps.c:2471:6-52: duplicated argument to && or ||
./drivers/input/mouse/alps.c:2677:5-53: duplicated argument to && or ||
./drivers/input/mouse/alps.c:2071:5-64: duplicated argument to && or ||
./drivers/input/mouse/alps.c:2072:5-64: duplicated argument to && or ||
./drivers/input/mouse/alps.c:1925:6-52: duplicated argument to && or ||
./drivers/input/mouse/alps.c:1926:6-52: duplicated argument to && or ||
./drivers/input/mouse/alps.c:1928:6-55: duplicated argument to && or ||
./drivers/input/mouse/alps.c:1854:5-35: duplicated argument to && or ||
./drivers/input/mouse/alps.c:1855:5-35: duplicated argument to && or ||
./drivers/input/mouse/alps.c:1789:5-49: duplicated argument to && or ||
./drivers/input/mouse/alps.c:1790:5-49: duplicated argument to && or ||
./drivers/input/mouse/alps.c:2182:6-55: duplicated argument to && or ||
./drivers/input/mouse/alps.c:2183:6-55: duplicated argument to && or ||
./drivers/input/mouse/alps.c:1985:5-51: duplicated argument to && or ||
./drivers/scsi/qlogicfas408.c:570:9-53: duplicated argument to && or ||
./sound/oss/waveartist.c:641:5-52: duplicated argument to && or ||
./sound/drivers/mpu401/mpu401_uart.c:437:7-36: duplicated argument to && or ||
./fs/binfmt_elf_fdpic.c:1280:45-64: duplicated argument to && or ||
./fs/binfmt_elf.c:1418:48-67: duplicated argument to && or ||
./arch/frv/kernel/gdb-stub.c:1929:32-45: duplicated argument to && or ||
./arch/frv/kernel/gdb-stub.c:1957:32-45: duplicated argument to && or ||
./tools/laptop/dslm/dslm.c:34:8-40: duplicated argument to && or ||
./sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c:78:6-12: inconsistent IS_ERR and PTR_ERR on line 81.
./drivers/staging/media/imx/imx-media-csi.c:990:5-11: inconsistent IS_ERR and PTR_ERR on line 992.
./drivers/pci/host/pci-ftpci100.c:483:5-11: inconsistent IS_ERR and PTR_ERR on line 484.
./drivers/staging/media/imx/imx-media-vdic.c:180:6-12: inconsistent IS_ERR and PTR_ERR on line 182.
```

TODO

<!-- EOF -->
