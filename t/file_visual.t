#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 15;

my $m;

BEGIN { use_ok($m = "Test::TAP::Model::File::Visual") }

isa_ok((bless {}, $m), "Test::TAP::Model::Colorful");
isa_ok((bless {}, $m), "Test::TAP::Model::File");

can_ok($m, "subtest_class");
like($m->subtest_class, qr/::Visual$/, "it's visual");

can_ok($m, "link");
can_ok($m, "case_rows");

can_ok($m, "str_status");

my $f= $m->new(my $r = {
	file => "foo",
});

$r->{results}{max} = 1;
$r->{results}{passing} = 1;
$r->{results}{seen} = 1;
is($f->str_status, "OK", "seen + ok = OK");

$r->{results}{max} = 2;
is($f->str_status, "FAILED", "seen != planned = FAILED");

$r->{results}{max} = 1;
$r->{results}{seen} = 0;
is($f->str_status, "FAILED", "no tests + ok = FAILED");

$r->{results}{passing} = 0;
$r->{results}{seen} = 1;
is($f->str_status, "FAILED", "seen + fail = FAILED");

$r->{results}{passing} = 1;
$r->{events}[0]{type} = "bailout";
is($f->str_status, "BAILED OUT", "seen + ok + bailout = BAILED OUT");

$r->{results}{passing} = 1;
$r->{results}{skip_all} = "foo";
$r->{events} = [];
is($f->str_status, "SKIPPED", "seen + ok + skip_all = SKIPPED");

$r->{results}{seen} = 0;
$r->{results}{skip_all} = "foo";
is($f->str_status, "SKIPPED", "no seen + ok + skip_all = SKIPPED");

