use strict;
use Test::More 0.98;
use BigOne;

unlink("./t/output.png");

my $bigone = BigOne->new(
    {input  => './t/banana.png',
     output => './t/output.png',
     type   => "banana"});

$bigone->run();

ok( -f "./t/output.png");

done_testing;

