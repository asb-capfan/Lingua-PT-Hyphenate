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

our $VERSION = '1.00';

my $regex;
my @regex;
my ($al,$cc);
BEGIN {

#ai au aú ei eu ia ie io iu ié iô oi ou ua ue ui uo uá ué uí ái áu éi éu ói ãe ãi ão õe

  $al = qr/[ãáéíóõúçÃÁÉÍÓÕÚÇ[:alpha:]]/i;

  $cc = qr/bl|br|cl|cr|dr|fl|fr|gr|tl|tr|vr/i;

  $regex = join "|", map { /(.)(.)/ ; "$1(?=$2)" } q(aa aá aã áa áá áã ãa ãá
           ãã ae aé áe áé ãé aí áí ãí ao aó aô aõ áo áó áô áõ ãó ãô ãõ áú ãu
           ãú ea eá eã éa éá éã ee eé ée éé eí éí eo eó eô eõ éo éó éô éõ eú
           éú iá iã ía íá íã íe íé ii ií íi íí ió iõ ío íó íô íõ iú íu íú oa
           oá oã óa óá óã ôa ôá ôã õa õá õã oe oé óe óé ôe ôé õé oí óí ôi ôí
           õi õí oo oó oô oõ óo óó óô óõ ôo ôó ôõ õo õó õô õõ oú óu óú ôu ôú
           õu õú uã úa úá úã úe úé úi úí uó uô uõ úo úó úô úõ uu uú úu úú );

  @regex = (qr/$al[^ãáéíóõúaeiou](?=[^ãáéíóõúaieouh.]$al)/i,
            qr/[ãáéíóõúaieou](?=[^ãáéíóõúaieou][^|.])/i,
            qr/$regex/i);
}

=head1 NAME

Lingua::PT::Hyphenate - Separates Portuguese words in syllables

=head1 SYNOPSIS

  use Lingua::PT::Hyphenate;

  @syllables = hyphenate("teste")   # @syllables now hold ('tes', 'te')

=cut

sub hyphenate {
  $_ = shift || return ();

  /^$al+$/ || return ();

  s/$cc/.$&./g;
  for my $regex ( @regex ) { s/$regex/$&|/g; }
  y/.//d;

  split '\|'
}

1;
__END__

=head1 DESCRIPTION

Separates Portuguese words into syllables.

Separation is done in three easy steps:

0) Mark special consonant combinations not to separate (like "tr",
   "vr", etc);

1) Separate consonants (not allowing consonants to be isolated; not
   separating "ch", "lh", "nh");

2) Separate vogals from consonants on their right;

3) Separate vowels from vowels (except for special cases like "ai",
   "au", etc).

4) Unmark the special consonant combinations marked in step 0)

=head1 SEE ALSO

If you're into Natural Language Processing tools, you may like this
Portuguese site: http://natura.di.uminho.pt

=head1 MESSAGE FROM THE AUTHOR

If you're using this module, please drop me a line to my e-mail. Tell
me what you're doing with it. Also, feel free to suggest new
bugs^H^H^H^H^H features.

=head1 AUTHOR

Jose Alves de Castro, E<lt>cog [at] cpan [dot] org<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2004 by Jose Alves de Castro

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
