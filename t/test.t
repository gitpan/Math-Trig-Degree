use Test;

BEGIN { plan tests => 40 };

use Math::Trig::Degree qw(dsin dcos tan sec csc cot asin acos atan asec acsc acot sinh cosh tanh sech csch coth asinh acosh atanh asech acsch acoth deg_to_rad rad_to_deg);

ok(1);

test_to_from( 0, 45, 90 );

sub test_to_from {
    my @range = @_;
    for my $x ( @range ) {
        ok( asin(dsin($x)), $x );
        ok( acos(dcos($x)), $x );
        ok( atan(tan($x)), $x );
        ok( asec(sec($x)), $x );
        ok( acsc(csc($x)), $x );
        ok( acot(cot($x)), $x );
        ok( asinh(sinh($x)), $x );
        ok( acosh(cosh($x)), $x );
        ok( atanh(tanh($x)), $x );
        ok( asech(sech($x)), $x );
        ok( acsch(csch($x)), $x );
        ok( acoth(coth($x)), $x );
        ok( rad_to_deg(deg_to_rad($x)), $x );
    }
}

