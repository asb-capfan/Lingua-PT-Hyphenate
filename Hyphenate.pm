package Lingua::PT::Hyphenate;

use 5.008;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw(
	hyphenate
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	hyphenate
);

our $VERSION = '0.01';

my @syllables;
my %exceptions;

BEGIN {
  @syllables = qw(
    ar an as al
    a

    brar bril
    bre bra ber ben bor bar bas
    ba be bo bi bu

    chão
    cão com cum con cen cor cer cho céu cha cea can cam çar ção cio cas
    co câ ca ça ci ce ço cí

    dir des der dar dor dão dio dia
    do da de di du

    eu en es em
    e

    fran
    fui fri fre for fan faz fei
    fu fo fa fi fe

    guei guar gran
    gir gos gal gem gel gua gla gam gor gra
    gu ga gi ge go

    hor
    há ha he ho

    in ir
    í i

    jan jor
    já jo

    lhões
    lhar lher lhei lhas lhou lhão
    lha lho liu lei lam liz lar lin lín ler los
    la lo le li lu lá ló

    mons
    men mar mor mun mão
    me ma mi mo mu mí mó má

    nhei nham
    nhã nam nei nia nel nas nho noi nio
    no na ne ni nu nó

    or os on
    o

    pren pães
    pre pri pon por pro pão
    pé pa po pu pi pe pí

    quais quios
    qual quan quer ques
    qui que

    rói rir rar rei rão ren rer rio
    ri ru ra ro re rá

    sois
    sim sus seu sua sem sen sal sol sub são
    sa so sí se si

    trar tron truz
    tar teu tis tir tro ter til tim tes tão tua tia tio tal ten tás tei tor
    ta tu ti te to tá

    ur
    u

    vel vir ver vân ven ves vez vês vro
    va ve vê vô vó vi vá vo

    ze zi za zo zu
  );
    # don't forget 'x'
  %exceptions = (
    borboleta	=> [qw(bor bo le ta)],
    canela	=> [qw(ca ne la)],
    janela	=> [qw(ja ne la)],
    embora	=> [qw(em bo ra)],
    'camarão'	=> [qw(ca ma rão)],
    submarino	=> [qw(sub ma ri no)],
    marinheiro	=> [qw(ma ri nhei ro)],
    comida	=> [qw(co mi da)],
    camelo	=> [qw(ca me lo)],
    medicamento	=> [qw(me di ca men to)],
    cama	=> [qw(ca ma)],
    camisa	=> [qw(ca mi sa)],
    camiseta	=> [qw(ca mi se ta)],
    casaco	=> [qw(ca sa co)],
    motorizada	=> [qw(mo to ri za da)],
  );
}

=head1 NAME

Lingua::PT::Hyphenate - Separates Portuguese words in syllables

=head1 SYNOPSIS

  use Lingua::PT::Hyphenate;

  @syllables = hyphenate("teste")   # @syllables now hold ('tes', 'te')

=cut

sub hyphenate {
  my $word = shift || return ();
  my @syll = ();

  defined $exceptions{$word} && return @{$exceptions{$word}};

  while ($word) {
    my $going = 1;
    for (@syllables) {
      if ($word =~ s/^$_//) {
        push @syll, $_;
        $going = 0;
        last;
      }
    }
    if ($going) {return @syll}
  }

  return @syll;
}

1;
__END__

=head1 DESCRIPTION

Separates Portuguese words into syllables.

The module currently works based on known syllables. There are two main
disadvantages to this:

1 -> If a syllable for your word isn't contemplated, there's some chance you
won't get the result you want.

2 -> Special cases have to be contemplated with the current algorithm.

I will have to do something about this in a near future.

=head1 AUTHOR

Jose Alves de Castro, E<lt>jac@natura.di.uminho.pt<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2004 by Jose Alves de Castro

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
