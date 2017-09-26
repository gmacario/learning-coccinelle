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

### 2.2.3 Write a semantic patch to remove parentheses in other places where they do not seem to be needed

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

TODO

On `linux-mainline/block`: 13+ 13-

<!-- EOF -->
