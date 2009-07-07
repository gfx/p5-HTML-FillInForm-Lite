#!perl

use strict;
use warnings;
use Test::More;

BEGIN{
	require utf8; # probably noop
	if(not defined &utf8::is_utf8){
		plan skip_all => "require utf8::is_utf8()";
	}
	else{
		plan tests => 4;
	}
}

use encoding 'Shift_JIS';

BEGIN{ use_ok('HTML::FillInForm::Lite') }

use FindBin qw($Bin);
my $file = "$Bin/test_sjis.html";

my $o = HTML::FillInForm::Lite->new();

my $u1  = "\xe9p\xe9k";         # "camel" in Japanese kanji    (Shift_JIS)
my $u2  = "\x83\x89\x83N\x83_"; # "camel" in Japanese katakana (Shift_JIS)

like $o->fill($file, { camel => $u1 }, layer => ':encoding(Shift_JIS)'),
	qr{name="camel" \s+ value="$u1"}xms, "Unicode value";

like $o->fill($file, { $u2 => 'camel' }, layer => ':encoding(Shift_JIS)'),
	qr{name="$u2" \s+ value="camel"}xms, "Unicode name";

like $o->fill($file, { $u2 => $u1 }, layer => ':encoding(Shift_JIS)'),
	qr{value="$u1"}, "Unicode name/value";
