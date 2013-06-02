package Trait::Premise::Ensurer;
use 5.014;
use utf8;
use warnings;

use Carp qw(croak);
use Class::ISA;
use Exporter qw(import);
use List::MoreUtils qw(uniq);

our @EXPORT_OK = qw(ensure);

sub ensure {
    my $class = shift;
    my %implements = map { $_ => 1 } Class::ISA::super_path($class);
    my @unimplemented = grep { @{$_->{unimplemented}} > 0 }
                        map  {+{
                            type => $_,
			    unimplemented => [
                                grep { not $implements{$_} } $_->premise
                            ],
                        }}
                        grep { $_->isa('Trait::Premise') }
                             keys %implements;

    if (@unimplemented) {
        croak sprintf(
	    'missing `use parent qw(%s);` at %s.(%s)',
	    join(', ', uniq(map { @{$_->{unimplemented}} } @unimplemented)),
	    $class,
	    join('. ', map {
		           sprintf(
                               '%s requires %s',
			       $_->{type},
			       join(', ', @{$_->{unimplemented}})
			   )
		       } @unimplemented)
       );
    }
}

1;
