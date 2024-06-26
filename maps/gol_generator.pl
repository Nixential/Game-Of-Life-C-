#!/usr/bin/perl
use strict;
use warnings;

my $ROWS = 100;
my $COLS = 100;

# Main subroutine to generate the map
sub generate_map {
    my ($type) = @_;
    my @map = map { [(0) x $COLS] } (1 .. $ROWS);

    if ($type eq 'glider') {
        setup_glider(\@map);
    } elsif ($type eq 'blinker') {
        setup_blinker(\@map);
    } elsif ($type eq 'toad') {
        setup_toad(\@map);
    } elsif ($type eq 'beacon') {
        setup_beacon(\@map);
    } elsif ($type eq 'spaceship') {
        setup_spaceship(\@map);
    } elsif ($type eq 'pulsar') {
        setup_pulsar(\@map);
    } elsif ($type eq 'gosper_glider_gun') {
        setup_gosper_glider_gun(\@map);
    } else {
        print "Unknown structure type: $type\n";
        exit;
    }

    print_map(\@map);
}


# Subroutine to set up a glider
sub setup_glider {
    my ($map_ref) = @_;
    $map_ref->[2][1] = 1;
    $map_ref->[3][2] = 1;
    $map_ref->[1][3] = $map_ref->[2][3] = $map_ref->[3][3] = 1;
}

# Subroutine to set up a blinker
sub setup_blinker {
    my ($map_ref) = @_;
    $map_ref->[1][1] = $map_ref->[1][2] = $map_ref->[1][3] = 1;
}

# Subroutine to set up a toad
sub setup_toad {
    my ($map_ref) = @_;
    $map_ref->[2][2] = $map_ref->[2][3] = $map_ref->[2][4] = 1;
    $map_ref->[3][1] = $map_ref->[3][2] = $map_ref->[3][3] = 1;
}

# Subroutine to set up a beacon
sub setup_beacon {
    my ($map_ref) = @_;
    # First square
    $map_ref->[1][1] = $map_ref->[1][2] = 1;
    $map_ref->[2][1] = $map_ref->[2][2] = 1;
    # Second square
    $map_ref->[3][3] = $map_ref->[3][4] = 1;
    $map_ref->[4][3] = $map_ref->[4][4] = 1;
}

# Subroutine to set up a spaceship (specifically, a lightweight spaceship)
sub setup_spaceship {
    my ($map_ref) = @_;
    $map_ref->[1][2] = $map_ref->[1][3] = $map_ref->[1][4] = $map_ref->[1][5] = 1;
    $map_ref->[2][1] = $map_ref->[2][5] = 1;
    $map_ref->[3][5] = 1;
    $map_ref->[4][1] = $map_ref->[4][4] = 1;
}

# Subroutine to set up a pulsar
sub setup_pulsar {
    my ($map_ref) = @_;
    my @pulsar_points = (
        [2,4],[2,5],[2,6],[2,10],[2,11],[2,12],
        [4,2],[5,2],[6,2],[4,7],[5,7],[6,7],[4,9],[5,9],[6,9],[4,14],[5,14],[6,14],
        [7,4],[7,5],[7,6],[7,10],[7,11],[7,12],
        [9,4],[9,5],[9,6],[9,10],[9,11],[9,12],
        [10,2],[11,2],[12,2],[10,7],[11,7],[12,7],[10,9],[11,9],[12,9],[10,14],[11,14],[12,14],
        [14,4],[14,5],[14,6],[14,10],[14,11],[14,12]
    );
    foreach my $point (@pulsar_points) {
        $map_ref->[$point->[0]][$point->[1]] = 1;
        # Mirror horizontally
        $map_ref->[14 - $point->[0] + 2][$point->[1]] = 1;
        # Mirror vertically
        $map_ref->[$point->[0]][14 - $point->[1] + 2] = 1;
        # Mirror both horizontally and vertically
        $map_ref->[14 - $point->[0] + 2][14 - $point->[1] + 2] = 1;
    }
}

sub print_map {
    my ($map_ref) = @_;
    foreach my $row (@$map_ref) {
        foreach my $cell (@$row) {
            print $cell ? '1' : '0';
        }
        print "\n";
    }
}

# Subroutine to set up a Gosper glider gun
sub setup_gosper_glider_gun {
    my ($map_ref) = @_;

    my @gun = (
        [1, 25],
        [2, 23], [2, 25],
        [3, 13], [3, 14], [3, 21], [3, 22], [3, 35], [3, 36],
        [4, 12], [4, 16], [4, 21], [4, 22], [4, 35], [4, 36],
        [5, 1], [5, 2], [5, 11], [5, 17], [5, 21], [5, 22],
        [6, 1], [6, 2], [6, 11], [6, 15], [6, 17], [6, 18], [6, 23], [6, 25],
        [7, 11], [7, 17], [7, 25],
        [8, 12], [8, 16],
        [9, 13], [9, 14]
    );

    foreach my $point (@gun) {
        $map_ref->[$point->[0]][$point->[1]] = 1;
    }
}


# Check for command-line arguments
die "Usage: $0 <structure type>\n" unless @ARGV == 1;

# Generate and print the map with the given structure
generate_map($ARGV[0]);
