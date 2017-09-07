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
* Szeliski, _Computer Vision: Algorithms and Applications_ published by Springer and available for purchase on various website or as a download (free) at http://szeliski.org/Book/.

Another reference for computer vision is below.
* Forsyth and Ponce, _Computer Vision, A Principled Approach_ Prentice Hall, 2nd Edition, 2011. (ISBN-13: 978-0136085928 ISBN-10: 013608592X) The textbook has a website: http://luthuli.cs.uiuc.edu/~daf/CV2E-site/cv2eindex.html.

#### Course Work and Evaluation
* Assignments (35%)
Assignments will be given roughly biweekly throughout the semester.
Assignments may have analytical components and a programming components.
The programming components will progressively develop a capable computer vision system.
All programming will be in Matlab.
All data for programming assignments will be provided by the instructor.
Problem sets may be discussed in groups but must be written independently, including programming.
Over-the-shoulder MATLAB debugging, for example, is not permitted.
No code from other students, on-line or off-line resources other than that explicitly mentioned in the assignment is permitted.

* Project (15%)
There will be an end-of-term team project where groups of (<=4) students will select a computer vision project problem, develop a solution and present the fruits of their labor to the class.
A short writeup will also be required.
The project implementation can build upon existing data and software, but the key components of the project must be implemented as part of the project.

* Quizzes (20%)
Quizzes will be given in class roughly bi-weekly.
The de facto quiz is 10 minutes and presents a combination of rote memory and topic comprehension; if a larger quiz will be given (e.g., in place of a full-out exam, students will be notified within two weeks).

* Exam (20%)
There will be one exam in mid-November.

* Readings/Annotations (10%)
All students are required to read the course material when it is assigned before class and provide annotations on it before class.
We expect to have weekly reading assignments. Due Tuesdays. Information below.

The lowest two grades for quizzes and participation will be dropped. The single lowest assignment will be dropped.

##### Readings and Annotations: why:
###### Overview
Students should expect one weekly reading.
We will post a pdf version on the canvas web site and an annotatable version on nb.engin.umich.edu.
Students will annotate sections of the text there.
The annotations will be visible to the student's sub-class (about 20 students rather than the full class of 100+), GSIs and instructor.
Students can rephrase difficult to understand concepts, fill in confusing steps in derivations, identify errors, provide better ways to illustrate the ideas than the examples in the book/text, ask great questions, and answer (correctly) others questions.
Students will be graded based on the quantity, quality and timeliness of their annotations.
One annotation per reading assignment is too little and more than 20 annotations is probably too much.
Providing 3 excellent annotations, including correct answers to another students good questions, will earn full credit for the week as long as they are completed in time and cover the material reasonably completely (i.e., are not just all in the first section).
###### Why annotate?
Annotating the text helps you and us.
First, you get practice reading technical material.
Once you graduate, papers and books will be your primary vehicle for learning and learning does not stop when you graduate.
If you can learn from such texts, you have mastered an important lifelong skill.
Second, by reading with attention and with an inquiring mind, you take ownership of your learning.
That skill too will be useful for your whole life (you may want to start reading ahead in some of your other classes to get more out of them; you'll have to read those books at some point anyway!).
Third, by annotating the text, you reverse the roles of student and teacher: for a change you are the one determining whats wrong or confusing.
In a traditional class, the teacher tells you what is wrong or confusing about your work.
When you annotate the text because you are confused, you have identified a problem in the text: you are right and the author is wrong!
By communicating that confusion to others, you create an opportunity to address the confusion and learn.
If many people in the class express confusion about a particular topic, we will know that we need to address that confusion in class or online.
###### How (much) should I annotate? (what we expect)
Without a lecture first, the reading is your initial (and in some sense primary) exposure to the content of this class.
It is therefore essential that you study each chapter with an inquisitive mind.
Your annotations can either be queries, comments, or answers/reactions to queries or comments posted by others.
When we look at your annotations we want them to reflect the effort you put in your study of the text.
It is unlikely that that effort will be reflected by just one or two annotations per chapter, unless your annotations are unusually thoughtful and stimulate a deep discussion.
On the other extreme, 20 per chapter is probably too many to be practical.
Somewhere in between these two extremes is about right.

##### Annotations: how:
Your annotations will be evaluated based on quality, quantity, and timeliness.
Your goal is demonstrating substantive, thorough, timely, and thoughtful reading of the material.
* Insufficient: This confuses me
* Better: "This equation appears to contradict (previous equation) or seems counter-intuitive because ..."
* Insufficient: Yes/No answers to questions without explanation.
* For more examples, see http://web.eecs.umich.edu/~fessler/course/556/r/nb-example-of-quality.pdf

Final score (per assignment) is the average of the top 3 quality scores (below) × their timeliness scores - 1 point for lack of reasonably even coverage in the text.
| Quality Score        | Description and Criteria |
| ------------- |:-------------:|
| 6      | Demonstrates thorough and thoughtful reading and insightful interpretation of the text. |
| 2      | Demonstrates reading, but little or only superficial interpretation of the text. |
| 0      | Does not demonstrate any thoughtful reading of the text. |

Each student must enter a minimum of 3 annotations per reading assignment (This number subject to change).

| Timeliness Factor  | Description and Criteria |
| ------------- |:-------------:|
| 1      | Submitted by the reading deadline, which is 11AM Tuesday, gets 1 timeliness factor. |
| 0.5    | Submitted by Friday midnight, gets 0.5 timeliness. |
| 0      | Submitted after Friday midnight, get 0 timeliness, but still helpful in learning. |

This timeliness score is computed by machine. Do not miss the deadline, even by a second.

##### Late Work and Missed Exam Policy:
__No__ late work will be accepted.
Ample time will be given to complete the assignments; use it wisely.
Similarly, the date of the exam will be known at least one month in advance.
Do not miss the exam.
__No__ make-up exams will be given other than for those University approved reasons.
This is a firm policy.
Do not expect special treatment.

##### Regrading:
Any questions about the grading of a piece of work must be raised within one week of the date that the work was returned by the teaching assistant or the instructor.
In other words, if you do not pick up your work in a timely fashion, you may forfeit your right to question the grading of your work.