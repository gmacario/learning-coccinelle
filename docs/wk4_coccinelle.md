# SIL2LinuxMP, Workshop 4 Coccinelle exercises


<!-- Upload to <https://github.com/gmacario/learning-coccinelle/tree/master/docs> -->

From <http://lists.osadl.org/pipermail/sil2linuxmp/2017-September/000474.html>

> The Coccinelle exercises to be done at the workshop are available at
>
> https://pages.lip6.fr/Julia.Lawall/wk4/index.html
>
> The whole thing can be downloaded from
>
> https://pages.lip6.fr/Julia.Lawall/wk4/wk4_exercises.tar.gz
>
> julia

-----

Logged as gmacario@ies-genbld01-ub16.ies.mentorg.com

```bash
mkdir -p ~/ws4 cd ~/ws4
wget https://pages.lip6.fr/Julia.Lawall/wk4/wk4_exercises.tar.gz
tar xvzf wk4_exercises.tar.gz
```

(the tarball is the snapshot of <https://pages.lip6.fr/Julia.Lawall/wk4/index.html>)

## 2 Introductory Exercises

### 2.1 Eliminating unnecessary temporary variables

#### 2.1.1 Write a semantic patch to make this transformation

```bash
cd ~/github/gmacario/learning-coccinelle
spatch --sp-file wk4/ex_2_1_1.cocci --dir ~/linux-mainline/crypto
```

(Julia)
Identifier vs local id expression:
Local ID expression: an expression which has a value, it looks like an identifier.
You can specify its type

Result: 8 occurrences on `linux-mainline/crypto`

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --very-quiet --sp-file wk4/ex_2_1_1.cocci --dir ~/linux-mainline/crypto | grep '@@'
@@ -741,9 +741,7 @@ struct crypto_attr_type *crypto_get_attr
trying for CRYPTO_MINALIGN_ATTR
trying for CRYPTO_MINALIGN_ATTR
trying for CRYPTO_MINALIGN_ATTR
@@ -865,8 +865,7 @@ static int __init khazad_mod_init(void)
@@ -189,9 +189,8 @@ __2data_recov_4(int disks, size_t bytes,
@@ -264,9 +263,8 @@ __2data_recov_5(int disks, size_t bytes,
@@ -332,9 +330,8 @@ __2data_recov_n(int disks, size_t bytes,
@@ -520,9 +517,8 @@ async_raid6_datap_recov(int disks, size_
@@ -690,8 +690,7 @@ static int __init anubis_mod_init(void)
@@ -328,9 +328,7 @@ static int mcryptd_hash_enqueue(struct a
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$
```

Trying on `linux-mainline/block`

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --very-quiet --sp-file wk4/ex_2_1_1.cocci --dir ~/linux-mainline/block
diff -u -p a/compat_ioctl.c b/compat_ioctl.c
--- a/compat_ioctl.c
+++ b/compat_ioctl.c
@@ -398,8 +398,7 @@ long compat_blkdev_ioctl(struct file *fi
        case BLKTRACESTART: /* compatible */
        case BLKTRACESTOP:  /* compatible */
        case BLKTRACETEARDOWN: /* compatible */
-               ret = blk_trace_ioctl(bdev, cmd, compat_ptr(arg));
-               return ret;
+               return blk_trace_ioctl(bdev, cmd, compat_ptr(arg));
        default:
                if (disk->fops->compat_ioctl)
                        ret = disk->fops->compat_ioctl(bdev, mode, cmd, arg);
diff -u -p a/cfq-iosched.c b/cfq-iosched.c
--- a/cfq-iosched.c
+++ b/cfq-iosched.c
@@ -1006,9 +1006,7 @@ static inline unsigned cfq_group_get_avg

        min_q = min(cfqg->busy_queues_avg[rt], busy);
        max_q = max(cfqg->busy_queues_avg[rt], busy);
-       cfqg->busy_queues_avg[rt] = (mult * max_q + min_q + round) /
-               cfq_hist_divisor;
-       return cfqg->busy_queues_avg[rt];
+       return (mult * max_q + min_q + round) / cfq_hist_divisor;
 }

 static inline u64
diff -u -p a/bfq-wf2q.c b/bfq-wf2q.c
--- a/bfq-wf2q.c
+++ b/bfq-wf2q.c
@@ -1408,9 +1408,7 @@ __bfq_lookup_next_entity(struct bfq_serv
        if (!in_service)
                bfq_update_vtime(st, new_vtime);

-       entity = bfq_first_active_entity(st, new_vtime);
-
-       return entity;
+       return bfq_first_active_entity(st, new_vtime);
 }

 /**
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$
```

Counting occurrences and comparing them against the solution at <https://pages.lip6.fr/Julia.Lawall/wk4/exercises040.html#remret1d>

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --very-quiet --sp-file wk4/ex_2_1_1.cocci --dir ~/linux-mainline/block | grep '^-' | grep -v '^---' | wc -l
8
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --very-quiet --sp-file wk4/ex_2_1_1.cocci --dir ~/linux-mainline/block | grep '^+' | grep -v '^+++' | wc -l
3
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$
```

**TODO**: Create a script to mimic output of exercise diffstat output
(Julia created this out of script but did not publish it)

Julia: You may safey ignore spurious messages `trying for ...` (reproduced on coccinelle built from master branch), they are just debugging messages inside Coccinelle which were not removed from the output even when using the `--very-quiet` flag.

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)$ spatch --very-quiet --sp-file wk4/ex_2_1_1.cocci --dir ~/linux-mainline/crypto/
diff -u -p a/algapi.c b/algapi.c
--- a/algapi.c
+++ b/algapi.c
@@ -741,9 +741,7 @@ struct crypto_attr_type *crypto_get_attr
        if (rta->rta_type != CRYPTOA_TYPE)
                return ERR_PTR(-EINVAL);

-       algt = RTA_DATA(rta);
-
-       return algt;
+       return RTA_DATA(rta);
 }
 EXPORT_SYMBOL_GPL(crypto_get_attr_type);

trying for CRYPTO_MINALIGN_ATTR
trying for CRYPTO_MINALIGN_ATTR
trying for CRYPTO_MINALIGN_ATTR
diff -u -p a/khazad.c b/khazad.c
--- a/khazad.c
+++ b/khazad.c
@@ -865,8 +865,7 @@ static int __init khazad_mod_init(void)
 {
        int ret = 0;

-       ret = crypto_register_alg(&khazad_alg);
-       return ret;
+       return crypto_register_alg(&khazad_alg);
 }
```

#### 2.1.2 Extend this semantic patch to ensure that `ret` is a local variable

Trying against `linux-mainline/block` (before it was 3+ 8-, now it should be 28+ 57-)

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)$ spatch --very-quiet --sp-file wk4/ex_2_1_2.cocci --dir ~/linux-mainline/block/
diff -u -p a/blk.h b/blk.h
--- a/blk.h
+++ b/blk.h
@@ -157,8 +157,7 @@ static inline struct request *__elv_next

        while (1) {
                if (!list_empty(&q->queue_head)) {
-                       rq = list_entry_rq(q->queue_head.next);
-                       return rq;
+                       return list_entry_rq(q->queue_head.next);
                }

                /*
diff -u -p a/compat_ioctl.c b/compat_ioctl.c
--- a/compat_ioctl.c
+++ b/compat_ioctl.c
@@ -398,8 +398,7 @@ long compat_blkdev_ioctl(struct file *fi
        case BLKTRACESTART: /* compatible */
        case BLKTRACESTOP:  /* compatible */
        case BLKTRACETEARDOWN: /* compatible */
-               ret = blk_trace_ioctl(bdev, cmd, compat_ptr(arg));
-               return ret;
+               return blk_trace_ioctl(bdev, cmd, compat_ptr(arg));
        default:
                if (disk->fops->compat_ioctl)
                        ret = disk->fops->compat_ioctl(bdev, mode, cmd, arg);
diff -u -p a/bfq-wf2q.c b/bfq-wf2q.c
--- a/bfq-wf2q.c
+++ b/bfq-wf2q.c
@@ -1408,9 +1408,7 @@ __bfq_lookup_next_entity(struct bfq_serv
        if (!in_service)
                bfq_update_vtime(st, new_vtime);

-       entity = bfq_first_active_entity(st, new_vtime);
-
-       return entity;
+       return bfq_first_active_entity(st, new_vtime);
 }

 /**
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)$
```

NOTE: I obtained a different result then what reported in diffstat: why???

Julia: I am not sure that '28+ 57-' is a valid solution, will look at it further.

For the moment let's skip and go to next exercise

Julia: The diffstat were generated by running spatch across the complete Linux source tree, rather than each single directory as reported by diffstat.
That's why many more occurrences are reported by diffstat

#### 2.1.3 Extend the semantic patch to remove the declaration of ret if it is not used elsewhere.

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)$ spatch --very-quiet --sp-file wk4/ex_2_1_3.cocci --dir ~/linux-mainline/block/
diff -u -p a/blk.h b/blk.h
--- a/blk.h
+++ b/blk.h
@@ -150,15 +150,13 @@ void blk_insert_flush(struct request *rq

 static inline struct request *__elv_next_request(struct request_queue *q)
 {
-       struct request *rq;
        struct blk_flush_queue *fq = blk_get_flush_queue(q, NULL);

        WARN_ON_ONCE(q->mq_ops);

        while (1) {
                if (!list_empty(&q->queue_head)) {
-                       rq = list_entry_rq(q->queue_head.next);
-                       return rq;
+                       return list_entry_rq(q->queue_head.next);
                }

                /*
diff -u -p a/compat_ioctl.c b/compat_ioctl.c
--- a/compat_ioctl.c
+++ b/compat_ioctl.c
@@ -398,8 +398,7 @@ long compat_blkdev_ioctl(struct file *fi
        case BLKTRACESTART: /* compatible */
        case BLKTRACESTOP:  /* compatible */
        case BLKTRACETEARDOWN: /* compatible */
-               ret = blk_trace_ioctl(bdev, cmd, compat_ptr(arg));
-               return ret;
+               return blk_trace_ioctl(bdev, cmd, compat_ptr(arg));
        default:
                if (disk->fops->compat_ioctl)
                        ret = disk->fops->compat_ioctl(bdev, mode, cmd, arg);
diff -u -p a/cfq-iosched.c b/cfq-iosched.c
--- a/cfq-iosched.c
+++ b/cfq-iosched.c
@@ -4593,7 +4593,6 @@ static void cfq_exit_queue(struct elevat
 static int cfq_init_queue(struct request_queue *q, struct elevator_type *e)
 {
        struct cfq_data *cfqd;
-       struct blkcg_gq *blkg __maybe_unused;
        int i, ret;
        struct elevator_queue *eq;

diff -u -p a/bfq-wf2q.c b/bfq-wf2q.c
--- a/bfq-wf2q.c
+++ b/bfq-wf2q.c
@@ -1383,7 +1383,6 @@ left:
 static struct bfq_entity *
 __bfq_lookup_next_entity(struct bfq_service_tree *st, bool in_service)
 {
-       struct bfq_entity *entity;
        u64 new_vtime;

        if (RB_EMPTY_ROOT(&st->active))
@@ -1408,9 +1407,7 @@ __bfq_lookup_next_entity(struct bfq_serv
        if (!in_service)
                bfq_update_vtime(st, new_vtime);

-       entity = bfq_first_active_entity(st, new_vtime);
-
-       return entity;
+       return bfq_first_active_entity(st, new_vtime);
 }

 /**
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)$
```

BUG: This patch has too enthusiastic and removes also unrelated variables!

### 2.2  Eliminating unnecessary parentheses

#### 2.2.1 Write a semantic patch to remove parentheses around the right hand side of an assignment

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --very-quiet --sp-file wk4/ex_2_2_1.cocci --dir ~/linux-mainline/block/
diff -u -p a/mq-deadline.c b/mq-deadline.c
--- a/mq-deadline.c
+++ b/mq-deadline.c
@@ -488,9 +488,9 @@ static ssize_t __FUNC(struct elevator_qu
        int __data;                                                     \
        deadline_var_store(&__data, (page));                            \
        if (__data < (MIN))                                             \
-               __data = (MIN);                                         \
+               __data = MIN;                                           \
        else if (__data > (MAX))                                        \
-               __data = (MAX);                                         \
+               __data = MAX;                                           \
        if (__CONV)                                                     \
                *(__PTR) = msecs_to_jiffies(__data);                    \
        else                                                            \
...
```

Result: 18-, 18+ (as reported by diffstat)

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --very-quiet --sp-file wk4/ex_2_2_1.cocci --dir ~/linux-mainline/block/ | grep '^-' | grep -v '^---' | wc -l
18
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --very-quiet --sp-file wk4/ex_2_2_1.cocci --dir ~/linux-mainline/block/ | grep '^+' | grep -v '^+++' | wc -l
18
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$
```

Julia: look at `coccinelle/demos/pythontococci.cocci` for an example how to use Python

#### 2.2.2 Write a semantic patch to remove parentheses around the right hand side of an assignment, but keep the parentheses when the right hand side has the form E1 == E2, as the two kinds of = can be confused.

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --very-quiet --sp-file wk4/ex_2_2_2.cocci --dir ~/linux-mainline/block/ | grep '^-' | grep -v '^---' | wc -l
16
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$
```

#### 2.2.3 Write a semantic patch to remove parentheses in other places where they do not seem to be needed

Some examples

```
return (expression);

... & (e->fld)
```

Result

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --very-quiet --sp-file wk4/ex_2_2_3.cocci --dir ~/linux-mainline/block/ | grep '^-' | grep -v '^---' | wc -l
13
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --very-quiet --sp-file wk4/ex_2_2_3.cocci --dir ~/linux-mainline/block/ | grep '^+' | grep -v '^+++' | wc -l
13
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$
```

On `linux-mainline/block`: 13+ 13-

### 2.3 Eliminating unnecessary prints

<!-- 2017-09-26 16:23 CEST -->

When the Linux kernel memory allocation function kmalloc does not find enough memory available, then it prints a backtrace before returning NULL. Thus there is no need for the calling context to print generic out of memory messages.

#### 2.3.1

Write a semantic patch to remove a call to a print function that has a single string argument on failure of calls to functions such as kmalloc, kzalloc, kcalloc, devm_kmalloc, devm_kzalloc, devm_kcalloc, etc. Ensure that no unnecessary braces are left in the transformed code.

Expected `block: 4+ 12-`

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --very-quiet --sp-file wk4/ex_2_3_1.cocci --dir ~/linux-mainline/block
diff -u -p a/partitions/ldm.c b/partitions/ldm.c
--- a/partitions/ldm.c
+++ b/partitions/ldm.c
@@ -379,10 +379,9 @@ static bool ldm_validate_tocblocks(struc
        ph = &ldb->ph;
        tb[0] = &ldb->toc;
        tb[1] = kmalloc(sizeof(*tb[1]) * 3, GFP_KERNEL);
-       if (!tb[1]) {
+       if (!tb[1])
                ldm_crit("Out of memory.");
-               goto err;
-       }
+       goto err;
        tb[2] = (struct tocblock*)((u8*)tb[1] + sizeof(*tb[1]));
        tb[3] = (struct tocblock*)((u8*)tb[2] + sizeof(*tb[2]));
        /*
@@ -1187,10 +1186,9 @@ static bool ldm_ldmdb_add (u8 *data, int
        BUG_ON (!data || !ldb);

        vb = kmalloc (sizeof (*vb), GFP_KERNEL);
-       if (!vb) {
+       if (!vb)
                ldm_crit ("Out of memory.");
-               return false;
-       }
+       return false;

        if (!ldm_parse_vblk (data, len, vb)) {
                kfree(vb);
@@ -1273,10 +1271,9 @@ static bool ldm_frag_add (const u8 *data
        }

        f = kmalloc (sizeof (*f) + size*num, GFP_KERNEL);
-       if (!f) {
+       if (!f)
                ldm_crit ("Out of memory.");
-               return false;
-       }
+       return false;

        f->group = group;
        f->num   = num;
@@ -1467,10 +1464,9 @@ int ldm_partition(struct parsed_partitio
                return 0;

        ldb = kmalloc (sizeof (*ldb), GFP_KERNEL);
-       if (!ldb) {
+       if (!ldb)
                ldm_crit ("Out of memory.");
-               goto out;
-       }
+       goto out;

        /* Parse and check privheads. */
        if (!ldm_validate_privheads(state, &ldb->ph))
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$
```

**NOTE**: The remaining `goto` statement is not properly aligned.
Julia: This is a bug in Coccinelle that has to be fixed.

Gianpaolo: Apart from that, questioning the added value of this semantic patch, especially about removing the unnecessary `{...}`.

Julia: This is part of the Linux kernel coding style, maintaners will get annoyed otherwise and will not accept the change upstream.

Discussing some conflicts between Linux kernel coding style vs. MISRA
(as this example well points out)

Search for "LWN 0 day " fenggung

<https://lwn.net/Articles/514278/>

See also: <https://01.org/lkp/documentation/0-day-test-service>

GitHub: <https://github.com/intel/lkp-tests>

Mailing List: <https://lists.01.org/mailman/listinfo/kbuild-all>

#### 2.3.2

Write a semantic patch to remove a call to a print function that has multiple arguments on failure of calls to functions such as kmalloc, kzalloc, kcalloc, devm_kmalloc, devm_kzalloc, devm_kcalloc, etc. Is is it always desirable to remove these calls?

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --very-quiet --sp-file wk4/ex_2_3_2.cocci --dir ~/linux-mainline/block
diff -u -p a/genhd.c b/genhd.c
--- a/genhd.c
+++ b/genhd.c
@@ -1898,10 +1898,9 @@ static void disk_alloc_events(struct gen
                return;

        ev = kzalloc(sizeof(*ev), GFP_KERNEL);
-       if (!ev) {
+       if (!ev)
                pr_warn("%s: failed to initialize events\n", disk->disk_name);
-               return;
-       }
+       return;

        INIT_LIST_HEAD(&ev->node);
        ev->disk = disk;
diff -u -p a/partitions/ldm.c b/partitions/ldm.c
--- a/partitions/ldm.c
+++ b/partitions/ldm.c
@@ -379,10 +379,9 @@ static bool ldm_validate_tocblocks(struc
        ph = &ldb->ph;
        tb[0] = &ldb->toc;
        tb[1] = kmalloc(sizeof(*tb[1]) * 3, GFP_KERNEL);
-       if (!tb[1]) {
+       if (!tb[1])
                ldm_crit("Out of memory.");
-               goto err;
-       }
+       goto err;
        tb[2] = (struct tocblock*)((u8*)tb[1] + sizeof(*tb[1]));
        tb[3] = (struct tocblock*)((u8*)tb[2] + sizeof(*tb[2]));
        /*
@@ -1187,10 +1186,9 @@ static bool ldm_ldmdb_add (u8 *data, int
        BUG_ON (!data || !ldb);

        vb = kmalloc (sizeof (*vb), GFP_KERNEL);
-       if (!vb) {
+       if (!vb)
                ldm_crit ("Out of memory.");
-               return false;
-       }
+       return false;

        if (!ldm_parse_vblk (data, len, vb)) {
                kfree(vb);
@@ -1273,10 +1271,9 @@ static bool ldm_frag_add (const u8 *data
        }

        f = kmalloc (sizeof (*f) + size*num, GFP_KERNEL);
-       if (!f) {
+       if (!f)
                ldm_crit ("Out of memory.");
-               return false;
-       }
+       return false;

        f->group = group;
        f->num   = num;
@@ -1467,10 +1464,9 @@ int ldm_partition(struct parsed_partitio
                return 0;

        ldb = kmalloc (sizeof (*ldb), GFP_KERNEL);
-       if (!ldb) {
+       if (!ldb)
                ldm_crit ("Out of memory.");
-               goto out;
-       }
+       goto out;

        /* Parse and check privheads. */
        if (!ldm_validate_privheads(state, &ldb->ph))
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$
```

Expected: `block: 5+ 15-`

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --very-quiet --sp-file wk4/ex_2_3_2.cocci --dir ~/linux-mainline/block | grep '^-' | grep -v '^---' | wc -l
15
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --very-quiet --sp-file wk4/ex_2_3_2.cocci --dir ~/linux-mainline/block | grep '^+' | grep -v '^+++' | wc -l
10
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$
```

**TODO**: Go figure out why I did not get the expected results

-----------------------------------------

## 2.4 Eliminate typedefs

<!-- 2017-09-27 09:00 CEST -->

Reference: <https://pages.lip6.fr/Julia.Lawall/wk4/exercises005.html>

> The Linux kernel does not normally use typedefs for structure types.
> Write a semantic patch to eliminate typedefs.
> In doing this, it may be necessary to change the structure name.
> Normally, structure names are in lowercase and do not end with `_t`.
> Note that some typedef’d structures have names of their own and some do not.
> In the former case, it may also be necessary to clean up uses of these names.

Expected `kernel: 3+ 3-`

Reference: SemPL grammar: <http://coccinelle.lip6.fr/docs/main_grammar.pdf>

Start simple: only look for `typedef xxx`

```
@@
identifier i1;
type i2;
@@

* typedef struct i1 { ...} i2;
```

Verify syntax of semantic patch

```
spatch --parse-cocci wk4/ex_2_4_1.cocci
```

Run semantic patch

2.4.1: Find occurrences only

```
spatch --sp-file wk4/ex_2_4_1.cocci --dir ~/linux-mainline/kernel
```

Result:

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --very-quiet
--sp-file wk4/ex_2_4_1.cocci --dir ~/linux-mainline/kernel
diff -u -p /home/gmacario/linux-mainline/kernel/debug/kdb/kdb_main.c /tmp/nothing/debug/kdb/kdb_main.c
--- /home/gmacario/linux-mainline/kernel/debug/kdb/kdb_main.c
+++ /tmp/nothing/debug/kdb/kdb_main.c
@@ -95,10 +95,6 @@ static kdbtab_t kdb_base_commands[KDB_BA
             num < kdb_max_commands;                                    \
             num++, num == KDB_BASE_CMD_MAX ? cmd = kdb_commands : cmd++)

-typedef struct _kdbmsg {
-       int     km_diag;        /* kdb diagnostic */
-       char    *km_msg;        /* Corresponding message text */
-} kdbmsg_t;

 #define KDBMSG(msgnum, text) \
        { KDB_##msgnum, text }
trying for __ro_after_init
trying for __tracer_data
trying for __tracer_data
trying for DEFAULT_REBOOT_MODE
trying for DEFAULT_REBOOT_MODE
trying for __ro_after_init
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$
```

Discussed with Julia about how the Intel 0 day build service is able to send notifications to only the committers to a change which causes a rule of the semantic patch to be hit.

1. Check-in source tree before the change
2. Run semantic patch against the whole tree, save output as p1
3. Check-in source tree including the change
4. Run semantic patch against the whole tree, save output as p2
5. If (p1 != p2) notify the committer of the change

```
cd ~/linux-mainline && git blame -- kernel/debug/kdb/kdb_main.c
```

Result:

```
...
5d5314d6 (Jason Wessel     2010-05-20 21:04:20 -0500   98) typedef struct _kdbmsg {
5d5314d6 (Jason Wessel     2010-05-20 21:04:20 -0500   99)      int     km_diag;        /* kdb diagnostic */
5d5314d6 (Jason Wessel     2010-05-20 21:04:20 -0500  100)      char    *km_msg;        /* Corresponding message text */
5d5314d6 (Jason Wessel     2010-05-20 21:04:20 -0500  101) } kdbmsg_t;
...
```

Verify source tree before and after the offending commit

```
git checkout 5d5314d6^ && git blame -- kernel/debug/kdb/kdb_main.c  
## fatal: no such path 'kernel/debug/kdb/kdb_main.c' in HEAD

git checkout 5d5314d6  && git blame -- kernel/debug/kdb/kdb_main.c  ## typedef is here

git checkout master
```

Step 2: Add another rule to search for `struct i1 { ... };`

Discussing with Julia how to supplement cocci output with details about which rule caused which diff ==> no built-in functions for doing that, she suggested to use Python scripting.

Look at examples in `coccinelle/demos/pythoncocci.cocci`

Manual: <https://github.com/coccinelle/coccinelle/blob/master/docs/manual/cocci-python.txt>

Definition of the elements shared between Python and Coccinelle:
<https://github.com/coccinelle/coccinelle/blob/master/python/coccilib/elems.py>

Step 3: Implement the Python script to bind the search and replace rules

Julia: In Python here is no built-in `make_ident` as in OCaml.
You may try the following

```
coccinelle.nm = i2
coccinelle.nm = cocci.make_ident(i2)
```

Notice that you always need to prefix variables `coccinelle.xxx` to have them pass values back to other rules - see pythoncocci.cocci

## 2.5

Skipped

## 2.6

Skipped


## 3.1 Simplify tests on boolean values

### Exercise 3.1.1

<!-- 2017-09-27 13:00 CEST -->

> Write a semantic patch to find cases where a boolean expression
> is tested using == or != and a constant (true, false, 1 or 0)
> and simplify the code to account for the fact that booleans
> are already true or false.

Expected `drivers/char: 4+ 4-`

Trying my own version

```
spatch --sp-file wk4/my_3_1_1.cocci --dir ~/linux-mainline/drivers/char
```

Result running the proposed solution for the Semantic Patch:

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --sp-file wk4/ex_3_1_1.cocci --dir ~/linux-mainline/drivers/char
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
warning: line 7: should true be a metavariable?
warning: line 10: should false be a metavariable?
warning: line 14: should false be a metavariable?
warning: line 18: should true be a metavariable?
HANDLING: /home/gmacario/linux-mainline/drivers/char/ipmi/ipmi_bt_sm.c
...
HANDLING: /home/gmacario/linux-mainline/drivers/char/mwave/mwavedd.c
diff =
diff -u -p a/mwave/mwavedd.c b/mwave/mwavedd.c
--- a/mwave/mwavedd.c
+++ b/mwave/mwavedd.c
@@ -324,7 +324,7 @@ static long mwave_ioctl(struct file *fil
                                pDrvData->IPCs[ipcnum].usIntCount);

                        mutex_lock(&mwave_mutex);
-                       if (pDrvData->IPCs[ipcnum].bIsEnabled == true) {
+                       if (pDrvData->IPCs[ipcnum].bIsEnabled) {
                                DECLARE_WAITQUEUE(wait, current);

                                PRINTK_2(TRACE_MWAVE,
@@ -384,9 +384,9 @@ static long mwave_ioctl(struct file *fil
                                return -EINVAL;
                        }
                        mutex_lock(&mwave_mutex);
-                       if (pDrvData->IPCs[ipcnum].bIsEnabled == true) {
+                       if (pDrvData->IPCs[ipcnum].bIsEnabled) {
                                pDrvData->IPCs[ipcnum].bIsEnabled = false;
-                               if (pDrvData->IPCs[ipcnum].bIsHere == true) {
+                               if (pDrvData->IPCs[ipcnum].bIsHere) {
                                        wake_up_interruptible(&pDrvData->IPCs[ipcnum].ipc_wait_queue);
                                }
                        }
HANDLING: /home/gmacario/linux-mainline/drivers/char/mwave/3780i.c
HANDLING: /home/gmacario/linux-mainline/drivers/char/mwave/tp3780i.c
diff =
diff -u -p a/mwave/tp3780i.c b/mwave/tp3780i.c
--- a/mwave/tp3780i.c
+++ b/mwave/tp3780i.c
@@ -127,7 +127,7 @@ static irqreturn_t DspInterrupt(int irq,
                                PRINTK_2(TRACE_TP3780I,
                                        "tp3780i::DspInterrupt usIntCount %x\n",
                                        pDrvData->IPCs[usPCNum - 1].usIntCount);
-                               if (pDrvData->IPCs[usPCNum - 1].bIsEnabled == true) {
+                               if (pDrvData->IPCs[usPCNum - 1].bIsEnabled) {
                                        PRINTK_2(TRACE_TP3780I,
                                                "tp3780i::DspInterrupt, waking up usPCNum %x\n",
                                                usPCNum - 1);
HANDLING: /home/gmacario/linux-mainline/drivers/char/ds1302.c
...
HANDLING: /home/gmacario/linux-mainline/drivers/char/random.c
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$
```

### Exercise 3.1.2

<!-- 2017-09-27 14:40 CEST -->

> Some operators such as < and > already have boolean return type,
> so there is not need to convert their results to booleans.
> An example of such an unnecessary test is:
> value > 3900 ? true : false
> Write a semantic patch to drop these unnecessary tests.
> Note that the transformation may require negating the test expression,
> depending on the order of the true and false values.

```
spatch --sp-file wk4/my_3_1_2.cocci --dir ~/linux-mainline/drivers/gpu
```

Result:

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --sp-file wk4/my_3_1_2.cocci --dir ~/linux-mainline/drivers/gpu
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
(ONCE) Expected tokens true false
Skipping: /home/gmacario/linux-mainline/drivers/gpu/host1x/dev.c
HANDLING: /home/gmacario/linux-mainline/drivers/gpu/host1x/mipi.c
Skipping: /home/gmacario/linux-mainline/drivers/gpu/host1x/channel.c
HANDLING: /home/gmacario/linux-mainline/drivers/gpu/host1x/cdma.c
...
HANDLING: /home/gmacario/linux-mainline/drivers/gpu/drm/nouveau/nouveau_ttm.c
diff =
diff -u -p a/drm/nouveau/nouveau_ttm.c b/drm/nouveau/nouveau_ttm.c
--- a/drm/nouveau/nouveau_ttm.c
+++ b/drm/nouveau/nouveau_ttm.c
@@ -391,7 +391,7 @@ nouveau_ttm_init(struct nouveau_drm *drm
                                  &nouveau_bo_driver,
                                  dev->anon_inode->i_mapping,
                                  DRM_FILE_PAGE_OFFSET,
-                                 bits <= 32 ? true : false);
+                                 bits <= 32);
        if (ret) {
                NV_ERROR(drm, "error initialising bo driver, %d\n", ret);
                return ret;
HANDLING: /home/gmacario/linux-mainline/drivers/gpu/drm/nouveau/nouveau_backlight.c
...
HANDLING: /home/gmacario/linux-mainline/drivers/gpu/drm/exynos/exynos_drm_fimc.c
diff =
diff -u -p a/drm/exynos/exynos_drm_fimc.c b/drm/exynos/exynos_drm_fimc.c
--- a/drm/exynos/exynos_drm_fimc.c
+++ b/drm/exynos/exynos_drm_fimc.c
@@ -960,8 +960,8 @@ static int fimc_set_prescaler(struct fim

        sc->hratio = (src_w << 14) / (dst_w << hfactor);
        sc->vratio = (src_h << 14) / (dst_h << vfactor);
-       sc->up_h = (dst_w >= src_w) ? true : false;
-       sc->up_v = (dst_h >= src_h) ? true : false;
+       sc->up_h = (dst_w >= src_w);
+       sc->up_v = (dst_h >= src_h);
        DRM_DEBUG_KMS("hratio[%d]vratio[%d]up_h[%d]up_v[%d]\n",
                sc->hratio, sc->vratio, sc->up_h, sc->up_v);

Skipping: /home/gmacario/linux-mainline/drivers/gpu/drm/exynos/exynos_drm_iommu.c
...
HANDLING: /home/gmacario/linux-mainline/drivers/gpu/drm/sti/sti_hqvdp.c
diff =
diff -u -p a/drm/sti/sti_hqvdp.c b/drm/sti/sti_hqvdp.c
--- a/drm/sti/sti_hqvdp.c
+++ b/drm/sti/sti_hqvdp.c
@@ -736,7 +736,7 @@ static bool sti_hqvdp_check_hw_scaling(s

        inv_zy = DIV_ROUND_UP(src_h, dst_h);

-       return (inv_zy <= lfw) ? true : false;
+       return (inv_zy <= lfw);
 }

 /**
HANDLING: /home/gmacario/linux-mainline/drivers/gpu/drm/sti/sti_tvout.c
...
HANDLING: /home/gmacario/linux-mainline/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
diff =
diff -u -p a/drm/amd/amdgpu/amdgpu_pm.c b/drm/amd/amdgpu/amdgpu_pm.c
--- a/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drm/amd/amdgpu/amdgpu_pm.c
@@ -1083,8 +1083,7 @@ static struct amdgpu_ps *amdgpu_dpm_pick
        int i;
        struct amdgpu_ps *ps;
        u32 ui_class;
-       bool single_display = (adev->pm.dpm.new_active_crtc_count < 2) ?
-               true : false;
+       bool single_display = (adev->pm.dpm.new_active_crtc_count < 2);

        /* check if the vblank period is too short to adjust the mclk */
        if (single_display && adev->pm.funcs->vblank_too_short) {
HANDLING: /home/gmacario/linux-mainline/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
...
Skipping: /home/gmacario/linux-mainline/drivers/gpu/drm/drm_vma_manager.c
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$
```
TODO


### Exercise 3.1.3

TODO

### Exercise 3.2

TODO

### Exercise 3.3

TODO

### Exercise 4.1

<!-- 2017-09-27 15:50 CEST -->

> The key point we are going to look into with respect to device nodes
> is memory management. Device nodes are reference counted, so the main
> relevant functions are
> `x = of_node_get(y);` (increment the reference count of y and return a pointer to the result which is stored in x)
> and
> `of_node_put(x);` (decrement the reference counter of x and possibly free it).
> `of_node_get()`, however, is not that common.
> More commonly, some kind of search function is called that finds a node
> with a particular property and return a pointer to it.
>
> The goal of this exercise is to collect the names of these functions.
> To this end, write a semantic patch that prints the name of any function
> such that the returned value is ultimately passed to of_node_put.

Running proposed solution

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --very-quiet --sp-file wk4/ex_4_1.cocci --dir ~/linux-mainline/drivers/of
of_get_child_by_name
of_get_parent
of_graph_get_remote_endpoint
of_node_get
of_find_compatible_node
of_find_node_by_path
of_find_node_opts_by_path
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$
```

TODO: Does not match expected `drivers/of: 0+ 29-`

NOTE: The script only prints each function name only once **within the same file**.
Julia explains this is an optimization done by Coccinelle which calls the
Python script for each distinct set of metavariables

The function names may be duplicated if they occur on different files, though.
See for example with `linux-mainline/arch`

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --very-quiet --sp-file wk4/ex_4_1.cocci --dir ~/linux-mainline/arch
of_find_compatible_node
of_find_node_by_name
of_find_node_by_name
of_find_node_by_path
of_node_get
of_find_compatible_node
of_find_node_by_path
of_find_compatible_node
of_find_compatible_node
of_find_compatible_node
of_find_node_by_path
of_parse_phandle
of_parse_phandle
of_find_compatible_node
trying for __ro_after_init
of_get_next_child
of_find_compatible_node
of_find_matching_node
of_find_compatible_node
of_find_compatible_node
of_find_compatible_node
omap_get_timer_dt
of_find_node_by_name
of_get_child_by_name
of_find_next_cache_node
of_find_compatible_node
of_find_node_by_name
of_find_node_by_path
of_get_parent
of_get_next_child
of_node_get
of_find_node_by_name
of_find_node_by_name
of_find_node_by_path
of_find_node_by_type
of_find_node_by_path
of_get_parent
of_get_parent
of_find_node_by_name
of_find_node_by_name
of_find_node_by_path
of_find_node_by_type
of_find_node_by_name
of_find_node_by_path
of_find_node_by_type
of_find_node_by_path
find_pe_dn
of_find_node_by_name
of_find_node_by_path
of_find_node_by_path
of_find_node_by_path
of_find_node_by_path
of_get_parent
of_find_compatible_node
of_find_node_by_path
of_find_node_by_path
of_find_compatible_node
of_find_compatible_node
of_find_compatible_node
of_get_parent
of_find_compatible_node
of_find_compatible_node
of_find_compatible_node
of_find_node_by_path
of_find_node_by_name
of_find_node_by_type
of_find_node_with_property
of_find_node_by_phandle
of_find_node_by_path
of_find_compatible_node
of_get_parent
of_find_matching_node
of_find_matching_node
of_find_matching_node
of_find_matching_node
of_find_matching_node
of_find_matching_node
of_get_parent
trying for __init_task_data
of_find_compatible_node
of_get_cpu_node
of_find_compatible_node
of_find_node_by_path
of_find_node_by_path
of_find_node_by_type
of_get_cpu_node
of_find_compatible_node
of_get_cpu_node
of_get_cpu_node
of_find_node_by_phandle
of_find_node_by_type
of_find_node_by_path
of_find_node_by_type
of_get_cpu_node
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$
```

Notice that Exercise 4.2 will provide a solution to this

To find all the occurrences you need to add other metavariables (i.e. p1, p2)
as in my solution

```
spatch --very-quiet --sp-file wk4/my_4_1.cocci --dir ~/linux-mainline/drivers/of
```

Result:

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --very-quiet --sp-file wk4/my_4_1.cocci --dir ~/linux-mainline/drivers/of
DEBUG: f= of_get_child_by_name
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/property.c , line= 616
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/property.c , line= 621
DEBUG: f= of_get_child_by_name
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/property.c , line= 571
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/property.c , line= 585
DEBUG: f= of_get_parent
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/property.c , line= 972
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/property.c , line= 979
DEBUG: f= of_get_parent
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/property.c , line= 538
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/property.c , line= 553
DEBUG: f= of_graph_get_remote_endpoint
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/property.c , line= 742
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/property.c , line= 746
DEBUG: f= of_node_get
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/irq.c , line= 138
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/irq.c , line= 142
DEBUG: f= of_find_compatible_node
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/of_numa.c , line= 147
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/of_numa.c , line= 151
DEBUG: f= of_find_node_by_path
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 1258
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 1278
DEBUG: f= of_find_node_by_path
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 600
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 602
DEBUG: f= of_find_node_by_path
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 51
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 55
DEBUG: f= of_find_node_by_path
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 62
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 66
DEBUG: f= of_find_node_by_path
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 69
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 73
DEBUG: f= of_find_node_by_path
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 80
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 84
DEBUG: f= of_find_node_by_path
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 87
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 89
DEBUG: f= of_find_node_by_path
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 91
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 93
DEBUG: f= of_find_node_by_path
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 95
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 97
DEBUG: f= of_find_node_by_path
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 1936
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 1990
DEBUG: f= of_find_node_opts_by_path
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 99
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 102
DEBUG: f= of_find_node_opts_by_path
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 104
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 107
DEBUG: f= of_find_node_opts_by_path
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 109
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 112
DEBUG: f= of_find_node_opts_by_path
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 114
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 116
DEBUG: f= of_find_node_opts_by_path
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 119
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 122
DEBUG: f= of_find_node_opts_by_path
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 125
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 128
DEBUG: f= of_find_node_opts_by_path
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 130
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 132
DEBUG: f= of_find_node_opts_by_path
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 135
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 137
DEBUG: f= of_find_node_opts_by_path
DEBUG: p1: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 140
DEBUG: p2: file /home/gmacario/linux-mainline/drivers/of/unittest.c , line= 142
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$
```

I got 26 occurrences now (not yet 29, though...)

### Exercise 4.2 Avoiding duplicates in the list of relevant functions

<!-- 2017-09-27 16:30 CEST -->

> Device node getting functions are likely to be used more than once.
> The result of the previous semantic patch will be more digestible
> if each function name appears only once in the output.
> Add an initialize rule to your semantic patch to make a global state in
> which to remember previously seen names, so they are not printed more than once.

Result against `linux-mainline/arch` using the proposed solution #1

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --very-quiet --sp-file wk4/ex_4_2.cocci --dir ~/linux-mainline/arch
trying for __ro_after_init
trying for __init_task_data
of_find_compatible_node
of_find_node_by_name
of_find_node_by_path
of_node_get
of_parse_phandle
of_get_next_child
of_find_matching_node
omap_get_timer_dt
of_get_child_by_name
of_find_next_cache_node
of_get_parent
of_find_node_by_type
find_pe_dn
of_find_node_with_property
of_find_node_by_phandle
of_get_cpu_node
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$
```

Result against `linux-mainline/arch` using the proposed solution #2
(notice that the order is different from solution #1, but no other differences since solution #1 did not produce duplicates either)

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --very-quiet --sp-file wk4/ex_4_2b.cocci --dir ~/linux-mainline/arch
trying for __ro_after_init
trying for __init_task_data
of_get_cpu_node
of_find_node_by_phandle
of_find_node_with_property
find_pe_dn
of_find_node_by_type
of_get_parent
of_find_next_cache_node
of_get_child_by_name
omap_get_timer_dt
of_find_matching_node
of_get_next_child
of_parse_phandle
of_node_get
of_find_node_by_path
of_find_node_by_name
of_find_compatible_node
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$
```

### Exercise 4.3 Finding potential memory leaks

<!-- 2017-09-27 16:58 CEST -->

> In principle, every get should have an accompanying put, but if there is no put at all in a function, then there may be something about how the function is written that makes it unnecessary. But if there is a put on one execution path and no put on another, then the code may be considered to be suspicious. Write a semantic patch that detects this situation, taking into account the list of functions obtained in the previous two exercises.
>
If there appear to be many false positives, revise your semantic patch until most of them are eliminated.
>
Note that one some architectures, device nodes are not actually reference counted (ie, the get and put functions are no-ops), and thus some seeming leaks may never leak memory in practice.

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --very-quiet --sp-file wk4/ex_4_3.cocci --dir ~/linux-mainline/drivers/iommu
diff -u -p /home/gmacario/linux-mainline/drivers/iommu/fsl_pamu.c /tmp/nothing/fsl_pamu.c
--- /home/gmacario/linux-mainline/drivers/iommu/fsl_pamu.c
+++ /tmp/nothing/fsl_pamu.c
@@ -576,7 +576,6 @@ found_cpu_node:
                of_node_put(node);

                /* advance to next node in cache hierarchy */
-               node = of_find_node_by_phandle(*prop);
                if (!node) {
                        pr_debug("Invalid node for cache hierarchy\n");
                        return ~(u32)0;
@@ -585,7 +584,6 @@ found_cpu_node:
...
```

### Exercise 4.4 Finding device node iterators

<!-- 2017-09-27 17:09 CEST -->

> A number of iterators are defined for processing device nodes.
> These typically have one argument that is the index variable and that
> is a local variable of type `struct device_node *` that has not been
> previously initialized. Write a semantic patch analogous to the ones
> developed for exercises 4.1 and 4.2 to find the names of these iterators
> and the number of arguments preceding the index variable

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)$ spatch --very-quiet --sp-file wk4/ex_4_4.cocci --dir ~/linux-mainline/drivers/clk
for_each_child_of_node 1
for_each_matching_node 0
for_each_matching_node 0
for_each_compatible_node 0
for_each_compatible_node 0
for_each_child_of_node 1
for_each_matching_node_and_match 0
for_each_child_of_node 1
for_each_child_of_node 1
for_each_child_of_node 1
for_each_child_of_node 1
for_each_child_of_node 1
for_each_matching_node_and_match 0
for_each_node_by_type 0
for_each_available_child_of_node 1
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$
```

Trying my version with additional debugging

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --very-quiet --sp-file wk4/my_4_4.cocci --dir ~/linux-mainline/drivers/clk
for_each_child_of_node 1
DEBUG: fp_p[0].file= /home/gmacario/linux-mainline/drivers/clk/tegra/clk-emc.c line= 449
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/tegra/clk-emc.c line= 449
for_each_child_of_node 1
DEBUG: fp_p[0].file= /home/gmacario/linux-mainline/drivers/clk/tegra/clk-emc.c line= 449
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/tegra/clk-emc.c line= 493
for_each_child_of_node 1
DEBUG: fp_p[0].file= /home/gmacario/linux-mainline/drivers/clk/tegra/clk-emc.c line= 493
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/tegra/clk-emc.c line= 449
for_each_child_of_node 1
DEBUG: fp_p[0].file= /home/gmacario/linux-mainline/drivers/clk/tegra/clk-emc.c line= 493
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/tegra/clk-emc.c line= 493
for_each_child_of_node 1
DEBUG: fp_p[0].file= /home/gmacario/linux-mainline/drivers/clk/at91/sckc.c line= 419
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/at91/sckc.c line= 419
for_each_child_of_node 1
DEBUG: fp_p[0].file= /home/gmacario/linux-mainline/drivers/clk/at91/clk-generated.c line= 302
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/at91/clk-generated.c line= 302
for_each_child_of_node 1
DEBUG: fp_p[0].file= /home/gmacario/linux-mainline/drivers/clk/at91/clk-programmable.c line= 257
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/at91/clk-programmable.c line= 257
for_each_child_of_node 1
DEBUG: fp_p[0].file= /home/gmacario/linux-mainline/drivers/clk/at91/clk-system.c line= 145
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/at91/clk-system.c line= 145
for_each_child_of_node 1
DEBUG: fp_p[0].file= /home/gmacario/linux-mainline/drivers/clk/at91/clk-peripheral.c line= 401
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/at91/clk-peripheral.c line= 401
for_each_matching_node_and_match 0
DEBUG: fp_p[0].file= /home/gmacario/linux-mainline/drivers/clk/clk.c line= 3430
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/clk.c line= 3458
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$
```

Check source

```
cat -n ~/linux-mainline/drivers/clk/tegra/clk-emc.c
```

Does not work as expected.
Julia suggests to have separate Python script called when each of the above rules `fromparam`, `r` are hit

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$ spatch --very-quiet --sp-file wk4/my_4_4.cocci --dir ~/linux-mainline/drivers/clk
DEBUG: fp_p[0].file= /home/gmacario/linux-mainline/drivers/clk/sunxi/clk-sun8i-bus-gates.c line= 69
DEBUG: fp_p[0].file= /home/gmacario/linux-mainline/drivers/clk/sunxi/clk-simple-gates.c line= 58
for_each_child_of_node 1
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/clk-si5351.c line= 1189
for_each_matching_node 0
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/ti/clockdomain.c line= 173
for_each_matching_node 0
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/ti/clk.c line= 438
for_each_compatible_node 0
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/imx/clk-imx27.c line= 260
for_each_compatible_node 0
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/imx/clk-imx31.c line= 224
for_each_child_of_node 1
DEBUG: fp_p[0].file= /home/gmacario/linux-mainline/drivers/clk/tegra/clk-emc.c line= 449
DEBUG: fp_p[0].file= /home/gmacario/linux-mainline/drivers/clk/tegra/clk-emc.c line= 493
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/tegra/clk-emc.c line= 449
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/tegra/clk-emc.c line= 493
for_each_matching_node_and_match 0
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/samsung/clk.c line= 293
for_each_child_of_node 1
DEBUG: fp_p[0].file= /home/gmacario/linux-mainline/drivers/clk/at91/sckc.c line= 419
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/at91/sckc.c line= 419
for_each_child_of_node 1
DEBUG: fp_p[0].file= /home/gmacario/linux-mainline/drivers/clk/at91/clk-generated.c line= 302
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/at91/clk-generated.c line= 302
for_each_child_of_node 1
DEBUG: fp_p[0].file= /home/gmacario/linux-mainline/drivers/clk/at91/clk-programmable.c line= 257
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/at91/clk-programmable.c line= 257
for_each_child_of_node 1
DEBUG: fp_p[0].file= /home/gmacario/linux-mainline/drivers/clk/at91/clk-system.c line= 145
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/at91/clk-system.c line= 145
for_each_child_of_node 1
DEBUG: fp_p[0].file= /home/gmacario/linux-mainline/drivers/clk/at91/clk-peripheral.c line= 401
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/at91/clk-peripheral.c line= 401
DEBUG: fp_p[0].file= /home/gmacario/linux-mainline/drivers/clk/ux500/u8500_of_clk.c line= 545
for_each_matching_node_and_match 0
DEBUG: fp_p[0].file= /home/gmacario/linux-mainline/drivers/clk/clk.c line= 3430
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/clk.c line= 3458
for_each_node_by_type 0
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/mvebu/clk-cpu.c line= 186
DEBUG: fp_p[0].file= /home/gmacario/linux-mainline/drivers/clk/clk-conf.c line= 88
for_each_available_child_of_node 1
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/clk-scpi.c line= 285
DEBUG: r_p[0].file= /home/gmacario/linux-mainline/drivers/clk/clk-scpi.c line= 270
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (wk4)*$
```

TODO: Add `--debug` when running spatch to understand what really happens.

```
spatch --debug --sp-file wk4/my_4_4.cocci --dir ~/linux-mainline/drivers/clk &> spatch.log
less spatch.log
```

TODO

<!-- 2017-09-28 09:30 CEST -->

Julia: Investigate the `spgen` tool to transform the Semantic Patch adding reporting mode.

For the Linux kernel

- patch
- report
- put context
- Emacs mode

Discussion with Markus Kreidl (OpenTech) about integrating the Patch Impact Checker with Coccinelle to filter out unnecessary output when applying a semantic patch which does not affect a given kernel configuration.

The PIC code will be released in about two weeks - now cleaning it up to provide data to Nicholas for assessing the maturity of the linux-stable kernel.


### Exercise 4.5 Finding device node iterator memory leaks

<!-- 2017-09-28 09:45 CEST -->

```
cd ~/linux-mainline && spatch --sp-file ~/github/gmacario/learning-coccinelle/wk4/ex_4_5.cocci --dir drivers/pinctrl >spatch.log
```

Result

```
gmacario@ies-genbld01-ub16:~ $ cd ~/linux-mainline && spatch --sp-file ~/github/gmacario/learning-coccinelle/wk4/ex_4_5.cocci --dir drivers/pinctrl >spatch.log
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
32 files match
HANDLING: drivers/pinctrl/freescale/pinctrl-imx.c
     (ONCE) already tagged but only removed, so safe
diff =
HANDLING: drivers/pinctrl/freescale/pinctrl-imx1-core.c
HANDLING: drivers/pinctrl/freescale/pinctrl-mxs.c
diff =
HANDLING: drivers/pinctrl/mediatek/pinctrl-mtk-common.c
HANDLING: drivers/pinctrl/meson/pinctrl-meson.c
diff =
HANDLING: drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
HANDLING: drivers/pinctrl/nomadik/pinctrl-abx500.c
diff =
HANDLING: drivers/pinctrl/nomadik/pinctrl-nomadik.c
diff =
HANDLING: drivers/pinctrl/pinconf-generic.c
HANDLING: drivers/pinctrl/pinctrl-at91-pio4.c
HANDLING: drivers/pinctrl/pinctrl-at91.c
HANDLING: drivers/pinctrl/pinctrl-falcon.c
diff =
HANDLING: drivers/pinctrl/pinctrl-gemini.c
diff =
HANDLING: drivers/pinctrl/pinctrl-lantiq.c
HANDLING: drivers/pinctrl/pinctrl-rockchip.c
HANDLING: drivers/pinctrl/pinctrl-rza1.c
diff =
HANDLING: drivers/pinctrl/pinctrl-st.c
diff =
HANDLING: drivers/pinctrl/pinctrl-tb10x.c
HANDLING: drivers/pinctrl/pinctrl-tz1090-pdc.c
diff =
HANDLING: drivers/pinctrl/pinctrl-tz1090.c
diff =
HANDLING: drivers/pinctrl/samsung/pinctrl-exynos.c
diff =
HANDLING: drivers/pinctrl/samsung/pinctrl-exynos5440.c
diff =
HANDLING: drivers/pinctrl/samsung/pinctrl-s3c24xx.c
HANDLING: drivers/pinctrl/samsung/pinctrl-s3c64xx.c
HANDLING: drivers/pinctrl/samsung/pinctrl-samsung.c
diff =
HANDLING: drivers/pinctrl/sh-pfc/pinctrl.c
HANDLING: drivers/pinctrl/sirf/pinctrl-sirf.c
HANDLING: drivers/pinctrl/spear/pinctrl-spear.c
diff =
HANDLING: drivers/pinctrl/sprd/pinctrl-sprd.c
diff =
HANDLING: drivers/pinctrl/stm32/pinctrl-stm32.c
diff =
HANDLING: drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
HANDLING: drivers/pinctrl/tegra/pinctrl-tegra.c
gmacario@ies-genbld01-ub16:~/linux-mainline (master)*$
```

Contents of `spatch.log`

```
diff -u -p drivers/pinctrl/freescale/pinctrl-imx.c /tmp/nothing/freescale/pinctrl-imx.c
--- drivers/pinctrl/freescale/pinctrl-imx.c
+++ /tmp/nothing/freescale/pinctrl-imx.c
@@ -560,13 +560,11 @@ static int imx_pinctrl_parse_functions(s
        if (!func->group_names)
                return -ENOMEM;

-       for_each_child_of_node(np, child) {
                func->group_names[i] = child->name;

                grp = devm_kzalloc(info->dev, sizeof(struct group_desc),
                                   GFP_KERNEL);
                if (!grp)
-                       return -ENOMEM;

                mutex_lock(&info->mutex);
                radix_tree_insert(&pctl->pin_group_tree,
@@ -589,13 +587,9 @@ static bool imx_pinctrl_dt_is_flat_funct
...  
```

Count number of occurrences

```
gmacario@ies-genbld01-ub16:~/linux-mainline (master)*$ grep '^-' spatch.log | grep -v '^---' | wc -l
54
gmacario@ies-genbld01-ub16:~/linux-mainline (master)*$
```

See also: `linux-mainline/scripts/coccinelle/iterators/device_node_continue.cocci`

<!-- 2017-09-28 10:28 CEST -->

Trying the `spgen` tool as suggested by Julia

```
spgen --help
man spgen
```

See also: <https://github.com/coccinelle/coccinelle/tree/master/tools/spgen>

Trying spgen to harden `my_4_5.cocci`

```
cd ~/github/gmacario/learning-coccinelle/wk4
spgen --default my_4_5.cocci -o my_4_5.cocci2
```

Alternatively, you may remove the `--default` and run spgen in interactive mode to be able to supply all the additional parameters.

The configuration will be saved to file `my_4_5.config`.

Generated file

```
...
@rule_0 depends on context || org || report@
iterator i;
expression n;
position start.p;
position j0, j1;
@@

* i@j0(...,n@p,...)
{
  ... when any
      when != of_node_put(n)
*  return@j1 ...;
}

// ----------------------------------------------------------------------------

@script:python rule_0_org depends on org@
j0 << rule_0.j0;
j1 << rule_0.j1;
@@

msg = "found a match around here ..."
coccilib.org.print_todo(j0[0], msg)
coccilib.org.print_link(j1[0], "")

// ----------------------------------------------------------------------------

@script:python rule_0_report depends on report@
j0 << rule_0.j0;
j1 << rule_0.j1;
@@

msg = "found a match around here .. around line %s." % (j1[0].line)
coccilib.report.print_report(j0[0], msg)
```

Run the Semantic patch in `report` mode (default)

```
TODO
```

Run the Semantic patch in `org` mode (the TODO messages come from statement `coccilib.org.print_todo(j0[0], msg)`)

```
TODO
```

Run the Semantic patch in `context` mode

```
TODO
```

Reference about the different available modes: See
* Doc `linux-mainline/Documentation/dev-tools/coccinelle.rst`
* <https://bottest.wiki.kernel.org/coccicheck>

Read `man coccilib` to know the APIs for `coccilib.org.xxx`, `coccilib.report.xxx`.
Unfortunately the man page seems incomplete, should rather look at source code instead: <https://github.com/coccinelle/coccinelle/blob/master/ocaml/coccilib.ml>

Discussed with Julia about the additional utility `pycocci` and whether that provides additional value. According to Julia this wrapper was developed once Coccinelle did not support parallelism well, but as of today there are no compelling reasons to use it any longer - some developers still prefer it just because that helps using the most common options of spatch.

### Exercise 4.6 Finding device node iterator double frees

<!-- 2017-09-28 12:55 CEST -->

TODO

...


# Additional exercises

## apparmor: Fix ref count leak

<!-- 2017-09-27 14:13 -->

From <http://lists.osadl.org/pipermail/sil2linuxmp/2017-September/000482.html>

> Hi all, hi coccinelle scripters,
>
> While scanning through the commits on the linux-stable repository as part of the root-cause analysis activities, I found this bug fix which might be suitable for detection with coccinelle:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.gi
> t/commit/?id=6090bfb684a9985e29c3c0aae52a4b93f967e90f
>
> For the root-cause analysis, we are currently not considering to do a further root-cause analysis, as apparmor is not part of the current image and we do not intend to use apparmor.
>
> So, just in case you lack any further coccinelle exercises and would like to write a script to detect issues in apparmor, please go ahead.
>
> We, the root-cause analysis team, are continuing to analyse the bugs and see if we can find one that is suitable for detection with coccinelle. I hope Andreas can provide you the further pointers to the pre-existing root-cause analyses that are suitable for detection with coccinelle, if we don’t find suitable bug fixes.

<https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=6090bfb684a9985e29c3c0aae52a4b93f967e90f>


Markus K

```
TODO
```

Cfr. Julia reply: <http://lists.osadl.org/pipermail/sil2linuxmp/2017-September/000483.html>

# See also

* Mailing List: <https://systeme.lip6.fr/mailman/listinfo/cocci>

<!-- EOF -->
