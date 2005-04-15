#!/usr/bin/perl

package Test::TAP::HTMLMatrix;
use fields qw/model extra petal/;

use strict;
use warnings;

use Test::TAP::Model::Visual;
use Petal;
use Carp qw/croak/;
use File::Spec;

use overload '""' => "html";

our $VERSION = "0.01";

sub new {
	my $pkg = shift;

	my $model = shift || croak "must supply a model to graph";

	my __PACKAGE__ $self = $pkg->fields::new;

	my $ext = shift;
	my $petal = shift || new Petal file => $self->template_file, input => "XHTML", output => "XHTML";

	$self->model($model);
	$self->extra($ext);
	$self->petal($petal);
	
	$self;
}

sub title { "TAP Matrix - " . gmtime() . " GMT" }

sub tests {
	my $self = shift;
	[ sort { $a->name cmp $b->name } $self->model->test_files ];
}

sub model {
	my __PACKAGE__ $self = shift;
	$self->{model} = shift if @_;
	$self->{model};
}

sub extra {
	my __PACKAGE__ $self = shift;
	$self->{extra} = shift if @_;
	$self->{extra};
}

sub petal {
	my __PACKAGE__ $self = shift;
	$self->{petal} = shift if @_;
	$self->{petal};
}

sub html {
	my __PACKAGE__ $self = shift;
	$self->{petal}->process(page => $self);
}

sub _find_in_INC {
	my $self = shift;
	my $file = shift;

	foreach my $str (grep { not ref } @INC){
		my $target = File::Spec->catfile($str, $file);
		return $target if -e $target;
	}
}

sub _find_in_my_INC {
	my $self = shift;
	$self->_find_in_INC(File::Spec->catfile(split("::", __PACKAGE__), shift));
}

sub template_file {
	my $self = shift;
	$self->_find_in_my_INC("template.html");
}

sub css_file {
	my $self = shift;
	$self->_find_in_my_INC("htmlmatrix.css");
}

__PACKAGE__

__END__

=pod

=head1 NAME

Test::TAP::HTMLMatrix - Creates colorful matrix of L<Test::Harness>
friendly test run results using L<Test::TAP::Model>.

=head1 SYNOPSIS

	use Test::TAP::HTMLMatrix;
	use Test::TAP::Model::Visual;

	my $model = Test::TAP::Model::Visual->new(...);

	my $v = Test::TAP::HTMLMatrix->new($model);

	print $v->html;

=head1 DESCRIPTION

This module is a wrapper for a template and some visualization classes, that
knows to take a L<Test::TAP::Model> object, which encapsulates test results,
and produce a pretty html file.

=head1 METHODS

=over 4

=item new ($model, $?extra, $?petal)

$model is the L<Test::TAP::Model> object to extract results from, and the
optional $?extra is a string to put in <pre></pre> at the top.

$petal is an optional templater object. If you are not happy with the default
template, you can use this. Read the source to see how it's processed.

=item html

Returns an HTML string.

This is also the method implementing stringification.

=item model

=item extra

=item petal

Just settergetters. You can override these for added fun.

=item title

A reasonable title for the page:

	"TAP Matrix - <gmtime>"

=item tests

A sorted array ref, resulting from $self->model->test_files;

=item template_file

=item css_file

These return the full path to the L<Petal> template and the CSS stylesheet it
uses.

Note that these are taken from @INC. If you put F<template.html> under
C< catfile(qw/Test TAP HTMLMatrix/) > somewhere in your @INC, it should find it
like you'd expect.

=back

=head1 AUTHORS

This list was generated from svn log testgraph.pl and testgraph.css in the pugs
repo, sorted by last name.

=over 4

=item *

Michal Jurosz

=item *

Yuval Kogman <nothingmuch@woobling.org> NUFFIN

=item *

Max Maischein <corion@cpan.org> CORION

=item *

James Mastros <james@mastros.biz> JMASTROS

=item *

Scott McWhirter <scott-cpan@NOSPAMkungfuftr.com> KUNGFUFTR

=item *

putter (svn handle)

=item *

Autrijs Tang <autrijus@autrjius.org> AUTRIJUS

=item *

Gaal Yahas <gaal@forum2.org> GAAL

=back

=head1 COPYRIGHT & LICNESE

	Copyright (c) 2005 the aforementioned authors. All rights
	reserved. This program is free software; you can redistribute
	it and/or modify it under the same terms as Perl itself.

=cut
