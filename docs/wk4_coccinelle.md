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

## Introductory Exercises

### Eliminating unnecessary temporary variables

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








TODO

<!-- EOF -->
