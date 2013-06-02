requires 'Carp';
requires 'Class::Data::Inheritable';
requires 'Class::ISA';
requires 'List::MoreUtils';

on 'test' => sub {
    requires 'Test::More';
    requires 'Test::Exception';
};
