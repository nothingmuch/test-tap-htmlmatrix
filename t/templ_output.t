#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 26;

use Test::TAP::Model::Visual;

# TODO
# use some kind of XML test module (They were all veeerrry slow)

my $m;
BEGIN { use_ok($m = "Test::TAP::HTMLMatrix") }

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

isa_ok(my $t = $m->new($s, "extra"), $m);

for my $no_js (1, 0) {
	$t->no_javascript($no_js);
	my $html = "$t";

	like($html, qr{<html.*/html>}s, "has <html> tags");

	like($html, qr/ok 1 foo/, "contains subtest 1 line");
	like($html, qr/not ok 2 bar/, "subtest 2 line");
	like($html, qr/ok 3 gorch/, "subtest 3 line");

	like($html, qr/66.6\d%/, "contains percentage");

	like($html, qr/BAILED OUT/, "something bailed out in there");

	like($html, qr/4\s+ok/is, "ok summary");
	like($html, qr/2\s+failed/is, "contains fail summary");
	like($html, qr/1\s+skipped/is, "contains skip summary");
	like($html, qr/2\s+todo/is, "contains skip summary");
	like($html, qr/1\s+unexpectedly\s+succeeded/is, "contains skip summary");

	like($html, qr/6/, "the number 6 is mentioned, that was our plan");
}
