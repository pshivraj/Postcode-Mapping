library(Imap)
df.postcodes <- read.csv("dbm.csv")
df.postcodes1 <- read.csv("apn.csv")
## a vectorized version of `gdist`
## x and y are vectors of index 
dist_imap <- 
  function(x,y){
    p1 <- df.postcodes[x,]
    p2 <- df.postcodes1[y,]
    mapply(gdist,p1$lon,p1$lat,p2$lon,p2$lat)
  }
## Use index of rows since we have to loop over data.frames
X <- seq_len(nrow(df.postcodes))
Y <- seq_len(nrow(df.postcodes1))
## outer will generate all comobination of index 
## and pply the vectorized function already created.
res <- outer(X,Y,dist_imap)
## naming for pretty output
rownames(res)  <- df.postcodes$postcode 
colnames(res) <- df.postcodes1$postal_code

#         210751   200991
# 21075 125.2018 66.91572
# 20099 118.7207 70.15158
# 33613 222.3866 96.82441