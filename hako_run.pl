
use strict;
use Hako;

print "stt\n";
my $h = Hako->new(stttime => '2018/07/25 03:00:00', endtime => '2018/07/28 13:00:00', qty => 300);
print "stttime=:\t".$h->{ stttime },"\n";
print "endtime=:\t".$h->{ endtime },"\n";
print "qty:\t".$h->{ qty },"\n";
$h->calc();
print "calc222': ". $h->{res_hash} ,"\n ";
foreach my $a(keys  $h->{res_hash}){ print $a,"\n";}
print "end\n";