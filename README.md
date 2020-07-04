# weatherData
A tool to merge tabular climate data from different sources

### The problem

If you use [INMET](http://www.inmet.gov.br/portal/) data you know the amount of work it takes to have data enough clean. 

Gaps are very common and values can be far away from the real value.

Visual checking is often required so as validation.

### Solution

The **under development** project here will basically help on the clean process from raw weather data.

It will be done using three sources (if it is available):

1. [INMET automatic station](http://www.inmet.gov.br/portal/index.php?r=estacoes/estacoesAutomaticas)
2. INMET conventional station: [Latest](http://www.inmet.gov.br/portal/index.php?r=estacoes/estacoesConvencionais) or [Historical](http://www.inmet.gov.br/portal/index.php?r=bdmep/bdmep)
3. [Xavier gridded weather data](https://github.com/AlexandreCandidoXavier/ExemplosPython)

### Actual Development

Until now it's possible to read data from automatic weather station as `.xls`. Example `.xls` files are [attached](https://github.com/FabioSeixas/weatherData/tree/master/inst/extdata/xls). 

``` r
install.packages("devtools")
devtools::install_github("FabioSeixas/weatherData")

library(weatherData)

# Put the xls files in a folder and run the following
directory = choose.dir("path/to/xls/files")
data = read_automatic(directory)
```

### OBS

INMET limit the amount of data you can obtain from its website. I know you can get in contact with them to request data from specific places and time ranges.

