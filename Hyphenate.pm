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

our $VERSION = '1.01';

my ($vogal,$consonant,$letter,$oc_fr);
my ($ditongo,$ditongos,@regex);

BEGIN {

  $vogal     = qr/[aeiouãâáêéíóõôúÃÁÉÍÓÕÔÊÂÚ]/i;
  $consonant = qr/[zxcvbnmsdfghjlqrtpçÇ]/i;
  $letter    = qr/[aeiouãâáêéíóõôúÃÁÂÉÊÍÓÕÔÚzxcvbnmsdfghjlqrtpçÇ]/i;
  $oc_fr     = qr/[ctpgdbfv]/i;

  my @ditongos = qw(ia ua uo ai ei oi ou ai ae au ao éi ei am$
                    ui oi ói ou ãi ãe ão iu eu en õe ui em$);

  $ditongo = join "|", @ditongos;
  $ditongo = qr/$ditongo/i;

  $ditongos = join "|", map { /(.)(.*)/ ; "$1(?=$2)" } @ditongos;
  $ditongos = qr/$ditongos/i;

  @regex = (
    [ qr/[gq]u(?=$vogal)/i,                                  '.' ],
    [ qr/$letter(?=${consonant}s)/i,                         '.' ],
    [ qr/[cln](?=h)/i,                                       '.' ],
    [ qr/(?<=$consonant)$oc_fr(?=[lr])/i,                    '.' ],
    [ qr/^sub(?=$consonant)/i,                               '|' ],
    [ qr/(?<=$consonant)$consonant(?=$consonant)/i,          '|' ],
    [ qr/$ditongo(?=$ditongo)/i,                             '|' ],
    [ qr/$vogal(?=$ditongo)/i,                               '|' ],
    [ qr/$ditongos/i,                                        '.' ], # n sep dits
    [ qr/$vogal(?=$vogal)/i,                                 '|' ],
    [ qr/$oc_fr(?=[lr])/i,                                   '.' ],
    [ qr/${letter}\.?$consonant(?=${consonant}\.?$letter)/i, '|' ], # cons/cons
    [ qr/$vogal(?=${consonant}\.?$letter)/i,                 '|' ], # vog/cons
  );

}

=head1 NAME

Lingua::PT::Hyphenate - Separates Portuguese words in syllables

=head1 SYNOPSIS

  use Lingua::PT::Hyphenate;

  @syllables = hyphenate("teste")   # @syllables now hold ('tes', 'te')

=cut

sub hyphenate {
  my $word = shift   || return ();
  $word =~ /^$letter+$/ || return ();

  for my $regex (@regex) {
    $word =~ s/$$regex[0]/${&}$$regex[1]/g;
  }

  $word =~ y/.//d;

  split '\|', $word;
}


1;
__END__

=head1 DESCRIPTION

Separates Portuguese words into syllables.

=head1 SEE ALSO

If you're into Natural Language Processing tools, you may like this
Portuguese site: http://natura.di.uminho.pt

Gramatica Universal da Lingua Portuguesa (Texto Editora)

=head1 BUGS

None known, but more tests need be made.

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
