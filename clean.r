# get your libraries in order
library(ggplot2)
library(data.table)

hci_data <- read.csv("2016_11_06_data_cleaned.csv", header = TRUE)
# fin_sum_counts <- summary(hci_data$finished)
# 
# fin_df <- data.frame(finished=factor(c(names(fin_sum_counts)), levels=c(names(fin_sum_counts))),
#                      count=c(fin_sum_counts))
# ggplot(data=fin_df, aes(x=finished, y=count, fill=count)) +
#   geom_bar(stat="identity")


# Remove all the rows that didn't finish
hci_data <- hci_data[! (hci_data$finished != "True"),]
# Now that 

# define a list of columns to remove, namely meta-data
# taken from
# https://stackoverflow.com/questions/7072159/how-do-you-remove-columns-from-a-data-frame
to_remove <- c("startDate",
           "endDate",
           "status",
           "ipAddress",
           "progress",
           "recordedDate",
           "X_recordId",
           "recipientLastName",
           "recipientFirstName",
           "recipientEmail",
           "externalDataReference",
           "locationLatitude",
           "locationLongitude",
           "distributionChannel",
           "QID10", # remove the form agreement column
           "QID20_4_TEXT" # remove freeform gender response, all NA's
           )
# Remove the columns
hci_data[to_remove] <- list(NULL)
#hci_data[finished] <- NULL

# Use the data.table function `setnames` to rename columns names semantically
setnames(hci_data, old = c("QID19",
                           "QID20",
                           "QID21",
                           "QID22",
                           "QID23"
), new = c("stem", # QID19
           "gender", # QID20
           "race", # QID21
           "school_year", # QID22
           "collOrCon" # QID23
           ))

ggplot(data=fin_df, aes(x=finished, y=count, fill=count)) +
   geom_bar(stat="identity")
