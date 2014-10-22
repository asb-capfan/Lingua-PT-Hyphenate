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

#ai au a� ei eu ia ie io iu i� i� oi ou ua ue ui uo u� u� u� �i �u �i �u �i �e �i �o �e

  $al = qr/[����������������[:alpha:]]/i;

  $cc = qr/bl|br|cl|cr|dr|fl|fr|gr|tl|tr|vr/i;

  $regex = join "|", map { /(.)(.)/ ; "$1(?=$2)" } q(aa a� a� �a �� �� �a ��
           �� ae a� �e �� �� a� �� �� ao a� a� a� �o �� �� �� �� �� �� �� �u
           �� ea e� e� �a �� �� ee e� �e �� e� �� eo e� e� e� �o �� �� �� e�
           �� i� i� �a �� �� �e �� ii i� �i �� i� i� �o �� �� �� i� �u �� oa
           o� o� �a �� �� �a �� �� �a �� �� oe o� �e �� �e �� �� o� �� �i ��
           �i �� oo o� o� o� �o �� �� �� �o �� �� �o �� �� �� o� �u �� �u ��
           �u �� u� �a �� �� �e �� �i �� u� u� u� �o �� �� �� uu u� �u �� );

  @regex = (qr/$al[^�������aeiou](?=[^�������aieouh.]$al)/i,
            qr/[�������aieou](?=[^�������aieou][^|.])/i,
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
