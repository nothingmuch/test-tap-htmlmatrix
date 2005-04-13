#!/usr/bin/perl

use Test::TAP::Visualize::HTMLMatrix;
use Test::TAP::Model::Visual;

my $model = Test::TAP::Model::Visual->new_with_tests(glob("t/*.t"));

open STDOUT, "|xmllint --noblanks -> example.html" or die "couldn't pipe to xmllint";

print Test::TAP::Visualize::HTMLMatrix->new($model);

print STDERR "open example.html\n";

