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
m� du lo
bar ca �a
bo te
cor ti na
gam bas
sub ma ri no
ca ma r�o
o cea no
tes te
m�o
li m�o
ma ca co
com pu ta dor
pa lha �o
ques t�o
ma ri nhei ro
bo t�o
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
ca ba �a
ca me lo
co lu nas
co lu na
r� dio
te le vi s�o
me di ca men to
pa ler ma
em pre sa
co le te
ca ma
guar da
fa to
ba nho
ba nhei ra
ar m� rio
mo to ri za da
ca sa co
so bre tu do
por t� til
ca mi sa
ca mi se ta
em pre sa

fan t�s ti co
pro gra ma dor
que
faz
es tes
m� du los

al mo �ar
can ti na
p�o
be bi da
es p� ri to
noi te
dia
co mi da
re fei ��o
pa tro c� nio
eu ro pa
cas te lo
ci ne ma
gran de
co ber tor

se cre t� ria
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
