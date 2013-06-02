use 5.014;
use utf8;
use warnings;

use Test::More;
my $class;
BEGIN {
    use_ok($class='Trait::Premise::Ensurer', qw(ensure));
}
use Test::Exception;

# ----
# Helpers.
{
    package Base;
    use Trait::Premise::Ensurer qw(ensure);

    sub new {
	my $class = shift;
	ensure($class);
	return bless {}, $class;
    }
}

{
    package Foo;
}
{
    package Bar;
    use parent qw(Trait::Premise);
    __PACKAGE__->premise(qw(Foo));
}
{
    package Sufficient;
    our @ISA=qw(Base Foo Bar);
}
{
    package Unsufficient;
    our @ISA=qw(Base Bar);
}

# ----
# Test
lives_ok { Sufficient->new() } 'suffcient';
dies_ok { Unsufficient->new() } 'unsufficient';

# ----
done_testing;
