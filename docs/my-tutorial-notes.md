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
TODO
```

**NOTE**: Did not understand questions/comments at point 3. and 4. of slide 34 of tutorial.pdf
