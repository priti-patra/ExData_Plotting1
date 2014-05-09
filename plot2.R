##getData: Retrieves required data from input file and return data as power_data data.frame
getData<-function(){
	lines<- readLines("household_power_consumption.txt")
	power_data<-read.table(textConnection(lines[grep('^[1-2]/2/2007',lines)]),sep=";",col.names=colnames(read.table("household_power_consumption.txt",sep=";",nrow=1,header=TRUE)))
}

##plot2_fn: Creates a plot of datetime vs Global_active_power
plot2_fn<-function( data ){
	
	datetime <- as.POSIXlt(paste(data$Date, data$Time), format='%d/%m/%Y %H:%M:%S')

	plot(datetime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

}

##plot2: Saves plot created by  plot2_fn to corresponding png file
plot2<-function(){
	pw_data<-getData()
	plot2_fn(pw_data)
	dev.copy(png, file="plot2.png", height=480, width=480)
	dev.off()
}

##Call to plot2 function
plot2()