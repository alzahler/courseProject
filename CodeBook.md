Code Book
==============

Files and Raw Data
-----
The run_analysis.R uses 6 files from where it obtains the raw data that was divided in a train and test group as follows:

Test Group
* subject_text.txt: a vector of 2947 observations of one variables, the subject ID.
* X_test.txt: a vector of 2947 observations of 561 variables
* Y_test.txt: a vector of 2947 observations of 1 variable, the activity performed.

Training Group
* subject_train.txt
* X_test.txt
* Y_test.txt

These data can be downloaded from:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Variables
---------
There were 66 variables selected from the 561 available in the files with the raw data:

* tBodyAcc-XYZ, mean & std (6)
* tGravityAcc-XYZ, mean & std (6)
* tBodyAccJerk-XYZ, mean & std (6)
* tBodyGyro-XYZ, mean & std (6)
* tBodyGyroJerk-XYZ, mean & std (6)
* tBodyAccMag, mean & std (2)
* tGravityAccMag, mean & std (2)
* tBodyAccJerkMag, mean & std (2)
* tBodyGyroMag, mean & std (2)
* tBodyGyroJerkMag, mean & std (2)
* fBodyAcc-XYZ, mean & std (6)
* fBodyAccJerk-XYZ, mean & std (6)
* fBodyGyro-XYZ, mean & std (6)
* fBodyAccMag, mean & std (2)
* fBodyAccJerkMag, mean & std (2)
* fBodyGyroMag, mean & std (2)
* fBodyGyroJerkMag, mean & std (2)

The variables names were renamed from the original raw data, as follows:


1. tbodyaccmeanx
2. tbodyaccmeany
3. tbodyaccmeanz
4. tbodyaccstdx
5. tbodyaccstdy
6. tbodyaccstdz
7. tgravityaccmeanx
8. tgravityaccmeany
9. tgravityaccmeanz
10. tgravityaccstdx
11. tgravityaccstdy
12. tgravityaccstdz
13. tbodyaccjerkmeanx
14. tbodyaccjerkmeany
15. tbodyaccjerkmeanz
16. tbodyaccjerkstdx
17. tbodyaccjerkstdy
18. tbodyaccjerkstdz
19. tbodygyromeanx
20. tbodygyromeany
21. tbodygyromeanz
22. tbodygyrostdx
23. tbodygyrostdy
24. tbodygyrostdz
25. tbodygyrojerkmeanx
26. tbodygyrojerkmeany
27. tbodygyrojerkmeanz
28. tbodygyrojerkstdx
29. tbodygyrojerkstdy
30. tbodygyrojerkstdz
31. tbodyaccmagmean
32. tbodyaccmagstd
33. tgravityaccmagmean
34. tgravityaccmagstd
35. tbodyaccjerkmagmean
36. tbodyaccjerkmagstd
37. tbodygyromagmean
38. tbodygyromagstd
39. tbodygyrojerkmagmean
40. tbodygyrojerkmagstd
41. fbodyaccmeanx
42. fbodyaccmeany
43. fbodyaccmeanz
44. fbodyaccstdx
45. fbodyaccstdy
46. fbodyaccstdz
47. fbodyaccjerkmeanx
48. fbodyaccjerkmeany
49. fbodyaccjerkmeanz
50. fbodyaccjerkstdx
51. fbodyaccjerkstdy
52. fbodyaccjerkstdz
53. fbodygyromeanx
54. fbodygyromeany
55. fbodygyromeanz
56. fbodygyrostdx
57. fbodygyrostdy
58. fbodygyrostdz
59. fbodyaccmagmean
60. fbodyaccmagstd
61. fbodybodyaccjerkmagmean
62. fbodybodyaccjerkmagstd
63. fbodybodygyromagmean
64. fbodybodygyromagstd
65. fbodybodygyrojerkmagmean
66. fbodybodygyrojerkmagstd

No changes were performed to the variables (quantitative data).

Further Cleaning
---------------
The labels of the activities were rewritten as follows:

1. walking
2. walkingupstairs
3. walkingdownstairs
4. sitting
5. standing
6. laying

Instead of using the number as the factor value, the category was used in order to make the data more readable.

Finally, for the Tidy Data, for each individual and activity combination, an arithmetic mean was calculated for the 66 variables.

