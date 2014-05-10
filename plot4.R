##getData: Retrieves required data from input file and returns data as power_data data.frame
getData<-function(){
	lines<- readLines("household_power_consumption.txt")
	power_data<-read.table(textConnection(lines[grep('^[1-2]/2/2007',lines)]),sep=";", na.strings="?", col.names=colnames(read.table("household_power_consumption.txt",sep=";",nrow=1,header=TRUE)))
}

##plot4_fn : Takes data as input and creates a matrix of 2rows * 2 cols plot
plot4_fn<-function( data ){
	
	datetime <- as.POSIXlt(paste(data$Date, data$Time), format='%d/%m/%Y %H:%M:%S')
	par(mfrow=c(2,2))

	##top-left plot for datetime vs Global active power
	plot(datetime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")
	
	##top-right plot for datetime vs Voltage
	plot(datetime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")
	
	##bottom-left plot for datetime vs (Sub_metering_1,Sub_metering_2,Sub_metering_3)
	yrange<-range(data$Sub_metering_1,data$Sub_metering_2,data$Sub_metering_3)
	plot(datetime,data$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering",ylim=yrange)
	lines(datetime,data$Sub_metering_1,type="l",col="black")
	lines(datetime,data$Sub_metering_2,type="l",col="red")
	lines(datetime,data$Sub_metering_3,type="l",col="blue")
	legend("topright",lty=1,col=c("black","red","blue"),legend=c(paste("Sub_metering_",1:3)),cex=0.8,bty="n")

	##bottom-right plot for datetime vs Global_reactive_power
	plot(datetime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

	}

##plot4: Saves matrix plot created by  plot4_fn to corresponding png file
plot4<-function(){
	pw_data<-getData()
	png(file="plot4.png", height=480, width=480)
	plot4_fn(pw_data)
	dev.off()
}

##Call to plot4 function
plot4()