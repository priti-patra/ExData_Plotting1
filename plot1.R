##getData: Retrieves required data from input file and return data as power_data data.frame
getData<-function(){
	lines<- readLines("household_power_consumption.txt")
	power_data<-read.table(textConnection(lines[grep('^[1-2]/2/2007',lines)]),sep=";", na.strings="?",col.names=colnames(read.table("household_power_consumption.txt",sep=";",nrow=1,header=TRUE)))
}

##plot1_fn: Plots histogram for Global_active_power of data
plot1_fn<-function( data ){
	hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power(kilowatts)")
}

##plot1: Saves plot created by  plot1_fn to corresponding png file
plot1<-function(){
	pw_data<-getData()
	png(file="plot1.png", height=480, width=480)
	plot1_fn(pw_data)
	dev.off()
}

##Call to plot1 function
plot1()