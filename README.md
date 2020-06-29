# weatherData
A tool to merge tabular climate data from different sources

### The problem

If you use [INMET](http://www.inmet.gov.br/portal/) data you know the amount of work it takes to have data enough clean. 

Gaps are very often and values can be very far from the real value.

Visual checking is often required so as validation.

### Solution

The under development project here will basically help on the clean process from raw weather data.

It will be done using three sources (if it is available):

1. [INMET automatic station](http://www.inmet.gov.br/portal/index.php?r=estacoes/estacoesAutomaticas)
2. INMET conventional station: [Latest](http://www.inmet.gov.br/portal/index.php?r=estacoes/estacoesConvencionais) or [Historical](http://www.inmet.gov.br/portal/index.php?r=bdmep/bdmep)
3. [Xavier gridded weather data](https://github.com/AlexandreCandidoXavier/ExemplosPython)

Hope it could be a R package in the future


### OBS

INMET limit the amount of data you can obtain from its website. I know you can get in contact with them to request data from specific places and time ranges.

