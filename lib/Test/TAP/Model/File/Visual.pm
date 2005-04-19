#!/usr/bin/perl

package Test::TAP::Model::File::Visual;
use base qw/Test::TAP::Model::File Test::TAP::Model::Colorful/;

use strict;
use warnings;

use Test::TAP::Model::Subtest::Visual;
use URI::file;

sub subtest_class { "Test::TAP::Model::Subtest::Visual" }

sub str_status { $_[0]->ok ? "OK" : ($_[0]->bailed_out ? "BAILED OUT" : "FAILED") }

sub link { URI::file->new($_[0]->name) }

sub case_rows {
	my $self = shift;
	my @cases = $self->cases;
	my @ret;
	
	my $rows = int(.9 + @cases / 50) || 1;
	my $per_row = int(.9 + @cases / $rows);

	push @ret, { cases => [ splice(@cases, 0, $per_row) ] } while @cases;
	
	\@ret;
}

__PACKAGE__

__END__

=pod

=head1 NAME

Test::Tap::Model::File::Visual - A test file with additional display oriented
methods.

=head1 SYNOPSIS

	See the template.

=head1 DESCRIPTION

This module is a subclass of L<Test::TAP::Model::File> that provides some
methods that ease display.

It also inherits from L<Test::TAP::Model::Colorful>, which
provides additional methods.

=head1 METHODS

=over 4

=item str_status

A string, "OK" or "FAILED"

=item link

Just the name of the test. Should be overridden to contain a proper path.

=item case_rows

The test's test cases, split into rows close to 50 elements in size.

The structure returned is:


	[ { cases => [ case, case, ... ] }, { cases => [ ... ] }, ... ];

=item subtest_class

This method overrides L<Test::TAP::Model::File/subtest_class> to return
L<Test::TAP::Model::Subtest::Visual>.

=back

=cut
