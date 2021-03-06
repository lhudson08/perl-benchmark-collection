#!/usr/bin/perl -w
# Digest::MD5 v.s. Digest::SHA1
use strict;
use warnings;
use Benchmark ':all';
use Test::More 'no_plan';
use Digest::MD5;
use Digest::SHA;

sub md5 { return( Digest::MD5::md5_hex($_[0]) ); }
sub sha { return( Digest::SHA::sha1_hex($_[0]) ); }

my $str = '794-uguisu-heiankyo';

ok( md5($str), md5($str) );
ok( sha($str), sha($str) );

cmpthese(600000, { 
	'Digest::MD5' => sub { &md5($str); },
	"Digest::SHA" => sub { &sha($str); },
});

__END__

* PowerBookG4/perl 5.10.0
                Rate Digest::SHA Digest::MD5
Digest::SHA  52910/s          --        -81%
Digest::MD5 273224/s        416%          --

* PowerBookG4/perl 5.12.0
Rate Digest::SHA Digest::MD5
Digest::SHA  58366/s          --        -82%
Digest::MD5 315789/s        441%          --

* Ubuntu 8.04 LTS/perl 5.10.1
            (warning: too few iterations for a reliable count)
                Rate Digest::SHA Digest::MD5
Digest::SHA 120000/s          --        -84%
Digest::MD5 769231/s        541%          --

* Mac OS X 10.7.5/Perl 5.14.2
                 Rate Digest::SHA Digest::MD5
Digest::SHA  191083/s          --        -85%
Digest::MD5 1250000/s        554%          --

* OpenBSD 5.2/Perl 5.12.2
                Rate Digest::SHA Digest::MD5
Digest::SHA  77320/s          --        -83%
Digest::MD5 461538/s        497%          --

