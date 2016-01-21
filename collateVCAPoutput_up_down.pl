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

# print a header line
print "pheno\tSNP_freq\tgroup\tgroup\theritability\tsd\n";

# for each of the files, grab the relavent data to fill out the table

foreach my $file ( @files ) {
	open (FH, "<$ARGV[0]/$file" ) || die ;
	my @data= <FH>;
	$file =~ s/results_//g;
	$file =~ s/_multiblup.txt.reml//g;
	$file =~ m/(paired_paralogs)_NAM_(.+)/;
	my $pheno = $2;
	my $status = $1;
	$status =~ s/__/,/;
	#$status = "[".$status.")";
	chomp $data[10];
	chomp $data[11];
	chomp $data[12];
	chomp $data[13];
	chomp $data[14];
	$data[10] =~ s/\s+/\t/g;
	$data[11] =~ s/\s+/\t/g;
	$data[12] =~ s/\s+/\t/g;
	$data[13] =~ s/\s+/\t/g;
	$data[14] =~ s/\s+/\t/g;
	print $pheno, "\t", $status , "\t" , "rest" , "\t",  $data[10] , "\n";
	print $pheno, "\t", $status , "\t" , "paralog down" , "\t",  $data[11] , "\n";
	print $pheno, "\t", $status , "\t" , "paralog up" , "\t",  $data[12] , "\n";
	print $pheno, "\t", $status , "\t" , "random down" , "\t",  $data[13] , "\n";
	print $pheno, "\t", $status , "\t" , "random up" , "\t",  $data[14] , "\n";
}# foreach

exit;