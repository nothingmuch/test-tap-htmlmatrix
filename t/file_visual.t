#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 7;

my $m;

BEGIN { use_ok($m = "Test::TAP::Model::File::Visual") }

isa_ok((bless {}, $m), "Test::TAP::Model::Colorful");
isa_ok((bless {}, $m), "Test::TAP::Model::File");

can_ok($m, "subtest_class");
like($m->subtest_class, qr/::Visual$/, "it's visual");

can_ok($m, "link");
can_ok($m, "case_rows");

