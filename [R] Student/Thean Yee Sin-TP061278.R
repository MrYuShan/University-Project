#Thean Yee Sin
#TP061278

InstallPackages=function(){   #install required package
  install.packages("dplyr")
  install.packages("ggplot2")
  install.packages("plotrix")
  install.packages("readr")
  install.packages("gridExtra")
}

LoadPackages=function(){      #load required package
  library(dplyr) #data manipulation
  library(ggplot2) #for graph
  library(plotrix) #3d graph
  library(readr) #reading file
  library(gridExtra) #multiple graph
}

InstallPackages()
LoadPackages()

#read file
student=read_delim(file="C:\\Users\\Lenovo\\Desktop\\Assignment\\year 2 sem 1\\PDFA\\student.csv",delim=";",quote="")
student

#index(initialization)
tempcol = c() # temporarily column
student_data=data.frame(index = 1:nrow(student))
student_data

#replace all double quotes with empty string in student data frame
for(col in 1:length(student)){
  tempcol=c()
  for(row in student[,col]){ #remove double quote
    temp=gsub("\"","",row)
    tempcol = c(tempcol,temp)
  }
  student_data=cbind(student_data,tempcol)
}

#naming student_data header
colName = c("Index","School","Sex","Age","Address","Family Size","Parent Status","Mother Education","Father Education","Mother Job",
            "Father Job","Reason","Guardian","Travel Time","Study Time","Failures","School Support","Family Support","Extra Class",
            "Extra Activity","Nursery","Higher Education","Internet","Romantic","Family Relationship","Free Time","Go Out",
            "Weekday Alcohol","Weekend Alcohol","Health","Absences","Grade 1","Grade 2","Grade 3")
names(student_data)= colName
student_data

#changing data type of some column from string to int
student_data$Age = as.integer(student_data$Age)
student_data$`Mother Education` = as.integer(student_data$`Mother Education`)
student_data$`Father Education` = as.integer(student_data$`Father Education`)
student_data$`Travel Time` = as.integer(student_data$`Travel Time`)
student_data$`Study Time` = as.integer(student_data$`Study Time`)
student_data$Failures = as.integer(student_data$Failures)
student_data$`Family Relationship` = as.integer(student_data$`Family Relationship`)
student_data$`Free Time` = as.integer(student_data$`Free Time`)
student_data$`Go Out` = as.integer(student_data$`Go Out`)
student_data$`Weekday Alcohol` = as.integer(student_data$`Weekday Alcohol`)
student_data$`Weekend Alcohol` = as.integer(student_data$`Weekend Alcohol`)
student_data$Health = as.integer(student_data$Health)
student_data$Absences = as.integer(student_data$Absences)
student_data$`Grade 1` = as.integer(student_data$`Grade 1`)
student_data$`Grade 2` = as.integer(student_data$`Grade 2`)
student_data$`Grade 3` = as.integer(student_data$`Grade 3`)


#summary
View(student_data)
student_data
summary(student_data)

#####Question 1 = How did the student achieve better score in grade 2 than grade 1?
better_score_in_G2=subset(student_data,`Grade 2`>`Grade 1`) #check if grade2 better than grade1
worse_score_in_G2=subset(student_data,`Grade 1`>`Grade 2`)# student with better grade in 1 than 2
nrow(better_score_in_G2) #total students 

#analysis 1&2 = relationship between family support,family status and improvement in grade 2
fam_sup_status_yes_yes = sum(better_score_in_G2$`Family Support`=="yes" &better_score_in_G2$`Parent Status`=="T")
fam_sup_status_yes_no = sum(better_score_in_G2$`Family Support`=="yes" &better_score_in_G2$`Parent Status`=="A")
fam_sup_status_no_yes = sum(better_score_in_G2$`Family Support`=="no" &better_score_in_G2$`Parent Status`=="T")
fam_sup_status_no_no = sum(better_score_in_G2$`Family Support`=="no" &better_score_in_G2$`Parent Status`=="A")

sum_of_fam_sup = c(fam_sup_status_yes_yes,fam_sup_status_yes_no,fam_sup_status_no_yes,fam_sup_status_no_no)
pie_percentages_1.1 = paste0(round(100 * sum_of_fam_sup/sum(sum_of_fam_sup), 2), "%")#percentages calculator

#visualization
pie(sum_of_fam_sup,labels=paste(c("Yes-Together","Yes-Apart","No-Together","No-Apart"),pie_percentages_1.1),
    main="Family Support - Parent Status",col=c("pink","lightyellow","lightgreen","lightblue"))

#analysis 3&4 = Relationship between school, school support and improvement in grade 2
school_sup_gp_yes= sum(better_score_in_G2$`School`=="GP" &better_score_in_G2$`School Support`=="yes")
school_sup_gp_no= sum(better_score_in_G2$`School`=="GP" &better_score_in_G2$`School Support`=="no")
school_sup_ms_yes=sum(better_score_in_G2$`School`=="MS" &better_score_in_G2$`School Support`=="yes")
school_sup_ms_no=sum(better_score_in_G2$`School`=="MS" &better_score_in_G2$`School Support`=="no")

sum_of_school_sup=c(school_sup_gp_yes,school_sup_gp_no,school_sup_ms_yes,school_sup_ms_no)
pie_percentages_1.2=paste0(round(100 * sum_of_school_sup/sum(sum_of_school_sup), 2), "%")#percentages calculator

#visualization
pie3D(sum_of_school_sup,labels=paste(c("GP - yes","GP - no","MS - yes","MS - no"),pie_percentages_1.2),
      theta=1,main="School and school support")

#analysis 5 = how extra class affect grade
bar_better_extra_class=
  ggplot(better_score_in_G2,aes(x=`Extra Class`))+geom_bar(fill=c("pink","lightblue"),width=0.5)+
  ggtitle("Student(Score better in Grade 2) VS Extra class")#barchart(better in grade2,x=extra class)

bar_worse_extra_class=
  ggplot(worse_score_in_G2,aes(x=`Extra Class`))+geom_bar(fill=c("lightyellow","lightgreen"),width=0.5)+
  ggtitle("Student(Score worse in Grade 2) VS Extra class")#barchart(worse in grade2,x=extra class)
grid.arrange(bar_better_extra_class,bar_worse_extra_class,ncol=2)#arrange 2 bar charts together

#analysis 6 = relationship between weekday and weekend alcohol and improvement
#Following source code referred to Joachim Schork (n.d.) 
par(mfrow=c(2,1),new=TRUE) #multiple graph for non-ggplot graphs
plot(x=better_score_in_G2$`Weekday Alcohol`,type="p",xlab="Index",ylab="Alcohol consumption",col="red",main="Weekday Alcohol Consumption")#plot(weekday alcohol)
plot(x=better_score_in_G2$`Weekend Alcohol`,type="p",xlab="Index",ylab="Alcohol consumption",col="blue",main="Weekend Alcohol Consumption")#plot(weekend alcohol)
#Following source code referred to Joachim Schork (n.d.) 
dev.off() #turn off par function

#analysis 7&8 = relationship between study time,travel time and improvement in G2
ggplot(better_score_in_G2,aes(x=`Travel Time`))+geom_histogram(aes(fill=..count..),binwidth=0.5)+
  facet_wrap(~`Study Time`)+ggtitle("Study Time vs Travel Time") #histogram(x=travel time and facet_wrap(study time))




#####Question 2= Which gender scores better result in their grades?
#analysis 1 = gender
male_only=subset(student_data,`Sex`=="M") #only male
female_only=subset(student_data,`Sex`=="F") #only female

male_G1_average = round(sum(male_only$`Grade 1`)/nrow(male_only),2)#male grade 1 average
male_G2_average = round(sum(male_only$`Grade 2`)/nrow(male_only),2)#male grade 2 average
male_G3_average = round(sum(male_only$`Grade 3`)/nrow(male_only),2)#male grade 3 average

female_G1_average = round(sum(male_only$`Grade 1`)/nrow(female_only),2)#female grade 1 average
female_G2_average = round(sum(male_only$`Grade 2`)/nrow(female_only),2)#female grade 2 average
female_G3_average = round(sum(male_only$`Grade 3`)/nrow(female_only),2)#female grade 3 average

male_all_average = c(male_G1_average,male_G2_average,male_G3_average) #combining all average for male
female_all_average = c(female_G1_average,female_G2_average,female_G3_average) #combining all average for female

barplot(c(male_all_average,female_all_average),width = 1,ylab="Average",ylim=c(0,20),
        names.arg =c("Male_G1","Male_G2","Male_G3","Female_G1","Female_G2","Female_G3"),
        col=c("pink","lightyellow","lightgreen","lightblue","magenta","purple"),
        main="Every average score between Male and Female")#barchart(y=average of every grade)

###sub-question = how did male students score better than female student?
#analysis 1&2 = to find out the relationship between gender,going out and romantic
ggplot(student_data,aes(x=`Go Out`,fill=Sex))+geom_histogram(binwidth=1,color="black")+
  facet_wrap(~Romantic)+ggtitle("Romantic vs Go out in each Gender")+
  #Following source code obtained from (FJCC, 2020)  
  geom_label(stat="bin",aes(label=..count..),position="stack",breaks=seq(0.5,5.5,1))

#analysis 3&4 = to find out the relationship between gender,health status and absences
ggplot(student_data,aes(x=Health,y=Absences,color=Sex))+stat_smooth(method="glm",se=FALSE)+
  ggtitle("Absences VS Health Status in each gender")




#####Question 3 = how many student didn't pass(<10) their final grade?
#analysis 1 = amount of student didn't pass
ggplot(student_data,(aes(x=`Grade 3`)))+geom_histogram(binwidth=1,aes(fill=factor(`Grade 3`)))+
  #Following source code obtained from (FJCC, 2020) 
  geom_label(stat="bin",aes(label=..count..),size=5,breaks=seq(-0.5,20.5,1),position="stack")+
  ggtitle("Score distribution for grade 3")

###sub-question = What are the causes of grade failures?
#analysis 1 = To find out the relationship between grade 3 and internet
fail_grade_3=subset(student_data,`Grade 3`<10)#student who failed in grade 3(final grade)
pass_grade_3=subset(student_data,`Grade 3`>=10)#student who passed grade 3
grade3_fail_internet_yes= sum(fail_grade_3$`Internet`=="yes")
grade3_fail_internet_no= sum(fail_grade_3$`Internet`=="no")
grade3_pass_internet_yes= sum(pass_grade_3$`Internet`=="yes")
grade3_pass_internet_no= sum(pass_grade_3$`Internet`=="no")

sum_of_grade3_internet=c(grade3_fail_internet_yes,grade3_fail_internet_no,grade3_pass_internet_yes,grade3_pass_internet_no)
pie_percentages_3.2.1=paste0(round(100 * sum_of_grade3_internet/sum(sum_of_grade3_internet), 2), "%")#percentages calculator

#visualization
pie3D(sum_of_grade3_internet,labels=paste(c("Fail - yes","Fail - no","Pass - yes","Pass - no"),pie_percentages_3.2.1),
      theta=1,main="Fail Vs Pass in Grade 3 and Internet")

#analysis 2&3 = relationship between grade 3, Higher education, reason
ggplot(student_data,aes(x=`Higher Education`,y=`Grade 3`,color=`Higher Education`))+geom_boxplot()+facet_grid(~Reason)+
  ggtitle("Relationship between Higher Education and Reason in Grade 3")

#analysis 4&5 = relationship between grade 3,travel time, address
ggplot(student_data,aes(x=`Travel Time`,y=`Grade 3`,color=`Travel Time`))+geom_point(position="jitter")+facet_wrap(~Address)+
  ggtitle("Relationship between Address and Travel Time in Grade 3")

#analysis 6&7 = relationship between grade 3,study time, extra class
fail_grade_3%>%
  select(`Extra Class`,`Study Time`,`Grade 3`)%>% 
  group_by(`Extra Class`)%>%
  summarize("Average Study Time"=mean(`Study Time`),"Average Grade 3"=mean(`Grade 3`))%>%
rbind(pass_grade_3%>%
  select(`Extra Class`,`Study Time`,`Grade 3`)%>% 
  group_by(`Extra Class`)%>%
  summarize("Average Study Time"=mean(`Study Time`),"Average Grade 3"=mean(`Grade 3`)))


#####Question 4 = Which school's students perform better in every grade?
#analysis 1 = school
student_data%>%
  select(`School`,`Grade 1`,`Grade 2`,`Grade 3`)%>%
  group_by(`School`)%>%
  summarise("Average Grade 1"=mean(`Grade 1`),"Average Grade 2"=mean(`Grade 2`),"Average Grade 3"=mean(`Grade 3`))

###sub-question = what are the factors that cause this result?
#analysis 1,2,3 = find relationship between extra activity, free time and school support
filter(student_data,`School`=="MS")%>% #only students in MS
  ggplot(aes(x=`Extra Activity`,y=`Free Time`))+geom_jitter(col="blue")+facet_wrap(~`School Support`)+
  ggtitle("MS students' relationship between Extra Activity, Free Time and School Extra Support")
  

#analysis 4,5 = find relationship between age and absence rate
student_data%>%
  select(`School`,`Age`,`Absences`)%>%
  group_by(`School`)%>%
  summarise("Average Age"=mean(Age),"Average Absences rate"=mean(`Absences`))

#analysis 6,7 = find the relationship between family support, mother education and father education
student_data%>%
  filter(`School`=="MS")%>%#only students in MS
  select(`School`,`Mother Education`,`Father Education`,`Family Support`)%>%
  group_by(`Family Support`)%>%
  summarise("School"="MS",
            "Average Mother Education"=mean(`Mother Education`),
            "Average Father Education"=mean(`Father Education`))%>%
  rbind(student_data%>%
          filter(`School`=="GP")%>%#only students in GP
          select(`School`,`Mother Education`,`Father Education`,`Family Support`)%>%
          group_by(`Family Support`)%>%
          summarise("School"="GP",
                    "Average Mother Education"=mean(`Mother Education`),
                    "Average Father Education"=mean(`Father Education`)))



#####question 5 = Students of which area get better score in every grade?
#analysis 1 = area & grade
address_grade_1=ggplot(student_data,aes(x=`Address`,y=`Grade 1`,group=`Address`))+geom_boxplot(fill="red")#grade 1 VS address
address_grade_2=ggplot(student_data,aes(x=`Address`,y=`Grade 2`,group=`Address`))+geom_boxplot(fill="blue")#grade 2 VS address
address_grade_3=ggplot(student_data,aes(x=`Address`,y=`Grade 3`,group=`Address`))+geom_boxplot(fill="yellow")#grade 3 VS address
grid.arrange(address_grade_1,address_grade_2,address_grade_3,ncol=3)#combining three graph

###sub-question = How did students who lived in urban area score better?
#analysis 1,2 = find out relationship between area, mother education level and father education level
student_data%>%
  select(`Address`,`Mother Education`,`Father Education`)%>%
  group_by(`Address`)%>%
  summarise("Average Mother Education"=mean(`Mother Education`),"Average Father Education"=mean(`Father Education`))

#analysis 3 = to find out relationship between address and internet access
urban_internet_yes = nrow(subset(student_data,Address=="U" & Internet =="yes"))#urban and yes internet
urban_internet_no = nrow(filter(student_data,Address=="U" & Internet =="no"))#urban and no internet
rural_internet_yes = nrow(subset(student_data,Address=="R" & Internet =="yes"))#rural and yes internet
rural_internet_no = nrow(filter(student_data,Address=="R" & Internet =="no"))#rural and no internet

sum_of_urban_internet=c(urban_internet_yes,urban_internet_no)#sum of urban 
sum_of_rural_internet=c(rural_internet_yes,rural_internet_no)#sum of rural

pie_percentages_5.2.3.1=paste0(round(100 * sum_of_urban_internet/sum(sum_of_urban_internet), 2), "%")#percentages calculator
pie_percentages_5.2.3.2=paste0(round(100 * sum_of_rural_internet/sum(sum_of_rural_internet), 2), "%")#percentages calculator

#Following source code referred to Joachim Schork (n.d.) 
par(mfrow=c(2,1))#for combining non-ggplot graph, row=1,col=2
pie3D(sum_of_urban_internet,labels=paste(c("U-Yes","U-No"),pie_percentages_5.2.3.1),col=c("red","green"),
      main="Urban - Internet")#urban and internet
pie3D(sum_of_rural_internet,labels=paste(c("R-Yes","R-No"),pie_percentages_5.2.3.2),col=c("orange","blue"),
      main="Rural - Internet")#rural and internet
#Following source code referred to Joachim Schork (n.d.) 
dev.off()# turn off par function

#analysis 4,5 = the relationship between address and family size and family relationship
student_data%>%
  ggplot(aes(x=`Family Relationship`,fill=`Family Size`))+geom_histogram(binwidth = 1)+facet_wrap(~`Address`)+
  #Following source code obtained from (FJCC, 2020)
  geom_label(stat="bin",aes(label=..count..),breaks=seq(0.5,5.5,1),position="stack",alpha=0.5)+
  ggtitle("Urban VS Rural in Family Size and Family Relationship")

#analysis 6,7 = the relationship between failures and higher education
`Total Higher Education` = data.frame(c(nrow(subset(student_data,`Address`=="R" & `Higher Education`=="no")),
                     nrow(subset(student_data,`Address`=="R" & `Higher Education`=="yes")),
                     nrow(subset(student_data,`Address`=="U" & `Higher Education`=="no")),
                     nrow(subset(student_data,`Address`=="U" & `Higher Education`=="yes"))))#all situation in address and higher education
names(`Total Higher Education`)="Total Higher Education"#name the column

student_data%>%
  select(`Address`,`Failures`,`Higher Education`)%>%
  group_by(`Address`,`Higher Education`)%>%
  summarise("Average Failures"=mean(Failures))%>%
  cbind(`Total Higher Education`)#column bind 




#####Question 6 = How is the distribution of every grade for students of all age?
#analysis 1 = age vs every grade
student_data%>%
  select(`Age`,`Grade 1`,`Grade 2`,`Grade 3`)%>%
  group_by(Age)%>%
  summarise("Average Grade 1"=mean(`Grade 1`),
            "Average Grade 2"=mean(`Grade 2`),
            "Average Grade 3"=mean(`Grade 3`))

###sub-question = What are the causes of this phenomenon?
#analysis 1,2,3 = the relationship between age, study time, weekday alcohol, weekend alcohol, health

student_data%>%
  select(`Age`,`Study Time`,`Weekday Alcohol`,`Weekend Alcohol`,`Health`)%>%
  group_by(Age)%>%
  summarise("Average Study Time"=mean(`Study Time`),
            "Average Weekday Alcohol"=mean(`Weekday Alcohol`),
            "Average Weekend Alcohol"=mean(`Weekend Alcohol`),
            "Average Health"=mean(Health))
  



#####Question 7 = How many students maintain distinction in every grades?
distinction_data=student_data%>%
  mutate(all_distinction=ifelse(`Grade 1`>=15 & `Grade 2`>=15 & `Grade 3`>= 15,1,0), #add a column and if all distinction then 1 is output else 0
         not_all_distinction= ifelse(`Grade 1`<15 | `Grade 2`< 15 | `Grade 3`<15,1,0))#add a column and if not all distinction then 1 is output else 0

#analysis 1 = display distinction distribution
all_and_notall_distinction=distinction_data%>% 
  summarise("All distinction"=sum(all_distinction), 
            "Not all distinction"=sum(not_all_distinction))
rownames(all_and_notall_distinction)="Total" #rename the row
View(all_and_notall_distinction)#view the result

###Sub-question= How did these students maintain their performance?
#analysis 1,2 = relationship between extra class, study time
student_with_all_distinction=distinction_data%>%filter(`Grade 1`>=15 & `Grade 2`>=15 & `Grade 3`>= 15)#all distinction
student_without_all_distinction=distinction_data%>%filter(`Grade 1`<15 | `Grade 2`<15 | `Grade 3`< 15)#not all distinction

distinction_extraclass_studytime=
  list(student_with_all_distinction%>%
       select(`Extra Class`,`Study Time`,all_distinction)%>%
       group_by(`Extra Class`)%>%
       summarise("Average Study Time"=mean(`Study Time`),"Total"=sum(all_distinction)),
        student_without_all_distinction%>%
         select(`Extra Class`,`Study Time`,not_all_distinction)%>%
         group_by(`Extra Class`)%>%
         summarise("Average Study Time"=mean(`Study Time`),"Total"=sum(not_all_distinction))) 
names(distinction_extraclass_studytime)=c("Student with all distinction","Student without all distinction")#name the variables in list
distinction_extraclass_studytime

#analysis 3,4= mother education and job
distinction_motherjob_education=
  list(student_with_all_distinction%>%
    select(`Mother Education`,`Mother Job`,`all_distinction`)%>%
    group_by(`Mother Job`)%>%
    summarise("Average Mother Education"=mean(`Mother Education`),"Total"=sum(`all_distinction`)),
      student_without_all_distinction%>%
        select(`Mother Education`,`Mother Job`,`not_all_distinction`)%>%
        group_by(`Mother Job`)%>%
        summarise("Average Mother Education"=mean(`Mother Education`),"Total"=sum(`not_all_distinction`)))
names(distinction_motherjob_education)=c("Student with all distinction","Student without all distinction")#name the variables in list
distinction_motherjob_education
  
#analysis 5,6= father education and job
distinction_fatherjob_education=
  list(student_with_all_distinction%>%
         select(`Father Education`,`Father Job`,`all_distinction`)%>%
         group_by(`Father Job`)%>%
         summarise("Average Father Education"=mean(`Father Education`),"Total"=sum(`all_distinction`)),
       student_without_all_distinction%>%
         select(`Father Education`,`Father Job`,`not_all_distinction`)%>%
         group_by(`Father Job`)%>%
         summarise("Average Father Education"=mean(`Father Education`),"Total"=sum(`not_all_distinction`)))
names(distinction_fatherjob_education)=c("Student with all distinction","Student without all distinction")#name the variables in list
distinction_fatherjob_education

#analysis 7,8,9=address, higher education, nursery
grid.arrange(student_with_all_distinction%>%
  ggplot(aes(x=`Higher Education`,fill=`Nursery`))+geom_bar(stat="count")+facet_grid(~Address)+
  geom_text(stat="count",aes(label=..count..),position="stack")+
  ggtitle("Relationship between higher education, Nursery and address for student with all distinction"),

student_without_all_distinction%>%
  ggplot(aes(x=`Higher Education`,fill=`Nursery`))+geom_bar(stat="count")+facet_grid(~Address)+
  geom_text(stat="count",aes(label=..count..),position="stack")+
  ggtitle("Relationship between higher education, Nursery and address for student without all distinction"))

#analysis 10=Go out, Romantic
grid.arrange(
student_with_all_distinction%>%
  ggplot(aes(x=`Go Out`,fill=`Romantic`))+geom_density(alpha=0.5)+
  ggtitle("Romantic Vs Go Out for student with all distinction"),
student_without_all_distinction%>%
  ggplot(aes(x=`Go Out`,fill=`Romantic`))+geom_density(alpha=0.5)+
  ggtitle("Romantic Vs Go Out for student without all distinction"))

###END
