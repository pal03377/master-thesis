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
#let fr_counter = counter("fr")
#let fr(it) = block[
  #fr_counter.step()
  #enum(numbering: n => "FR " + fr_counter.display(), body-indent: 2em)[
    #it
  ]
]

= Introduction
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Introduce the topic of your thesis, e.g. with a little historical overview.
]

== Problem
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Describe the problem that you like to address in your thesis to show the importance of your work. Focus on the negative symptoms of the currently available solution.
]

== Motivation
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Motivate scientifically why solving this problem is necessary. What kind of benefits do we have by solving the problem?
]

== Objectives
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Describe the research goals and/or research questions and how you address them by summarizing what you want to achieve in your thesis, e.g. developing a system and then evaluating it.
]

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
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Describe each proven technology / concept shortly that is important to understand your thesis. Point out why it is interesting for your thesis. Make sure to incorporate references to important literature here.
]

== e.g. User Feedback
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: This section would summarize the concept User Feedback using definitions, historical overviews and pointing out the most important aspects of User Feedback.
]

== e.g. Representational State Transfer
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: This section would summarize the architectural style Representational State Transfer (REST) using definitions, historical overviews and pointing out the most important aspects of the architecture.
]

== e.g. Scrum
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: This section would summarize the agile method Scrum using definitions, historical overviews and pointing out the most important aspects of Scrum.
]

= Related Work
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Describe related work regarding your topic and emphasize your (scientific) contribution in contrast to existing approaches / concepts / workflows. Related work is usually current research by others and you defend yourself against the statement: “Why is your thesis relevant? The problem was al- ready solved by XYZ.” If you have multiple related works, use subsections to separate them.
]

= Requirements Analysis
// Note: This chapter follows the Requirements Analysis Document Template in @bruegge2004object. Important: Make sure that the whole chapter is independent of the chosen technology and development platform. The idea is that you illustrate concepts, taxonomies and relationships of the application domain independent of the solution domain! Cite @bruegge2004object several times in this chapter.

== Overview
// Note: Provide a short overview about the purpose, scope, objectives and success criteria of the system that you like to develop.
Despite our intentions to plan and detail it meticulously, we anticipate that we will only be able to fulfill some specifications for the new semi-automatic grading system. With the limitation of only two people working on this project for only six months in mind, our strategy leans toward the progressive delivery of a scaled-down system. Prioritizing high-quality code and thorough documentation, we opt for this approach over rushing the development of an expansive yet potentially flawed prototype.

== Current System
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

Upon completion of these processes, the Load Balancer transmits the segmented and clustered data back to Artemis via the initially supplied callback URL, and this data is then stored in the system's database.

Artemis activates the Athena-CoFee subsystem when a tutor begins to assess a student's submission. This subsystem suggests feedback for segments closely associated with others in the same cluster, drawing on feedback given on other segments within the cluster. This mechanism supports the tutor in providing a consistent and thorough evaluation of student submissions.

== Proposed System
// Note: Describe the proposed system in detail. Use the following subsections to structure your description.
We propose a new system on top of Athena-CoFee called Athena. In the following, we will describe Athena's functional and non-functional requirements using the Requirements Analysis Document Template in @bruegge2004object.

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

*Assessment Modules*
// - There should be multiple assessment modules in Athena, each of which can be turned on or off
// - A user of the LMS can choose which assessment module(s) to use for a particular exercise
// - An assessment module should be able to provide a suggested next submission to the LMS if requested
// - The LMS should be able to send existing submissions and feedback to Athena for analysis.
// - Athena should be able to provide feedback suggestions on a submission to the LMS.
#fr[
  *Select Assessment Module*
  If automatic assessments are enabled in the LMS, // condition
  an instructor // subject
  can select // action
  which assessment module // object
  to use for a particular exercise.
  Only assessment modules that are compatible with the exercise type can be selected. // constraint of action
]
#fr[
  *Provide Suggested Submission*
  Upon receiving a request from the LMS, // condition
  an assessment module // subject
  can generate // action
  a suggested next submission // object
  based on the previous submissions and their feedback.
  The suggestion can only be provided if there are previous submissions and feedback data available. // constraint of action
]
#fr[
  *Send Submissions and Feedback*
  After the deadline of an exercise and each time a tutor submits feedback, // condition
  the LMS // subject
  can transmit // action
  the submissions or associated feedback // object
  to Athena for analysis.
  The transmission should only occur if the chosen assessment module in Athena is active. // constraint of action
]
#fr[
  *Provide Feedback Suggestions*
  When a tutor starts grading a submission, // condition
  Athena // subject
  can deliver // action
  feedback suggestions // object
  to the LMS.
  Feedback suggestions are generated based on the selected assessment module's capabilities and analysis parameters. // constraint of action
]

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
]
#fr[
  *Send Submissions and Feedback for Various Exercises*
  After the completion of any text, programming, or file upload exercise by a user, // condition
  Artemis // subject
  will automatically send // action
  the corresponding submissions and feedback // object
  to Athena.
  The data transfer will only happen if Athena is enabled in Artemis and has an active corresponding assessment module. // constraint of action
]
#fr[
  *View Feedback Suggestions UI*
  Once Athena has finished processing all incoming data and can provide feedback suggestions, // condition
  Artemis // subject
  can display // action
  a UI for tutors to view these feedback suggestions // object
  for text exercises, programming exercises, and file upload exercises.
  The UI should be accessible only to authorized tutors who are grading the exercise. // constraint of action
]

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
]

#fr[
  *Feedback Suggestions by ThemisML*
  When the LMS sends a submission for a programming exercise, // condition
  ThemisML // subject
  can provide // action
  feedback suggestions // object
  based on the similarity of the submissions' code and existing feedback.
  Only if sufficient historical submission data and feedback are available can ThemisML provide feedback suggestions. // constraint of action
]

#fr[
  *Replace Themis Grading App Integration*
  With the inclusion of ThemisML in Athena, // condition
  the existing integration // subject
  of the Themis grading app should be replaced // action
  with an API call to Artemis. // object
  The replacement should not affect the functionality of the Themis grading app. // constraint of action
]


=== Nonfunctional Requirements
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: List and describe all nonfunctional requirements of your system. Also mention requirements that you were not able to realize. Categorize them using the FURPS+ model described in @bruegge2004object without the category functionality that was already covered with the functional requirements.

  - NFR1 Category: Short Description. 
  - NFR2 Category: Short Description. 
  - NFR3 Category: Short Description.

]
// is documentation an nfr? essential
// ThemisML should be providing feedback suggestions fast enough (all modules actually)

== System Models
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: This section includes important system models for the requirements analysis.
]

=== Scenarios
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: If you do not distinguish between visionary and demo scenarios, you can remove the two subsubsections below and list all scenarios here.

  *Visionary Scenarios*

  Note: Describe 1-2 visionary scenario here, i.e. a scenario that would perfectly solve your problem, even if it might not be realizable. Use free text description.

  *Demo Scenarios*

  Note: Describe 1-2 demo scenario here, i.e. a scenario that you can implement and demonstrate until the end of your thesis. Use free text description.
]

=== Use Case Model
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: This subsection should contain a UML Use Case Diagram including roles and their use cases. You can use colors to indicate priorities. Think about splitting the diagram into multiple ones if you have more than 10 use cases. *Important:* Make sure to describe the most important use cases using the use case table template (./tex/use-case-table.tex). Also describe the rationale of the use case model, i.e. why you modeled it like you show it in the diagram.

]

=== Analysis Object Model
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: This subsection should contain a UML Class Diagram showing the most important objects, attributes, methods and relations of your application domain including taxonomies using specification inheritance (see @bruegge2004object). Do not insert objects, attributes or methods of the solution domain. *Important:* Make sure to describe the analysis object model thoroughly in the text so that readers are able to understand the diagram. Also write about the rationale how and why you modeled the concepts like this.

]

=== Dynamic Model
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: This subsection should contain dynamic UML diagrams. These can be a UML state diagrams, UML communication diagrams or UML activity diagrams.*Important:* Make sure to describe the diagram and its rationale in the text. *Do not use UML sequence diagrams.*
]

=== User Interface
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Show mockups of the user interface of the software you develop and their connections / transitions. You can also create a storyboard. *Important:* Describe the mockups and their rationale in the text.
]

= System Design
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: This chapter follows the System Design Document Template in @bruegge2004object. You describe in this chapter how you map the concepts of the application domain to the solution domain. Some sections are optional, if they do not apply to your problem. Cite @bruegge2004object several times in this chapter.
]

== Overview
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Provide a brief overview of the software architecture and references to other chapters (e.g. requirements analysis), references to existing systems, constraints impacting the software architecture..
]

== Design Goals
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Derive design goals from your nonfunctional requirements, prioritize them (as they might conflict with each other) and describe the rationale of your prioritization. Any trade-offs between design goals (e.g., build vs. buy, memory space vs. response time), and the rationale behind the specific solution should be described in this section
]

== Subsytem Decomposition
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Describe the architecture of your system by decomposing it into subsys- tems and the services provided by each subsystem. Use UML class diagrams including packages / components for each subsystem.
]

== Hardware Software Mapping
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: This section describes how the subsystems are mapped onto existing hardware and software components. The description is accompanied by a UML deployment diagram. The existing components are often off-the-shelf components. If the components are distributed on different nodes, the network infrastructure and the protocols are also described.
]

== Persistent Data Management
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Optional section that describes how data is saved over the lifetime of the system and which data. Usually this is either done by saving data in structured files or in databases. If this is applicable for the thesis, describe the approach for persisting data here and show a UML class diagram how the entity objects are mapped to persistent storage. It contains a rationale of the selected storage scheme, file system or database, a description of the selected database and database administration issues.
]

== Access Control
#rect(
  width: 100%,
  radius: 10%,
  stroke: 0.5pt,
  fill: yellow,
)[
  Note: Optional section describing the access control and security issues based on the nonfunctional requirements in the requirements analysis. It also de- scribes the implementation of the access matrix based on capabilities or access control lists, the selection of authentication mechanisms and the use of en- cryption algorithms.
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