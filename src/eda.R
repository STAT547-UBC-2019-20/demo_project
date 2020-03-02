library(ggplot2)
library(corrplot)
library(tidyverse)


# Read file
df <- foreign::read.arff("../data/Autism-Adult-Data.arff")

# Barplot
df  %>%
  ggplot(aes(x=ethnicity, fill=austim))+
  geom_bar(stat="count", position = "dodge")+
  labs(x = "Ethnicity", y = "Count", title = "Occurence of Autism by Ethnicity") +
  scale_fill_discrete(name="Autism") + # This changes the legend title
  theme_bw(18) + # Change the theme and set the font size
  coord_flip() # Flip x- and y-axis

### Save the barplot
ggsave(filename = "../img/barplot", device = 'png')

#### This may not be necessary;
#### If you're getting a file called "Rplots.pdf" generated in your folder, 
#### use the following to delete it
unlink("Rplots.pdf")

# Proportional bar chart
df%>% 
  ggplot()+
  geom_bar(mapping = aes(x=as.factor(result), fill = austim),
           position = "fill")+
  ylab("Proportion of Participants")+
  xlab("ASD-10 Test Score")+
  ggtitle("Proportion of Participants by \nASD-10 Test Score")+
  scale_fill_brewer(name = "Diagnosed \nwith Autism", palette = "Paired") +
  theme_bw(20)

## Save the chart
ggsave(filename = "../img/propbarplot", device = 'png')


# Correlation Plot

## Convert numeric columns to 'double' type
df[1:10] <- sapply(df[1:10], as.double)
autism_corr <- cor(df[1:10])

## Round the values to 2 decimal places
autism_corr <- round(autism_corr,2)

## Save the corrplot
### The corrplot function doesn't create a ggplot object,
### so we have to use a different method to save (or export) the plot

## Set up the graphics device
png(filename="../img/correlation.png")
#### Attribution: https://blog.hasanbul.li/2018/01/14/exporting-correlation-plots/

## Make the correlation plog
corrplot(autism_corr, 
         type = "upper",
         method="color",
         tl.srt=45, 
         tl.col = "blue",
         diag = FALSE)

## Turn off graphics device
dev.off()