#!/usr/bin/perl

package Test::TAP::Model::Subtest::Visual;
use base qw/Test::TAP::Model::Subtest/;

use strict;
use warnings;

sub css_class {
	my $self = shift;
	return "x sk" if $self->skipped;
	
	my $todo = $self->todo;
	
	"x " .
	($self->actual_ok
		? ( $todo ? "u" : "p" )
		: ( $todo ? "t" : "f" ))
}

sub popup {
	my $self = shift;
	join("\n", $self->line, $self->diag);
}

sub link {
	my $self = shift;
	my $file = $self->test_file;
	$file ?  sprintf("%s#line_%d", $file, $self->test_line) : "#";
}

__PACKAGE__

__END__

=pod

=head1 NAME

Test::Tap::Model::Subtest::Visual - A subtest with additional display oriented
methods.

=head1 SYNOPSIS

	See template

=head1 DESCRIPTION

This object knows is used by the template to display per case cells, with a
class, and a link, and a tooltip.

=head1 METHODS

=over 4

=item css_class

The correct css class for a case as defined in F<testgraph.css>.

=item popup

A concatenation of the test line and it's diagnosis, used for tooltips.

=item link

Extracted from the pos:

	$file#line_$line

=back

=cut
