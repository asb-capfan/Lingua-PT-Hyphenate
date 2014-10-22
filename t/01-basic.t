# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

#use Test::More tests => 1;
use Test::More 'no_plan';
BEGIN { use_ok('Lingua::PT::Hyphenate') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $tests = '
m�dulo m� du lo
barca�a bar ca �a
bote bo te
cortina cor ti na
gambas gam bas
submarino sub ma ri no
camar�o ca ma r�o
oceano o cea no
teste tes te
m�o m�o
lim�o li m�o
macaco ma ca co
computador com pu ta dor
palha�o pa lha �o
quest�o ques t�o
marinheiro ma ri nhei ro
bot�o bo t�o
formigueiro for mi guei ro
formiga for mi ga
elefante e le fan te
contente con ten te
rato ra to
ratazana ra ta za na
avestruz a ves truz
copo co po
aberto a ber to
infantil in fan til
borboleta bor bo le ta
embora em bo ra
janela ja ne la
canela ca ne la
contentamento con ten ta men to
testamento tes ta men to
livro li vro
caba�a ca ba �a
camelo ca me lo
colunas co lu nas
coluna co lu na
r�dio r� dio
televis�o te le vi s�o
medicamento me di ca men to
palerma pa ler ma
empresa em pre sa
colete co le te
cama ca ma
guarda guar da
fato fa to
banho ba nho
banheira ba nhei ra
arm�rio ar m� rio
motorizada mo to ri za da
casaco ca sa co
sobretudo so bre tu do
port�til por t� til
camisa ca mi sa
camiseta ca mi se ta
empresa em pre sa

fant�stico fan t�s ti co
programador pro gra ma dor
que que
faz faz
estes es tes
m�dulos m� du los

almo�ar al mo �ar
cantina can ti na
p�o p�o
bebida be bi da
esp�rito es p� ri to
noite noi te
dia dia
comida co mi da
refei��o re fei ��o
patroc�nio pa tro c� nio
europa eu ro pa
castelo cas te lo
cinema ci ne ma
grande gran de
cobertor co ber tor
';
#secret�ria correio facto erro serrote

my @tests = map { [split / /, $_] } split /\n/, $tests;

for (@tests) {
  my ($word, @expected) = @$_;
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
