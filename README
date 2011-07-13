INTRODUCTION

	This project contains all the code necessary to reproduce the analysis
	presented in my R tutorial on mining Twitter for airline sentiment:
	
		http://jeffreybreen.wordpress.com/2011/07/04/twitter-text-mining-r-slides/


CONTENTS

	data/
		opinion-lexicon-English/	- Hu & Liu's opinion lexicon
			negative-words.txt
			NLP-handbook-sentiment-analysis.pdf
			positive-words.txt
			source.txt
			source.webloc
	
		acsi.df.RData				- airline customer satisfaction scores
		acsi.raw.df.RData			- scraped from theacsi.org web site
		
	output/							- output files, mainly graphics
		qplot_delta_hist.pdf
		twitter_acsi_comparison_with_fit.pdf
		twitter_acsi_comparison.pdf
		twitter_score_histograms.pdf
	
	R/								- R source code
		0_start.R
		1_load.R
		2_run.R
		scrape.R
		sentiment.R
		
	LICENSE							- Copyright per Apache 2.0 license
	
	README 							- this file


INSTRUCTIONS

In order to run the analysis, start R from this project's root directory
or it with setwd()


1. Load the prerequisite packages, our score.sentiment() function, and
   some environment variables with the "0_start.R" script:

		> source("R/0_start.R")


2. This distribution does not ship with any data from Twitter, so you will need
   to collect your own the first time you attempt to run this package.
   
   To collect data from Twitter, simply execute the "scrape.R" script:
   
   		> source("R/scrape.R")

    This script caches your collected tweets to the data/ directory, so you 
    only need to run this step once.

	
3.  Load the Twitter data, opinion lexicon, and ACSI results from disk:

		> source("R/1_load.R")

	If this is your first time running this code, and you have not followed Step 2
	to collect your own Twitter data, you will see this error message:
	
      Error: Tweets not found on disk -- source('R/scrape.R') to scrape Twitter first


4.	Run the analysis:

		> source("R/2_run.R")
		
	Progress messages will be displayed on the console and all generated graphics will
	be displayed and saved as PDFs in the output/ directory.

	
Jeffrey Oliver Breen
jbreen@cambridge.aero
July 2011
