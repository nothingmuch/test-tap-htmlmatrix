#!/usr/bin/perl

use strict;
use warnings;

use Test::TAP::HTMLMatrix;
use Test::TAP::Model::Visual;
use Test::TAP::Model::Consolidated;

my $model_ok = Test::TAP::Model::Visual->new_with_tests(glob("t/*.t"));
my $model_failing = do { local $ENV{TEST_FAIL_RANDOMLY} = 1; Test::TAP::Model::Visual->new_with_tests(glob("t/*.t")) };

open STDOUT, ">", "example.html"; #"|xmllint --noblanks -> example.html" or die "couldn't pipe to xmllint";

my $v = Test::TAP::HTMLMatrix->new(Test::TAP::Model::Consolidated->new($model_ok, $model_failing));

$v->has_inline_css(1);

print "$v";

print STDERR "open example.html\n";

