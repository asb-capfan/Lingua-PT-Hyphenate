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
módulo mó du lo
barcaça bar ca ça
bote bo te
cortina cor ti na
gambas gam bas
submarino sub ma ri no
camarão ca ma rão
oceano o cea no
teste tes te
mão mão
limão li mão
macaco ma ca co
computador com pu ta dor
palhaço pa lha ço
questão ques tão
marinheiro ma ri nhei ro
botão bo tão
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
cabaça ca ba ça
camelo ca me lo
colunas co lu nas
coluna co lu na
rádio rá dio
televisão te le vi são
medicamento me di ca men to
palerma pa ler ma
empresa em pre sa
colete co le te
cama ca ma
guarda guar da
fato fa to
banho ba nho
banheira ba nhei ra
armário ar má rio
motorizada mo to ri za da
casaco ca sa co
sobretudo so bre tu do
portátil por tá til
camisa ca mi sa
camiseta ca mi se ta
empresa em pre sa

fantástico fan tás ti co
programador pro gra ma dor
que que
faz faz
estes es tes
módulos mó du los

almoçar al mo çar
cantina can ti na
pão pão
bebida be bi da
espírito es pí ri to
noite noi te
dia dia
comida co mi da
refeição re fei ção
patrocínio pa tro cí nio
europa eu ro pa
castelo cas te lo
cinema ci ne ma
grande gran de
cobertor co ber tor
';
#secretária correio facto erro serrote

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
