### This utility will generate a sample data set with random null values in each column.
#author: slowlyswimming

colnum = 20
rownum = 10

# Generate random numbers of NULL values for each column
nullnums = sample(0:(rownum-1),colnum,replace = TRUE)

for(i in 1:length(nullnums)){
  # Generate data for selected column without NULL data
  v = sample(1:1, 10,replace=TRUE)
  
  # Generate NULL data for the selected column
  nullindexes = sample(1:rownum, nullnums[i])
  for(j in 1:length(nullindexes)){
    nullindex = nullindexes[j]
    nullindex
    v[nullindex] = NA
  }
  
  # Put generated data column into data frame
  if(i == 1){
    sdata = data.frame(v)
  }else{
    sdata = data.frame(sdata,v)
  }
}

colnames(sdata) = seq(1, colnum)

# Save data frame to local file
write.csv(sdata, '/Users/work/project/workspace-rwe-2016/AnimationSandBox/WebContent/charts/scatter-chart/data.csv', row.names=FALSE, na="")
