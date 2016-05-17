### This utility will generate a sample data set according to the specified data schema.
### The dataset will have random null values in each column.
#author: slowlyswimming

library(jsonlite)

url = '/Users/work/project/workspace-r-2016/r-utilities/generate-random-dataset/data-schema.json'
schema <- fromJSON(txt=url)

# Generate random numbers of NULL values for each column
nullnums = sample(0:(schema$rownum-1),length(schema$columns[1]$name),replace = TRUE)

for(i in 1:length(nullnums)){
  if(schema$columns[2]$type[i] == 'numeric'){
    # Generate data for selected column without NULL data
    dmin = schema$columns[3]$min[i]
    dmax = schema$columns[4]$max[i]
    v = sample(dmin:dmax,schema$rownum,replace = TRUE)
    
    # Generate NULL data for the selected column
    nullindexes = sample(1:schema$rownum, nullnums[i])
    for(j in 1:length(nullindexes)){
      nullindex = nullindexes[j]
      nullindex
      v[nullindex] = NA
    }
  }else if(schema$columns[2]$type[i] == 'double'){
    # Generate data for selected column without NULL data
    dmin = schema$columns[3]$min[i]
    dmax = schema$columns[4]$max[i]
    v = runif(schema$rownum,dmin,dmax)
    
    # Generate NULL data for the selected column
    nullindexes = sample(1:schema$rownum, nullnums[i])
    for(j in 1:length(nullindexes)){
      nullindex = nullindexes[j]
      nullindex
      v[nullindex] = NA
    }
  }else if (schema$columns[2]$type[i] == 'categorical'){
    # Generate data for selected column without NULL data
    drange = schema$columns[5]$range[i][[1]]
    v = sample(drange,schema$rownum,replace = TRUE)
    
    # Generate NULL data for the selected column
    nullindexes = sample(1:schema$rownum, nullnums[i])
    for(j in 1:length(nullindexes)){
      nullindex = nullindexes[j]
      nullindex
      v[nullindex] = NA
    }
  }
  
  # Put generated data column into data frame
  name = schema$columns[1]$name[i]
  if(i == 1){
    sdata = data.frame(v)
  }else{
    sdata = data.frame(sdata,v)
  }
}

colnames(sdata) = schema$columns[1]$name

# Save data frame to local file
write.csv(sdata, '/Users/work/project/workspace-rwe-2016/AnimationSandBox/WebContent/charts/scatter-chart/data.csv', row.names=FALSE, na="")
