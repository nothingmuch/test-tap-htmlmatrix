#!/usr/bin/perl

package Test::TAP::Model::Visual;
use base qw/Test::TAP::Model Test::TAP::Model::Colorful/;

use strict;
use warnings;

use Test::TAP::Model::File::Visual;

sub file_class { "Test::TAP::Model::File::Visual" }

sub summary {
	my $self = shift;
	$self->{_summar} ||=
	sprintf "%d test cases: %d ok, %d failed, %d todo,"
			."%d skipped and %d unexpectedly succeeded",
			map { my $m = "total_$_"; $self->$m }
			qw/seen passed failed todo skipped unexpectedly_succeeded/;
}

__PACKAGE__

__END__

=pod

=head1 NAME

Test::TAP::Model::Visual - A result set that will create ::Visual children, and
knows it's color.

=head1 SYNOPSIS

	See template

=head1 DESCRIPTION

It inherits from L<Test::TAP::Model::Colorful>. That's about it.

=head1 METHODS

=over 4

=item file_class

This is actually the only functionality. This method is overridden to return
L<Test::TAP::Model::File::Visual>. See L<Test::TAP::Model/file_class> for
details.

=item summary

A nice little textual summary about the result of the entire test run.

=back

=cut
