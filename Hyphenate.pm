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

our $VERSION = '1.02';

my ($vowel,$consonant,$letter,$oc_fr);
my ($ditongo,$ditongos,@regex);

BEGIN {

  $vowel     = qr/[aeiou„‚·‡ÍÈÌÛıÙ˙√¡…Õ”’‘ ¬⁄]/i;
  $consonant = qr/[zxcvbnmsdfghjlqrtpÁ«]/i;
  $letter    = qr/[aeiou„‚·‡ÍÈÌÛıÙ˙√¡¬… Õ”’‘⁄zxcvbnmsdfghjlqrtpÁ«]/i;
  $oc_fr     = qr/[ctpgdbfv]/i;

  my @ditongos = qw(ia ua uo ai ei oi ou ai ae au ao Èi ei am$
                    ui oi Ûi ou „i „e „o iu eu en ıe ui em$);

  $ditongo = join "|", @ditongos;
  $ditongo = qr/$ditongo/i;

  $ditongos = join "|", map { /(.)(.*)/ ; "$1(?=$2)" } @ditongos;
  $ditongos = qr/$ditongos/i;

  @regex = (
    [ qr/[gq]u(?=$vowel)/i,                                  '.' ],
    [ qr/$letter(?=${consonant}s)/i,                         '.' ],
    [ qr/[cln](?=h)/i,                                       '.' ],
    [ qr/(?<=$consonant)$oc_fr(?=[lr])/i,                    '.' ],
    [ qr/^sub(?=$consonant)/i,                               '|' ],
    [ qr/(?<=$consonant)$consonant(?=$consonant)/i,          '|' ],
    [ qr/$ditongo(?=$ditongo)/i,                             '|' ],
    [ qr/$vowel(?=$ditongo)/i,                               '|' ],
    [ qr/$ditongos/i,                                        '.' ],
    [ qr/$vowel(?=$vowel)/i,                                 '|' ],
    [ qr/$oc_fr(?=[lr])/i,                                   '.' ],
    [ qr/${letter}\.?$consonant(?=${consonant}\.?$letter)/i, '|' ],
    [ qr/$vowel(?=${consonant}\.?$letter)/i,                 '|' ],
  );

}

=head1 NAME

Lingua::PT::Hyphenate - Separates Portuguese words in syllables

=head1 SYNOPSIS

  use Lingua::PT::Hyphenate;

  @syllables = hyphenate("teste")   # @syllables now hold ('tes', 'te')

  # or

  $word = new Lingua::PT::Hyphenate;
  @syllables = $word->hyphenate;

=cut

sub hyphenate {

  my $word;
  if (ref($_[0]) eq 'Lingua::PT::Hyphenate') {
    my $self = shift;
    $word = $$self;
  }
  else {
    $word = shift   || return ();
  }

  $word =~ /^$letter+$/ || return ();

  for my $regex (@regex) {
    $word =~ s/$$regex[0]/${&}$$regex[1]/g;
  }

  $word =~ y/.//d;

  split '\|', $word;
}

sub new {
  my ($self, $word) = @_;
  bless \$word, $self;
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
