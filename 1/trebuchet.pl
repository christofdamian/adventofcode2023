#!/bin/perl

sub to_number {
    my ($string) = @_;
    print "$string\n";

    if ($string =~ /^\d$/) {
        return $string;
    }
    if ($string eq "one") {
        return 1;
    }
    if ($string eq "two") {
        return 2;
    }
    if ($string eq "three") {
        return 3;
    }
    if ($string eq "four") {
        return 4;
    }
    if ($string eq "five") {
        return 5;
    }
    if ($string eq "six") {
        return 6;
    }
    if ($string eq "seven") {
        return 7;
    }
    if ($string eq "eight") {
        return 8;
    }
    if ($string eq "nine") {
        return 9;
    }
}

$sum = 0;
while (<>) {
    print;

    ($right) = /^.*(\d|one|two|three|four|five|six|seven|eight|nine)/;
    ($left) = /(\d|one|two|three|four|five|six|seven|eight|nine).*$/;

    print "$left $right\n";

    $left = to_number($left);
    $right = to_number($right);

    print "$left $right\n";

    $sum += "$left$right";
}
print "$sum\n";
