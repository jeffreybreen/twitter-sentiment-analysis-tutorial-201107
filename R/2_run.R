
if (VERBOSE)
{
	print("Extracting text from tweets & calculating sentiment scores")
	flush.console()
}

american.text = laply(american.tweets, function(t) t$getText() )
delta.text = laply(delta.tweets, function(t) t$getText() )
jetblue.text = laply(jetblue.tweets, function(t) t$getText() )
southwest.text = laply(southwest.tweets, function(t) t$getText() )
united.text = laply(united.tweets, function(t) t$getText() )
us.text = laply(us.tweets, function(t) t$getText() )

american.scores = score.sentiment(american.text, pos.words, neg.words, .progress='text')
delta.scores = score.sentiment(delta.text, pos.words, neg.words, .progress='text')
jetblue.scores = score.sentiment(jetblue.text, pos.words, neg.words, .progress='text')
southwest.scores = score.sentiment(southwest.text, pos.words, neg.words, .progress='text')
united.scores = score.sentiment(united.text, pos.words, neg.words, .progress='text')
us.scores = score.sentiment(us.text, pos.words, neg.words, .progress='text')

american.scores$airline = 'American'
american.scores$code = 'AA'
delta.scores$airline = 'Delta'
delta.scores$code = 'DL'
jetblue.scores$airline = 'JetBlue'
jetblue.scores$code = 'B6'
southwest.scores$airline = 'Southwest'
southwest.scores$code = 'WN'
united.scores$airline = 'United'
united.scores$code = 'UA'
us.scores$airline = 'US Airways'
us.scores$code = 'US'

all.scores = rbind( american.scores, delta.scores, jetblue.scores, 
					southwest.scores, united.scores, us.scores )

if (VERBOSE)
	print("Plotting score distributions")

g.hist = ggplot(data=all.scores) + # ggplot works on data.frames, always
		geom_bar(mapping=aes(x=score, fill=airline), binwidth=1) + 
		facet_grid(airline~.) + # make a separate plot for each airline
		theme_bw() + scale_fill_brewer() # plain display, nice colors

print(g.hist)
ggsave(file.path(outputDir, 'score_historam.pdf'), g.hist, width=6, height=8)


if (VERBOSE)
	print("Comparing Twitter & ACSI data")

all.scores$very.pos = as.numeric( all.scores$score >= 2 )
all.scores$very.neg = as.numeric( all.scores$score <= -2 )

twitter.df = ddply(all.scores, c('airline', 'code'), summarise, pos.count=sum( very.pos ), neg.count=sum( very.neg ) )

twitter.df$all.count = twitter.df$pos.count + twitter.df$neg.count

twitter.df$score = round( 100 * twitter.df$pos.count / twitter.df$all.count )

compare.df = merge(twitter.df, acsi.df, by='code', suffixes=c('.twitter', '.acsi'))
# compare.df = subset(compare.df, all.count > 100)

g.fit = ggplot( compare.df ) + 
			geom_point(aes(x=score.twitter, y=score.acsi, color=airline.twitter), size=5) + 
			geom_smooth(aes(x=score.twitter, y=score.acsi, group=1), se=F, method="lm") +
			theme_bw() +
			opts(legend.position=c(0.2, 0.85))

print(g.fit)
ggsave(file.path(outputDir, 'twitter_acsi_comparison.pdf'), g.fit, width=7, height=7)
