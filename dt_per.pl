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

#--------------base---------------------
my $qty=100;
my $stt = "2018/07/25 18:00:00";
my $end = "2018/07/28 02:00:00";
my $hose2 = 1*60*60;

my $tt1= Time::Piece->strptime($stt, "%Y/%m/%d %H:%M:%S");
my $tt2= Time::Piece->strptime($end, "%Y/%m/%d %H:%M:%S");
my $sa_s = $tt2-$tt1;
print "sa_(h)=". $sa_s/60/60,"\n";
my $our_days = int(($sa_s/60/60 / 24)+1); 
my $sa_s_with_hose2 = $sa_s - ($hose2*$our_days);
my $sa_m_with_hose2 = $sa_s_with_hose2/60;
print $our_days,"\n";
print $sa_s_with_hose2/60/60," hours without hose2\n";
print $sa_m_with_hose2," min without hose2\n";
#------------------------------------------
#----------------------loop-----------------
#開始日０時
my $stt0=$tt1->strftime("%Y/%m/%d") . " 00:00:00";
my $day0= Time::Piece->strptime($stt0, "%Y/%m/%d %H:%M:%S");

my $i;
my %hash=();
for ($i=1; $i<=($our_days+1) ;$i++){
   if ($day0 <= $tt1){
   	  #初日
   	  my $run_time_min= (($day0+ONE_DAY*1)-$tt1-$hose2)/60 ;
	  print "first $run_time_min ? $i  $day0 \n";
	  print "   |-". $run_time_min/$sa_m_with_hose2." \n";
	  print "   |-". $qty * ($run_time_min/$sa_m_with_hose2)." \n";
	  $hash{$day0->strftime("%Y/%m/%d")}="type"."_".$qty * ($run_time_min/$sa_m_with_hose2);
   }elsif ( ($day0 <= $tt2)  && ($day0 + ONE_DAY*1) > $tt2  ){
	  my $run_time_min= ($tt2-$day0)/60;
	  print "last day $run_time_min ? $i $day0 \n";
	  print "   |-". $run_time_min/$sa_m_with_hose2." \n";
	  print "   |-". $qty * ($run_time_min/$sa_m_with_hose2)." \n";
	   $hash{$day0->strftime("%Y/%m/%d")}="type"."_".$qty * ($run_time_min/$sa_m_with_hose2);
   }elsif ($day0 > $tt2){
   	  print "[warn] over the last day ? $i \n";
   } else{
   	  my $run_time_min= 24*60 - $hose2/60;
   	  print "  middle day $run_time_min $day0 [$i]\n";
   	  print "     |-". $run_time_min/$sa_m_with_hose2." \n";
   	  print "   |-". $qty * ($run_time_min/$sa_m_with_hose2)." \n";
   	  $hash{$day0->strftime("%Y/%m/%d")}="type"."_".$qty * ($run_time_min/$sa_m_with_hose2);
   }
   
   $day0=$day0 + ONE_DAY*1;
}

#my $next=$tt1+ONE_DAY*1;
#my $tt1_n= Time::Piece->strptime($next->strftime("%Y/%m/%d") . " 00:00:00","%Y/%m/%d %H:%M:%S");
#print "firstday_h=".(($tt1_n-$tt1)-$hose2)/60/60,"\n"; #firstday hours.

print "end2\n";

foreach my $k(keys %hash){
	print $k . ":". $hash{$k},"\n";
}
