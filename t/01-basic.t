# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 242;
BEGIN { use_ok('Lingua::PT::Hyphenate') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $tests = '
mó du lo
bar ca ça
bo te
cor ti na
gam bas
sub ma ri no
ca ma rão
o cea no
tes te
mão
li mão
ma ca co
com pu ta dor
pa lha ço
ques tão
ma ri nhei ro
bo tão
for mi guei ro
for mi ga
e le fan te
con ten te
ra to
ra ta za na
a ves truz
co po
a ber to
in fan til
bor bo le ta
em bo ra
ja ne la
ca ne la
con ten ta men to
tes ta men to
li vro
ca ba ça
ca me lo
co lu nas
co lu na
rá dio
te le vi são
me di ca men to
pa ler ma
em pre sa
co le te
ca ma
guar da
fa to
ba nho
ba nhei ra
ar má rio
mo to ri za da
ca sa co
so bre tu do
por tá til
ca mi sa
ca mi se ta
em pre sa

fan tás ti co
pro gra ma dor
que
faz
es tes
mó du los

al mo çar
can ti na
pão
be bi da
es pí ri to
noi te
dia
co mi da
re fei ção
pa tro cí nio
eu ro pa
cas te lo
ci ne ma
gran de
co ber tor

se cre tá ria
cor reio
fac to
er ro
ser ro te
';


my @tests = map { [split / /, $_] } split /\n/, $tests;

for (@tests) {
  my ($word, @expected) = ((join '', @$_), @$_);
  my @got = hyphenate($word);
  while ($a = shift @got) {
    $b = shift @expected;
    is($a,$b);
  }
  while (@expected) {
    $b = shift @expected;
    is(undef,$b);
  }
}
