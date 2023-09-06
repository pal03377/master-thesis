#import "thesis_template.typ": *
#import "common/cover.typ": *
#import "common/titlepage.typ": *
#import "thesis_typ/disclaimer.typ": *
#import "thesis_typ/acknowledgement.typ": *
#import "thesis_typ/abstract_en.typ": *
#import "thesis_typ/abstract_de.typ": *

// Enter your thesis data here:
#let titleEnglish = "Generalizing Machine-Learning Based Assessments"
#let titleGerman = "Verallgemeinerung von auf maschinellem Lernen basierenden Bewertungen"
#let degree = "Master"
#let program = "Informatics"
#let supervisor = "Prof. Dr. Stephan Krusche"
#let advisors = ("Maximilian Sölch, M.Sc.",)
#let author = "Paul Schwind"
#let startDate = "March 15, 2023"
#let submissionDate = "September 15, 2023"


#cover(
  title: titleEnglish,
  degree: degree,
  program: program,
  author: author,
)

#titlepage(
  title: titleEnglish,
  titleGerman: titleGerman,
  degree: degree,
  program: program,
  supervisor: supervisor,
  advisors: advisors,
  author: author,
  startDate: startDate,
  submissionDate: submissionDate
)

#disclaimer(
  title: titleEnglish,
  degree: degree,
  author: author,
  submissionDate: submissionDate
)

#acknowledgement()

#abstract_en()

#abstract_de()

#show: project.with(
  title: titleEnglish,
  titleGerman: titleGerman,
  degree: degree,
  program: program,
  supervisor: supervisor,
  advisors: advisors,
  author: author,
  startDate: startDate,
  submissionDate: submissionDate
)

// Custom functions
// inspired by https://github.com/typst/typst/issues/325#issuecomment-1502633209:
#let enumlink(prefix, enum_counter, label) = link(label)[#locate(loc => {
  let item = query(selector(label), loc).first();
  [#{prefix}~#{numbering("1",..enum_counter.at(item.location()).map(i => i+1))}] // can't work out numbering of enum, but render number
})]

#let fr_counter = counter("fr")
#let fr(it) = block[
  #fr_counter.step()
  #enum(numbering: n => "FR " + fr_counter.display(), body-indent: 2em)[
    #it
  ]
]
#let frlink(label) = enumlink("FR", fr_counter, label)
#let nfr_counter = counter("nfr")
#let nfr(it) = block[
  #nfr_counter.step()
  #enum(numbering: n => "NFR " + nfr_counter.display(), body-indent: 2em)[
    #it
  ]
]
#let nfrlink(label) = enumlink("NFR", nfr_counter, label)
#show ref: it => {
  if it.element != none and it.element.func() == fr {
    "FR " + it.element.args[0].display()
  } else if it.element != none and it.element.func() == nfr {
    "NFR " + it.element.args[0].display()
  } else {
    it
  }
}

= Introduction
What is the best way to provide feedback on online exercises?
Written feedback can have many forms, including simple corrections, marks, comments, questions and targets~@morris2021formative.
Feedback is information provided by an agent, such as a teacher, to a learner, such as a student, regarding aspects of the learner's performance or understanding~@hattie2007feedback. It can effectively guide students toward the correct solution and help them learn from their mistakes, depending on the quality and impact of the feedback~@hattie2007feedback.
Feedback is an essential part of the learning process, and it is especially important in the context of online learning. In this context, feedback can be provided by a teacher or a computer system. The latter is called automatic feedback.
Automatic feedback can be especially helpful in courses with a large number of students, where it is not feasible for a teacher to provide feedback to each student individually~@ArTEMiS.
Keuning et al. found that such feedback has increased in diversity over the last decades and "new techniques are being applied to generate feedback that is increasingly helpful for students"~@keuning2018review.

The automated generation of feedback is a challenging task, yet it is crucial for the success of online learning: It is difficult for teachers to provide feedback to each student individually in courses with a large number of students~@ArTEMiS. The number of students in computer science courses at universities is steadily increasing. At the Technical University of Munich, the number of full-time students#footnote[i.e., full-time equivalents] has recently increased by more than 2,400 within five years#footnote[TUM in Zahlen 2020, https://mediatum.ub.tum.de/doc/1638190/1638190.pdf].

The current state of the art does not yet provide a satisfactory solution to fully automating the feedback process for most types of exercises. However, the process of providing individual feedback to each student can be supported by semi-automatic feedback systems, e.g. the CoFee framework for textual exercises presented by Bernius et al~@cofee.
The implementation of the CoFee framework is called _Athena_#footnote[Source code and setup documentation available on https://github.com/ls1intum/Athena-CoFee, last visited August 17th, 2023] and is integrated into the _Artemis_ learning platform#footnote[Source code and links to the documentation available on https://github.com/ls1intum/Artemis, last visited August 14th, 2023] that is developed and used at the Technical University of Munich. From 2019 to 2021, this integration effectively streamlined the grading process for 34 exercises~@cofee2.

Cremer and Michel recently enhanced the system in two key dimensions: adding support for more languages in text assessments and increasing the system's capacity to handle a higher workload~#cite("atheneLanguage", "atheneLoadBalancer").

== Problem <problem>
// Note: Describe the problem that you like to address in your thesis to show the importance of your work. Focus on the negative symptoms of the currently available solution.
Although Athena effectively generates feedback suggestions for tutors in text submissions using the CoFee approach~@cofee2, a significant issue remains: The current architecture of Athena constrains its extensibility and adaptability.

Currently, Athena is bound to one approach in the process of generating feedback suggestions for tutors and it only supports text submissions using the _CoFee_ approach. This decreases the flexibility and extensibility of the system and is one of the main points we will improve in this thesis.
On a more practical level, Athena does not support programming exercises, which are commonly featured in computer science courses. The lack of support for programming exercises in Athena is a limitation, especially considering that this feature is a main advantage of Artemis over other exercise management systems, such as Moodle#footnote[https://moodle.org]. Therefore, extending Athena to support programming exercises is a critical area for improvement.
// Support for automatic assessments of modeling exercises in Athena would also be beneficial. These are already possible using _Compass_~@compass, which is currently integrated with Artemis and is not a focus of this thesis.

Two types of actors could have problems with the current status of Athena:
- *Tutors* in courses with manually graded programming exercises: They cannot profit from Athena's assessment generation capabilities, because Athena does not support programming exercises. This means that they won't get any automatically generated suggestions for programming exercises, which would save them a lot of time.
  For textual exercises, Athena currently provides suggestions for around 45\% of the submissions~@cofee2.
- Also, it is difficult for *researchers* to integrate additional approaches and features into Athena, as the system is currently bound to one approach for each step in the generation process. 
  The system for the actual choice of assessment suggestions is part of Artemis (outside Athena). This external dependency makes it impossible to change the logic for the suggestion choice independently of Artemis. In a more general sense, this architecture violates the _Single Responsibility Principle_. // TODO: Add citation for SRP
  More practically, it prevents Athena from being used with other LMSs than Artemis, which is a significant limitation.
  For example, recent innovations in the field of machine learning like the openly available LLaMA language model~@touvron2023llama or the GPT-4 model from OpenAI~@openai2023gpt4 could be used to improve the quality of feedback suggestions, but this is not possible with the current system architecture.

== Motivation
// Note: Motivate scientifically why solving this problem is necessary. What kind of benefits do we have by solving the problem?
In this section, we explore the potential benefits of addressing the identified issues in Athena, specifically its constrained approach to generating feedback suggestions and its current inability to support programming exercises.

Quality feedback to students holds significant importance. To this end, equipping tutors with the necessary support to improve their feedback delivery is crucial. This support allows tutors to allocate more time to challenging assessments. Evaluations by tutors, both positive and negative, not only document students' knowledge but also play a pivotal role in shaping their learning and motivation~@wulf2010feedback. As such, these assessments must be conducted with care and effectiveness~@sabilah2018openended.

Second, extending Athena to support programming exercises aligns with Artemis's strengths and addresses a significant gap in its current functionality. By enabling Athena to generate feedback suggestions for programming exercises, we align the capabilities of Athena with the fundamental features of Artemis, thereby creating a more seamless and comprehensive user experience for tutors.
By extension, the experience for students will improve as well, as they will receive more timely, consistent and thorough feedback on their submissions.
Hattie et al. note that only feedback that addresses multiple dimensions (like the direction, the progress and the next steps) are effective in improving student performance~@hattie2007educational, so it is important that tutors have the time and resources to provide such feedback. Athena can help with this by providing feedback suggestions, which will save tutors time and effort.

Last, keeping the Athena system updated with the latest developments in the field of machine learning is essential for maintaining its competitive edge. The current system architecture has limitations when it comes to integrating new approaches into Athena. With a redesigned system, we aim to significantly enhance its flexibility and extensibility. This update will allow Athena to more easily incorporate future innovations in feedback suggestions, and to adapt swiftly to the state of the art. Additionally, this new architecture will facilitate the combination of different approaches, accelerating research and enabling more timely alignment with emerging developments.

== Objectives
// Note: Describe the research goals and/or research questions and how you address them by summarizing what you want to achieve in your thesis, e.g. developing a system and then evaluating it.
This thesis aims to address the issues outlined in @problem by advocating for a transformative architectural shift in Athena, designed to enhance its flexibility and extensibility.
To achieve this overarching objective, we have identified the following specific sub-goals:

=== Shift in System Responsibilities
We want to shift the responsibility of computing feedback suggestions from the Artemis system to Athena. This will allow us to decouple the two systems and make Athena more flexible and extensible.
The Athena system will be independently deployable and will be able to provide feedback suggestions for any learning management system (LMS) like Artemis. Further development will also be accelerated, as Athena can be developed and tested independently of Artemis.

=== Modularized Architecture
The transformation to a modularized architecture will be realized by evolving the current system architecture to accommodate various _assessment modules_.
There will be an _assessment module manager_ that is responsible for managing the interactions between the assessment modules and the LMS.
An assessment module is a self-contained component designed to offer various functionalities related to feedback suggestion generation. At its core, it provides a mechanism to generate feedback suggestions for a submission.
Additionally, based on specific requirements, the module may offer extended capabilities, such as receiving feedback from tutors or suggesting a subsequent submission for a student.

=== Assisting Tools for Module Development
We will provide a basic tool for testing assessment modules while in development, called the "playground". This will serve as a straightforward web interface, allowing developers to send sample submissions and feedback to the assessment module under development, request feedback suggestions, and comprehensively test the module using exemplary data.

Additionally, we will offer a Python package, called `athena`, aimed at streamlining the creation of assessment modules. While the technical stack for developing an assessment module remains unrestricted, this supplementary tool is designed to enhance the development experience and accelerate the development process for Python developers.

=== Programming Assessment Module "ThemisML"
We will develop a specialized assessment module for programming exercises, informed by insights from the practical course _iPraktikum_ at the Technical University of Munich.
This module will leverage the pre-trained model CodeBERT~@codeBERT, developed by Microsoft, to embed and cluster programming submissions. This approach will enable the generation of feedback suggestions for programming exercises like CoFee.
Furthermore, we will seamlessly integrate these suggestions into the assessment user interface of Artemis.

== Outline
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Describe the outline of your thesis
]

= Background
// Note: Describe each proven technology/concept shortly that is important to understand your thesis. Point out why it is interesting for your thesis. Make sure to incorporate references to important literature here.
In this chapter, the key concepts and technologies essential to this thesis are presented. First, the Artemis learning management system is introduced, which serves as the integration point for Athena.
Next, the CoFee framework is discussed; this is the current method employed by Athena to generate feedback suggestions for textual exercises.
This is followed by an overview of the ThemisML approach, the proposed strategy for Athena to generate feedback suggestions for programming exercises.
Finally, we give an overview of the microservice architecture, which Athena leverages to structure its components.

== Artemis
Artemis is an open-source automated assessment management system designed for large computer science classes~@ArTEMiS. It automatically evaluates students' programming assignments and provides immediate, iterative feedback, enabling students to refine their solutions~@ArTEMiS.
It features an online code editor and interactive exercise instructions, making it adaptable and programming language-independent. The system is intended to reduce instructors' manual assessment workload and to enhance the learning experience for students by offering timely and actionable feedback on their work~@ArTEMiS.
At the time of writing, Artemis supports exercises in the following formats: programming, text, modeling, file upload and quiz.

== CoFee
// Will describe in "Current System"
CoFee is "a machine learning approach designed to suggest computer-aided feedback in open-ended textual exercises"~@cofee.
We will describe the CoFee approach and its current implementation in more detail in @currentSystem.

== ThemisML
ThemisML is a "system for automated feedback suggestions of programming exercises"#footnote[https://github.com/ls1intum/Themis-ML, last visited September 5th, 2023] developed by a group of the practical course "iPraktikum" in the winter semester of 2022/23 at the Technical University of Munich. It is based on the CodeBERT model~@codeBERT, which is a pre-trained model for programming language processing by Microsoft.
Its source code is openly available on #link("https://github.com/ls1intum/Themis-ML")[GitHub]. The following description is based on the documentation of the system, available at https://ls1intum.github.io/Themis.

Similar to CoFee, ThemisML analyzes student code submissions and compares them with past feedback from previous assessments. Based on this analysis, ThemisML proposes context-specific feedback for the current submission, which tutors can review and modify as needed. This system aims to streamline the assessment process, enhancing both the accuracy and efficiency of feedback provided to students.
ThemisML employs ANTLR4#footnote[https://www.antlr.org, last visited August 17th, 2023] for method extraction from code and utilizes CodeBERTScore~@zhou2023codebertscore#footnote[Source code available at https://github.com/neulab/code-bert-score, last visited August 17th, 2023. At the time of initial development, the source code was already available, but the complementary paper was not released yet.], a wrapper for the CodeBERT machine learning model~@codeBERT, to compare code submissions and assess their similarity.
Thus, ThemisML is a tool that helps tutors who use the Themis app give clearer and more focused feedback on student programming assignments.

// == FastAPI // TODO: Do I want this here?

== Microservice Architecture
// TODO: Also talk about Docker?
Microservices are small, autonomous services that communicate through well-defined APIs, allowing them to be independently deployed and evolved without tight coupling to other services~@newman2015building.

Newman highlights several notable advantages of adopting a microservice architecture in the book "Building Microservices"~@newman2015building, including:
- *Technology Heterogeneity:* This architecture allows for the use of diverse technologies across different services, offering flexibility and potentially enhancing the development process.
- *Resilience:* The isolated nature of microservices ensures that the failure of one service does not directly impact the functionality of others, contributing to the overall system's robustness.
- *Scaling:* Microservices facilitate more straightforward and efficient scaling of individual services, as opposed to the often cumbersome scaling of a monolithic application.

While these advantages are enticing, microservices are also generally seen as more complex to manage and deploy compared to monolithic architectures~@hossain2023microservice,
they can be more difficult to test in combination with other services~@hossain2023microservice,
and can even be worse in performance in specific cases~@aldebagy2018comparative.

= Related Work
// Note: Describe related work regarding your topic and emphasize your (scientific) contribution in contrast to existing approaches/concepts/workflows. Related work is usually current research by others and you defend yourself against the statement: “Why is your thesis relevant? The problem was already solved by XYZ.” If you have multiple related works, use subsections to separate them.

_Atenea_#footnote[Not to be confused with *Athena*, the name of the system we are developing.] is a system that provides automatic scores for short textual answers in English and Spanish computer science exercises using Latent Semantic Analysis and other natural language processing techniques~@atenea2005.
It scores submissions based on the similarity of the student's answer to a set of reference answers provided by the teacher. This approach has the problem of requiring the teacher to provide a set of reference answers for each exercise, which can be time-consuming and error-prone. Also, the range of possible answers is limited to the ones provided by the teacher and answers similar to them. This means that the system is not able to recognize answers that are correct but different from the given ones.
Atenea, like Athena, is a modularized system to allow for the integration of different scoring methods, but this remains within the scope of different ways to grade free-text answers.

#linebreak()
Alikaniotis et al. propose a system for Automated Text Scoring that uses a deep learning approach to score the quality of a text~@alikaniotis2016. The system makes its results more interpretable by providing the locations of the text that are most relevant to the score. This is done by using Long-Short Term Memory networks trained on the Kaggle dataset containing almost 13,000 essays, marked by two raters.
The system is different from Athena in that it is not focused on providing feedback to the student but on scoring the quality of the text. It also only generally works on essays, while Athena is designed to work on a broader range of exercises.

#linebreak()
Bernius et al. introduce _CoFee_, a machine-learning methodology developed to provide computer-assisted feedback for open-ended textual assignments~@cofee. While CoFee addresses a specific subset of our broader objective, our goal is to support different types of exercises, including text-based ones. We integrated CoFee into Athena as an assessment module for text exercises. The name "Athena"#footnote[Also sometimes referred to as "Athene"] was previously used for the integrated system, but we will use it to refer to the new system in this work.
CoFee is integrated into Athena as an assessment module for text exercises. Alongside it, there are other assessment modules, some of which support programming exercises.

// TODO: This seems a bit out of place...
#linebreak()
Chow et al. integrated an automatic programming feedback system into the _Grok Learning platform_ to provide direct feedback to students~@chow2017automated.
They utilize different methods to create hints for students, including clustering, pattern mining and filtering. These hints include potential failing inputs, suggested code changes and concept explanations. The system exclusively works for exercises in the programming language Python.
It is different from Athena in that it is not focused on providing feedback suggestions to tutors but on providing hints to students while they solve the exercise. Also, Athena is not limited to Python but can be used for programming exercises using any programming language, as well as text exercises.

#linebreak()
Sing et al. propose an automated feedback generation for introductory programming assignments that uses a sample solution written in a subset of Python to give feedback in the form of a list of changes necessary to transform the student's submission into a solution with the same behavior~@singh2013automated. The system can detect common mistakes and provide feedback on them, but its feedback is limited to suggestions on how to fix the mistakes in the code. It does not provide any feedback on the quality of the code or the design of the solution. Neither does it provide any feedback on the student's approach to solving the problem or deeper insight into the underlying misunderstanding that led to the mistake.
Athena can provide feedback suggestions for programming exercises, but it is not limited to providing suggestions on how to fix mistakes in the code. Depending on the chosen assessment module, Athena can provide feedback on the quality of the code, the design of the solution, and the student's approach to solving the problem. Furthermore, the assessment modules in Athena generally do not require a sample solution to work.

// Note that generally, one could include related work that proves to be useful as an assessment module in Athena:
// TODO: Does this make sense here?
#linebreak()
Athena has been designed with adaptability in mind. In the future, findings from other research or methodologies can be incorporated into it if they are shown to be useful for providing feedback suggestions in our specific context.


= Requirements Analysis
// Note: This chapter follows the Requirements Analysis Document Template in @bruegge2004object. Important: Make sure that the whole chapter is independent of the chosen technology and development platform. The idea is that you illustrate concepts, taxonomies and relationships of the application domain independent of the solution domain! Cite @bruegge2004object several times in this chapter.

== Overview
// Note: Provide a short overview about the purpose, scope, objectives and success criteria of the system that you like to develop.
// TODO: Make it sound less like two people are working on the specific thesis topic, just on the whole system in general
Despite our intentions to plan and detail it meticulously, we anticipate that we will only be able to fulfill some specifications for the new semi-automatic grading system. With the limitation of only two people working on this project for only six months in mind, our strategy leans toward the progressive delivery of a scaled-down system. Prioritizing high-quality code and thorough documentation, we opt for this approach over rushing the development of an expansive yet potentially flawed prototype.

== Current System <currentSystem>
// Note: This section is only required if the proposed system (i.e. the system that you develop in the thesis) should replace an existing system.
// - current: System also called Athena / Athene (somewhat inconsistent), as a "reference implementation" of an approach to giving automatic feedback called CoFee (@cofee)
// current: Athena-CoFee integrated into existing LMS (Learning Management System) Artemis
// - Athena-CoFee system is essentially a service for segmentation and clustering test exercise submissions, for Artemis.
// - When the deadline of an exercise is reached, the following happens.
// * The *Artemis LMS* sends a list of submissions to the *Load Balancer* of Athena-CoFee, including a callback URL for later @atheneLoadBalancer
// * The *Load Balancer* distributes the next tasks between different services
// * The *Segmentation Service* partitions each submission into a list of `TextBlock`s, by start index and end index.
// * The *Embedding Service* uses deeply contextualized word representations (ElMO @elmo) for creating a linguistic embedding of the segments @cofee
// * The *Clustering Service* uses the Hierarchical Density-Based Spatial Clustering (HDBSCAN) clustering algorithm to create clusters of the embedded segments.
// * The Load Balancer sends the segments and clusters to Artemis using the callback URL, where they are stored in the database
// - When a tutor starts assessing a student's submission, the Athena-CoFee subsystem within Artemis will suggest feedback on segments close to other ones in the same cluster based on feedback given on the other segments within the cluster.

// TODO: add more detail

The current system under investigation is named Athena but is occasionally referred to as Athene outside of this work. This system acts as a "reference implementation" for a distinctive approach to dispensing automatic feedback, known as CoFee (@cofee). We will call this system Athena-CoFee to avoid confusion with the newly proposed Athena system.
Athena-CoFee is integrated into the existing Learning Management System (LMS) Artemis, functioning as a service dedicated to segmenting and clustering test exercise submissions.

When a predetermined exercise deadline arrives, a sequence of events unfolds. Artemis LMS sends a list of submissions to the Load Balancer within Athena-CoFee, including a callback URL for subsequent use (@atheneLoadBalancer). This Load Balancer distributes the tasks among several different services.

The Segmentation Service first partitions each submission into a list of TextBlocks and stores their start and end indexes. The Embedding Service then adopts deeply contextualized word representations, specifically the ElMO model (@elmo), to construct a linguistic embedding of these segments (@cofee). Following this, the Clustering Service applies the Hierarchical Density-Based Spatial Clustering (HDBSCAN, @hdbscan) algorithm to assemble clusters of the embedded segments.

Upon completion of these processes, the Load Balancer transmits the segmented and clustered data back to Artemis via the initially supplied callback URL, and this data is then stored in the database of the system.

Artemis activates the Athena-CoFee subsystem when a tutor begins to assess a student's submission. This subsystem suggests feedback for segments closely associated with others in the same cluster, drawing on feedback given on other segments within the cluster. This mechanism supports the tutor in providing a consistent and thorough evaluation of student submissions.

== Proposed System
// Note: Describe the proposed system in detail. Use the following subsections to structure your description.
We propose a new system on top of Athena-CoFee called Athena. In the following, we will describe the functional and non-functional requirements of Athena using the Requirements Analysis Document Template in @bruegge2004object.

=== Functional Requirements
// Note: List and describe all functional requirements of your system. Also mention requirements that you were not able to realize. The short title should be in the form “verb objective”
//   - FR1 Short Title: Short Description. 
//   - FR2 Short Title: Short Description. 
//   - FR3 Short Title: Short Description.
Functional requirements are independent of implementation details. They solely describe the interactions between the system and its environment @bruegge2004object. We use ISO/IEC/IEEE 29148:2018 to specify functional requirements in a structured way.
// 3 parts:
// 1. Generalization: Multiple modules
// 2. Generalization: Multiple exercise types
// 3. Semi-Automatic Suggestions for Programming Submissions

#v(1em)
*Assessment Modules*
// - There should be multiple assessment modules in Athena, each of which can be turned on or off
// - An assessment module should be able to provide a suggested next submission to the LMS if requested
// - The LMS should be able to send existing submissions and feedback to Athena for analysis.
// - Athena should be able to provide feedback suggestions on a submission to the LMS.
// - A user of the LMS can choose which assessment module(s) to use for a particular exercise
#fr[
  *Suggest Next Submission*
  Upon receiving a request from the LMS, // condition
  an assessment module // subject
  can generate // action
  a suggested next submission // object
  based on the previous submissions and their feedback.
  The suggestion can only be provided if there are previous submissions and feedback data available. // constraint of action
] <frSuggestNextSubmission>
#fr[
  *Process Student Submissions*
  After the deadline of an exercise, // condition
  the LMS // subject
  transmits // action
  all submissions // object
  to Athena for analysis, so that Athena can prepare for future feedback suggestions.
  The transmission should only occur if the chosen assessment module in Athena is active. // constraint of action
] <frReceiveSubmissions>
#fr[
  *Learn from Past Feedback*
  Each time a tutor submits feedback, // condition
  the LMS // subject
  transmits // action
  the associated feedback // object
  to Athena for analysis, so that Athena can learn from past feedback.
  The transmission should only occur if the chosen assessment module in Athena is active. // constraint of action
] <frLearnFromPastFeedback>
#fr[
  *Provide Feedback Suggestions*
  When a tutor starts grading a submission, // condition
  Athena // subject
  can deliver // action
  feedback suggestions // object
  to the LMS.
  Feedback suggestions are generated based on the capabilities of the selected assessment module and analysis parameters. // constraint of action
] <frProvideFeedbackSuggestions>
#fr[
  *Review Suggestions*
  Once Athena has finished processing all incoming data and can provide feedback suggestions, // condition
  Artemis // subject
  can display // action
  a UI for tutors to view these feedback suggestions // object
  for text exercises, programming exercises, and file upload exercises.
  The UI should be accessible only to authorized tutors who are grading the exercise. // constraint of action
] <frViewFeedbackSuggestionsUI>
#fr[
  *Accept Feedback Suggestions*
  When a tutor is content with a given feedback suggestion, // condition
  they // subject
  can accept // action
  it // object
  from within the LMS.
  // constraint of action
] <frAcceptFeedbackSuggestions>
#fr[
  *Modify Feedback Suggestions*
  When a tutor wants to modify a feedback suggestion, // condition
  they // subject
  can do so // action
  it // object
  from within the LMS.
  // constraint of action
] <frModifyFeedbackSuggestions>
#fr[
  *Discard Feedback Suggestions*
  When a tutor does not want to apply a feedback suggestion, // condition
  they // subject
  can discard // action
  it // object
  from within the LMS.
  // constraint of action
] <frDiscardFeedbackSuggestions>
#fr[
  *Restore Discarded Feedback Suggestions*
  When a tutor accidentally discarded a feedback suggestion, // condition
  they // subject
  can restore // action
  it // object
  from within the LMS.
  // constraint of action
] <frRestoreDiscardedFeedbackSuggestions>
#fr[
  *Inspect Athena Health*
  During the operation of the LMS, // condition
  an administrator // subject
  should be able to get insight into // action
  the module health statuses // object
  of the Athena system, directly from the LMS.
  The health status should be accessible only to authorized administrators. // constraint of action
] <frCommunicateModuleHealthStatus>
#fr[
  *Select Assessment Module*
  If automatic assessments are enabled in the LMS, // condition
  an administrator // subject
  can select // action
  which assessment module // object
  to use for a particular exercise.
  Only assessment modules that are compatible with the exercise type can be selected. // constraint of action
] <frSelectAssessmentModule> // TODO: Say that this one is not fulfilled / half-fulfilled with the Spring config (in the status section)

#v(1em)
*More Exercise Types*
// - Athena should be able to receive submissions and feedback for text exercises, programming exercises, file upload exercises, and modeling exercises.
// - Artemis should send submissions and feedback for text exercises, programming exercises, file upload exercises, and modeling exercises to Athena.
// - Artemis should provide UI for tutors to view feedback suggestions for text exercises, programming exercises, and file upload exercises.
#fr[
  *Receive Submissions and Feedback for Various Exercises*
  When the LMS sends a new submission or feedback, // condition
  Athena // subject
  can receive // action
  the submissions and feedback // object
  for text exercises, programming exercises, and file upload exercises.
  The data must be in a format compatible with Athena. // constraint of action
] <frMoreGeneralSubmissionsAndFeedbackReceive>
#fr[
  *Send Submissions and Feedback for Various Exercises*
  After the completion of any text, programming, or file upload exercise by a user, // condition
  specifically Artemis // subject
  will automatically send // action
  the corresponding submissions and feedback // object
  to Athena.
  The data transfer will only happen if Athena is enabled in Artemis and has an active corresponding assessment module. // constraint of action
] <frSendSubmissionsAndFeedback>

#v(1em)
*Programming Assessment Module*
// - A newly developed programming assessment module called ThemisML should be included in Athena. It should be able to provide feedback suggestions for programming exercises based on the similarity of the submissions' code and existing feedback.
// - The existing integration of the Themis grading app into ThemisML should be replaced with an integration into Artemis + Athena.
#fr[
  *Include New Programming Assessment Module*
  As part of the Athena system expansion, // condition
  Athena // subject
  will incorporate // action
  a newly developed programming assessment module called ThemisML. // object
  ThemisML, being a new module, should not interfere with the functionality of the existing assessment modules in Athena. // constraint of action
] <frIncludeNewProgrammingAssessmentModule>
#fr[
  *Feedback Suggestions by ThemisML*
  When the LMS sends a submission for a programming exercise, // condition
  ThemisML // subject
  can provide // action
  feedback suggestions // object
  based on the similarity of the code and existing feedback of the submissions.
  Only if sufficient historical submission data and feedback are available can ThemisML provide feedback suggestions. // constraint of action
] <frFeedbackSuggestionsByThemisML>
//#fr[
//  *Replace Themis Grading App Integration*
//  With the inclusion of ThemisML in Athena, // condition
//  the existing integration // subject
//  of the Themis grading app should be replaced // action
//  with an API call to Artemis. // object
//  The replacement should not affect the functionality of the Themis grading app. // constraint of action
//] <frReplaceThemisGradingAppIntegration>

// TODO: Do I need to make the FRs more granular? Moritz has 15. Here are 11.


=== Nonfunctional Requirements <nfr>
// Note: List and describe all nonfunctional requirements of your system. Also mention requirements that you were not able to realize. Categorize them using the FURPS+ model described in @bruegge2004object without the category functionality that was already covered with the functional requirements.
// - NFR1 Category: Short Description. 
// - NFR2 Category: Short Description. 
// - NFR3 Category: Short Description.

// is documentation an nfr? essential
// ThemisML should be providing feedback suggestions fast enough (all modules actually)
// minimal configuration / simple setup process
// scalable system
// easy to develop new modules
// user documentation
// developer documentation

// TODO: write some introductory sentence here about NFRs
*Maintainability*
#nfr[
  *System Maintenance*
    *System Maintenance*
  Documentation should cover at least 95% of all system modules and APIs, and code should comply with industry-standard linting and style guidelines.
] <nfrSystemMaintenance>
#nfr[
  *Extensibility*
  The system should allow for the creation of the basic structure of a new module within two developer-hours, without requiring changes to existing modules.
] <nfrNewModuleDevelopment>

*Usability*
#nfr[
  *Feedback Accessibility*
  Feedback suggestions should be accessible within two clicks and should take no longer than 30 seconds to load. Tutors should be able to accept, modify or discard a suggestion within five seconds.
] <nfrFeedbackAccessibility>
#nfr[
  *Easy Configuration*
  Configuration changes to the system, like changing authentication secrets or external API tokens for some assessment modules, should be possible within 30 minutes.
] <nfrEasyConfiguration>

*Scalability*
#nfr[
  *System Scalability*
  The system should be capable of processing submissions and generating feedback suggestions for 2,000 submissions within two hours after the due date of an exercise. It should be able to handle ten requests for feedback suggestions per second.
] <nfrSystemScalability>

*Performance*
#nfr[
  *Response Time*
  Feedback suggestions should be displayed to tutors within 10 seconds for 95% of requests.
] <nfrResponseTime>
#nfr[
  *Immediate Grading*
  The grading interface should be accessible within 1 second of request, and Athena's feedback suggestions should load asynchronously.
] <nfrImmediateGrading>

*Security*
#nfr[
  *Mutual Authentication*
  Artemis and Athena should complete mutual authentication using a shared API secret.
] <nfrMutualAuthentication>
#nfr[
  *Data Leakage Prevention*
  Access to sensitive data should be restricted to authorized personnel only. Audit logs should report unauthorized access attempts.
] <nfrDataLeakagePrevention>

*Reliability*
#nfr[
  *System Availability*
  The system should achieve at least 98% uptime, measured monthly.
] <nfrSystemAvailability>
#nfr[
  *Module Independence*
  A failure in one module should not impact the functionality of other modules, with auto-recovery mechanisms in place to restore functionality within 1 minute.
] <nfrModuleIndependence>

*Documentation*
#nfr[
  *User Documentation*
  A user manual covering at least 95% of system functionalities should be available and updated within one month of any major system changes.
] <nfrUserDocumentation>
#nfr[
  *Developer's Guide*
  A developer's guide should be available online and should include system architecture diagrams, database schemas, and module development guidelines.
] <nfrDevelopersGuide>


== System Models
In this part of the requirements analysis, we will present the system models for the Athena system. We start by describing the scenarios that we envision for the system. Then, we present the use case model, analysis object model, dynamic model, and user interface of the system, including detailed diagrams and descriptions.

=== Scenarios
// Visionary Scenario: scenario that would perfectly solve the problem, even if it might not be realizable. Use free text description
// Demo Scenario: scenario that you can implement and demonstrate until the end of your thesis
A scenario is "a concrete, focused, informal description of a single feature of the system from the viewpoint of a single actor" @bruegge2004object. The following sections describe two visionary scenarios and one demonstration scenario.
\ \ 

*Visionary Scenarios*

*Real-time Automatic Feedback*
// The student already receives feedback suggestions in real-time themselves and submits a fully correct submission at the end, having learned a lot more in the process with the shortest feedback cycle possible. The system automatically finds mistakes and points the student to where they could be wrong with helpful but not too revealing feedback. This way, there is no need for additional grading, and the tutors for the course can fully concentrate on supporting the students in other ways.
Julia, a persistent student in a Data Structures course, and Leo, a dedicated tutor for the same course, find themselves in a modern, technologically advanced learning environment. This time, the students have an innovative tool at their disposal that offers real-time feedback suggestions while they are working on their exercises.
In this context, Julia encounters a complex assignment on tree data structures. As she works her way through the exercise, she benefits from the feedback suggestions of the system. The tool cleverly points out possible mistakes without revealing the entire solution, nudging Julia towards the correct path.
This intelligent feedback system operates like a silent tutor, helping Julia correct minor errors and improve her understanding in real time. It guides her, prompting her to think more critically about her code, and encourages her to find and fix errors independently. By the time Julia finishes the assignment and submits it, her work is free of errors. The immediate feedback she received throughout her work allowed her to correct her mistakes as she made them.
Freed from the time-consuming task of grading assignments, Leo can now invest more of his time in addressing students' conceptual questions and mentoring them in their learning journey. He can now engage more deeply with students.
\ \ 
*Enhancing Automatic Test Feedback*
// - The automatic tests to check the correctness of programming exercises provide accurate feedback, but it is not always helpful to the student.
// - Therefore, the _Introduction to Informatics_ course runs some basic tests after the submission deadline, but otherwise the tutors of the course grade the submissions manually.
// - This takes a lot of time and it is difficult (for the tutors) to always spot the exact place in which the tests fail.
// - Because of this, the course now uses Athena to enhance the automatic test results such that they are processed and their wording is automatically enhanced to provide more detail on the exact root cause of the underlying issue.
// - This way, tutors can focus on grading other related issues and can be much quicker overall.
Sophie, a dedicated tutor for the Introduction to Informatics course, and Noah, a meticulous student enrolled in the course, navigate a new approach to grading programming exercises. The course originally relied on a combination of automated tests and manual grading by tutors. However, the tests, although accurate, often failed to provide the detailed feedback students like Noah needed.
To overcome this limitation, the course implemented the Athena system.
As Noah submits his code, the Athena system evaluates it. It pinpoints where and why a test might have failed, providing feedback that is both precise and insightful.
Sophie no longer has to search through every line of code to spot errors or understand the causes of test failures. This change gives her more time to focus on other relevant aspects of students' submissions.
\ \ 
*Demo Scenarios*

*Quicker Feedback Loop*
// - Edward is a tutor in the Software Engineering course
// - Fiona is a student in the Software Engineering course
// - Fiona is an eager student who always submits solutions for all weekly exercises in the course, but she often makes a lot of minor mistakes that many other students struggle with in a similar fashion
// - Accurate and timely feedback is very important for Fiona, as she will still have the concepts of the last exercise freshly in mind - the sooner she gets the feedback, the more she still remembers the intricate details of the exercise and the fewer misconceptions will manifest in her mind in the meantime
// - Edward, however, needs help keeping up the pace for grading, as there are many students, and he always has a lot of work this way. Usually, the results of the manual grading process take about two weeks to complete.
// - With the help of accurate and quick automatic feedback suggestions, Edward can speed up the grading significantly. The system automatically detects common errors and suggests feedback on them. It can also find more difficult-to-spot mistakes, saving Edward a lot of time trying to find the issue in the submission.
// - This way, Fiona also gets her results faster.
Edward is a teaching assistant in a Software Engineering course. One of the students in the course is Fiona. She is a hard-working individual who always turns in her weekly exercises on time.
Fiona, like her classmates, sometimes makes small errors in her work. The nature of learning something new is such that these mistakes can happen, and catching them early is vital for steady progress. Fiona needs to understand her errors while the exercises are still fresh in her mind.
Edward, on the other hand, has a big task on his hands. He needs to grade many assignments, and this would usually take up to two weeks. This delay is not ideal because students need their feedback sooner rather than later.
However, the automatic feedback suggestion capabilities of the learning platform are enabled: Edward can see suggestions as soon as Fiona and the other students submit their work. The tool not only highlights the mistakes that students often make but also points out the less obvious ones that can be hard to spot. This saves Edward a lot of time and allows him to focus on delivering timely feedback.
For Fiona, it means she gets her feedback much faster. She can learn from her mistakes, adjust her approach, and move on to the next exercise without delay.

=== Use Case Model
// Note: This subsection should contain a UML Use Case Diagram including roles and their use cases. You can use colors to indicate priorities. Think about splitting the diagram into multiple ones if you have more than 10 use cases. *Important:* Make sure to describe the most important use cases using the use case table template. Also describe the rationale of the use case model, i.e. why you modeled it like you show it in the diagram.
According to Bruegge and Dutoit, use cases describe "a function provided by the system that yields a visible result for an actor"~@bruegge2004object. In the discussion, the actors will be represented by a _tutor_, an _administrator_ and _Athena_ interacting with the system Artemis, as well as a _researcher_ interacting with the system Athena.
We will break down the use case model into two separate diagrams for clarity.

#figure(
  image("figures/use-case-diagram-artemis.svg", width: 100%),
  caption: [Use Case Diagram for the Artemis system],
) <useCaseModelArtemis>

In @useCaseModelArtemis we show the use cases of a tutor, an administrator, and Athena in the Artemis system.

The administrator can _select the assessment module_ that is best suited for giving feedback suggestions on the specific exercise to be assessed (#frlink(<frSelectAssessmentModule>)). Examples of the assessment module include the CoFee module for text exercises, ThemisML for programming exercises or one of the two available modules using LLMs for feedback suggestions on both programming and text exercises.
After the administrator has selected an assessment module and after the exercise due date is reached, the tutor can start assessing the submissions. They can _view a given submission_ that is chosen by the current assessment module in Athena. Then, they will directly receive feedback suggestions from Athena (#frlink(<frSuggestNextSubmission>)) and _review_ it in the user interface (#frlink(<frViewFeedbackSuggestionsUI>)).

The tutor can either _accept the suggestions_ or _modify them_ to match their evaluation of the submission (#frlink(<frAcceptFeedbackSuggestions>)). Alternatively, they can also choose to _discard any suggestion_ and to only give manual feedback (#frlink(<frDiscardFeedbackSuggestions>)). Any combination of accepting, modifying and discarding suggestions is possible. If the tutor accidentally discards a suggestion, they can _restore it_ (#frlink(<frRestoreDiscardedFeedbackSuggestions>)).
After the tutor has finished grading the submission, they can _submit_ the result to the system.

Athena uses that feedback to _learn from it_ (#frlink(<frLearnFromPastFeedback>)) and to improve its suggestions for future submissions.

#figure(
  image("figures/use-case-diagram-athena.svg", width: 60%),
  caption: [Use Case Diagram for the Athena System],
) <useCaseModelAthena>

// - The researcher can easily _change the suggestion algorithm_ to explore different approaches to generating feedback suggestions.
// - The researcher can _inspect usage statistics_ about the acceptance rate of feedback suggestions and more. This enables them to evaluate the effectiveness of the system under evaluation.
// - The researcher can _test modules independently of the LMS_ to ensure that they work as intended without having to prepare a test exercise in the LMS and go through the process of setting up the exercise and submitting one or multiple submissions.
The use cases of a researcher within Athena are shown in @useCaseModelAthena.
Athena enables them to _change the suggestion algorithm_, thereby enabling various approaches for optimizing tutor feedback.
Furthermore, the researcher can _inspect usage statistics_ related to the system's assessment modules to evaluate their effectiveness and how frequently the generated feedback is accepted or modified.
Lastly, the researcher can _test assessment modules independently of the LMS_, which eliminates the need for test exercise configurations within Artemis. This approach facilitates more efficient verification of module functionality.
Overall, these capabilities allow the researcher to significantly improve both the effectiveness of the Athena system.

=== Analysis Object Model
// Note: This subsection should contain a UML Class Diagram showing the most important objects, attributes, methods and relations of your application domain including taxonomies using specification inheritance (see @bruegge2004object). Do not insert objects, attributes or methods of the solution domain. *Important:* Make sure to describe the analysis object model thoroughly in the text so that readers can understand the diagram. Also, write about the rationale about how and why you modeled the concepts like this.
As described by Bruegge and Dutoit, we use the analysis model to prepare for the architecture of the system~@bruegge2004object. The corresponding analysis object model is shown in @analysisObjectModel and includes the most important objects, attributes, methods and relations of the application domain.

#figure(
  image("figures/aom.svg", width: 100%),
  caption: [Analysis Object Model for the Artemis System concerning feedback suggestions],
) <analysisObjectModel>

A *Course* has multiple *Users*, each with a name. These might be *Students*, *Tutors* or *Instructors*.
There are several *Exercises* in a course, which can be either *Text Exercises* or *Programming Exercises*, with the corresponding type of content. Each exercise has a title, a maximum score, and a due date.
The course instructors can _select the assessment module_ for any exercise. This way, they can choose between the different approaches for feedback suggestions.
Students can create a *Submission* for an exercise, which contains the actual content of their solution. Tutors can _view_ these submissions and _assess_ them. Athena will _suggest feedback_ on the submission.
This feedback is a *Feedback Suggestion*, which the tutor can _accept_, _modify_ or _discard_. There are two other types of feedback: *Manual Feedback*, which is given by the tutor, and *Automatic Feedback*, which is given on programming exercises using the fully automatic tests in Artemis.
A *Feedback* consists of the feedback text, an optional reference to the location in the submission that it applies to and a given number of credits, which can also be negative.
A collection of feedback creates an *Assessment*, which is the result of assessing a submission. It has a given non-negative score and can be _submitted_ by the tutor.

=== Dynamic Model
// Note: This subsection should contain dynamic UML diagrams. These can be a UML state diagrams, UML communication diagrams or UML activity diagrams. *Important:* Make sure to describe the diagram and its rationale in the text. *Do not use UML sequence diagrams.*
@activityDiagram shows an activity diagram of the assessment workflow with Athena.
When the submission due date of the exercise is reached, Artemis starts to prepare the exercise assessment. One step of this preparation is to send all submissions to Athena for processing.
Artemis then enables the assessment of the exercise for the tutors.
Depending on whether the feature is supported or not given the exercise, Artemis then either sends a list of submission IDs to Athena or chooses a random submission to assess. This way, Athena can select the best submission, i.e., the submission with the highest information gain, for the tutor to assess.
The selected submission is then sent to the tutor, who can request suggestions from Athena right after getting the submission. The tutor can also directly start the manual review in case Athena takes unusually long to respond to the request.
Athena then generates and sends the feedback suggestions to the tutor for review.
After the tutor has finished the assessment, they can submit the assessment to Artemis.
Artemis saves the assessment in its database and also sends the assessment to Athena for learning.
After this step, the assessment workflow is finished, and the tutor can start assessing the next submission until all submissions are assessed.

#figure(
  image("figures/activity-diagram.svg", width: 100%),
  caption: [Activity Diagram showing the assessment workflow with Athena],
) <activityDiagram>

=== User Interface
// Note: Show mockups of the user interface of the software you develop and their connections/transitions. You can also create a storyboard. *Important:* Describe the mockups and their rationale in the text.
In this section, we present the user interface mockups that illustrate how Athena integrates into Artemis, first for text exercises and then for programming exercises.

In Artemis, when a tutor starts a new assessment for a text or manually graded programming exercise, the system automatically selects a student's submission using Athena. The tutor receives the submission right away and can begin grading immediately. This design choice aims to prevent interruptions in the grading workflow that could arise from Athena's asynchronous generation of feedback suggestions. As the tutor evaluates the work, Athena-generated feedback suggestions become available in the user interface.

In the assessment interface seen in @userInterfaceTextFull, tutors can view student submissions and feedback suggestions on the left side. These suggestions resemble existing feedback but feature an additional badge labeled "Suggestion." By default, these are pre-accepted but can be discarded by the tutor. This design is consistent with the existing manual feedback system, as cited in @cofee.

We've made minor modifications to this design: the badge text has been changed from "Automatic" to "Suggestion" for clarity, and we've adopted a unique purple color for these badges, replacing the previous blue background.

#figure(
  image("figures/ui-mockups/text-full.png", width: 100%),
  caption: [The text assessment interface for tutors, showcasing a referenced feedback suggestion],
) <userInterfaceTextFull>

When a tutor opens the programming assessment interface, they are presented with a submission and available feedback suggestions. The interface is shown in @userInterfaceProgrammingFull. Feedback suggestions are displayed in a manner consistent with the text exercise interface, featuring a purple "Suggestion" badge for easy identification (see @userInterfaceProgrammingFull, A).

#figure(
  image("figures/ui-mockups/programming-full.png", width: 100%),
  caption: [The full programming assessment interface with an inline feedback suggestion],
) <userInterfaceProgrammingFull>

To differentiate these suggestions from already given manual feedback, they appear against a light purple background with semi-transparent text. This design choice serves as a visual cue, indicating that the suggestions are optional and require tutor approval for inclusion.
After accepting a suggestion, the background color shifts to align with the other, previously accepted feedback, and the text becomes opaque (see @userInterfaceProgrammingAccepted). The "Suggestion" badge remains visible to indicate that the feedback was generated by the Athena system.

#figure(
  image("figures/ui-mockups/programming-accepted.png", width: 100%),
  caption: [An accepted referenced inline feedback suggestion in the programming assessment interface],
) <userInterfaceProgrammingAccepted>

After discarding a feedback suggestion, it simply disappears to avoid further distraction.

Feedback that does not have a reference to a specific part of the text or programming submission is displayed in a separate section at the bottom of the interface. Its appearance is consistent with the inline feedback, as seen in @userInterfaceProgrammingUnreferenced.

#figure(
  image("figures/ui-mockups/programming-unreferenced.jpg", width: 100%),
  caption: [Unreferenced feedback suggestion at the bottom of the assessment interface. Left: before acceptance, right: after acceptance.],
) <userInterfaceProgrammingUnreferenced>

To simplify navigation within the assessment, files containing feedback suggestions are marked with a light bulb symbol in the file tree. A counter also displays the number of suggestions available for each file, offering tutors a quick reference (see @userInterfaceProgrammingFull, B).

Feedback suggestions are loaded once the assessment interface is opened. If there is a conflict between pre-existing tutor feedback and suggestions (e.g. because the assessment was saved before and is being continued now), the system prioritizes the tutor's feedback. This ensures that tutors can always see and build upon their feedback while grading.


= System Design
// Note: This chapter follows the System Design Document Template in @bruegge2004object. You describe in this chapter how you map the concepts of the application domain to the solution domain. Some sections are optional if they do not apply to your problem. Cite @bruegge2004object several times in this chapter.
In the following sections, we present our system design, which is informed by the requirements and system models specified earlier. We start by identifying design goals based on our non-functional requirements and then move on to discuss our approach to subsystem decomposition, hardware-software mapping, data management strategies, and access control policies~@bruegge2004object.

== Overview
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Provide a brief overview of the software architecture and references to other chapters (e.g. requirements analysis), references to existing systems, constraints impacting the software architecture.
]

== Design Goals
// Note: Derive design goals from your nonfunctional requirements, prioritize them (as they might conflict with each other) and describe the rationale of your prioritization. Any trade-offs between design goals (e.g., build vs. buy, memory space vs. response time), and the rationale behind the specific solution should be described in this section
We begin by establishing clear design goals for our proposed system, building on the nonfunctional requirements outlined in @nfr. Following this, we prioritize these goals and engage in a detailed discussion regarding the reasoning behind this ranking, as well as the possible trade-offs that may arise. To organize our approach, we use a set of design criteria suggested by Bruegge and Dutoit, systematically categorizing our design goals into five distinct and purposeful groups~@bruegge2004object.

// From the book (p. 243): 5 groups of design criteria:
// 1. Performance criteria: Response time, Throughput, Memory
// 2. Dependability criteria: Robustness, Reliability, Availability, Fault Tolerance, Security, Safety
// 3. Cost criteria: Development cost, Deployment cost, Upgrade cost, Maintenance cost, Administration cost
// 4. Maintenance criteria: Extensibility, Modifiability, Adaptability, Portability, Readability, Traceability of requirements
// 5. End user criteria: Utility, Usability

*Performance Criteria*
To ensure seamless integration within the Artemis grading workflow, the feedback suggestions of Athena must be provided swiftly, ideally within a few seconds, as specified in~#nfrlink(<nfrResponseTime>). Additionally, to prevent any delays in the grading process, tutors must be able to initiate grading immediately while the suggestions load asynchronously, as outlined in~#nfrlink(<nfrImmediateGrading>).

*Dependability Criteria*
For Athena to be a reliable component of Artemis's grading process, it must aim for a high level of system availability, targeting a 99.9% uptime, as suggested in~#nfrlink(<nfrSystemAvailability>). Additionally, it is vital to maintain the resilience of Athena by ensuring that a failure in one of its modules does not compromise the functionality of other modules, as defined in~#nfrlink(<nfrModuleIndependence>).

*Cost Criteria*
The security of Athena is very important, and strict measures are in place to ensure this. As per~#nfrlink(<nfrMutualAuthentication>), both Artemis and Athena authenticate each other using a shared API secret on all requests, maintaining the integrity and confidentiality of the data. Additionally, stringent data protection measures, in line with~#nfrlink(<nfrDataLeakagePrevention>), ensure that confidential student data is not leaked outside the Athena and Artemis systems.

*Maintenance Criteria*
Focusing on developer extensibility, Athena is architected to allow effortless integration of new modules and functionalities, fulfilling the goal of~#nfrlink(<nfrNewModuleDevelopment>). Complementing this, Athena is built to be easy to maintain and update, with comprehensive and clear documentation on system architecture and code as per~#nfrlink(<nfrSystemMaintenance>).

To ensure that Athena is user-friendly and maintainable, extensive documentation is prepared. Detailed user documentation, as specified in ~#nfrlink(<nfrUserDocumentation>), will enable tutors and administrators to effectively utilize the system. For future development and maintenance needs, a comprehensive developer's guide is made available, detailing the system architecture, database schemas, and module development process, as outlined in~#nfrlink(<nfrDevelopersGuide>).

*End User Criteria*
User experience is deeply considered in our design. Tutors using Artemis should be able to effortlessly view and interpret all feedback suggestions, aligning with~#nfrlink(<nfrFeedbackAccessibility>). Moreover, the system is developed to be easily configurable, aiming to encourage widespread adoption among educators and institutions, as highlighted in~#nfrlink(<nfrEasyConfiguration>).

*Prioritization and Trade-offs*
We prioritize the design goals from most important to least important as follows:
1. *End User Criteria*: 
   Ensuring a positive and efficient experience for the tutors using Artemis is the highest priority. This directly impacts the tutors' satisfaction and the effectiveness of the grading process. As Athena's feedback is central to the tutors' workflow within Artemis, ease of use is essential for successful integration and broad adoption.
2. *Maintenance Criteria*: 
   Maintenance, with a strong focus on extensibility, is critical to ensure that the wide and diverse range of developers contributing to the open-source Artemis project can easily understand, adapt, and extend Athena's implementation. Clear and thorough documentation is necessary, as it allows for more effortless collaboration and future enhancement.
3. *Performance Criteria*: 
   The system aims to be fast and responsive, with a strict requirement that submission selection should be within 2 seconds. Additionally, tutors must be able to grade submissions independently of whether feedback suggestions are available; grading should be unaffected if suggestions are delayed or unavailable. While performance remains crucial as it affects user satisfaction, some trade-offs in response times for feedback suggestions are acceptable to ensure that the grading process remains uninterrupted.
4. *Cost Criteria*: 
  Given that Artemis operates as an open-source project with limited funding, minimizing maintenance and administration costs is vital. We need to operate within a tight budget while striving to achieve effective integration and user satisfaction.
5. *Dependability Criteria*: 
   While high availability is valuable, occasional downtimes or failures might be tolerable, given the nature of a complementary feedback suggestion system where immediate, continuous operation may not always be critical.

This prioritization strategy aims to establish Athena as a user-centric, maintainable, and cost-effective addition to the Artemis ecosystem, aligning with the community-driven, open-source nature of the project.

== Subsystem Decomposition
// Note: Describe the architecture of your system by decomposing it into subsystems and the services provided by each subsystem. Use UML class diagrams including packages/components for each subsystem.
// - There are 3 main subsystems: Artemis client, Artemis server, Athena
// - Artemis client: UI, communication with Artemis server

As a distinct subsystem, _Athena_ analyzes exercises, student submissions, and historical feedback to generate targeted suggestions. It operates alongside two other primary subsystems: the _Artemis Client_, the user interface for tutors, and the _Artemis server_, which manages its logic and data.
As an alternative interface to the Artemis Client, tutors can also use the _Themis Grading App_ to assess submissions. The collaborator Tarlan Ismayilsoy adds the integration of Athena's feedback suggestions into the Themis app in his ongoing Master's Thesis.

The communication between all components in @subsystemDecompositionOverview is facilitated through the respective APIs of the subsystems, using a REST interface with JSON serialization.

#figure(
  image("figures/subsystem-decomposition-overview.svg", width: 100%),
  caption: [Subsystem decomposition diagram: Overview of the interaction between Athena, Artemis and the Themis Grading App],
) <subsystemDecompositionOverview>

=== Athena
The Athena system is written in Python utilizing the FastAPI server framework#footnote[https://fastapi.tiangolo.com, last visited September 6th, 2023].
We introduce the architecture of Athena in @subsystemDecompositionAthena.
//
Placed on the left side of the architecture diagram are various assessment modules. These modules have the primary function of creating feedback suggestions tailored to specific student submissions.
Importantly, these modules are designed to be interchangeable due to their adherence to a unified interface. For example, both the _CoFee Module_ and the _Text LLM Module_ focus on generating feedback for text-based exercises, whereas the _ThemisML Module_ and the _Programming LLM Module_ specialize in formulating suggestions for programming exercises.

Further details on the CoFee module are provided in the subsequent section. The ThemisML module, on the other hand, is an adaptation of the pre-existing ThemisML system#footnote[https://github.com/ls1intum/Themis-ML, last visited September 5th, 2023], tailored to fit into the Athena framework. The LLM modules -- both Text and Programming -- were developed by collaborator Felix Dietrich, who discusses them extensively in his concurrent Master's Thesis.

The _Assessment Module Manager_ serves as the coordinator for all assessment modules. Additionally, it offers an Application Programming Interface (API) to facilitate interactions between external LMSs and Athena.

Lastly, the _Playground_ is a web application created using the Next.js framework#footnote[https://nextjs.org, last visited September 6th, 2023] that also communicates with Athena through this API. This platform provides a sandbox environment for researchers, allowing them to test the efficacy of various assessment modules and to preview the generated feedback suggestions for a given submission.

#figure(
  image("figures/subsystem-decomposition-athena.svg", width: 90%),
  caption: [Subsystem decomposition of Athena],
) <subsystemDecompositionAthena>

=== CoFee Module
We largely keep the architecture of the CoFee module as proposed by Bernius and Michel~#cite("cofee", "cofee2", "atheneLoadBalancer"). Notably, Michel contributed a _Load Balancer_ that efficiently distributes incoming requests among the CoFee modules for _Segmentation_, _Embedding_, and _Clustering_~@atheneLoadBalancer.
Unfortunately, the load balancer is highly coupled with the CoFee modules, which is why we cannot use it in Athena directly. To enhance compatibility, we introduce a _Module Adapter_ that provides a unified interface for the CoFee module to the Athena system.

Both the existing CoFee module and the new Module Adapter are based on the FastAPI framework.

#figure(
  image("figures/subsystem-decomposition-cofee-module.svg", width: 80%),
  caption: [Subsystem decomposition of the CoFee Module, inspired by similar diagrams in @cofee and @atheneLoadBalancer],
) <subsystemDecompositionCoFee>

=== Artemis Server

// The Artemis Server is written in Java and uses Spring Boot. In the context of the work presented in this thesis, it is responsible for handling the communication with Athena.

// All the components mentioned in the subsystem decomposition diagram that include "Athena" in their name are enabled using the "athena" Spring profile. This way, they are only loaded if the profile is active. This is useful because the Athena components can be disabled in production if they are not needed.

// The architecture is split into three layers: web, application and persistence.
// The _Text and Programming Exercise and Assessment Resources_ provide endpoints for creating and updating exercises and tutor assessments respectively. They trigger the following Athena services when there are updates:
// - The _Athena Schedule Service_ schedules the _Athena Submission Sending Service_ that sends submissions on the exercise to Athena.
// - The _Text and Programming Submission Services_ that request the currently best submission to assess from the _Athena Submission Selection Service_.
// - The _Athena Feedback Sending Service_ is responsible for sending added feedback to Athena so that Athena can learn from it.
// The _Athena Resource_ provides all endpoints that are purely related to Athena and its interaction with Artemis. It provides feedback suggestions to the client using the _Athena Feedback Suggestions Service_ and it also provides endpoints for Athena to download programming submissions if needed.
// The _Athena Health Indicator_ provides information to the health dashboard that is built-in into Artemis to show the status of the connection to the Athena system.

The Artemis Server, constructed using Java and Spring Boot#footnote[https://spring.io/projects/spring-boot, last visited September 6th, 2023], serves as a pivotal element in the work discussed in this thesis. Its primary role consists of managing communications with Athena, the automatic feedback suggestion system for tutors.

#figure(
  image("figures/subsystem-decomposition-artemis-server.svg", width: 100%),
  caption: [Subsystem decomposition of the Artemis Server],
) <subsystemDecompositionArtemisServer>

@subsystemDecompositionArtemisServer provides an overview of the Artemis Server's subsystems.
The system's architecture is organized into three distinct layers: the web layer, the application layer, and the persistence layer. The modules for _Text and Programming Exercise Resources_ and _Text and Programming Assessment Resources_ expose endpoints that facilitate the creation and modification of exercises and tutor assessments. Upon any updates in these areas, several Athena services are invoked:
  
1. The _Athena Schedule Service_ initiates the _Athena Submission Sending Service_, which forwards exercise submissions to Athena.
2. The _Text and Programming Submission Services_ interact with the _Athena Submission Selection Service_ to find the most appropriate submission for the next assessment.
3. The _Athena Feedback Sending Service_ takes on the role of transmitting new feedback to Athena, enabling Athena to refine its learning algorithms.

Moreover, the _Athena Resource_ serves as a hub for all operations that exclusively concern functionality related to Athena. It delivers feedback suggestions to the client through the _Athena Feedback Suggestions Service_ and also offers endpoints to allow Athena to download programming submissions when required through the _Athena Repository Export Service_.

Lastly, the _Athena Health Indicator_ integrates with Artemis's built-in health dashboard, providing data on the status of the connection between the Artemis system and Athena.

A Spring profile labeled "athena" activates components with "Athena" in their identifiers. When activated, this profile loads these Athena-related components. This allows the deactivation of unnecessary Athena-related components in production if needed.

In the persistence layer, the _Text and Programming Submission Repositories_ along with the _Feedback Repository_ retrieve data from the database using an Object-Relational Mapping (ORM) framework.
Additionally, the _Text Block Repository_ serves a specific function in the representation conversion for feedback on text exercises. While Artemis uses inline references identified by text block IDs for feedback, Athena references the submission text by the start and end indices of the feedback within the submission text. The _Text Block Repository_ helps with this conversion between the two different feedback representations.


=== Artemis Client

// - Artemis Web Client is a web client created with Angular
// - There are two layers: The UI layer (Angular components) and the service layer (mostly connecting to the Artemis API)
// - We add the new components _Text Feedback Suggestion Component_ and _Programming Feedback Suggestion Component_ to the UI layer to display feedback suggestions
// - The feedback suggestion components have to be separate from each other because their layout has to resemble the layout of the corresponding feedback components
// - We change both the _Text Submission Assessment Component_ and the _Programming Submission Assessment Component_ to support displaying feedback suggestions using these components - both referenced inline suggestions and unreferenced suggestions
// - The Text Submission Assessment Component uses the _Text Assessment Service_ to get and save assessments.
// - The Programming Submission Assessment Component uses the _Programming Assessment Service_ to get and save assessments.
// - Both of these components use the _Athena Service_ to get feedback suggestions.
// - The _Programming Submission Assessment Component_ is called `CodeEditorTutorAssessmentContainerComponent` in the source code

The Artemis Web Client, developed using Angular, is divided into two primary layers: the UI layer, consisting of Angular components, and the service layer, primarily responsible for interfacing with the Artemis API.

#figure(
  image("figures/subsystem-decomposition-artemis-client.svg", width: 75%),
  caption: [Subsystem decomposition of the Artemis Client],
) <subsystemDecompositionArtemisClient>

To enhance the user interface, we introduce two new components to the UI layer: the _Text Feedback Suggestion Component_ and the _Programming Feedback Suggestion Component_. These components display feedback suggestions and are deliberately separate to fit into the layout of their corresponding feedback components.

In order to accommodate the display of feedback suggestions, we modify both the _Text Submission Assessment Component_ and the _Programming Submission Assessment Component_#footnote[Name in the existing source code: `CodeEditorTutorAssessmentContainerComponent`]. These modifications enable the components to display both inline-referenced suggestions and unreferenced suggestions. For handling and saving assessments, the _Text Submission Assessment Component_ utilizes the _Text Assessment Service_, while the _Programming Submission Assessment Component_ employs the _Programming Assessment Service_. Both components fetch feedback suggestions from Athena using the _Athena Service_.

== Hardware Software Mapping
// Note: This section describes how the subsystems are mapped onto existing hardware and software components. The description is accompanied by a UML deployment diagram. The existing components are often off-the-shelf components. If the components are distributed on different nodes, the network infrastructure and the protocols are also described.

// - @deploymentDiagram shows an example setup based on the one used at Technical University of Munich
// - We skip the load balancing of Artemis because it is not relevant for the thesis
// - Both the Athena Server and the Artemis Server are deployed within the University Datacenter
// - They each have their own database servers. The Artemis Server uses a MySQL database and the Athena Server uses a Postgres database.
// - A tutor can access the Artemis Server using the Artemis Web Client, which is served by the Artemis Server. It communicates with the Artemis Server using the Artemis API through the https protocol.
// - A researcher can access the Athena Server using the Athena Playground, which is served by the Athena Server. It communicates with the Athena Server using the Athena API through the https protocol.

The deployment diagram presented in @deploymentDiagram illustrates an example architecture closely mirroring the actual system setup at the Technical University of Munich. Specifically, both the Athena Server and the Artemis Server are housed within the University Datacenter.
Artemis can access the services provided by Athena through the Athena API, which is served by the Athena Server over HTTPs.
Both the Athena and Artemis Servers are housed in the University Datacenter and use independent databases: Artemis uses MySQL, while Athena employs Postgres.
We have intentionally omitted the load-balancing aspect of the Artemis system as it is not relevant to the research focus of this thesis.

#figure(
  image("figures/deployment-diagram.svg", width: 80%),
  caption: [Deployment diagram of the Artemis and Athena systems, inspired by the deployment diagram from the Artemis documentation page#footnote[https://ls1intum.github.io/Artemis/dev/system-design/#deployment, last visited September 6th, 2023]],
) <deploymentDiagram>

Tutors access the Artemis Server via the Artemis Web Client, while researchers use the Athena Playground for the Athena Server. Both interfaces communicate with their respective servers through APIs using the HTTPs.

== Persistent Data Management
// Note: Optional section that describes how data is saved over the lifetime of the system and which data. Usually this is either done by saving data in structured files or in databases. If this is applicable for the thesis, describe the approach for persisting data here and show a UML class diagram how the entity objects are mapped to persistent storage. It contains a rationale of the selected storage scheme, file system or database, a description of the selected database and database administration issues.
// TODO: Add some introductory text

=== Artemis
// - Reason for MySQL/Postgres as the database: The existing Artemis system already uses it.
// - We add a new boolean exercise.feedback_suggestions_enabled column Artemis to enable the feedback suggestions for an exercise.
// - Everything else is the same: Students submit submissions, all of one students submissions are a participation, a participation belongs to an exercise and has a result, a result gets feedback from a tutor.
In managing persistent data for Athena within Artemis, we chose to support both MySQL and PostgreSQL because Artemis already supports these databases. We show the relevant parts from the Artemis data model in @classDiagramArtemis.

We introduce a new column, `exercise.feedback_suggestions_enabled`. This boolean flag is used to indicate whether Athena's feedback suggestions are enabled for a particular exercise.
The data structure remains largely the same as in Artemis. Students submit their work as _submissions_, which are part of a _participation_. Each participation is linked to an exercise and has a _result_, which has _feedback_ from a tutor.
#figure(
  image("figures/db-class-diagram-artemis.svg", width: 70%),
  caption: [Part of the data model for the Artemis system taken from the Artemis documentation#footnote[https://ls1intum.github.io/Artemis/dev/system-design/#deployment, last visited September 6th, 2023], with the added `feedbackSuggestionsEnabled` column on the `Exercise` table],
) <classDiagramArtemis>

=== Athena
// - reason to choose PostgreSQL
// - General Assessment Modules data
// - tables removed from Artemis for CoFee changes
// - additional tables in CoFee module

== Access Control
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Optional section describing the access control and security issues based on the nonfunctional requirements in the requirements analysis. It also de- scribes the implementation of the access matrix based on capabilities or access control lists, the selection of authentication mechanisms and the use of encryption algorithms.
]

== Global Software Control
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Optional section describing the control flow of the system, in particular, whether a monolithic, event-driven control flow or concurrent processes have been selected, how requests are initiated and specific synchronization issues
]

== Boundry Conditions
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Optional section describing the use cases how to start up the separate components of the system, how to shut them down, and what to do if a component or the system fails.
]

= Object Design
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Answer the questions "How did you design the system?", "How do the algorithms work?", "How to extend your system?" and more.
]

== Feature 1

== Feature 2

= Case Study / Evaluation
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: If you did an evaluation / case study, describe it here.
]

== Design 
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Describe the design / methodology of the evaluation and why you did it like that. E.g. what kind of evaluation have you done (e.g. questionnaire, personal interviews, simulation, quantitative analysis of metrics, what kind of participants, what kind of questions, what was the procedure?
]

== Objectives
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Derive concrete objectives / hypotheses for this evaluation from the general ones in the introduction.
]

== Results
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Summarize the most interesting results of your evaluation (without interpretation). Additional results can be put into the appendix.
]

== Findings
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Interpret the results and conclude interesting findings
]

== Discussion
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Discuss the findings in more detail and also review possible disadvantages that you found
]

== Limitations
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Describe limitations and threats to validity of your evaluation, e.g. reliability, generalizability, selection bias, researcher bias
]

= Summary
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: This chapter includes the status of your thesis, a conclusion and an outlook about future work.
]

== Status
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Describe honestly the achieved goals (e.g. the well implemented and tested use cases) and the open goals here. if you only have achieved goals, you did something wrong in your analysis.
]

- #sym.circle.stroked.small
- ◐
- #sym.circle.filled

=== Realized Goals
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Summarize the achieved goals by repeating the realized requirements or use cases stating how you realized them.
]

=== Open Goals
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Summarize the open goals by repeating the open requirements or use cases and explaining why you were not able to achieve them. Important: It might be suspicious, if you do not have open goals. This usually indicates that you did not thoroughly analyze your problems.
]

== Conclusion
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Recap shortly which problem you solved in your thesis and discuss your *contributions* here.
]

== Future Work
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Tell us the next steps (that you would do if you have more time). Be creative, visionary and open-minded here.
]