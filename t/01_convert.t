use strict;
use Test::More 0.98;
use BigOne;
use Cwd 'abs_path';

my $input = abs_path("./t/children.jpg");
my $output = abs_path("./t/output.jpg");

unlink($output);

my $bigone = BigOne->new(
    {input  => $input,
     output => $output,
     type   => "haarcascade_mcs_mouth"});

$bigone->run();

ok( -f $output);

done_testing;

