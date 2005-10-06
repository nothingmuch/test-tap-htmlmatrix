#!/usr/bin/perl

use strict;
use warnings;

use Test::TAP::HTMLMatrix;
use Test::TAP::Model::Visual;
use Test::TAP::Model::Consolidated;

my $model_ok = Test::TAP::Model::Visual->new_with_tests(glob("t/*.t"));
$model_ok->desc_string("real run");
my $model_failing = do { local $ENV{TEST_FAIL_RANDOMLY} = 1; Test::TAP::Model::Visual->new_with_tests(glob("t/*.t")) };
$model_failing->desc_string("dummy failures");

#open STDOUT, ">", "example.html"; #"|xmllint --noblanks -> example.html" or die "couldn't pipe to xmllint";

my $v = Test::TAP::HTMLMatrix->new(Test::TAP::Model::Consolidated->new($model_ok, $model_failing));

my $t = times;

$v->has_inline_css(1);
#$v->no_javascript(1);

$v->output_dir("output/");
#print $v->summary_html;
#print $v->detail_html;

print STDERR "open example.html\n";

print STDERR "Generating HTML took" . (times() - $t) . "\n";

