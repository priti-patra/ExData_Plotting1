##getData: Retrieves required data from input file and return data as power_data data.frame
getData<-function(){
	lines<- readLines("household_power_consumption.txt")
	power_data<-read.table(textConnection(lines[grep('^[1-2]/2/2007',lines)]),sep=";",col.names=colnames(read.table("household_power_consumption.txt",sep=";",nrow=1,header=TRUE)))
}

##plot3_fn: Creates a plot of datetime vs (Sub_metering_1,Sub_metering_2,Sub_metering_3)
plot3_fn<-function( data ){
	yrange<-range(data$Sub_metering_1,data$Sub_metering_2,data$Sub_metering_3)
	datetime <- as.POSIXlt(paste(dd$Date, dd$Time), format='%d/%m/%Y %H:%M:%S')
	plot(datetime,dd$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering",ylim=yrange)
	lines(datetime,dd$Sub_metering_1,type="l",col="black")
	lines(datetime,dd$Sub_metering_2,type="l",col="red")
	lines(datetime,dd$Sub_metering_3,type="l",col="blue")
	legend("topright",lty=1,col=c("black","red","blue"),legend=c(paste("Sub_metering_",1:3)))

}

##plot3: Saves plot created by  plot3_fn to corresponding png file
plot3<-function(){
	pw_data<-getData()
	plot3_fn(pw_data)
	dev.copy(png, file="plot3.png", height=480, width=480)
	dev.off()
}

##Call to plot3 function
plot3()
