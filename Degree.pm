package Math::Trig::Degree;

require Exporter;

use vars qw( @ISA @EXPORT_OK $VERSION $RADIANS );
$VERSION = '0.01';
@ISA=qw(Exporter);
@EXPORT_OK=qw(
    dsin    asin
    dcos    acos
    tan     atan
    sec     asec
    csc     acsc
    cot     acot
    sinh    asinh
    cosh    acosh
    tanh    atanh
    sech    asech
    csch    acsch
    coth    acoth
    deg_to_rad rad_to_deg
    );

BEGIN { $pi = 3.1415926535897932384626433832795028841971693993751058209;
        $inf = exp(1000000);
        $RADIANS = 0
      }

# this sub is used to check for edge cases where an illegal division
# by zero would occur or the correct return value is infinity
sub div_zero {
    my ( $angle, $offset ) = @_;
    $offset ||= 0;
    if ( $RADIANS ) {
      return ((rad_to_deg($angle) + $offset) % 180 ) ? 1 : 0;
    }
    else {
      return (($angle + $offset) % 180 ) ? 1 : 0;
    }
}

sub deg_to_rad { my $x=$_[0]; return $RADIANS ? $x : ($x/180) * $pi }

sub rad_to_deg { my $x=$_[0]; return $RADIANS ? $x : ($x/$pi) * 180 }

sub dsin { my $x=$_[0];  $x=deg_to_rad($x); return div_zero($_[0]) ? sin($x) : 0 }

sub dcos { my $x=$_[0];  $x=deg_to_rad($x); return cos($x) }

sub tan { my $x=$_[0]; $x=deg_to_rad($x); return div_zero($_[0], 90) ? sin($x)/cos($x) : $inf; }

sub sec { my $x=$_[0]; $x=deg_to_rad($x); return div_zero($_[0], 90) ? 1/cos($x) : $inf; }

sub csc { my $x=$_[0]; $x=deg_to_rad($x); return div_zero($_[0]) ? 1/sin($x) : $inf; }

sub cot { my $x=$_[0]; $x=deg_to_rad($x); return div_zero($_[0]) ? cos($x)/sin($x) : $inf; }

sub asin { my $x=$_[0]; return ($x<-1 or $x>1) ? undef : rad_to_deg( atan2($x,sqrt(1-$x*$x)) ); }

sub acos { my $x=$_[0]; return ($x<-1 or $x>1) ? undef : rad_to_deg( atan2(sqrt(1-$x*$x),$x) ); }

sub atan {
    my $x=$_[0];
    if ($x==0) {
  return 0;
    } elsif ($x>0) {
  return rad_to_deg( atan2(sqrt(1+$x*$x),sqrt(1+1/($x*$x))) );
    } else {
  return ( $RADIANS ? $pi : 180 ) - rad_to_deg( atan2(sqrt(1+$x*$x),sqrt(1+1/($x*$x))) );
    }
}

sub asec { my $x=$_[0]; return ( $x==0 or ($x>-1 and $x<1) ) ? undef : acos(1/$x); }

sub acsc { my $x=$_[0]; return ( $x==0 or ($x>-1 and $x<1) ) ? undef : asin(1/$x); }

sub acot {
    my $x=$_[0];
    if ($x==0) {
  return $RADIANS ? $pi/2 : 90;
    } else {
  return atan(1/$x);
    }
}

sub sinh { my $x=$_[0]; $x=deg_to_rad($x); return (exp($x)-exp(-$x))/2; }

sub cosh { my $x=$_[0]; $x=deg_to_rad($x); return (exp($x)+exp(-$x))/2; }

sub tanh {
    my $x=$_[0];
    $x=deg_to_rad($x);
    my($ep,$em) = (exp($x),exp(-$x));
    if ($ep == $inf) {
  return 1;
    } elsif ($em == $inf) {
  return -1;
    } else {
  return ($ep-$em)/($ep+$em);
    }
}

sub sech { my $x=$_[0]; $x=deg_to_rad($x); return 2/(exp($x)+exp(-$x)); }

sub csch { my $x=$_[0]; $x=deg_to_rad($x); return ($x==0) ? $inf : 2/(exp($x)-exp(-$x)); }

sub coth {
    my $x=$_[0];
    $x=deg_to_rad($x);
    my($ep,$em) = (exp($x),exp(-$x));
    if ($x==0) {
  return $inf;
    } elsif ($ep == $inf) {
  return 1;
    } elsif ($em == $inf) {
  return -1;
    } else {
  return (exp($x)+exp(-$x))/(exp($x)-exp(-$x));
    }
}

sub asinh { my $x=$_[0]; return rad_to_deg(log($x+sqrt(1+$x*$x))); }

sub acosh { my $x=$_[0]; return ($x<1) ? $inf : asinh(sqrt($x*$x-1)); }  # Returns positive value only!

sub atanh { my $x=$_[0]; return ( $x<=-1 or $x>=1) ? $inf : asinh($x/sqrt(1-$x*$x)); }

sub asech { my $x=$_[0]; return ( $x<=0 or $x>1 ) ? $inf : asinh(sqrt(1-$x*$x)/$x); }  # Returns positive value only!

sub acsch { my $x=$_[0]; return ( $x==0 ) ? $inf : asinh(1/$x); }

sub acoth {
    my $x=$_[0];
    if ($x>=-1 and $x<=1) {
  return $inf;
    } elsif ($x<-1) {
  return -asinh(1/sqrt($x*$x-1));
    } else {
  return asinh(1/sqrt($x*$x-1));
    }
}

1;

__END__

=head1 NAME

    Math::Trig::Degree - Inverse and hyperbolic trigonemetric Functions
                         in degrees or radians

=head1 SYNOPSIS

    use Math::Trig::Degree qw(dsin dcos tan sec csc cot asin acos atan asec acsc acot sinh cosh tanh sech csch coth asinh acosh atanh asech acsch acoth deg_to_rad rad_to_deg);
    $v = dsin($x);
    $v = dcos($x);
    $v = tan($x);
    $v = sec($x);
    $v = csc($x);
    $v = cot($x);
    $v = asin($x);
    $v = acos($x);
    $v = atan($x);
    $v = asec($x);
    $v = acsc($x);
    $v = acot($x);
    $v = sinh($x);
    $v = cosh($x);
    $v = tanh($x);
    $v = sech($x);
    $v = csch($x);
    $v = coth($x);
    $v = asinh($x);
    $v = acosh($x);
    $v = atanh($x);
    $v = asech($x);
    $v = acsch($x);
    $v = acoth($x);
    $degrees = rad_to_deg($radians);
    $radians = deg_to_rad($degrees);

    # to use radians instead of degrees
    $Math::Trig::Degree::RADIANS = 1;

=head1 DESCRIPTION

This module exports the missing inverse and hyperbolic trigonometric
functions of real numbers.  The inverse functions return values
cooresponding to the principal values.  Specifying an argument outside
of the domain of the function where an illegal divion by zero would occur
will cause infinity to be returned. Infinity is Perl's version of this.

This module implements the functions in degrees by default. If you want
radians use Math::Trig or set the $RADIANS var:

    $Math::Trig::Degree::RADIANS = 1;

A value of Pi to 30 decimal places is used in the source. This
will be truncated by your version of Perl to the longest float supported.

To avoid redefining the internal sin() and cos() functions we use dsin() and
dcos() for the degree based variants. You can use either if you set $RADIANS.

=head3 dsin

returns sin of real argument.

=head3 dcos

returns cos of real argument.

=head3 tan

returns tangent of real argument.

=head3 sec

returns secant of real argument.

=head3 csc

returns cosecant of real argument.

=head3 cot

returns cotangent of real argument.

=head3 asin

returns inverse sine of real argument.

=head3 acos

returns inverse cosine of real argument.

=head3 atan

returns inverse tangent of real argument.

=head3 asec

returns inverse secant of real argument.

=head3 acsc

returns inverse cosecant of real argument.

=head3 acot

returns inverse cotangent of real argument.

=head3 sinh

returns hyperbolic sine of real argument.

=head3 cosh

returns hyperbolic cosine of real argument.

=head3 tanh

returns hyperbolic tangent of real argument.

=head3 sech

returns hyperbolic secant of real argument.

=head3 csch

returns hyperbolic cosecant of real argument.

=head3 coth

returns hyperbolic cotangent of real argument.

=head3 asinh

returns inverse hyperbolic sine of real argument.

=head3 acosh

returns inverse hyperbolic cosine of real argument.

(positive value only)

=head3 atanh

returns inverse hyperbolic tangent of real argument.

=head3 asech

returns inverse hyperbolic secant of real argument.

(positive value only)

=head3 acsch

returns inverse hyperbolic cosecant of real argument.

=head3 acoth

returns inverse hyperbolic cotangent of real argument.

=head1 HISTORY

Modification of Math::Trig by request from stefan_k.

=head1 BUGS

Because of the limit on the accuracy of the vaule of Pi that is easily
supported via a float you will get values like dsin(30) = 0.49999999999999945

Let me know about any others.

=head1 AUTHOR

Initial Version John A.R. Williams <J.A.R.Williams@aston.ac.uk>
Bug fixes and many additonal functions Jason Smith <smithj4@rpi.edu>
This version James Freeman <james.freeman@id3.org.uk>

=cut




