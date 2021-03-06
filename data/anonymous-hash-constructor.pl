#!/usr/bin/perl -w
# +{} v.s. {}
use strict;
use warnings;
use Benchmark ':all';
use Test::More 'no_plan';

sub plusbrace { 
    my $x = shift; 
    my $y = +{ 'x' => $x }; 
    my $z = +{ 'z' => $y->{'x'} };

    return +{ 'y' => ( $y->{'x'} + $z->{'z'} ) };
}

sub braceonly { 
    my $x = shift; 
    my $y = { 'x' => $x }; 
    my $z = { 'z' => $y->{'x'} };

    return { 'y' => ( $y->{'x'} + $z->{'z'} ) };
}

isa_ok( plusbrace(1), 'HASH' );
isa_ok( braceonly(1), 'HASH' );

cmpthese(500000, { 
    '+{}' => sub { &plusbrace(1) }, 
    ' {}' => sub { &braceonly(1) }, 
});

__END__

* Mac OS X 10.9.5/Perl 5.20.1
        Rate +{}  {}
+{} 467290/s  -- -2%
 {} 476190/s  2%  --

* PowerBookG4/perl 5.8.8
        Rate +{}  {}
+{} 314465/s  -- -4%
 {} 328947/s  5%  --

* PowerBookG4/perl 5.10.0
        Rate  {} +{}
 {} 226244/s  -- -1%
+{} 228311/s  1%  --

* PowerBookG4/perl 5.12.0
        Rate  {} +{}
 {} 282486/s  -- -2%
+{} 289017/s  2%  --

* Ubuntu 8.04 LTS/perl 5.10.1
        Rate  {} +{}
 {} 218341/s  -- -2%
+{} 222222/s  2%  --

* Mac OS X 10.7.5/Perl 5.14.2
        Rate  {} +{}
 {} 396825/s  -- -2%
+{} 406504/s  2%  --

* OpenBSD 5.2/Perl 5.12.2
        Rate +{}  {}
+{} 170068/s  -- -3%
 {} 174825/s  3%  --

