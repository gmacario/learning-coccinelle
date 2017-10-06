# Analyzing coccicheck-d81fa669e3de7eb8a631d7d95dac5fbcb2bf9d4e.log

<!-- 2017-10-06 09:00 CEST -->

Some statistics

```
cd ~/github/gmacario/learning-coccinelle
cat docs/coccicheck-d81fa669e3de7eb8a631d7d95dac5fbcb2bf9d4e.log | wc -l
```

Result:

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (master)$ cat docs/coccicheck-d81fa669e3de7eb8a631d7d95dac5fbcb2bf9d4e.log | wc -l
6778
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (master)$
```

Number of deviations reported (filter on lines containing a filename)

```
cat docs/coccicheck-d81fa669e3de7eb8a631d7d95dac5fbcb2bf9d4e.log | grep '^\.\/' | sort | less
cat docs/coccicheck-d81fa669e3de7eb8a631d7d95dac5fbcb2bf9d4e.log | grep '^\.\/' | wc -l
```

Result

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (master)$ cat docs/coccicheck-d81fa669e3de7eb8a631d7d95dac5fbcb2bf9d4e.log | grep '^\.\/' | sort | wc -l
4913
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (master)$
```

Number of ERROR and WARNING

```
cat docs/coccicheck-d81fa669e3de7eb8a631d7d95dac5fbcb2bf9d4e.log | grep ERROR | wc -l
cat docs/coccicheck-d81fa669e3de7eb8a631d7d95dac5fbcb2bf9d4e.log | grep WARNING | wc -l
```

Result

```
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (master)$ cat docs/coccicheck-d81fa669e3de7eb8a631d7d95dac5fbcb2bf9d4e.log | grep ERROR | wc -l
463
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (master)$ cat docs/coccicheck-d81fa669e3de7eb8a631d7d95dac5fbcb2bf9d4e.log | grep WARNING | wc -l
2835
gmacario@ies-genbld01-ub16:~/github/gmacario/learning-coccinelle (master)$
```

<!-- EOF -->
