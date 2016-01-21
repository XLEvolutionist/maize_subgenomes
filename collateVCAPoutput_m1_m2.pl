#!usr/bin/perl
use strict;
use warnings;

# Simon Renny-Byfield, UC Davis December 2015

# usage script.pl <dir> 

# extract heritability from .reml files produced by AHTP

opendir DIR, $ARGV[0] or die "cannot open dir $ARGV[0]: $!";
my @files= readdir DIR;
closedir DIR;

# filter out the files that aren't NAM
@files=grep(/NAM/, @files );
# now we need only the reml output
@files=grep(/reml/, @files);
# now we need only the M1 and M2 stuff output
@files=grep(/m1_vs_m2_NAM/, @files);

# print a header line
print "pheno\tstatus\tsub.genome\tgroup\theritability\tsd\n";

# for each of the files, grab the relavent data to fill out the table

foreach my $file ( @files ) {
	open (FH, "<$ARGV[0]/$file" ) || die ;
	my @data= <FH>;
	$file =~ s/results_//g;
	$file =~ s/_multiblup.txt.reml//g;
	$file =~ m/(m1_vs_m2)_NAM_(.+)/;
	my $pheno = $2;
	my $status = $1;
	$status =~ s/__/,/;
	$status = "[".$status.")";
	chomp $data[10];
	chomp $data[11];
	chomp $data[12];
	$data[10] =~ s/\s+/\t/g;
	$data[11] =~ s/\s+/\t/g;
	$data[12] =~ s/\s+/\t/g;
	print $pheno , "\t" , $status , "\t" , "M1" , "\t" ,  $data[10] , "\n";
	print $pheno , "\t" , $status , "\t" , "M2" , "\t" ,  $data[11] , "\n";
	print $pheno , "\t" , $status , "\t" , "rest" , "\t" ,  $data[12] , "\n";
}# foreach

exit;