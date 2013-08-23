package NCBI;
# PPath@Cornell
# Surya Saha

use strict;
use warnings;

########################################################################
sub Accession2GI{
	# Purpose: To find GI for a Accession number using GenBank Livelists 
	# Update before use!!
	# URL: ftp://ftp.ncbi.nih.gov/genbank/livelists/
	# Make sure version number is stripped off
	my ($Acc,$GI);
	chomp $_[0]; $Acc=$_[0];
#	if($Acc =~ /\./){#remove seq version
#		@temp=split(".",$Acc); $Acc=$temp[0];
#	}
	$Acc=~ s/\./,/;#converting . to , to match database
	$GI = `fgrep -m 1 $Acc /home/surya/data/NCBI/LiveLists/GbAccList.0415.2012 | awk -F"," '{print \$3}'`;
	return $GI;
}

1;
