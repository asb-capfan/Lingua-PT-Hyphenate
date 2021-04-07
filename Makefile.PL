use 5.006;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Lingua::PT::Hyphenate',
    'VERSION_FROM'	=> 'lib/Lingua/PT/Hyphenate.pm', # finds $VERSION
    'PREREQ_PM'		=> {}, # e.g., Module::Name => 1.1
    'AUTHOR'     => 'Jose Alves de Castro <cog@cpan.org>',
);
