package Trait::Premise;
use 5.014;
use utf8;
use warnings;

use parent qw(Class::Data::Inheritable);
use List::MoreUtils qw(uniq);

__PACKAGE__->mk_classdata(_premise => []);
sub premise {
    my ($class, @types) = @_;
    return @{$class->_premise} unless @types;

    $class->_premise(\@types);
}

1;
