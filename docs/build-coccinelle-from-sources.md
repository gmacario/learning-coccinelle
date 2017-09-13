### Building Coccinelle from sources

<!-- 2017-09-08 12:00 CEST -->

Logged as gmacario@ies-genbld01-ub16 (Ubuntu 16.04.3 LTS 64-bit)

Install prerequisites to build Coccinelle

```bash
sudo apt-get update && sudo apt-get -y dist-upgrade
sudo apt-get -y install curl git build-essential make
sudo apt-get -y build-dep coccinelle
sudo apt-get -y install autoconf
```

Install Coccinelle from GitHub sources

```bash
mkdir -p ~/github/coccinelle && cd ~/github/coccinelle
git clone https://github.com/coccinelle/coccinelle
cd coccinelle
autoreconf -i
./configure
make
```

**FIXME**: When building from `/home/gmacario/github/coccinelle/coccinelle`, command `make` keeps looping here:

```
gmacario@ies-genbld01-ub16:~/github/coccinelle/coccinelle$ make
make[1]: Entering directory '/home/gmacario/github/coccinelle/coccinelle'
Constructing '.depend'
set -e; for i in /home/gmacario/github/coccinelle/coccinelle/bundles/pyml/  commons globals ctl parsing_cocci parsing_c ocaml python engine popl09 extra tools/spgen; do echo $i; make -C $i depend; done
/home/gmacario/github/coccinelle/coccinelle/bundles/pyml/
make[2]: Entering directory '/home/gmacario/github/coccinelle/coccinelle/bundles/pyml'
make[2]: Nothing to be done for 'depend'.
make[2]: Leaving directory '/home/gmacario/github/coccinelle/coccinelle/bundles/pyml'
commons
make[2]: Entering directory '/home/gmacario/github/coccinelle/coccinelle/commons'
/usr/bin/ocamldep -I ocamlextra  common.mli objet.mli ocollection.mli ograph_extended.mli ograph_simple.mli commands.ml common.ml ograph_simple.ml ograph_extended.ml  > .depend
for i in ocamlextra; do /usr/bin/ocamldep -I ocamlextra  $i/*.ml $i/*.mli >> .depend; done
make[2]: Leaving directory '/home/gmacario/github/coccinelle/coccinelle/commons'
globals
make[2]: Entering directory '/home/gmacario/github/coccinelle/coccinelle/globals'
/usr/bin/ocamldep -I ../commons -I /usr/lib/ocaml/pcre *.mli *.ml > .depend
make[2]: Leaving directory '/home/gmacario/github/coccinelle/coccinelle/globals'
ctl
make[2]: Entering directory '/home/gmacario/github/coccinelle/coccinelle/ctl'
/usr/bin/ocamldep -I ../commons -I ../commons/ocamlextra -I ../globals *.mli *.ml > .depend
make[2]: Leaving directory '/home/gmacario/github/coccinelle/coccinelle/ctl'
parsing_cocci
make[2]: Entering directory '/home/gmacario/github/coccinelle/coccinelle/parsing_cocci'
/usr/bin/menhir --ocamlc "/usr/bin/ocamlc.opt" --ocamldep "/usr/bin/ocamldep" --table --base parser_cocci_menhir parser_cocci_menhir.mly
Warning: you are using the standard library and/or the %inline keyword. We
recommend switching on --infer in order to avoid obscure type error messages.
/usr/bin/menhir --ocamlc "/usr/bin/ocamlc.opt" --ocamldep "/usr/bin/ocamldep" --table --base parser_cocci_menhir parser_cocci_menhir.mly
Warning: you are using the standard library and/or the %inline keyword. We
recommend switching on --infer in order to avoid obscure type error messages.
/usr/bin/ocamldep *.mli *.ml > .depend
/usr/bin/menhir --ocamlc "/usr/bin/ocamlc.opt" --ocamldep "/usr/bin/ocamldep" --table --base parser_cocci_menhir parser_cocci_menhir.mly
Warning: you are using the standard library and/or the %inline keyword. We
recommend switching on --infer in order to avoid obscure type error messages.
...
```

Cannot understand why, maybe some clock skew issues as `/home/gmacario` is mounted from NFS???

**WORKAROUND**: Do "git clone" of the repository under `/var/tmp`

```bash
sudo make install
```

Run tests

```bash
cd .../coccinelle
spatch --testall
```

Result

```
...
new test file appeared: zero.res
--------------------------------
total score
--------------------------------
good = 503/526
Current score is greater than expected :)
(was expecting 0 but got 503)
Generating new expected score file and saving old one
mv tests/SCORE_expected.sexp tests/SCORE_expected.sexp.save [y/n] ?
y
mv: cannot stat 'tests/SCORE_expected.sexp': No such file or directory
mv tests/SCORE_best_of_both.sexp tests/SCORE_expected.sexp [y/n] ?
y
gmacario@ies-genbld01-ub16:~/github/coccinelle/coccinelle$
```
