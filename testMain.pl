#!/usr/bin/perl -w
# PPath@Cornell
# Surya Saha  

use strict;
use warnings;
use lib '/home/surya/work/Eclipse/Taxonomy';
use NCBI_Taxonomy;

my ($i,$j,@temp);
#$i=&NCBI::Accession2GI('ABBA01004711');
#chomp $i;
#print "$i";

# subroutine will have to be included inside calling script since we want to create 
# a dictionary only once per run, not for every call to module subroutine
#use Bio::LITE::Taxonomy::NCBI::Gi2taxid qw/new_dict/;
#if (!(-e 'gi_taxid_prot_dict.bin')){
#	new_dict (in => "/home/surya/data/NCBI/Taxonomy/gi_taxid_prot.dmp", out => "gi_taxid_prot_dict.bin");
#}
#if (!(-e 'gi_taxid_nucl_dict.bin')){
#	new_dict (in => "/home/surya/data/NCBI/Taxonomy/gi_taxid_nucl.dmp", out => "gi_taxid_nucl_dict.bin");
#}
#
#my $ndict = Bio::LITE::Taxonomy::NCBI::Gi2taxid->new(dict=>"gi_taxid_nucl_dict.bin");
#my $pdict = Bio::LITE::Taxonomy::NCBI::Gi2taxid->new(dict=>"gi_taxid_prot_dict.bin");
#my $taxid = $ndict->get_taxid(152206664);
#printf $taxid;

$i=&NCBI_Taxonomy::GI2TaxID(124257968);
chomp $i;
print "$i\n";

@temp=&NCBI_Taxonomy::TaxID2TaxonomyLevels($i);
#printf $i;
print "$_->[1]\: $_->[0]\n" for @temp;
print"\n\n";


