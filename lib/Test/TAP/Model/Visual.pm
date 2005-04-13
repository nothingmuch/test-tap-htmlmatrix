#!/usr/bin/perl

package Test::TAP::Model::Visual;
use base qw/Test::TAP::Model Test::TAP::Visualize::HTMLMatrix::Colorful/;

use strict;
use warnings;

use Test::TAP::Model::File::Visual;

sub file_class { "Test::TAP::Model::File::Visual" }

__PACKAGE__

__END__

=pod

=head1 NAME

Test::TAP::Model::Visual - A result set that will create ::Visual children, and
knows it's color.

=head1 SYNOPSIS

	See template

=head1 DESCRIPTION


It inherits from L<Test::TAP::Visualize::HTMLMatrix::Colorful>. That's about it.

=cut
