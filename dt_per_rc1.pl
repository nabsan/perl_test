use strict;
use Time::Piece;
use Time::Seconds;

print "stt2","\n";

# Time::Pieceオブジェクトの取得
my $t = localtime;
# 日付や時刻の情報の取得
my $year   = $t->year;
my $month  = $t->mon;
my $mday   = $t->mday;
my $hour   = $t->hour;
my $minute = $t->minute;
my $second = $t->sec;
my $nowstr = sprintf("%04d/%02d/%02d %02d:%02d:%02d",$year,$month,$mday,$hour,$minute,$second);
print "$year/$month/$mday $hour:$minute:$second","\n";
print "nowstr=$nowstr\n";


