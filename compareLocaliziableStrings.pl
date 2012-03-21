use strict;
use warnings;
my $fileJp = './ja.lproj/Localizable.strings';
my $fileEn = './en.lproj/Localizable.strings';
my @files = ($fileJp, $fileEn);

my @wordsJp;
my @wordsEn;
my $words = [\@wordsJp, \@wordsEn];

my $fh;
my $ct = 0;
foreach my $file (@files){
	open( $fh, "<", $file)
		or die "Cannot open $file: $!";

	while(my $line = readline $fh){
		chomp $line;
		if( $line =~ /"(.+)"\s*=/ || $line =~ /\s*"(.+)";/){
			push @{$words->[$ct]}, $1;
		}
	}
	close $fh;
	$ct++;
}

my $lenEn = @{$words->[0]};
my $lenJp = @{$words->[1]};

for (my $i = 0; $i < $lenEn; $i++) {
   for(my $j = 0; $j < $lenJp; $j++){
	if($words->[0]->[$i] eq $words->[1]->[$j]){
	  $words->[0]->[$i] = "";
	  $words->[1]->[$j] = "";
	}	
    }
}

$ct = 0;
foreach my $eachwords (@{$words}){
	foreach my $word (@$eachwords){
	    if($word ne ""){
	        print $word," is not in $files[($ct+1)%2]","\n";
	    }
	}
	++$ct;
}
