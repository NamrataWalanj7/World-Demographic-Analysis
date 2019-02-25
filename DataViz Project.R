#Importing data files
metadata = read.csv(file.choose(), header=TRUE)
population = read.csv(file.choose(), header=TRUE)
fertility_rate = read.csv(file.choose(), header=TRUE)
life_expectancy = read.csv(file.choose(),header=TRUE)


metadata_df = metadata[-c(2,5)]
population_df = population[-c(2:4)]
fertility_df = fertility_rate[-c(2:4)]
lifeexp_df = life_expectancy[-c(2:4)]


library(tidyr)

population_long <- gather(population_df, year, population_value, X1960:X2013, factor_key=TRUE)
population_long
population_long$ID <- seq.int(nrow(population_long))

fertility_long <- gather(fertility_df, year, fertility_value, X1960:X2013, factor_key=TRUE)
fertility_long
fertility_long$ID <- seq.int(nrow(fertility_long))

lifeexp_long <- gather(lifeexp_df, year, lifeexp_value, X1960:X2013, factor_key=TRUE)
lifeexp_long
lifeexp_long$ID <- seq.int(nrow(lifeexp_long))

pf = merge(x=population_long, y=fertility_long, by="ID", all.x=TRUE)
pfl = merge(x=pf, y=lifeexp_long, by="ID", all.x=TRUE)
pflm = merge(x=pfl, y=metadata_df, by="Country.Name", all.x=TRUE)

pflm_df = pflm[-c(3,6:7,9)]

pflm_df$year.x <- substr(pflm_df$year.x, 2,5)

class(pflm_df$year.x)

pflm_df$year.x = as.numeric(as.character(pflm_df$year.x))

colnames(pflm_df)[colnames(pflm_df)=="year.x"] <- "Year"
colnames(pflm_df)[colnames(pflm_df)=="Country.Name"] <- "Country_Name"
colnames(pflm_df)[colnames(pflm_df)=="population_value"] <- "Population_Value"
colnames(pflm_df)[colnames(pflm_df)=="fertility_value"] <- "Fertility_Value"
colnames(pflm_df)[colnames(pflm_df)=="lifeexp_value"] <- "Lifeexp_Value"

pflm_df$Fertility_Value = as.numeric(as.character(pflm_df$Fertility_Value))
pflm_df$Lifeexp_Value = as.numeric(as.character(pflm_df$Lifeexp_Value))

class(pflm_df$Fertility_Value)

write.csv(pflm_df,"datavizproject.csv",  row.names = TRUE)

t = read.csv(file.choose(),header =TRUE)
class(t$Fertility_Value)
class(t$Lifeexp_Value)
class(t$Country_Name)
