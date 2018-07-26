package Hako;
use strict;
use warnings;
use Time::Piece;
use Time::Seconds;

sub new {
    my $class = shift;

    my %self = @_;
    $self{stttime} //= 'No date';
    $self{endtime} //= 'No date';
    $self{qty} //= 20;
    $self{hose2} //= 1*60*60;
    $self{res_hash} //= {};

    bless \%self, $class;
}

sub getSttTime {
    my $self = shift;
    return $self->{ stttime };
}
sub getEndTime {
    my $self = shift;
    return $self->{ endtime };
}

# colorメソッドを追加。
sub calc {
    my $self = shift;
    #--------------base---------------------
    my $qty=$self->{qty};
    my $stt = $self->{stttime};
    my $end = $self->{endtime};
    my $hose2 = $self->{hose2};

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
	      $hash{$day0->strftime("%Y/%m/%d")}="type"."_". int($qty * &round_off(($run_time_min/$sa_m_with_hose2),3));
       }elsif ( ($day0 <= $tt2)  && ($day0 + ONE_DAY*1) > $tt2  ){
    	  my $run_time_min= ($tt2-$day0)/60;
    	  print "last day $run_time_min ? $i $day0 \n";
    	  print "   |-". &round_off(($run_time_min/$sa_m_with_hose2),3)." \n";
	      print "   |-". $qty * ($run_time_min/$sa_m_with_hose2)." \n";
	      $hash{$day0->strftime("%Y/%m/%d")}="type"."_". int($qty * &round_off(($run_time_min/$sa_m_with_hose2),3));
       }elsif ($day0 > $tt2){
   	      print "[warn] over the last day ? $i $day0 : $tt2 \n";    
       } else{
   	      my $run_time_min= 24*60 - $hose2/60;
       	  print "  middle day $run_time_min $day0 [$i]\n";
      	  print "     |-". $run_time_min/$sa_m_with_hose2." \n";
   	       print "   |-". $qty * ($run_time_min/$sa_m_with_hose2)." \n";
    	  $hash{$day0->strftime("%Y/%m/%d")}="type"."_". int($qty * &round_off(($run_time_min/$sa_m_with_hose2),3));
       } 
       $day0=$day0 + ONE_DAY*1;
    }

    foreach my $k(keys %hash){
	    print $k . ":". $hash{$k},"\n";
    }
    $self->{res_hash}=%hash;
    return $self->{res_hash};
}

sub round_off{
        my($n,$r)=@_;

        $n=int($n*10**$r)/(10**$r);
        #$n = int($n*1000)/1000;

        return $n;
}

1;