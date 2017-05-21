package BigOne;
use 5.008001;
use strict;
use warnings;
use Imager;
use Image::ObjectDetect;

our $VERSION = "0.01";

use Class::Accessor::Lite (
    new => 1,
    rw  => [],
    ro  => [ qw(input output type) ],
    wo  => [],
);

sub run{
    my $self = shift;

    my $image = Imager->new->read(file => $self->input);
    my $cascade = sprintf('cascades/%s.xml', $self->type);
    my $detector = Image::ObjectDetect->new($cascade);
    my @objects = $detector->detect($image);
    my $font_filename = 'fontfiles/ipagp.ttf';
    my $font = Imager::Font->new(file=>$font_filename)
    or die "Cannot load $font_filename: ", Imager->errstr;

    my @sorted = sort{ $a->width * $a->height <=> $b->width * $b->height}@objects;
    my $rank = 1;
    for my $object (@sorted){
        $font->align(string => $rank++,
               size => 12,
               color => 'red',
               x => $object->{x},
               y => $object->{y},
               halign => 'center',
               valign => 'center',
               image => $image);
}

$image->write(file => $self->output);  

}

1;
__END__

=encoding utf-8

=head1 NAME

BigOne - Rank by the objects by size in photo.

=head1 SYNOPSIS

    use BigOne;

=head1 DESCRIPTION

BigOne is ...

=head1 LICENSE

Copyright (C) dokechin.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

dokechin E<lt>ttatsumi@ra2.so-net.ne.jpE<gt>

=cut

