package NCBI_Taxonomy;
# PPath@Cornell
# Surya Saha

use strict;
use warnings;

sub GI2TaxID{
	# Purpose: To find taxon ID for GI using Taxonomy
	#wget ftp://ftp.ncbi.nih.gov/pub/taxonomy/gi_taxid_prot.dmp.gz; gunzip gi_taxid_prot.dmp.gz
	#wget ftp://ftp.ncbi.nih.gov/pub/taxonomy/gi_taxid_nucl.dmp.gz; gunzip gi_taxid_nucl.dmp.gz
	#patch gi_taxid_nucl.dmp gi_taxid_nucl_diff.dmp
	#patch gi_taxid_prot.dmp gi_taxid_prot_diff.dmp 
	#cat gi_taxid_nucl.dmp gi_taxid_prot.dmp > gi_taxid.dmp
	my ($tid,$GI);
	chomp $_[0]; $GI=$_[0];
	$tid = `fgrep -m 1 $GI /home/surya/data/NCBI/Taxonomy/gi_taxid.dmp | awk -F" " '{print \$2}'`;
	return $tid;
}
########################################################################
# Update Taxonomy DB
# wget ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz
# tar -zxvf taxdump.tar.gz
########################################################################
sub TaxID2TaxonomyArr{
	#Accepts a taxid as input and returns an array with its ascendants ordered from top to bottom
	use Bio::LITE::Taxonomy::NCBI;
	my ($tid,$taxNCBI,@taxarr);
	chomp $_[0]; $tid=$_[0]; 
	$taxNCBI = Bio::LITE::Taxonomy::NCBI->new (names=> "/home/surya/data/NCBI/Taxonomy/names.dmp",
		nodes=>"/home/surya/data/NCBI/Taxonomy/nodes.dmp");
	@taxarr=$taxNCBI->get_taxonomy($tid);
	return @taxarr;
}
########################################################################
sub TaxID2TaxonomyLevels{
	#returns an array of array references. Each array reference has the ascendant and 
	#its taxonomic level (at positions 0 and 1 respectively).
	use Bio::LITE::Taxonomy::NCBI;
	my ($tid,$taxNCBI,@taxarr);
	chomp $_[0]; $tid=$_[0]; 
	$taxNCBI = Bio::LITE::Taxonomy::NCBI->new (names=> "/home/surya/data/NCBI/Taxonomy/names.dmp",
		nodes=>"/home/surya/data/NCBI/Taxonomy/nodes.dmp");
	@taxarr=$taxNCBI->get_taxonomy_with_levels($tid);
	return @taxarr;
}
########################################################################
# ERR: Can't call method "get_taxid" on an undefined value at /usr/local/share/perl/5.10.1/Bio/LITE/Taxonomy/NCBI.pm line 237.
#sub GI2TaxonomyArr{
#	#Accepts a GI as input and returns an array with its ascendants ordered from top to bottom
#	use Bio::LITE::Taxonomy::NCBI;
#	my ($gi,$taxNCBI,@taxarr);
#	$gi=$_[0]; 
#	$taxNCBI = Bio::LITE::Taxonomy::NCBI->new (names=> "/home/surya/data/NCBI/Taxonomy/names.dmp",
#		nodes=>"/home/surya/data/NCBI/Taxonomy/nodes.dmp");
#	@taxarr=$taxNCBI->get_taxonomy_from_gi($gi);
#	return @taxarr;
#}
########################################################################
# ERR: Can't call method "get_taxid" on an undefined value at /usr/local/share/perl/5.10.1/Bio/LITE/Taxonomy/NCBI.pm line 237.
#sub GI2TaxonomyLevels{
#	#returns an array of array references. Each array reference has the ascendant and 
#	#its taxonomic level (at positions 0 and 1 respectively).
#	use Bio::LITE::Taxonomy::NCBI;
#	my ($gi,$taxNCBI,@taxarr);
#	$gi=$_[0]; 
#	$taxNCBI = Bio::LITE::Taxonomy::NCBI->new (names=> "/home/surya/data/NCBI/Taxonomy/names.dmp",
#		nodes=>"/home/surya/data/NCBI/Taxonomy/nodes.dmp");
#	@taxarr=$taxNCBI->get_taxonomy_with_levels_from_gi($gi);
#	return @taxarr;
#}
########################################################################
sub Name2TaxID{
	#Accepts the scientific name of a taxon and returns its associated taxid
	use Bio::LITE::Taxonomy::NCBI;
	my ($tid,$taxNCBI,$name);
	chomp $_[0]; $name=$_[0]; 
	$taxNCBI = Bio::LITE::Taxonomy::NCBI->new (names=> "/home/surya/data/NCBI/Taxonomy/names.dmp",
		nodes=>"/home/surya/data/NCBI/Taxonomy/nodes.dmp");
	$tid=$taxNCBI->get_taxid_from_name($name);
	return $tid;
}
########################################################################
sub Name2TaxonomyArr{
	#returns the full taxonomy of the scientific name
	use Bio::LITE::Taxonomy::NCBI;
	my (@taxarr,$taxNCBI,$name);
	chomp $_[0]; $name=$_[0]; 
	$taxNCBI = Bio::LITE::Taxonomy::NCBI->new (names=> "/home/surya/data/NCBI/Taxonomy/names.dmp",
		nodes=>"/home/surya/data/NCBI/Taxonomy/nodes.dmp");
	@taxarr=$taxNCBI->get_taxonomy_from_name($name);
	return @taxarr;
}
########################################################################
sub TaxID_Level2Name{
	#Given a taxid and a taxonomic level as input, returns the taxon
	use Bio::LITE::Taxonomy::NCBI;
	my ($level,$name,$taxNCBI,$tid);
	chomp $_[0]; $tid=$_[0];
	chomp $_[1]; $level=$_[1]; 
	$taxNCBI = Bio::LITE::Taxonomy::NCBI->new (names=> "/home/surya/data/NCBI/Taxonomy/names.dmp",
		nodes=>"/home/surya/data/NCBI/Taxonomy/nodes.dmp");
	$name=$taxNCBI->get_term_at_level($tid,$level);
	return $name;
}

1;
