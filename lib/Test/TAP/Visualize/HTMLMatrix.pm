#!/usr/bin/perl

package Test::TAP::Visualize::HTMLMatrix;
use fields qw/model extra petal/;

use strict;
use warnings;

use Test::TAP::Model;
use Test::TAP::Model::Visual;
use Petal;
use Carp qw/croak/;

use overload '""' => "html";

sub new {
	my $pkg = shift;

	my $model = shift || croak "must supply a model to graph";
	my $ext = shift;
	my $petal = shift || new Petal file => "template.html", input => "XHTML", output => "XHTML";

	my __PACKAGE__ $self = $pkg->fields::new;

	$self->model($model);
	$self->extra($ext);
	$self->petal($petal);
	
	$self;
}

sub title { "TAP Matrix - " . gmtime() }

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
	
__PACKAGE__

__END__

=pod

=head1 NAME

Test::TAP::Visualize::HTMLMatrix - Creates colorful matrix of L<Test::Harness>
friendly test run results using L<Test::TAP::Model>.

=head1 SYNOPSIS

	use Test::TAP::Visualize::HTMLMatrix;
	use Test::TAP::Model::Visual;

	my $model = Test::TAP::Model::Visual->new(...);

	my $v = Test::TAP::Visualize::HTMLMatrix->new($model);

	print $v->html;

=head1 DESCRIPTION

This module is a wrapper for a template and some visualization classes, that
knows to take a L<Test::TAP::Model> object, which encapsulates test results,
and produce a pretty html file.

=head1 METHODS

=over 4 new ($model, $?extra, $?petal)

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

A reasonable title for the page

=item tests

A sorted array ref, resulting from $self->model->test_files;

=back

=cut
