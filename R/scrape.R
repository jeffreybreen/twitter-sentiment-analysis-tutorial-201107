#
# scrape.R - scrape web data and cache to the data/ directory:
#
#			 * airline-related tweets via twitteR's searchTwitter()
#			 * ACSI scores with XML's readHTMLTable()
#

if (VERBOSE)
	print("Searching Twitter for airline tweets and saving to disk")

require(twitteR)

american.tweets = searchTwitter('@americanair', n=1500)
save(american.tweets, file=file.path(dataDir, 'american.tweets.RData' ), ascii=T)

delta.tweets = searchTwitter('@delta', n=1500)
save(delta.tweets, file=file.path(dataDir, 'delta.tweets.RData' ), ascii=T)

jetblue.tweets = searchTwitter('@jetblue', n=1500)
save(jetblue.tweets, file=file.path(dataDir, 'jetblue.tweets.RData' ), ascii=T)

southwest.tweets = searchTwitter('@southwestair', n=1500)
save(southwest.tweets, file=file.path(dataDir, 'southwest.tweets.RData' ), ascii=T)

united.tweets = searchTwitter('@united', n=1500)
save(united.tweets, file=file.path(dataDir, 'united.tweets.RData' ), ascii=T)

us.tweets = searchTwitter('@usairways', n=1500)
save(us.tweets, file=file.path(dataDir, 'us.tweets.RData' ), ascii=T)


if (VERBOSE)
	print("Scraping ACSI airline scores and saving to disk")

require(XML)

# this assumes 2011 scores which just went live in June 2011
acsi.url = 'http://www.theacsi.org/index.php?option=com_content&view=article&id=147&catid=&Itemid=212&i=Airlines'

# we want the first table (which=1) on tha page, which has column headers (header=T)
acsi.raw.df = readHTMLTable(acsi.url, header=T, which=1, stringsAsFactors=F)
acsi.df = acsi.raw.df[,c(1,19)]

# change the columnn names ("11" -> "score" since we're only looking at most recent)
colnames(acsi.df) = c('airline', 'score')

# add codes for later matching, and make sure score is treated as a number (not a string)
acsi.df$code = c('WN', NA, NA, 'CO', 'AA', 'UA', 'US', 'DL', 'NW')
acsi.df$score = as.numeric(acsi.df$score)

save(acsi.raw.df, file=file.path(dataDir, 'acsi.raw.df.RData'), ascii=T)
save(acsi.df, file=file.path(dataDir, 'acsi.df.RData'), ascii=T)
