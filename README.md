# Project: Words 4 Music

### [Project Description](doc/Project4_desc.md)

![image](http://cdn.newsapi.com.au/image/v1/f7131c018870330120dbe4b73bb7695c?width=650)

Term: Fall 2016

+ [Data link](https://courseworks2.columbia.edu/courses/11849/files/folder/Project_Files?preview=763391)-(**courseworks login required**)
+ [Data description](doc/readme.html)
+ Contributor's name: Peiran Fang
+ Projec title: Association mining of music and text
+ Project summary: In this project, we tried to use songs' muscial features to predict their lyrics. Five models are considered and tested. They are KNN, KNN Regression, Logistic Regression, Linear Regression, Random Forest. The metric I used to select models was the formula in [project evaluation](https://github.com/TZstatsADS/ADS_Teaching/tree/master/Tutorials/Topic%20Modelling). The benchmark for comparing purpose sums up all the columns in training set (lyrics words), ranks the sum, and every testing song is assigned this rank. Suprisingly, only KNN regression beat this benchmark, thus selected to be my final model.
	
Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.
