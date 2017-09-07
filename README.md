# EECS 442 Comupter Vision
## Electrical Engineering and Computer Science
## University of Michigan
### Syllabus for Fall 2017


##### Instructor:
Jason Corso (jjcorso)
##### GSIs:
Siyuan Chen (chsiyuan) and Byungsu Kyle Min (kylemin)

##### Course Webpage:
http://web.eecs.umich.edu/~jjcorso/t/442F17.

##### Canvas LMS Website:
https://umich.instructure.com/courses/173857.

##### Meeting Times / Location:
* Main Course: TuTh 15:00-14:30 in 2505 GGBL
* Discussion Sections: 
1. W 15:30-16:30 in 1311 EECS (kylemin)
2. W 13:30-14:30 in 1017 DOW (chsiyuan)

##### Prof. Office Hours: @EECS 4238
* Tuesday 13:00-14:00
* Thursday 13:30-14:00 or by appt.

##### GSI Office Hours: @EECS 3312
* Monday 14:00-16:00	(chsiyuan)
* Tuesday 9:30-11:30	(chsiyuan)
* Wednesday 9:30-11:30	(chsiyuan)
* Wednesday 13:30-15:30	(kylemin)
* Thursday 12:30-14:30	(kylemin)

##### Course Information Flow and A Note On Contacting The Instructor:
This courses primarily uses Canvas to manage information flow.
It will be used for announcements, lecture notes, assignments, and possibly for submitting work (details provided later).
The Canvas link is https://umich.instructure.com/courses/173857.
The instructor’s course website is primarily the public portal to the site for broad reach in what the course covers, it will not be updated regularly throughout the term.
Piazza will be used for discussions.
Nearly all questions you have about the course, both logistical and technical should be posted to piazza.
Only in the event of a concern of privacy, should you directly email the instructor.
We also use Nota Bene (NB) for week-to-week readings and idea exchange.
More details are below.
__Students are expected to help each other through postings and discussions on the Canvas, Piazza and NB site. In fact, some of this is factored into your grade.__


#### Main Course Material
##### Course Description:
Computer Vision seeks to extract useful information from images of various types.
This course introduces the main topics in computer vision, emphasizing the breadth of problems in computer vision as well as recent application advances.
It does introduction an intellectual framework for computer vision, but does not emphasize the theoretical aspects of that framework (as I do in EECS 504).
It emphasizes computer vision as a search for visual invariants and computer vision as mathematical modeling.
Foundational representations of images and image content will be discussed.
Cross-cutting problems of reduction (e.g., feature extraction, segmentation), estimation (e.g., post estimation, camera calibration), and matching (e.g., image stitching, stereo reconstruction) will be concretely defined and elaborated through many real examples from modern computer vision.

This course approaches the teaching of computer vision in a rather unique way in comparison to typical introductory courses in computer vision.
This course seeks to lay a foundation of the core elements of computer vision by developing these in a common mathematical framework.
In this 442 version, the course will attend to examples and pseudocode more than the theory and mathematical framework.
However, some attention to the core mathematics is needed. The core elements include how problems in extraction of useful information from images are represented, that computer vision is nicely posed as a set of optimization problems, that computer vision is a search for invariants of different forms, and that there are just a few common problem abstractions that cross-cut modern computer vision: reduction, estimation, and matching problems.

##### Rough Topic Outline:
1. Representation and Computer Vision as Optimization
2. Visual Invariance (photometric, geometric (shift, rotation, affine, scale), projective, structural, deformation, rate)
3. Reduction Problems (feature extraction, segmentation and grouping, etc.)
4. Estimation Problems (line and curve fitting, pose estimation, camera calibration, bundle adjustment, etc.)
5. Matching Problems (stereo correspondence, image stitching, image registration, etc.)

##### Course Goals:
After taking the course, the student should have a clear understanding of
1. the foundations of computer vision, including representation, invariance, reduction, estimation and matching;
2. examples of modern computer vision methods in each of the above foundations; and
3. implementation of computer vision methods on real data.
These goals are evaluated through the assignments, quizzes and exams.

##### Prerequisites:
No prior course in computer vision is needed.
EECS 281 or sufficient prior training in programming and data structures, which is necessary not only to work on real computer vision problems but also to understand how typical methods work.
A working knowledge of calculus, linear algebra, and probability theory. Students are expected to be (or become on their own time) proficient in MATLAB.
The following is a list of some mathematical tools needed for this course. We will cover them as necessary, and when we do, we will cover them in as much detail as necessary to understand how to use them but not why they work.
This is not a math course.
These are the tools of the math of computer vision and are needed to work in computer vision.
* Eigenvector decomposition
* SVD
* Linear least squares
* Non-linear least squares
* Robust estimation
* Dictionary learning and sparse coding
* Combinatorial Optimization
* Cuts on graphs
* Linear programming
* Dynamic programming

##### Textbooks:
There is no required textbook for this course.
Instructor notes will be made available as external reading and readings from the following book will be assigned periodically to deepen the understand of the material.
All readings are required.
* Szeliski _Computer Vision: Algorithms and Applications_ published by Springer and available for purchase on various website or as a download (free) at http://szeliski.org/Book/.
Another reference for computer vision is below.
* Forsyth and Ponce _Computer Vision, A Principled Approach_ Prentice Hall, 2nd Edition, 2011. (ISBN-13: 978-0136085928 ISBN-10: 013608592X) The textbook has a website: http://luthuli.cs.uiuc.edu/~daf/CV2E-site/cv2eindex.html.