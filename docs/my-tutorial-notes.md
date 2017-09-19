# Gianpaolo notes doing Coccinelle tutorial exercises

Attend the Coccinelle tutorial at
http://coccinelle.lip6.fr/papers/tutorial.pdf

A video is available here:
https://www.youtube.com/watch?v=buZrNd6XkEw

Slide 3 (Example: Bad bit-and)

- NOTE: File `drivers/staging/crystalhd/crystalhd_hw.c` was removed around v3.17
- See http://elixir.free-electrons.com/linux/v3.16.47/source/drivers/staging/crystalhd 

### Exercise 1

Contents of file `ex1.cocci`:

```
@@
expression E;
constant C;
@@

- !E & C
+ !(E & C)
```

```bash
cd ~/linux-stable && git checkout linux-3.2.y
spatch --sp-file ~/github/gmacario/learning-coccinelle/ex1.cocci --very-quiet --dir drivers/staging/crystalhd
```

Result:

```
gmacario@ies-genbld01-ub16:~/linux-stable (linux-3.2.y)$ spatch --sp-file ~/github/gmacario/learning-coccinelle/ex1.cocci --very-quiet --dir drivers/staging/crystalhd
diff -u -p a/crystalhd_hw.c b/crystalhd_hw.c
--- a/crystalhd_hw.c
+++ b/crystalhd_hw.c
@@ -869,7 +869,7 @@ static enum BC_STATUS crystalhd_stop_tx_
        BCMLOG(BCMLOG_DBG, "Stopping TX DMA Engine..\n");

        /* FIXME: jarod: invert dma_ctrl and check bit? or are there missing parens? */
-       if (!dma_cntrl & DMA_START_BIT) {
+       if (!(dma_cntrl & DMA_START_BIT)) {
                BCMLOG(BCMLOG_DBG, "Already Stopped\n");
                return BC_STS_SUCCESS;
        }
gmacario@ies-genbld01-ub16:~/linux-stable (linux-3.2.y)$
```

**FIXME**: Adjust patch base directory

Slide 11: Metavariable types

- Surrounded by `@@ @@`
- expression, statement, type, constant, local idexpression
- A type from the source program
- iterator, declarer, iterator name, declarer name, typedef

Slide 12: Transformation specification

- `-` in the leftmost column for something to remove
- `+` in the leftmost column for something to add
- `*` in the lefmost column for something of interest
  (Cannot be used with `+` and `-`)
- Spaces, newlines irrelevant

Slide 15: Practical issues

- To check that your semantic patch is valid:

```bash
spatch --parse-cocci mysp.cocci
```

- To run your semantic patch:

```bash
spatch --sp-file mysp.cocci file.c
spatch --sp-file mysp.cocci --dir directory
```
  
- If you don't need to include header files:

```bash
spatch --sp-file mysp.cocci file.c
  --dir directory
  --no-includes --include-headers
```

- To understand why your semantic patch didn't work:

```bash
spatch --sp-file mysp.cocci file.c --debug
```

Slide 16: More practical issues

- Put the interesting output in a file:

```bash
spatch ... > output.patch
```

- Omit the uninteresting output:

```bash
spatch --spatch ...
```

### Exercise 2

<!-- 2017-09-11 16:45 CEST -->

Contents of file `ex2.cocci`:

```
@@
expression * e;
expression arg1, arg2;
type T;
@@

- e = (T) kmalloc(arg1, arg2)
+ e = kmalloc(arg1, arg2)
```

Running Coccinelle

```bash
cd ~/linux-stable && git checkout linux-3.2.y
spatch --sp-file ~/github/gmacario/learning-coccinelle/ex2.cocci --very-quiet --dir drivers/isdn
```

Result:

```
gmacario@ies-genbld01-ub16:~/linux-stable (linux-3.2.y)$ spatch --sp-file ~/github/gmacario/learning-coccinelle/ex2.cocci --very-quiet --dir drivers/isdn
EXN: Failure("Impossible: How can diff be null and have not Correct in compare_c? (\"diff token: ulong VS ulong\\nFile \\\"drivers/isdn/hisax/config.c\\\", line 712, column 6, charpos = 16636\\n  around = 'ulong',\\n  whole content = \\ti = (ulong) & len - current->kernel_stack_page;\\nFile \\\"/tmp/cocci-output-2537-764161-config.c\\\", line 712, column 6, charpos = 16636\\n  around = 'ulong',\\n  whole content = \\ti = (ulong) & len - current->kernel_stack_page;\\n\")")EXN: Failure("Impossible: How can diff be null and have not Correct in compare_c? (\"diff token: ctrl_msg VS ctrl_msg\\nFile \\\"drivers/isdn/hisax/st5481_usb.c\\\", line 66, column 8, charpos = 1770\\n  around = 'ctrl_msg',\\n  whole content = \\tstruct ctrl_msg *ctrl_msg;\\nFile \\\"/tmp/cocci-output-2537-3e784f-st5481_usb.c\\\", line 66, column 8, charpos = 1770\\n  around = 'ctrl_msg',\\n  whole content = \\tstruct ctrl_msg *ctrl_msg;\\n\")")EXN: Failure("Impossible: How can diff be null and have not Correct in compare_c? (\"diff token: setup_parm VS setup_parm\\nFile \\\"drivers/isdn/hisax/callc.c\\\", line 353, column 58, charpos = 9018\\n  around = 'setup_parm',\\n  whole content = \\t\\tmemcpy(&ic.parm.setup, &chanp->proc->para.setup, sizeof(setup_parm));\\nFile \\\"/tmp/cocci-output-2537-4c7b13-callc.c\\\", line 353, column 58, charpos = 9018\\n  around = 'setup_parm',\\n  whole content = \\t\\tmemcpy(&ic.parm.setup, &chanp->proc->para.setup, sizeof(setup_parm));\\n\")")EXN: Failure("Impossible: How can diff be null and have not Correct in compare_c? (\"diff token: #ifdef EXT_BEARER_CAPS VS #ifdef EXT_BEARER_CAPS\\nFile \\\"drivers/isdn/hisax/l3dss1.c\\\", line 980, column 0, charpos = 27119\\n  around = '#ifdef EXT_BEARER_CAPS',\\n  whole content = #ifdef EXT_BEARER_CAPS\\nFile \\\"/tmp/cocci-output-2537-d04b0e-l3dss1.c\\\", line 980, column 0, charpos = 27119\\n  around = '#ifdef EXT_BEARER_CAPS',\\n  whole content = #ifdef EXT_BEARER_CAPS\\n\")")diff -u -p a/hisax/hfc_sx.c b/hisax/hfc_sx.c
--- a/hisax/hfc_sx.c
+++ b/hisax/hfc_sx.c
@@ -1480,8 +1480,7 @@ setup_hfcsx(struct IsdnCard *card)
                  release_region(cs->hw.hfcsx.base, 2);
                  return(0);
                }
-               if (!(cs->hw.hfcsx.extra = (void *)
-                     kmalloc(sizeof(struct hfcsx_extra), GFP_ATOMIC))) {
+               if (!(cs->hw.hfcsx.extra = kmalloc(sizeof(struct hfcsx_extra), GFP_ATOMIC))) {
                  release_region(cs->hw.hfcsx.base, 2);
                  printk(KERN_WARNING "HFC-SX: unable to allocate memory\n");
                  return(0);
diff -u -p a/capi/capidrv.c b/capi/capidrv.c
--- a/capi/capidrv.c
+++ b/capi/capidrv.c
@@ -469,8 +469,7 @@ static int capidrv_add_ack(struct capidr
 {
        struct ncci_datahandle_queue *n, **pp;

-       n = (struct ncci_datahandle_queue *)
-               kmalloc(sizeof(struct ncci_datahandle_queue), GFP_ATOMIC);
+       n = kmalloc(sizeof(struct ncci_datahandle_queue), GFP_ATOMIC);
        if (!n) {
           printk(KERN_ERR "capidrv: kmalloc ncci_datahandle failed\n");
           return -1;
@@ -2058,7 +2057,8 @@ static int capidrv_addcontr(u16 contr, s
        strcpy(card->name, id);
        card->contrnr = contr;
        card->nbchan = profp->nbchannel;
-       card->bchans = kmalloc(sizeof(capidrv_bchan) * card->nbchan, GFP_ATOMIC);
+       card->bchans = kmalloc(sizeof(capidrv_bchan) * card->nbchan,
+                              GFP_ATOMIC);
        if (!card->bchans) {
                printk(KERN_WARNING
                "capidrv: (%s) Could not allocate bchan-structs.\n", id);
EXN: Failure("Impossible: How can diff be null and have not Correct in compare_c? (\"diff token: icn_dev VS icn_dev\\nFile \\\"drivers/isdn/icn/icn.c\\\", line 1632, column 24, charpos = 41651\\n  around = 'icn_dev',\\n  whole content = \\tmemset(&dev, 0, sizeof(icn_dev));\\nFile \\\"/tmp/cocci-output-2537-dd4e81-icn.c\\\", line 1632, column 24, charpos = 41651\\n  around = 'icn_dev',\\n  whole content = \\tmemset(&dev, 0, sizeof(icn_dev));\\n\")")gmacario@ies-genbld01-ub16:~/linux-stable (linux-3.2.y)$
```

**FIXME**: What does `EXN: Failure` mean???
(Running Coccinelle built from master, commit 3f038a5dd6f5016eb7bd6bcff51c24d908c7d33b)

### Exercise 3

<!-- 2017-09-11 17:05 CEST -->

Contents of file `ex3.cocci` (pci_map_single: Fourth attempt):

```
@@ expression E1, E2, E3, E4; @@
- pci_map_single(E1,
+ dma_map_single(&E1->dev,
     E2, E3, E4)

@@ expression E1, E2, E3; @@
  dma_map_single(E1, E2, E3,
(
-    PCI_DMA_BIDIRECTIONAL
+    DMA_BIDIRECTIONAL
|
-    PCI_DMA_TODEVICE
+    DMA_TO_DEVICE
|
-    PCI_DMA_FROMDEVICE
+    DMA_FROM_DEVICE
|
-    PCI_DMA_NONE
+    DMA_NONE_DEVICE
)
  )
```

Running Coccinelle

```bash
cd ~/linux-stable && git checkout linux-3.2.y
spatch --sp-file ~/github/gmacario/learning-coccinelle/ex3.cocci --very-quiet --dir drivers/net/ethernet
```

Result:

```
gmacario@ies-genbld01-ub16:~/linux-stable (linux-3.2.y)$ spatch --sp-file ~/github/gmacario/learning-coccinelle/ex3.cocci --very-quiet --dir drivers/net/ethernet
diff -u -p a/natsemi/ns83820.c b/natsemi/ns83820.c
--- a/natsemi/ns83820.c
+++ b/natsemi/ns83820.c
@@ -542,8 +542,8 @@ static inline int ns83820_add_rx_skb(str

        dev->rx_info.next_empty = (next_empty + 1) % NR_RX_DESC;
        cmdsts = REAL_RX_BUF_SIZE | CMDSTS_INTR;
-       buf = pci_map_single(dev->pci_dev, skb->data,
-                            REAL_RX_BUF_SIZE, PCI_DMA_FROMDEVICE);
+       buf =  dma_map_single(&dev->pci_dev->dev, skb->data,
+                             REAL_RX_BUF_SIZE, DMA_FROM_DEVICE);
        build_rx_desc(dev, sg, 0, buf, cmdsts, 0);
        /* update link of previous rx */
        if (likely(next_empty != dev->rx_info.next_rx))
@@ -1137,7 +1137,8 @@ again:
...
@@ -11577,7 +11579,8 @@ static int tg3_run_loopback(struct tg3 *
        for (i = data_off; i < tx_len; i++)
                tx_data[i] = (u8) (i & 0xff);

-       map = pci_map_single(tp->pdev, skb->data, tx_len, PCI_DMA_TODEVICE);
+       map =  dma_map_single(&tp->pdev->dev, skb->data, tx_len,
+                             DMA_TO_DEVICE);
        if (pci_dma_mapping_error(tp->pdev, map)) {
                dev_kfree_skb(skb);
                return -EIO;
gmacario@ies-genbld01-ub16:~/linux-stable (linux-3.2.y)$
```

**NOTE**: I cannot execute this semantic patch as part of `make coccicheck`

```
gmacario@ies-genbld01-ub16:~/linux-stable (linux-3.2.y)$ make coccicheck COCCI=~/github/gmacario/learning-coccinelle/ex3.cocci M=drivers/net/ethernet MODE=patch

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

Processing ex3.cocci
with option(s) ""

Message example to submit a patch:
 The semantic patch that makes this change is available
 in /home/gmacario/github/gmacario/learning-coccinelle/ex3.cocci.

 More information about semantic patching is available at
 http://coccinelle.lip6.fr/

virtual rule patch not supported
Makefile:1441: recipe for target 'coccicheck' failed
make: *** [coccicheck] Error 1
gmacario@ies-genbld01-ub16:~/linux-stable (linux-3.2.y)$
```

### Exercise 4

<!-- 2017-09-12 13:50 CEST -->

Contents of file `ex4_1.cocci` (Getter and setter functions: First attempt):

```
@@
expression hwif;
@@
- hwif->hwif_data
+ ide_get_hwifdata(hwif)

@@
expression hwif, data;
@@
- hwif->hwif_data = data
+ ide_set_hwifdata(hwif, data)

```

Running Coccinelle

```bash
cd ~/linux-stable && git checkout linux-3.2.y
spatch --sp-file ~/github/gmacario/learning-coccinelle/ex4_1.cocci --very-quiet --dir include/linux/ide.h
```

Result:

```
gmacario@ies-genbld01-ub16:~/linux-stable (linux-3.2.y)$ spatch --sp-file ~/github/gmacario/learning-coccinelle/ex4_1.cocci --dir include/linux/ide.h
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
HANDLING: include/linux/ide.h
diff =
--- include/linux/ide.h
+++ /tmp/cocci-output-5491-970294-ide.h
@@ -1447,12 +1447,12 @@ void ide_port_scan(ide_hwif_t *);

 static inline void *ide_get_hwifdata (ide_hwif_t * hwif)
 {
-       return hwif->hwif_data;
+       return ide_get_hwifdata(hwif);
 }

 static inline void ide_set_hwifdata (ide_hwif_t * hwif, void *data)
 {
-       hwif->hwif_data = data;
+       ide_get_hwifdata(hwif) = data;
 }

 extern void ide_toggle_bounce(ide_drive_t *drive, int on);
gmacario@ies-genbld01-ub16:~/linux-stable (linux-3.2.y)$
```

**TODO**: Why does the following command return nothing?

```
spatch --sp-file ~/github/gmacario/learning-coccinelle/ex4_1.cocci --very-quiet --dir include/linux
```

**TIP**: Use `--patch` to adjust the source/dest paths inside the patch header (need to understand how exactly)

### Exercise 5

<!-- 2017-09-13 11:00 CEST -->

Contents of file `ex5.cocci`:

```
@@ expression E1, E2, E3, E4; @@
- dma_map_single(E1,
+ pci_map_single(&E1->dev,
     E2, E3, E4)

@@ expression E1, E2, E3; @@
  dma_map_single(E1, E2, E3,
(
-    PCI_DMA_BIDIRECTIONAL
+    DMA_BIDIRECTIONAL
|
-    PCI_DMA_TODEVICE
+    DMA_TO_DEVICE
|
-    PCI_DMA_FROMDEVICE
+    DMA_FROM_DEVICE
|
-    PCI_DMA_NONE
+    DMA_NONE_DEVICE
)
  )
```

Test the semantic patch:

```bash
cd ~/linux-stable && git checkout linux-3.2.y
spatch --sp-file ~/github/gmacario/learning-coccinelle/ex5.cocci --very-quiet --dir drivers/net/ethernet
```

Result:

```
gmacario@ies-genbld01-ub16:~/linux-stable (linux-3.2.y)$ spatch --sp-file ~/github/gmacario/learning-coccinelle/ex5.cocci --very-quiet --dir drivers/net/ethernet
diff -u -p a/faraday/ftgmac100.c b/faraday/ftgmac100.c
--- a/faraday/ftgmac100.c
+++ b/faraday/ftgmac100.c
@@ -1150,7 +1150,8 @@ static int ftgmac100_hard_start_xmit(str
                return NETDEV_TX_OK;
        }

-       map = dma_map_single(priv->dev, skb->data, skb_headlen(skb), DMA_TO_DEVICE);
+       map =  pci_map_single(&priv->dev->dev, skb->data, skb_headlen(skb),
+                             DMA_TO_DEVICE);
        if (unlikely(dma_mapping_error(priv->dev, map))) {
                /* drop packet */
                if (net_ratelimit())
diff -u -p a/faraday/ftmac100.c b/faraday/ftmac100.c
...
diff -u -p a/cadence/macb.c b/cadence/macb.c
--- a/cadence/macb.c
+++ b/cadence/macb.c
@@ -654,8 +654,8 @@ static int macb_start_xmit(struct sk_buf

        entry = bp->tx_head;
        dev_dbg(&bp->pdev->dev, "Allocated ring entry %u\n", entry);
-       mapping = dma_map_single(&bp->pdev->dev, skb->data,
-                                len, DMA_TO_DEVICE);
+       mapping =  pci_map_single(&(&bp->pdev->dev)->dev, skb->data,
+                                 len, DMA_TO_DEVICE);
        bp->tx_skb[entry].skb = skb;
        bp->tx_skb[entry].mapping = mapping;
        dev_dbg(&bp->pdev->dev, "Mapped skb data %p to DMA addr %08lx\n",
diff -u -p a/marvell/mv643xx_eth.c b/marvell/mv643xx_eth.c
...
```

**NOTE**: Did not understand questions/comments at point 3. and 4. of slide 34 of tutorial.pdf
<!-- 2017-09-13 17:10 CEST -->

Slide 37: Coccinelle features

- Isomorphisms
- Dots
- Positions
- Python

Trying Semantic Patch from Slide 43

<!-- 2017-08-13 17:18 CEST -->

Contents of file div_round_up.cocci

```
@@
expression n,d;
@@

- ((n) + (d) / (d))
+ DIV_ROUND_UP(n,d)
```

Test the semantic patch

```bash
cd ~/linux-stable && git checkout linux-3.2.y
spatch --sp-file ~/github/gmacario/learning-coccinelle/div_round_up.cocci --very-quiet --dir . | tee div_round_up.patch
grep '+++' div_round_up.patch | wc -l
```

Result: 185 occurrences

```
...
@@ -2714,9 +2713,7 @@ loop_again:
                         * of the zone, whichever is smaller.
                         */
                        balance_gap = min(low_wmark_pages(zone),
-                               (zone->present_pages +
-                                       KSWAPD_ZONE_BALANCE_GAP_RATIO-1) /
-                               KSWAPD_ZONE_BALANCE_GAP_RATIO);
+                               DIV_ROUND_UP(zone->present_pages, KSWAPD_ZONE_BALANCE_GAP_RATIO));
                        if (!zone_watermark_ok_safe(zone, order,
                                        high_wmark_pages(zone) + balance_gap,
                                        end_zone, 0)) {
trying for __initdata_memblock
diff -u -p a/mm/slob.c b/mm/slob.c
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -174,7 +174,7 @@ static inline void clear_slob_page_free(
 }

 #define SLOB_UNIT sizeof(slob_t)
-#define SLOB_UNITS(size) (((size) + SLOB_UNIT - 1)/SLOB_UNIT)
+#define SLOB_UNITS(size) DIV_ROUND_UP(size, SLOB_UNIT)
 #define SLOB_ALIGN L1_CACHE_BYTES

 /*
gmacario@ies-genbld01-ub16:~/linux-stable (linux-3.2.y)$ grep '+++' div_round_up.patch | wc -l
185
gmacario@ies-genbld01-ub16:~/linux-stable (linux-3.2.y)$
```

**TODO**: Why not as in slide 43: "Changes 281 occurrences in Linux 3.2"?

(Notice that I checked Linux 3.2.92, commit 52bc1fde85f0baf84ef30ebe32560c16c924696e)

Trying against exact git tag "v3.2"

```bash
cd ~/linux-stable && git checkout v3.2
spatch --sp-file ~/github/gmacario/learning-coccinelle/div_round_up.cocci --very-quiet --dir . | tee div_round_up.patch
grep '+++' div_round_up.patch | wc -l
```

Result: 186 occurrences (again, not 281 as displayed on slide 43)

```
...
diff -u -p a/arch/powerpc/platforms/powermac/nvram.c b/arch/powerpc/platforms/powermac/nvram.c
--- a/arch/powerpc/platforms/powermac/nvram.c
+++ b/arch/powerpc/platforms/powermac/nvram.c
@@ -601,7 +601,7 @@ int __init pmac_nvram_init(void)
                ppc_md.nvram_write_val  = direct_nvram_write_byte;
        } else if (nvram_naddrs == 1) {
                nvram_data = ioremap(r1.start, s1);
-               nvram_mult = (s1 + NVRAM_SIZE - 1) / NVRAM_SIZE;
+               nvram_mult = DIV_ROUND_UP(s1, NVRAM_SIZE);
                ppc_md.nvram_read_val   = direct_nvram_read_byte;
                ppc_md.nvram_write_val  = direct_nvram_write_byte;
        } else if (nvram_naddrs == 2) {
trying for __init_task_data
trying for iowa_pci_io
trying for iowa_pci_io
trying for iowa_pci_io
trying for __init_task_data
diff -u -p a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -359,7 +359,7 @@ static inline void __dma_sync_page_highm
        size_t seg_size = min((size_t)(PAGE_SIZE - offset), size);
        size_t cur_size = seg_size;
        unsigned long flags, start, seg_offset = offset;
-       int nr_segs = 1 + ((size - seg_size) + PAGE_SIZE - 1)/PAGE_SIZE;
+       int nr_segs = 1 + DIV_ROUND_UP(size - seg_size, PAGE_SIZE);
        int seg_nr = 0;

        local_irq_save(flags);
diff -u -p a/tools/perf/util/help.c b/tools/perf/util/help.c
--- a/tools/perf/util/help.c
+++ b/tools/perf/util/help.c
@@ -83,7 +83,7 @@ static void pretty_print_string_list(str

        if (space < max_cols)
                cols = max_cols / space;
-       rows = (cmds->cnt + cols - 1) / cols;
+       rows = DIV_ROUND_UP(cmds->cnt, cols);

        for (i = 0; i < rows; i++) {
                printf("  ");
diff -u -p a/mm/slab.c b/mm/slab.c
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -4177,8 +4177,8 @@ static void cache_reap(struct work_struc
                else {
                        int freed;

-                       freed = drain_freelist(searchp, l3, (l3->free_limit +
-                               5 * searchp->num - 1) / (5 * searchp->num));
+                       freed = drain_freelist(searchp, l3,
+                                              DIV_ROUND_UP(l3->free_limit, 5 * searchp->num));
                        STATS_ADD_REAPED(searchp, freed);
                }
 next:
diff -u -p a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2638,9 +2638,7 @@ loop_again:
                         * of the zone, whichever is smaller.
                         */
                        balance_gap = min(low_wmark_pages(zone),
-                               (zone->present_pages +
-                                       KSWAPD_ZONE_BALANCE_GAP_RATIO-1) /
-                               KSWAPD_ZONE_BALANCE_GAP_RATIO);
+                               DIV_ROUND_UP(zone->present_pages, KSWAPD_ZONE_BALANCE_GAP_RATIO));
                        if (!zone_watermark_ok_safe(zone, order,
                                        high_wmark_pages(zone) + balance_gap,
                                        end_zone, 0)) {
trying for __initdata_memblock
diff -u -p a/mm/slob.c b/mm/slob.c
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -174,7 +174,7 @@ static inline void clear_slob_page_free(
 }

 #define SLOB_UNIT sizeof(slob_t)
-#define SLOB_UNITS(size) (((size) + SLOB_UNIT - 1)/SLOB_UNIT)
+#define SLOB_UNITS(size) DIV_ROUND_UP(size, SLOB_UNIT)
 #define SLOB_ALIGN L1_CACHE_BYTES

 /*
gmacario@ies-genbld01-ub16:~/linux-stable (detached*)$ grep '+++' div_round_up.patch | wc -l
186
gmacario@ies-genbld01-ub16:~/linux-stable (detached*)$
```

**TODO**: What do lines i.e. `trying for iowa_pci_io` mean???


### Exercise 6

<!-- 2017-09-14 09:50 CEST -->

Contents of file `ex6.cocci`

```
@@ identifier e1; expression e2; statement S1, S2; @@
+ e1 = e2;
  if (
-     (e1 = e2)
+     e1
      == NULL) S1 else S2
```

Test the semantic patch

```bash
cd ~/linux-stable && git checkout v3.2
spatch --sp-file ~/github/gmacario/learning-coccinelle/ex6.cocci --very-quiet --dir sound/pci/au88x0
```

Result:

```
gmacario@ies-genbld01-ub16:~/linux-stable (detached*)$ spatch --sp-file ~/github/gmacario/learning-coccinelle/ex6.cocci --very-quiet --dir sound/pci/au88x0
diff -u -p a/au88x0_eq.c b/au88x0_eq.c
--- a/au88x0_eq.c
+++ b/au88x0_eq.c
@@ -884,8 +884,8 @@ static int __devinit vortex_eq_init(vort

        vortex_Eqlzr_init(vortex);

-       if ((kcontrol =
-            snd_ctl_new1(&vortex_eqtoggle_kcontrol, vortex)) == NULL)
+       kcontrol = snd_ctl_new1(&vortex_eqtoggle_kcontrol, vortex);
+       if (kcontrol == NULL)
                return -ENOMEM;
        kcontrol->private_value = 0;
        if ((err = snd_ctl_add(vortex->card, kcontrol)) < 0)
@@ -893,8 +893,8 @@ static int __devinit vortex_eq_init(vort

        /* EQ gain controls */
        for (i = 0; i < 10; i++) {
-               if ((kcontrol =
-                    snd_ctl_new1(&vortex_eq_kcontrol, vortex)) == NULL)
+               kcontrol = snd_ctl_new1(&vortex_eq_kcontrol, vortex);
+               if (kcontrol == NULL)
                        return -ENOMEM;
                snprintf(kcontrol->id.name, sizeof(kcontrol->id.name),
                        "%s Playback Volume", EqBandLabels[i]);
@@ -904,7 +904,8 @@ static int __devinit vortex_eq_init(vort
                //vortex->eqctrl[i] = kcontrol;
        }
        /* EQ band levels */
-       if ((kcontrol = snd_ctl_new1(&vortex_levels_kcontrol, vortex)) == NULL)
+       kcontrol = snd_ctl_new1(&vortex_levels_kcontrol, vortex);
+       if (kcontrol == NULL)
                return -ENOMEM;
        if ((err = snd_ctl_add(vortex->card, kcontrol)) < 0)
                return err;
diff -u -p a/au88x0_a3d.c b/au88x0_a3d.c
--- a/au88x0_a3d.c
+++ b/au88x0_a3d.c
@@ -861,8 +861,8 @@ static int __devinit vortex_a3d_register
        int err, i;
        /* HRTF controls. */
        for (i = 0; i < NR_A3D; i++) {
-               if ((kcontrol =
-                    snd_ctl_new1(&vortex_a3d_kcontrol, &vortex->a3d[i])) == NULL)
+               kcontrol = snd_ctl_new1(&vortex_a3d_kcontrol, &vortex->a3d[i]);
+               if (kcontrol == NULL)
                        return -ENOMEM;
                kcontrol->id.numid = CTRLID_HRTF;
                kcontrol->info = snd_vortex_a3d_hrtf_info;
@@ -872,8 +872,8 @@ static int __devinit vortex_a3d_register
        }
        /* ITD controls. */
        for (i = 0; i < NR_A3D; i++) {
-               if ((kcontrol =
-                    snd_ctl_new1(&vortex_a3d_kcontrol, &vortex->a3d[i])) == NULL)
+               kcontrol = snd_ctl_new1(&vortex_a3d_kcontrol, &vortex->a3d[i]);
+               if (kcontrol == NULL)
                        return -ENOMEM;
                kcontrol->id.numid = CTRLID_ITD;
                kcontrol->info = snd_vortex_a3d_itd_info;
@@ -883,8 +883,8 @@ static int __devinit vortex_a3d_register
        }
        /* ILD (gains) controls. */
        for (i = 0; i < NR_A3D; i++) {
-               if ((kcontrol =
-                    snd_ctl_new1(&vortex_a3d_kcontrol, &vortex->a3d[i])) == NULL)
+               kcontrol = snd_ctl_new1(&vortex_a3d_kcontrol, &vortex->a3d[i]);
+               if (kcontrol == NULL)
                        return -ENOMEM;
                kcontrol->id.numid = CTRLID_GAINS;
                kcontrol->info = snd_vortex_a3d_ild_info;
@@ -894,8 +894,8 @@ static int __devinit vortex_a3d_register
        }
        /* Filter controls. */
        for (i = 0; i < NR_A3D; i++) {
-               if ((kcontrol =
-                    snd_ctl_new1(&vortex_a3d_kcontrol, &vortex->a3d[i])) == NULL)
+               kcontrol = snd_ctl_new1(&vortex_a3d_kcontrol, &vortex->a3d[i]);
+               if (kcontrol == NULL)
                        return -ENOMEM;
                kcontrol->id.numid = CTRLID_FILTER;
                kcontrol->info = snd_vortex_a3d_filter_info;
gmacario@ies-genbld01-ub16:~/linux-stable (detached*)$
```

**NOTE**: No matches will happen If I disable isomorphism with the `--iso-file empty.iso` command line option:

```
gmacario@ies-genbld01-ub16:~/linux-stable (detached*)$ spatch --sp-file ~/github/gmacario/learning-coccinelle/ex6.cocci --very-quiet --iso-file empty.iso --dir sound/pci/au88x0
gmacario@ies-genbld01-ub16:~/linux-stable (detached*)$
```


### Exercise 7

<!-- 2017-09-14 11:00 CEST -->

Run `spatch` with `--parse-cocci` for some semantic patch you have developed.

Example

```
spatch --parse-cocci ~/github/gmacario/learning-coccinelle/ex6.cocci
```

Result

```
gmacario@ies-genbld01-ub16:~/linux-stable (detached*)$ spatch --parse-cocci ~/github/gmacario/learning-coccinelle/ex6.cocci
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
@rule starting on line 1@
identifier e1;
expression e2;
statement S2;
statement S1;
@@


(

(

(

  <<< e1 = e2;
if (-(
        >>> e1
      -e1 -= -e2-) == NULL)
|

  <<< e1 = e2;
if (-e1
      >>> e1
     -= -e2 == NULL)
)S1 else S2
|

(

  <<< e1 = e2;
if (-(
        >>> e1
      -e1 -= -e2-) == NULL)
|

  <<< e1 = e2;
if (-e1
      >>> e1
     -= -e2 == NULL)
)S1
)
|

(

(

(

  <<< e1 = e2;
if (-(
        >>> e1
      -e1 -= -e2-) != NULL)
|

  <<< e1 = e2;
if (-e1
      >>> e1
     -= -e2 != NULL)
)S2 else S1
|

(

  <<< e1 = e2;
if (-(
        >>> e1
      -e1 -= -e2-) != NULL)
|

  <<< e1 = e2;
if (-e1
      >>> e1
     -= -e2 != NULL)
)S2
)
|

(

(

  <<< e1 = e2;
if (-(
        >>> e1
      -e1 -= -e2-) == NULL)
|

  <<< e1 = e2;
if (-e1
      >>> e1
     -= -e2 == NULL)
)S1 else S2
|

(

  <<< e1 = e2;
if (-(
        >>> e1
      -e1 -= -e2-) == NULL)
|

  <<< e1 = e2;
if (-e1
      >>> e1
     -= -e2 == NULL)
)S1
)
)
)


grep tokens
NULL
No query
warning: iso commeq does not match the code below on line 4
bool (unknown *(e1 = e2)
  >>> e1
 == unknown *NULL)
the following code matched is not uniformly minus or context,
or contains a disjunction:
Exp:
bool (unknown *(e1 = e2)
  >>> e1
 == unknown *NULL)

warning: iso is_null does not match the code below on line 4
bool (unknown *(e1 = e2)
  >>> e1
 == unknown *NULL)
the following code matched is not uniformly minus or context,
or contains a disjunction:
Exp:
bool (unknown *(e1 = e2)
  >>> e1
 == unknown *NULL)

gmacario@ies-genbld01-ub16:~/linux-stable (detached*)$
```

Explain the result (???)


Slide 47: Dots

Issue: Sometimes it is necessary to search for multiple related code fragments.

Goals:

1. Specify patterns consisting of fragments of code separated by arbitrary precision paths.
2. Specify constraints on the contents of those execution paths.

Using dots

```
gmacario@ies-genbld01-ub16:~/linux-stable (detached*)$ spatch --sp-file ~/github/gmacario/learning-coccinelle/kmalloc_check_v1.cocci --dir --very-quiet arch/cris/arch-v10/kernel
diff -u -p arch/cris/arch-v10/kernel/io_interface_mux.c /tmp/nothing/io_interface_mux.c
--- arch/cris/arch-v10/kernel/io_interface_mux.c
+++ /tmp/nothing/io_interface_mux.c
@@ -1106,11 +1106,9 @@ int cris_io_interface_register_watcher(v
        if (NULL == notify) {
                return -EINVAL;
        }
-       w = kmalloc(sizeof(*w), GFP_KERNEL);
        if (!w) {
                return -ENOMEM;
        }
-       w->notify = notify;
        w->next = watchers;
        watchers = w;

gmacario@ies-genbld01-ub16:~/linux-stable (detached*)$
```

Update semantic patch to avoid false positive (see tutorial.pdf, slide 54)

```
gmacario@ies-genbld01-ub16:~/linux-stable (detached*)$ spatch --sp-file ~/github/gmacario/learning-coccinelle/kmalloc_check_v2.cocci --dir --very-quiet arch/cris/arch-v10/kernel
gmacario@ies-genbld01-ub16:~/linux-stable (detached*)$
```

Update semantic patch again (see tutorial.pdf, slide 55) and applying to all Linux source tree

```
gmacario@ies-genbld01-ub16:~/linux-stable (detached*)$ spatch --sp-file ~/github/gmacario/learning-coccinelle/kmalloc_check_v3.cocci --dir --very-quiet .
diff -u -p ./net/ipv4/syncookies.c /tmp/nothing/net/ipv4/syncookies.c
--- ./net/ipv4/syncookies.c
+++ /tmp/nothing/net/ipv4/syncookies.c
@@ -325,8 +325,6 @@ struct sock *cookie_v4_check(struct sock
        if (opt && opt->optlen) {
                int opt_size = sizeof(struct ip_options_rcu) + opt->optlen;

-               ireq->opt = kmalloc(opt_size, GFP_ATOMIC);
-               if (ireq->opt != NULL && ip_options_echo(&ireq->opt->opt, skb)) {
                        kfree(ireq->opt);
                        ireq->opt = NULL;
                }
diff -u -p ./drivers/macintosh/via-pmu.c /tmp/nothing/drivers/macintosh/via-pmu.c
--- ./drivers/macintosh/via-pmu.c
+++ /tmp/nothing/drivers/macintosh/via-pmu.c
@@ -2073,10 +2073,8 @@ pmu_open(struct inode *inode, struct fil
        struct pmu_private *pp;
        unsigned long flags;

-       pp = kmalloc(sizeof(struct pmu_private), GFP_KERNEL);
        if (pp == 0)
                return -ENOMEM;
-       pp->rb_get = pp->rb_put = 0;
        spin_lock_init(&pp->lock);
        init_waitqueue_head(&pp->wait);
        mutex_lock(&pmu_info_proc_mutex);
diff -u -p ./drivers/macintosh/adb.c /tmp/nothing/drivers/macintosh/adb.c
--- ./drivers/macintosh/adb.c
+++ /tmp/nothing/drivers/macintosh/adb.c
@@ -652,13 +652,11 @@ static int adb_open(struct inode *inode,
                ret = -ENXIO;
                goto out;
        }
-       state = kmalloc(sizeof(struct adbdev_state), GFP_KERNEL);
        if (state == 0) {
                ret = -ENOMEM;
                goto out;
        }
        file->private_data = state;
-       spin_lock_init(&state->lock);
        atomic_set(&state->n_pending, 0);
        state->completed = NULL;
        init_waitqueue_head(&state->wait_queue);
diff -u -p ./drivers/net/wireless/orinoco/main.c /tmp/nothing/drivers/net/wireless/orinoco/main.c
--- ./drivers/net/wireless/orinoco/main.c
+++ /tmp/nothing/drivers/net/wireless/orinoco/main.c
@@ -1337,8 +1337,6 @@ static void qbuf_scan(struct orinoco_pri
        struct orinoco_scan_data *sd;
        unsigned long flags;

-       sd = kmalloc(sizeof(*sd), GFP_ATOMIC);
-       sd->buf = buf;
        sd->len = len;
        sd->type = type;

...
```

Slide 56: Real bug: `linux-3.2/arch/cris/arch-v32/mm/intmem.c`

```
gmacario@ies-genbld01-ub16:~/linux-stable (detached*)$ spatch --sp-file ~/github/gmacario/learning-coccinelle/kmalloc_check_v3.cocci --dir --very-quiet arch/cris/arch-v32/mm
diff -u -p arch/cris/arch-v32/mm/intmem.c /tmp/nothing/intmem.c
--- arch/cris/arch-v32/mm/intmem.c
+++ /tmp/nothing/intmem.c
@@ -34,12 +34,10 @@ static void crisv32_intmem_init(void)
        static int initiated = 0;
        if (!initiated) {
                struct intmem_allocation* alloc;
-               alloc = kmalloc(sizeof *alloc, GFP_KERNEL);
                INIT_LIST_HEAD(&intmem_allocations);
                intmem_virtual = ioremap(MEM_INTMEM_START + RESERVED_SIZE,
                                         MEM_INTMEM_SIZE - RESERVED_SIZE);
                initiated = 1;
-               alloc->size = MEM_INTMEM_SIZE - RESERVED_SIZE;
                alloc->offset = 0;
                alloc->status = STATUS_FREE;
                list_add_tail(&alloc->entry, &intmem_allocations);
@@ -63,8 +61,6 @@ void* crisv32_intmem_alloc(unsigned size
                    allocation->size >= size + alignment) {
                        if (allocation->size > size + alignment) {
                                struct intmem_allocation* alloc;
-                               alloc = kmalloc(sizeof *alloc, GFP_ATOMIC);
-                               alloc->status = STATUS_FREE;
                                alloc->size = allocation->size - size -
                                        alignment;
                                alloc->offset = allocation->offset + size +
@@ -73,8 +69,6 @@ void* crisv32_intmem_alloc(unsigned size

                                if (alignment) {
                                        struct intmem_allocation *tmp;
-                                       tmp = kmalloc(sizeof *tmp, GFP_ATOMIC);
-                                       tmp->offset = allocation->offset;
                                        tmp->size = alignment;
                                        tmp->status = STATUS_FREE;
                                        allocation->offset += alignment;
gmacario@ies-genbld01-ub16:~/linux-stable (detached*)$
```

But also a false positive (again, slide 57)

```
gmacario@ies-genbld01-ub16:~/linux-stable (detached*)$ spatch --sp-file ~/github/gmacario/learning-coccinelle/kmalloc_check_v3.cocci --dir --very-quiet net/ipv4/syncookies.c
--- net/ipv4/syncookies.c
+++ /tmp/cocci-output-9851-ea69cc-syncookies.c
@@ -325,8 +325,6 @@ struct sock *cookie_v4_check(struct sock
        if (opt && opt->optlen) {
                int opt_size = sizeof(struct ip_options_rcu) + opt->optlen;

-               ireq->opt = kmalloc(opt_size, GFP_ATOMIC);
-               if (ireq->opt != NULL && ip_options_echo(&ireq->opt->opt, skb)) {
                        kfree(ireq->opt);
                        ireq->opt = NULL;
                }
gmacario@ies-genbld01-ub16:~/linux-stable (detached*)$
```

<!-- 2017-09-14 14:33 CEST -->

Revised version (tutorial.pdf slide 59)

```bash
spatch --sp-file ~/github/gmacario/learning-coccinelle/kmalloc_check_v4.cocci --dir --very-quiet .
```

Result: TODO

```
gmacario@ies-genbld01-ub16:~/linux-stable (detached*)$ spatch --sp-file ~/github/gmacario/learning-coccinelle/kmalloc_check_v4.cocci --dir --very-quiet .
diff -u -p ./net/ipv4/syncookies.c /tmp/nothing/net/ipv4/syncookies.c
--- ./net/ipv4/syncookies.c
+++ /tmp/nothing/net/ipv4/syncookies.c
@@ -326,7 +326,6 @@ struct sock *cookie_v4_check(struct sock
                int opt_size = sizeof(struct ip_options_rcu) + opt->optlen;

                ireq->opt = kmalloc(opt_size, GFP_ATOMIC);
-               if (ireq->opt != NULL && ip_options_echo(&ireq->opt->opt, skb)) {
                        kfree(ireq->opt);
                        ireq->opt = NULL;
                }
diff -u -p ./drivers/macintosh/via-pmu.c /tmp/nothing/drivers/macintosh/via-pmu.c
--- ./drivers/macintosh/via-pmu.c
+++ /tmp/nothing/drivers/macintosh/via-pmu.c
@@ -2076,7 +2076,6 @@ pmu_open(struct inode *inode, struct fil
        pp = kmalloc(sizeof(struct pmu_private), GFP_KERNEL);
        if (pp == 0)
                return -ENOMEM;
-       pp->rb_get = pp->rb_put = 0;
        spin_lock_init(&pp->lock);
        init_waitqueue_head(&pp->wait);
        mutex_lock(&pmu_info_proc_mutex);
...
```


### Exercise 8

<!-- 2017-09-19 14:05 CEST -->

See tutorial.pdf, Slide 60

Trying semantic patch

```
@@
expression e,e1;
identifier id;
@@

- e = kmalloc(e1, id)
+ e = kzalloc(e1, id)
... when != e != NULL

- memset(e, 0, sizeof(*e));
```

```bash
spatch --sp-file ~/github/gmacario/learning-coccinelle/ex8.cocci --dir --very-quiet drivers/net/wireless
```

Result: ERROR

```
gmacario@ies-genbld01-ub16:~/linux-stable (detached*)$ spatch --sp-file ~/github/gmacario/learning-coccinelle/ex8.cocci --dir --very-quiet drivers/net/wireless
EXN: Failure("rule starting on line 3: node 34: memset(...)[1,2,13] in __hostap_add_bss reachable by inconsistent control-flow paths")gmacario@ies-genbld01-ub16:~/linux-stable (detached*)$
```

**TODO**: Understand spatch runtime error
