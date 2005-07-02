#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 7;

use File::Spec;

my $m;
BEGIN { use_ok($m = "Test::TAP::HTMLMatrix") }

my $template = $m->template_file;

ok(-e $template, "template file exists");
like($template, qr/detailed_view\.html$/, "name looks OK");
ok(File::Spec->file_name_is_absolute($template), "abs path");

my $css = $m->css_file;

ok(-e $css, "css file exists");
like($css, qr/htmlmatrix\.css$/, "name looks OK");
ok(File::Spec->file_name_is_absolute($css), "abs path");

