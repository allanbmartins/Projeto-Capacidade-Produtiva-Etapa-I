#CHAMAR PACOTES/INSTALAR QUE SERÃO UTILIZADOS NESTE SCRIPT
library(readxl) #O pacote readxl facilita a obtenção de dados do Excel e para o R.(fonte de pesquisa: https://readxl.tidyverse.org/)
library(dplyr)#Acionar a biblioteca do pacote dplyr, deixando-o disponível para uso.
library(tidyverse)
#library(clusterSim) #Tem conflito com dplyr #Infelizmente, este pacote não está disponível para a versão 3.4.4. do R. Mas disponível para a versões mais recente do R.
library(cluster) # fonte pesquisa (https://smolski.github.io/livroavancado/analise-de-clusters.html)
library(cowplot) #O pacote cowplot fornece vários recursos que ajudam na criação de figuras com qualidade de publicação; fonte de pesquisa: (https://www.rdocumentation.org/packages/cowplot/versions/1.1.1)
library(ggplot2) #O pacote ggplot2 é um sistema para criar gráficos declarativamente, baseado na Gramática dos Gráficos; fonte de pesquisa: (https://www.rdocumentation.org/packages/ggplot2/versions/3.3.5)
library(factoextra) # o pacote factoextra fornece algumas funções fáceis de usar para extrair e visualizar a saída de análises de dados multivariadas; fonte de pesquisa:  (https://www.rdocumentation.org/packages/factoextra/versions/1.0.3)
library(dendextend) # O pacote "dendextend", pacote para manipular os dendrogramas; fonte de pesquisa (https://www.rdocumentation.org/packages/dendextend/versions/1.15.1)
library(FactoMineR) #O FactoMineR é um pacote R dedicado à análise exploratória de dados multivariados.
library(sf) #Um pacote que fornece acesso a recursos simples para R. Pacote sf. Fonte de pesquisa: (https://r-spatial.github.io/sf/)
library(geobr) #O pacote geobr tem as rotinas para o download dos mapas com divisões territoriais variadas. Fonte de pesquisa: (https://adrianofigueiredo.netlify.app/post/mapas-em-r-com-geobr/)
library(magrittr) #Fornece um mecanismo para encadear comandos com um novo operador forward-pipe,%>%. Fonte de pesquisa: (https://cran.r-project.org/web/packages/magrittr/index.html)
#library(geom_map)
#library(esquisse) #O pacote Esquisse permite criar gráficos com o pacote 'ggplot2' de maneira interativa, possibilitando funcionalidades como arrastar e soltar para mapear suas variáveis. Fonte de pesquisa: (https://operdata.com.br/blog/pacote-esquisse-e-graficos-interativos/)
#library(ggspatial) #Os dados espaciais mais o poder da estrutura ggplot2 significam um mapeamento mais fácil quando os dados de entrada já estão na forma de objetos espaciais. Fonte de pesquisa:(https://cran.r-project.org/web/packages/ggspatial/index.html)
library(ggimage)
#library(raster)
#library(rasterVis)
#library(colorspace)
#library(fields)
#library(patchwork)

teste <-bdcp_2012_2021 %>% filter(bdcp_2012_2021$ANO==i) %>% select(UF, X1FTINST, X2CusteioT)


#ANALISE DAS VERIfICAÇÕES DE INSTRUMENTOS PERIÓDICAS POR GRUPOS EM RELAÇÃO A fORÇA DE TRABALHO DE INSTRUMENTOS E DESPESA DE CUSTEIO TOTAL

#Definir diretorio de trabalho, isto e, o local em sua maquina para alocar os resultados.

getwd() # Mostrar o diretorio em que o R esta trabalhando. Voce pode usar o default do R ou alterar esse diretorio,
setwd("D:/01_Trabalhos Digea/02_Demandas/02_ Dados para o projeto Capacidade Produtiva da RBMLQ-I/09_4_Etapa/01_VERIf_INSTR_PER_2012_2021") 

#Ler base (excel ou csv) de dados da BDCP_Estrutura de cada tipo de serviço de Instrumentos(Verificações Periódicas), PPM, Qualidade, Outros e Jurídico

?readxl
#read_excel: Leia os arquivos xls e xlsx.
bdcp_2012_2021 <- read_excel(file.choose(), sheet=1, col_names=TRUE) #fazer a leitura/importacao do arquivo (xlsx) BDCP_Estrutura de acordo com a atividade que se queira analisar. fonte de pesquisa (https://www.luisotavio.pro/blog/como-ler-planilha-excel-no-r/)

bdcp_2012_2021 <- read_excel("D:/01_Trabalhos Digea/02_Demandas/02_ Dados para o projeto Capacidade Produtiva da RBMLQ-I/01_BDCP_Estrutura_INST_PER_2012_2021.xlsx", sheet=1, col_names=TRUE)

#read.csv2:  Leia os arquivos cvs com caracteristica (sep=";"   e dec=",".)  fonte de pesquisa (http://www.estatisticacomr.uff.br/?p=176)
#bdcp_2012_2021 <- read.csv2(file.choose(), header = TRUE, stringsAsfactors = fALSE, fill = fALSE) #fazer a leitura/importacao do arquivo (csv) BDCP_Estrutura de acordo com a atividade que se queira analisar. fonte de pesquisa (https://fmeireles.com/blog/rstats/como-importar-dados-em-csv-no-r/)

str(bdcp_2012_2021) #Ver estrutura
View(bdcp_2012_2021) #Ver formato tabela


#Transformar os dados (Criar variáveis de ANO, Uf, força de trabalho e Custeio Total)

bdcp_2012_2021 <- transform(bdcp_2012_2021,
                            ANO = as.factor(ANO),
                            UF = as.factor(UF),
                            X1FTINST = as.factor(X1FTINST),
                            X2CusteioT = as.factor(X2CusteioT))

str(bdcp_2012_2021) #Ver estrutura

#Instalar o pacote dplyr, para facilitar filtros de variáveis.


#fazer, por meio do pacote dplyr, alguns filtros importantes no banco de dados, deixando só as variáveis de nosso interesse para uso.

#Forma antiga

bdcp_2012=bdcp_2012_2021 %>% filter(bdcp_2012_2021$ANO=="2012") #filtrar somente os registro pelos exercícios.
bdcp_2013=bdcp_2012_2021 %>% filter(bdcp_2012_2021$ANO=="2013") 
bdcp_2014=bdcp_2012_2021 %>% filter(bdcp_2012_2021$ANO=="2014") 
bdcp_2015=bdcp_2012_2021 %>% filter(bdcp_2012_2021$ANO=="2015") 
bdcp_2016=bdcp_2012_2021 %>% filter(bdcp_2012_2021$ANO=="2016") 
bdcp_2017=bdcp_2012_2021 %>% filter(bdcp_2012_2021$ANO=="2017") 
bdcp_2018=bdcp_2012_2021 %>% filter(bdcp_2012_2021$ANO=="2018") 
bdcp_2019=bdcp_2012_2021 %>% filter(bdcp_2012_2021$ANO=="2019") 
bdcp_2020=bdcp_2012_2021 %>% filter(bdcp_2012_2021$ANO=="2020") 
bdcp_2021=bdcp_2012_2021 %>% filter(bdcp_2012_2021$ANO=="2021")


#Fazer estruturas de repetição para filtar os dados da estrutura bdcp.

#Forma nova

i <- (0) #Reinicializar variável de incremento

ano_i <- (2012) #Ano inicial do range
ano_f <- (2019) #Ano final do range

for (i in (ano_i:ano_f)){ #filtrar em loop somente os registro pelos exercícios.
  assign(paste0("bdcp_", i), 
         bdcp_2012_2021 %>% filter(bdcp_2012_2021$ANO==i))
}

#Forma antiga

FOR_CUST_2012 <- data.frame(bdcp_2012$UF, bdcp_2012$X1FTINST, bdcp_2012$X2CusteioT, row.names = 1) #formar um data-frame com as variáveis força de Trabalho e Custeio Total, para cada exercício.
FOR_CUST_2013 <- data.frame(bdcp_2013$UF, bdcp_2013$X1FTINST, bdcp_2013$X2CusteioT, row.names = 1) 
FOR_CUST_2014 <- data.frame(bdcp_2014$UF, bdcp_2014$X1FTINST, bdcp_2014$X2CusteioT, row.names = 1) 
FOR_CUST_2015 <- data.frame(bdcp_2015$UF, bdcp_2015$X1FTINST, bdcp_2015$X2CusteioT, row.names = 1) 
FOR_CUST_2016 <- data.frame(bdcp_2016$UF, bdcp_2016$X1FTINST, bdcp_2016$X2CusteioT, row.names = 1) 
FOR_CUST_2017 <- data.frame(bdcp_2017$UF, bdcp_2017$X1FTINST, bdcp_2017$X2CusteioT, row.names = 1) 
FOR_CUST_2018 <- data.frame(bdcp_2018$UF, bdcp_2018$X1FTINST, bdcp_2018$X2CusteioT, row.names = 1) 
FOR_CUST_2019 <- data.frame(bdcp_2019$UF, bdcp_2019$X1FTINST, bdcp_2019$X2CusteioT, row.names = 1) 
FOR_CUST_2020 <- data.frame(bdcp_2020$UF, bdcp_2020$X1FTINST, bdcp_2020$X2CusteioT, row.names = 1) 
FOR_CUST_2021 <- data.frame(bdcp_2021$UF, bdcp_2021$X1FTINST, bdcp_2021$X2CusteioT, row.names = 1) 

str(FOR_CUST_2012) #Ver estrutura
View(FOR_CUST_2012) #Ver formato tabela


#Forma nova e completa 

i <- (0) #Reinicializar variável de incremento.

ano_i <- (2012) #Ano inicial do range.
ano_f <- (2019) #Ano final do range.

temp <- (0) #Reinicializar variável temporária.
uf <- bdcp_2012_2021 %>% filter(bdcp_2012_2021$ANO==2012) %>% select(UF) #Variável para rownames

library(dplyr)
library(tidyverse)

for (i in (ano_i:ano_f)){ #filtrar em loop somente os registro pelos exercícios , colunas de UF, força de trabalho e custeio total.
    temp <- bdcp_2012_2021 %>% filter(bdcp_2012_2021$ANO==i) %>% select(UF, X1FTINST, X2CusteioT)
    temp <- column_to_rownames(temp, var = "UF")
    assign(paste0("for_cust_", i), temp )
  
}

#Consolidado do periódo.
for_cust_2012_2019 <- data.frame(uf, 
                                 for_cust_2012$X1FTINST, 
                                 for_cust_2013$X1FTINST,
                                 for_cust_2014$X1FTINST,
                                 for_cust_2015$X1FTINST,
                                 for_cust_2016$X1FTINST,
                                 for_cust_2017$X1FTINST,
                                 for_cust_2018$X1FTINST,
                                 for_cust_2019$X1FTINST,
                                 for_cust_2012$X2CusteioT,
                                 for_cust_2013$X2CusteioT,
                                 for_cust_2014$X2CusteioT,
                                 for_cust_2015$X2CusteioT,
                                 for_cust_2016$X2CusteioT,
                                 for_cust_2017$X2CusteioT,
                                 for_cust_2018$X2CusteioT,
                                 for_cust_2019$X2CusteioT,
                                 row.names = 1)


?row.names

#Instalar pacotes de análise de agrupamentos (AAG)
#library(clusterSim) #Infelizmente, este pacote não está disponível para a versão 3.4.4. do R. Mas disponível para a versões mais recente do R.
#library(cluster) # fonte pesquisa (https://smolski.github.io/livroavancado/analise-de-clusters.html)


# Número ótimo de clusters / fonte pesquisa (https://smolski.github.io/livroavancado/analise-de-clusters.html)
#library(cowplot) #O pacote cowplot fornece vários recursos que ajudam na criação de figuras com qualidade de publicação; fonte de pesquisa: (https://www.rdocumentation.org/packages/cowplot/versions/1.1.1)
#library(ggplot2) #O pacote ggplot2 é um sistema para criar gráficos declarativamente, baseado na Gramática dos Gráficos; fonte de pesquisa: (https://www.rdocumentation.org/packages/ggplot2/versions/3.3.5)
#library(factoextra) # o pacote factoextra fornece algumas funções fáceis de usar para extrair e visualizar a saída de análises de dados multivariadas; fonte de pesquisa:  (https://www.rdocumentation.org/packages/factoextra/versions/1.0.3)
#Elbow method
fviz_nbclust(FOR_CUST_2021, kmeans, method = "wss") + #Fonte de pesquisa: (https://pt.stackoverflow.com/questions/420967/como-definir-o-n%C3%BAmero-de-clusters-no-algoritmo-kmeans-no-r)
  geom_vline(xintercept = 4, linetype = 2)+
  labs(subtitle = "Elbow method - 2021")

#Parte II - Métodos hierárquicos Aglomerativos (função agnes)
##Nos métodos hierárquicos aglomerativos têm-se, incialmente, n grupos de 1 objeto. São efetuadas uma série de uniões até se obterem k grupos.
##Há também os métodos hierárquicos divisivos. Nesses, Inicialmente, tem um único grupo formado pelo n indivíduos. São efetuadas sucessivas divisões até se formarem k grupos

?agnes
dend_s_2012=agnes(for_cust_2012[,1:2], method ="single") #Aplicar a f_unção agnes aos dados de força de trabalho e custeio total de cada exercício, usando o método Single; 
dend_w_2012=agnes(for_cust_2012[,1:2], method ="ward") #Aplicar a função agnes aos dados de força de trabalho e custeio total de cada exercício, usando o método Ward;
dend_s_2013=agnes(for_cust_2013[,1:2], method ="single") 
dend_w_2013=agnes(for_cust_2013[,1:2], method ="ward")
dend_s_2014=agnes(for_cust_2014[,1:2], method ="single") 
dend_w_2014=agnes(for_cust_2014[,1:2], method ="ward")
dend_s_2015=agnes(for_cust_2015[,1:2], method ="single") 
dend_w_2015=agnes(for_cust_2015[,1:2], method ="ward")
dend_s_2016=agnes(for_cust_2016[,1:2], method ="single") 
dend_w_2016=agnes(for_cust_2016[,1:2], method ="ward")
dend_s_2017=agnes(for_cust_2017[,1:2], method ="single") 
dend_w_2017=agnes(for_cust_2017[,1:2], method ="ward")
dend_s_2018=agnes(for_cust_2018[,1:2], method ="single") 
dend_w_2018=agnes(for_cust_2018[,1:2], method ="ward")
dend_s_2019=agnes(for_cust_2019[,1:2], method ="single") 
dend_w_2019=agnes(for_cust_2019[,1:2], method ="ward")
dend_s_2020=agnes(for_cust_2020[,1:2], method ="single") 
dend_w_2020=agnes(for_cust_2020[,1:2], method ="ward")
dend_s_2021=agnes(for_cust_2021[,1:2], method ="single") 
dend_w_2021=agnes(for_cust_2021[,1:2], method ="ward")

str(dend_s_2012)
str(DEN_W_2012)

dend_S_2012_2019=agnes(for_cust_2012_2019[,1:16], method ="single") #Aplicar a f_unção agnes no consolidado dos dados de força de trabalho e custeio total de cada exercício, usando o método Single; 
dend_W_2012_2019=agnes(for_cust_2012_2019[,1:16], method ="ward") 

#Estrutura de repetição dos dendrogramas função agnes - method ="single"


for (i in (ano_i:ano_f)){ 
  temp = for_cust_==i
    
  temp = agnes(for_cust_i[,1:2], method ="single")
  assign(paste0("dend_s_", i), temp )
  
}


#Criar/plotar "Dendrograma da função Agnes - método Single e Ward para os exercícios de 2012 a 2021 da força de Trabalho de Instrumentos x Custeio Total.

?fviz_dend #. "fviz_dend( )", no pacote factoextra, para criar facilmente no ggplot2;fonte de pesquisa (https://www.rdocumentation.org/packages/factoextra/versions/1.0.7/topics/fviz_dend)
?dendextend

#library(dendextend) #. "dendextend", pacote para manipular os dendrogramas; fonte de pesquisa (https://www.rdocumentation.org/packages/dendextend/versions/1.15.1)

#Dendrogramas série agnes - método Single
D_S_1 <- fviz_dend(dend_s_2012,
                k = 4, # Cut in four groups
                #sub = "A",
                color_labels_by_k = TRUE,  # color labels by groups
                cex = .6, # Tamanho das etiquetas
                main = "2012- Força Trab. Inst. x Custeio Total",
                xlab = "UF", # Eixo X, horizontal
                ylab = "Distância", # Eixo Y, vertical
                k_colors = c("jco"), # OR JCO fill color for rectangles
                rect = TRUE, 
                rect_border = "jco", 
                rect_fill = TRUE,
                ggtheme = theme_gray()     # Change theme
)

D_S_2 <- fviz_dend(dend_s_2013,
                k = 4, # Cut in four groups
                color_labels_by_k = TRUE,  # color labels by groups
                cex = .6, # Tamanho das etiquetas
                main = "2013- Força Trab. Inst. x Custeio Total",
                xlab = "UF", # Eixo X, horizontal
                ylab = "Distância", # Eixo Y, vertical
                k_colors = c("jco"), # OR JCO fill color for rectangles
                rect = TRUE, 
                rect_border = "jco", 
                rect_fill = TRUE,
                ggtheme = theme_gray()     # Change theme
)

D_S_3 <- fviz_dend(dend_s_2014,
                k = 4, # Cut in four groups
                #color_labels_by_k = TRUE,  # color labels by groups
                cex = .6, # Tamanho das etiquetas
                main = "2014- Força Trab. Inst. x Custeio Total",
                xlab = "UF", # Eixo X, horizontal
                ylab = "Distância", # Eixo Y, vertical
                k_colors = c("jco"), # OR JCO fill color for rectangles
                rect = TRUE, 
                rect_border = "jco", 
                rect_fill = TRUE,
                ggtheme = theme_gray()     # Change theme
)

D_S_4 <- fviz_dend(dend_s_2015,
                k = 4, # Cut in four groups
                color_labels_by_k = TRUE,  # color labels by groups
                cex = .6, # Tamanho das etiquetas
                main = "2015- Força Trab. Inst. x Custeio Total",
                xlab = "UF", # Eixo X, horizontal
                ylab = "Distância", # Eixo Y, vertical
                k_colors = c("jco"), # OR JCO fill color for rectangles
                rect = TRUE, 
                rect_border = "jco", 
                rect_fill = TRUE,
                ggtheme = theme_gray()     # Change theme
)

D_S_5 <- fviz_dend(dend_s_2016,
                k = 4, # Cut in four groups
                color_labels_by_k = TRUE,  # color labels by groups
                cex = .6, # Tamanho das etiquetas
                main = "2016- Força Trab. Inst. x Custeio Total",
                xlab = "UF", # Eixo X, horizontal
                ylab = "Distância", # Eixo Y, vertical
                k_colors = c("jco"), # OR JCO fill color for rectangles
                rect = TRUE, 
                rect_border = "jco", 
                rect_fill = TRUE,
                ggtheme = theme_gray()     # Change theme
)

D_S_6 <- fviz_dend(dend_s_2017,
                k = 4, # Cut in four groups
                color_labels_by_k = TRUE,  # color labels by groups
                cex = .6, # Tamanho das etiquetas
                main = "2017- Força Trab. Inst. x Custeio Total",
                xlab = "UF", # Eixo X, horizontal
                ylab = "Distância", # Eixo Y, vertical
                k_colors = c("jco"), # OR JCO fill color for rectangles
                rect = TRUE, 
                rect_border = "jco", 
                rect_fill = TRUE,
                ggtheme = theme_gray()     # Change theme
)

D_S_7 <- fviz_dend(dend_s_2018,
                k = 4, # Cut in four groups
                color_labels_by_k = TRUE,  # color labels by groups
                cex = .6, # Tamanho das etiquetas
                main = "2018- Força Trab. Inst. x Custeio Total",
                xlab = "UF", # Eixo X, horizontal
                ylab = "Distância", # Eixo Y, vertical
                k_colors = c("jco"), # OR JCO fill color for rectangles
                rect = TRUE, 
                rect_border = "jco", 
                rect_fill = TRUE,
                ggtheme = theme_gray()     # Change theme
)

D_S_8 <- fviz_dend(dend_s_2019,
                k = 4, # Cut in four groups
                color_labels_by_k = TRUE,  # color labels by groups
                cex = .6, # Tamanho das etiquetas
                main = "2019- Força Trab. Inst. x Custeio Total",
                xlab = "UF", # Eixo X, horizontal
                ylab = "Distância", # Eixo Y, vertical
                k_colors = c("jco"), # OR JCO fill color for rectangles
                rect = TRUE, 
                rect_border = "jco", 
                rect_fill = TRUE,
                ggtheme = theme_gray()     # Change theme
)

D_S_9 <- fviz_dend(dend_s_2020,
                k = 4, # Cut in four groups
                color_labels_by_k = TRUE,  # color labels by groups
                cex = .6, # Tamanho das etiquetas
                main = "2020- Força Trab. Inst. x Custeio Total",
                xlab = "UF", # Eixo X, horizontal
                ylab = "Distância", # Eixo Y, vertical
                k_colors = c("jco"), # OR JCO fill color for rectangles
                rect = TRUE, 
                rect_border = "jco", 
                rect_fill = TRUE,
                ggtheme = theme_gray()     # Change theme
)

D_S_10 <- fviz_dend(dend_s_2021,
                 k = 4, # Cut in four groups
                 color_labels_by_k = TRUE,  # color labels by groups
                 cex = .6, # Tamanho das etiquetas
                 main = "2021- Força Trab. Inst. x Custeio Total",
                 xlab = "UF", # Eixo X, horizontal
                 ylab = "Distância", # Eixo Y, vertical
                 k_colors = c("jco"), # OR JCO fill color for rectangles
                 rect = TRUE, 
                 rect_border = "jco", 
                 rect_fill = TRUE,
                 ggtheme = theme_gray()     # Change theme
)

#Dendrogramas série agnes - método Single (Painel de vizualização com 10 dedrogramas de 2012 a 2021)
plot_grid(D_S_1, D_S_2, D_S_3, D_S_4, D_S_5, D_S_6, D_S_7, D_S_8, D_S_9, D_S_10, ncol = 5, nrow = 2)

#plot_grid(D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, labels=c("2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021"), main = "Dendrograma da função Agnes - método Single - para o exercício de 2012 (Força de Trabalho de Instrumentos x Custeio Total", ncol = 5, nrow = 2)

#Dendrogramas série agnes - método Single por  exercício
plot_grid(D_S_1, ncol = 1, nrow = 1)


#Dendrogramas série agnes - método Single por 2012 a 2019
D_S_11 <- fviz_dend(dend_S_2012_2019,
                    k = 4, # Cut in four groups
                    color_labels_by_k = TRUE,  # color labels by groups
                    cex = .6, # Tamanho das etiquetas
                    main = "2012 a 2021- Força Trab. Inst. x Custeio Total \nAgnes - metódo single",
                    xlab = "UF", # Eixo X, horizontal
                    ylab = "Distância", # Eixo Y, vertical
                    k_colors = c("jco"), # OR JCO fill color for rectangles
                    rect = TRUE, 
                    rect_border = "jco", 
                    rect_fill = TRUE,
                    ggtheme = theme_gray()     # Change theme
)

plot_grid(D_S_11, ncol = 1, nrow = 1)



#Dendrogramas série agnes - método Ward
D_W_1 <- fviz_dend(dend_w_2012,
                   k = 4, # Cut in four groups
                   #sub = "A",
                   show_labels = 
                   color_labels_by_k = TRUE,  # color labels by groups
                   cex = .6, # Tamanho das etiquetas
                   main = "2012- Força Trab. Inst. x Custeio Total",
                   xlab = "UF", # Eixo X, horizontal
                   ylab = "Distância", # Eixo Y, vertical
                   k_colors = c("jco"), # OR JCO fill color for rectangles
                   rect = TRUE, 
                   rect_border = "jco", 
                   rect_fill = TRUE,
                   ggtheme = theme_gray()     # Change theme
)

D_W_2 <- fviz_dend(dend_w_2013,
                   k = 4, # Cut in four groups
                   color_labels_by_k = TRUE,  # color labels by groups
                   cex = .6, # Tamanho das etiquetas
                   main = "2013- Força Trab. Inst. x Custeio Total",
                   xlab = "UF", # Eixo X, horizontal
                   ylab = "Distância", # Eixo Y, vertical
                   k_colors = c("jco"), # OR JCO fill color for rectangles
                   rect = TRUE, 
                   rect_border = "jco", 
                   rect_fill = TRUE,
                   ggtheme = theme_gray()     # Change theme
)

D_W_3 <- fviz_dend(dend_w_2014,
                   k = 4, # Cut in four groups
                   #color_labels_by_k = TRUE,  # color labels by groups
                   cex = .6, # Tamanho das etiquetas
                   main = "2014- Força Trab. Inst. x Custeio Total",
                   xlab = "UF", # Eixo X, horizontal
                   ylab = "Distância", # Eixo Y, vertical
                   k_colors = c("jco"), # OR JCO fill color for rectangles
                   rect = TRUE, 
                   rect_border = "jco", 
                   rect_fill = TRUE,
                   ggtheme = theme_gray()     # Change theme
)

D_W_4 <- fviz_dend(dend_w_2015,
                   k = 4, # Cut in four groups
                   color_labels_by_k = TRUE,  # color labels by groups
                   cex = .6, # Tamanho das etiquetas
                   main = "2015- Força Trab. Inst. x Custeio Total",
                   xlab = "UF", # Eixo X, horizontal
                   ylab = "Distância", # Eixo Y, vertical
                   k_colors = c("jco"), # OR JCO fill color for rectangles
                   rect = TRUE, 
                   rect_border = "jco", 
                   rect_fill = TRUE,
                   ggtheme = theme_gray()     # Change theme
)

D_W_5 <- fviz_dend(dend_w_2016,
                   k = 4, # Cut in four groups
                   color_labels_by_k = TRUE,  # color labels by groups
                   cex = .6, # Tamanho das etiquetas
                   main = "2016- Força Trab. Inst. x Custeio Total",
                   xlab = "UF", # Eixo X, horizontal
                   ylab = "Distância", # Eixo Y, vertical
                   k_colors = c("jco"), # OR JCO fill color for rectangles
                   rect = TRUE, 
                   rect_border = "jco", 
                   rect_fill = TRUE,
                   ggtheme = theme_gray()     # Change theme
)

D_W_6 <- fviz_dend(dend_w_2017,
                   k = 4, # Cut in four groups
                   color_labels_by_k = TRUE,  # color labels by groups
                   cex = .6, # Tamanho das etiquetas
                   main = "2017- Força Trab. Inst. x Custeio Total",
                   xlab = "UF", # Eixo X, horizontal
                   ylab = "Distância", # Eixo Y, vertical
                   k_colors = c("jco"), # OR JCO fill color for rectangles
                   rect = TRUE, 
                   rect_border = "jco", 
                   rect_fill = TRUE,
                   ggtheme = theme_gray()     # Change theme
)

D_W_7 <- fviz_dend(dend_w_2018,
                   k = 4, # Cut in four groups
                   color_labels_by_k = TRUE,  # color labels by groups
                   cex = .6, # Tamanho das etiquetas
                   main = "2018- Força Trab. Inst. x Custeio Total",
                   xlab = "UF", # Eixo X, horizontal
                   ylab = "Distância", # Eixo Y, vertical
                   k_colors = c("jco"), # OR JCO fill color for rectangles
                   rect = TRUE, 
                   rect_border = "jco", 
                   rect_fill = TRUE,
                   ggtheme = theme_gray()     # Change theme
)

D_W_8 <- fviz_dend(dend_w_2019,
                   k = 4, # Cut in four groups
                   color_labels_by_k = TRUE,  # color labels by groups
                   cex = .6, # Tamanho das etiquetas
                   main = "2019- Força Trab. Inst. x Custeio Total",
                   xlab = "UF", # Eixo X, horizontal
                   ylab = "Distância", # Eixo Y, vertical
                   k_colors = c("jco"), # OR JCO fill color for rectangles
                   rect = TRUE, 
                   rect_border = "jco", 
                   rect_fill = TRUE,
                   ggtheme = theme_gray()     # Change theme
)

D_W_9 <- fviz_dend(dend_w_2020,
                   k = 4, # Cut in four groups
                   color_labels_by_k = TRUE,  # color labels by groups
                   cex = .6, # Tamanho das etiquetas
                   main = "2020- Força Trab. Inst. x Custeio Total",
                   xlab = "UF", # Eixo X, horizontal
                   ylab = "Distância", # Eixo Y, vertical
                   k_colors = c("jco"), # OR JCO fill color for rectangles
                   rect = TRUE, 
                   rect_border = "jco", 
                   rect_fill = TRUE,
                   ggtheme = theme_gray()     # Change theme
)

D_W_10 <- fviz_dend(dend_w_2021,
                    k = 4, # Cut in four groups
                    color_labels_by_k = TRUE,  # color labels by groups
                    cex = .6, # Tamanho das etiquetas
                    main = "2021- Força Trab. Inst. x Custeio Total",
                    xlab = "UF", # Eixo X, horizontal
                    ylab = "Distância", # Eixo Y, vertical
                    k_colors = c("jco"), # OR JCO fill color for rectangles
                    rect = TRUE, 
                    rect_border = "jco", 
                    rect_fill = TRUE,
                    ggtheme = theme_gray()     # Change theme
)

#Dendrogramas série agnes - método Ward (Painel de vizualização com 10 dedrogramas de 2012 a 2021)
plot_grid(D_W_1, D_W_2, D_W_3, D_W_4, D_W_5, D_W_6, D_W_7, D_W_8, D_W_9, D_W_10, ncol = 5, nrow = 2)


#png(filename = "Figura3.png",width = 10, height = 8, # funções tiff() , png() , jpeg() e bmp() é possível salvar gráficos como imagem em alta resolução; Fonte de pesquisa: (https://tiagoolivoto.github.io/e-bookr/exporta.html)
    #units = "cm",pointsize = 12, "lzw",res = 1200)
#p1
#dev.off()

#plot_grid(D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, labels=c("2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021"), main = "Dendrograma da função Agnes - método Single - para o exercício de 2012 (Força de Trabalho de Instrumentos x Custeio Total", ncol = 5, nrow = 2)

#Dendrogramas série agnes - método Ward por exercício
plot_grid(dend_S_2012_2019, ncol = 1, nrow = 1)

plot_grid(dend_w_2012_2019, ncol = 1, nrow = 1)

#Dendrogramas série agnes - método Single por 2012 a 2019
D_W_11 <- fviz_dend(dend_W_2012_2019,
                    k = 4, # Cut in four groups
                    color_labels_by_k = TRUE,  # color labels by groups
                    cex = .6, # Tamanho das etiquetas
                    main = "2012 a 2021- Força Trab. Inst. x Custeio Total \nAgnes - metódo Ward",
                    xlab = "UF", # Eixo X, horizontal
                    ylab = "Distância", # Eixo Y, vertical
                    k_colors = c("jco"), # OR JCO fill color for rectangles
                    rect = TRUE, 
                    rect_border = "jco", 
                    rect_fill = TRUE,
                    ggtheme = theme_gray()     # Change theme
)

plot_grid(D_W_11, ncol = 1, nrow = 1)



#Parte III - Métodos não hierárquivos das K-Médias (função Kmeans) e dos k-medóides (função pam)
##Nos métodos não hierárquicos, os algoritmos computacionais são, em geral, iterativos.
## Os métodos das k-médias (somente variáveis quantitativas) e dos k-medóides (variáveis mistas) são os mais utilizados.
## Esses dois métodos exigem que se defina, a priori, o número k de grupos que se seja formar.


#Aplicar o método das k-médias (função kmeans)
k_1_2012=kmeans(for_cust_2012[,1:2],4) #Aplicar o método k-means para formar k=4 grupos de mais ou memos 6 OIR, repetir para cada exercício.
k_1_2012$size #Ver tamanho dos clusters
str(k_1_2012)
k_1_2012 #Ver os grupos formados pelos métodos não hierárquicos das K-médias


k_1_2012_2019 <-kmeans(for_cust_2012_2019[,1:16],4) #Aplicar o método k-means para formar k=4 grupos de mais ou memos 6 OIR, repetir para cada exercício.


help(escale)

#Criar data-frame com dados dos clusters.
cluster_2012 <- data.frame(k_1_2012$cluster) 
cluster_2012
str(cluster_2012)
cluster_2012 <- cbind(rownames(cluster_2012), data.frame(cluster_2012, row.names=NULL)) #Transformar rownames em coluna. 

cluster_2012 <- rename (cluster_2012, abbrev_state = "rownames(cluster_2012)") #Renomear colunas
cluster_2012 <- rename (cluster_2012, cod_cluster = "k_1_2012.cluster") #Renomear colunas
#?rename

#Criar data-frame com dados dos clusters.
cluster_2012_2019 <- data.frame(k_1_2012_2019$cluster) 
cluster_2012_2019
str(cluster_2012_2019)
cluster_2012_2019 <- cbind(rownames(cluster_2012_2019), data.frame(cluster_2012_2019, row.names=NULL)) #Transformar rownames em coluna. 

cluster_2012_2019 <- rename (cluster_2012_2019, abbrev_state = "rownames(cluster_2012_2019)") #Renomear colunas
cluster_2012_2019 <- rename (cluster_2012_2019, cod_cluster = "k_1_2012_2019.cluster") #Renomear colunas



write.table(cluster_2012, file = "agrupamentos_2012.csv", sep=";", col.names = TRUE, row.names = FALSE) #Exportar para leitura em Excel

#Transformar os dados da variável cluster tal que a variáveis-chave fique com mesma formatação em ambos os arquivos.
cluster_2012<-transform(cluster_2012, abbrev_state = as.factor(abbrev_state))
str(cluster_2012)

cluster_2012_2019<-transform(cluster_2012_2019, abbrev_state = as.factor(abbrev_state))
str(cluster_2012_2019)

write.table(cluster_2012_2019, file = "agrupamentos_2012_2019.csv", sep=";", col.names = TRUE, row.names = TRUE) #Exportar para leitura em Excel


#Parte IV - Agregar os resultados obtidos pelos métodos 

#?cluster
Ak_1_2012_2 <- k_1_2012$cluster #Extrair os valores (cluster) dos agrupamentos pelo método não hierárquico das K-médias
Ak_1_2012_2
str(Ak_1_2012_2)

?write.table 
write.table(Ak_1_2012_2, file = "agrupamentos_2012.csv", sep=";", col.names = TRUE, row.names = TRUE) #Exportar para leitura em Excel




#Parte V - Criar um data.frame com os dados do mapa BRASIL 2020 usando geobr - Fonte de pesquisa (https://jodavid.github.io/post/gerando-um-mapa-com-geobr-no-r/)
BR_2020<- read_state(code_state="all", year=2020)
str(BR_2012)

BR_2020 <- BR_2020[(-27),] #Retirar dos dados do Distrito Federal- DF, devido não termos os dados do mesmo separado do Goiá para usar. 
str(BR_2020)

write.table(BR_2020, file = "BR_MAPAS_2020.csv", sep=";", col.names = NA, row.names = TRUE) #Exportar dados geográficos para leitura em Excel

#Parte VI - Unir as bases de dados de georreferenciamento do IBGE com os dados dos clusters dos estados.

MAPA_2012 <- full_join(BR_2020,cluster_2012, by="abbrev_state")

MAPA_2012_2019 <- full_join(BR_2020,cluster_2012_2019, by="abbrev_state")

write.table(MAPA_2012, file = "BR_MAPAS_2012.xlsx", sep=";", col.names = TRUE, row.names = TRUE) #Exportar dados geográficos para leitura em Excel


#Parte VII - Inicar o trabalho de confeccionar o mapa

MAPA_2012_2019$categoria <- cut(MAPA_2012_2019$cod_cluster, breaks = c(0, 1, 2, 3, 4),labels =  c("Micro", "Pequeno", "Médio", "Grande")) #Transformar em categorias os conglomerados.
str(MAPA_2012_2019)

ggplot(MAPA_2012_2019)+
 geom_sf(aes(fill=categoria), colour = "black", size = 0.1)+
   scale_fill_manual(values = c("#ece7f2", "#a6bddb", "#3690c0", "#034e7b"))+
   xlab("") +  ylab("") +geom_sf_label(aes(label = abbrev_state),label.padding = unit(0.5, "mm"),size = 3)+ 
  
  #theme(panel.grid = element_line(colour = "transparent"), # tira sistema cartesiano
        #panel.background = element_blank(),
        #axis.text = element_blank(),
        #axis.ticks = element_blank())+
 
  annotation_scale(location = "br", 
                   height = unit(0.5, "cm"),
                   width = unit(0.5, "cm"))+  #Inserir escala (t em cima e b em baixo) e (r direita e l esquerdo)
  annotation_north_arrow(location = "tr", 
                         style = north_arrow_nautical,
                         height = unit(4.5, "cm"),
                         width = unit(4.5, "cm"))+ #Inserir rosa dos ventos (t em cima e b em baixo) e (r direita e l esquerdo)
  geom_image(aes(x=-37, y=-27), #Inserir imagem.
             image="D:/01_Trabalhos Digea/02_Demandas/02_ Dados para o projeto Capacidade Produtiva da RBMLQ-I/09_4_Etapa/01_VERIF_INSTR_PER_2012_2021/Mapas/Marca Inmetro/vertical-preta-traco.png",
                   size=0.15)+
  labs(title = "Força Trab. Inst. x Custeio Total - Função kmeans", #Inserir título e subtítulo.
       subtitle = "2012 a 2019",
       fill="Conglomerados \nClusters", #Especificar a nome da legenda
       x=NULL,
       y=NULL)+
  theme_bw() +
  theme(legend.position = c(0.18,0.2), #Especificar a posição da legenda.
        legend.key.size = unit(10,"mm")) #Especificar tamanho da legenda.





dendo <- fviz_dend(cluster_2012_2019,
                    k = 4, # Cut in four groups
                    color_labels_by_k = TRUE,  # color labels by groups
                    cex = .6, # Tamanho das etiquetas
                    main = "2012 a 2019 - Força Trab. Inst. x Custeio Total \n- Função kmeans",
                    xlab = "UF", # Eixo X, horizontal
                    ylab = "Distância", # Eixo Y, vertical
                    k_colors = c("jco"), # OR JCO fill color for rectangles
                    rect = TRUE, 
                    rect_border = "jco", 
                    rect_fill = TRUE,
                    ggtheme = theme_gray()     # Change theme
)
 

MAPA_2012_2019$categoria <- cut(MAPA_2012_2019$cod_cluster, breaks = c(0, 1, 2, 3, 4),labels =  c( "Micro","Pequeno","Médio","Grande")) #Transformar em categorias os conglomerados.
str(MAPA_2012_2019) 

ggplot(MAPA_2012_2019)+
  geom_sf(aes(fill=categoria), colour = "black", size = 0.1)+
  scale_fill_manual(values = c("#7fc97f","#beaed4","#fdc086", "#ffff99"))+
  xlab("") +  ylab("") +geom_sf_label(aes(label = abbrev_state),label.padding = unit(0.5, "mm"),size = 3)+ 
  
  #theme(panel.grid = element_line(colour = "transparent"), # tira sistema cartesiano
  #panel.background = element_blank(),
  #axis.text = element_blank(),
  #axis.ticks = element_blank())+
  
  annotation_scale(location = "br", 
                   height = unit(0.5, "cm"),
                   width = unit(0.5, "cm"))+  #Inserir escala (t em cima e b em baixo) e (r direita e l esquerdo)
  annotation_north_arrow(location = "tr", 
                         style = north_arrow_nautical,
                         height = unit(4.5, "cm"),
                         width = unit(4.5, "cm"))+ #Inserir rosa dos ventos (t em cima e b em baixo) e (r direita e l esquerdo)
  geom_image(aes(x=-37, y=-27), #Inserir imagem.
             image="D:/01_Trabalhos Digea/02_Demandas/02_ Dados para o projeto Capacidade Produtiva da RBMLQ-I/09_4_Etapa/01_VERIF_INSTR_PER_2012_2021/Mapas/Marca Inmetro/vertical-preta-traco.png",
             size=0.15)+
  labs(title = "Força Trab. Inst. x Custeio Total - Função kmeans", #Inserir título e subtítulo.
       subtitle = "2012 a 2019",
       fill="Conglomerados \nClusters", #Especificar a nome da legenda
       x=NULL,
       y=NULL)+
  theme_bw() +
  theme(legend.position = c(0.18,0.2), #Especificar a posição da legenda.
        legend.key.size = unit(10,"mm")) #Especificar tamanho da legenda.


