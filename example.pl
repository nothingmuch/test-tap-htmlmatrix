#!/usr/bin/perl

use Test::TAP::HTMLMatrix;
use Test::TAP::Model::Visual;

my $model = Test::TAP::Model::Visual->new_with_tests(glob("t/*.t"));

open STDOUT, ">", "example.html"; #"|xmllint --noblanks -> example.html" or die "couldn't pipe to xmllint";

my $v = Test::TAP::HTMLMatrix->new($model);

$v->has_inline_css(1);

print "$v";

print STDERR "open example.html\n";

