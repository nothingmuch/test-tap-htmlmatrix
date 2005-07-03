#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 4;

use Test::TAP::Model::Visual;

my $m; BEGIN { use_ok($m = "Test::TAP::HTMLMatrix") };

my $s = Test::TAP::Model::Visual->new;

my $f = $s->start_file("foo");
eval { $f->{results} = { $s->analyze("foo", [split /\n/, <<TAP]) } };
1..6
ok 1 foo
not ok 2 bar
ok 3 gorch # skip foo
ok 4 # TODO bah
not ok 5 # TODO ding
Bail out!
TAP

isa_ok(my $t = $m->new($s, "blah"), $m);

$t->has_inline_css(1);

my $html = $t->detail_html;

like($html, qr/<style/, "HTML contains style tag");

like($html, qr/background-color/,  "document contains typical CSS string");

