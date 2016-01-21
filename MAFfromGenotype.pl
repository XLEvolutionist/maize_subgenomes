#!/usr/bin/perl
use strict;
use warnings;

#######################################################
# A brief script to calculate MAF from genotype files #
# 				from maize NAM lines				  #
#######################################################

# usage script.pl <file>

# Simon Renny-Byfield, UC Davis November 24th 2015

# version 1

# load in modules
use List::Util 'sum';

# a global variable
my @outArray;

############
# Main	   #
############

# set up the file handle

open ( IN , $ARGV[0] ) || die "Could not open file $ARGV[0]: $!\n";

# cycle through the file

while ( <IN> ) {
	chomp;
	# assume the header line contains #
 	if ( m/#/ ) {
 		# add the last column header for the new data to be added
 		print $_ , "\t" , "MAF\n";
 	}# if
 	else {
 		# split the data by NA
 		my @data = split /NA/;
 		# $data[0] is the chromosome info
 		# $data[6] is all the SNP calls
 		
 		# first find the alleles that are present.
 		my @chromInfo = split /\t/ , $data[0];
 		my @alleles = split /\// , $chromInfo[1];
 		# replace + and - with N
 		for(@alleles){s/[+-]/N/g}
 		# skip lines with multiple, or undef alleles
 		if ( grep( /N/ , @alleles ) or scalar @alleles > 2 ) {
 			print $_ , "\tNA\n";
 			next;
 		}# if
 		my %counts;	
		# for each allele count the number of occurrences
		for my $allele ( @alleles ) {
			my @c = $data[6] =~ m/$allele/g;
			my $count = @c;
			#print $allele , "\t" , $count , "\t";
			$counts{$allele} = $count;
		}# foreach
		# the sum of all allele counts
		my $total_count = sum values %counts;
		#print "$total_count\t";
		my $MAF = $counts{$alleles[1]}/$total_count;
		print $_ , "\t$MAF\n";
 	}# else
}# while

exit;
