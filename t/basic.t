#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 6;


my $m;
BEGIN { use_ok($m = "Test::TAP::HTMLMatrix") }

use Test::TAP::Model::Visual;
my $r = Test::TAP::Model::Visual->new;

isa_ok(my $v = $m->new($r), $m);

can_ok($v, "html");

can_ok($v, "petal");
isa_ok($v->petal, "Petal");

can_ok($v, "extra");

