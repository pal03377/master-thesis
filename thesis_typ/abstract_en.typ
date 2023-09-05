#let abstract_en() = {
  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: none,
    number-align: center,
  )

  let body-font = "New Computer Modern"
  let sans-font = "New Computer Modern Sans"

  set text(
    font: body-font, 
    size: 12pt, 
    lang: "en"
  )

  set par(leading: 1em)

  
  // --- Abstract (DE) ---
  v(1fr)
  align(center, text(font: body-font, 1em, weight: "semibold", "Abstract"))
  
  //  1. *paragraph:* What is the motivation of your thesis? Why is it interesting from a scientific point of view? Which main problem do you like to solve?
  //  2. *paragraph:* What is the purpose of the document? What is the main content, the main contribution?
  //  3. *paragraph:* What is your methodology? How do you proceed?

  // - Systems like the learning management system Artemis are used to support the learning process in programming courses. They are gaining more and more popularity.
  // - To give high-quality feedback on all submitted exercises, the tutors have to invest a lot of time.
  // - Recently, the idea of using machine learning to semi-automate the feedback process has been proposed.
  // - Athena is a system that uses machine learning to semi-automate the feedback process for text exercises. It was recently developed at the University of Munich.
  // - However, most exercises in programming courses are not text exercises, but programming exercises.
  // - Artemis also supports a number of other types of exercises, like file upload exercises and modeling exercises.
  // - Therefore, the goal of this thesis is to extend Athena to be capable of supporting more types of exercises. We focus on generalizing Athena to support programming exercises in addition to text exercises.
  // - It is also very important to evaluate the quality of the feedback that different systems ("modules" in Athena) provide.
  // - Therefore, we introduce a new module architecture that allows us to easily compare the quality of different modules by swapping them out.
  // - One such module will be "ThemisML", which is the machine learning module that is used to provide feedback suggestions on programming exercises in the recently developed Themis app. We unify the ThemisML module with Athena.
  // - Our methodology is to do this:
  //   * Analyze the current architecture of Athena
  //   * Design a new architecture that allows us to create new modules for any type of exercise and swap them out easily
  //   * Implement the new architecture
  //   * Contain the current Athena system in a module
  //   * Contain the current ThemisML system in a module
  //   * Integrate the new system into the learning management system Artemis
  //   * Evaluate the quality of the feedback that the new system provides
  par(justify: true)[
As educational platforms evolve to accommodate modern learning paradigms, Learning Management Systems like Artemis have become pivotal in administering programming courses. However, tutors still face the time-consuming task of providing detailed feedback. While the recently proposed Athena system has begun to semi-automate this process for text exercises, a gap remains for programming exercises. The research made in this thesis aims to fill that void by adapting Athena to handle both text and programming exercises in a unified manner.

We present a modular design that streamlines the addition and interchangeability of feedback-generating components. Included in this new architecture are CoFee, the current text-exercise feedback module from Athena, and a machine-learning module specialized for programming exercises. We integrate this new Athena system into Artemis.

An analysis of Athena's existing framework reveals areas for improvement. We design and implement a modular structure to support multiple types of exercises and allow for the addition of new feedback modules. A brief evaluation follows to assess the quality of the automated feedback the system offers.

By expanding Athena's capabilities, this thesis aims to enrich the feedback loop in programming education, thereby offering advantages to both tutors and students.
  ]

  v(1fr)
}