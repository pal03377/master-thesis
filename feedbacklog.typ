// Enter your thesis data here:
#let title = "Generalizing Machine-Learning Based Assessments"
#let degree = "Master"
#let program = "Informatics"
#let supervisor = "Prof. Dr. Stephan Krusche"
#let advisor = "Maximilian Sölch, M.Sc.."
#let author = "Paul Schwind"
#let presentation_date = "Sep 11, 2023"

#show heading: set text(size: 1.5em)

// Title section
#align(center)[
    #heading[
        Presentation Feedbacklog#linebreak()
        #degree's Thesis #author#linebreak()
        #title
    ]
    #v(2em)
    #text(size: 1.5em)[
        #datetime.today().display("[month repr:short] [day], [year]")
    ]

    #v(2em)

    // Information table
    #line(length: 100%, stroke: gray)
    #table(
        columns: (9em, auto),
        align: left,
        stroke: none,
        [Author:], [#author],
        [Supervisor:], [#supervisor],
        [Advisor:], [#advisor],
        [Presentation date:], [#presentation_date],
    )
    #line(length: 100%, stroke: gray)

    #v(2em)
]

// Helper functions
#let feedback_counter = counter("feedback")
#let feedback(it) = block[
    #feedback_counter.step()
    *#feedback_counter.display(). Feedback:*
    #it
]
#let response(it) = pad(left: 3em)[
    #text(fill: blue)[
        *Response:*
        #it
    ]
]

// ===========================================

// Content
#feedback[
    Change the wording from "high coupling" to "extensibility", because this is the real problem that is solved from the developer's perspective. The real problem with the current system is hard to understand.
]
#response[
    We changed this in the slides and the thesis and additionally added the subsystem decomposition diagram of Athena-CoFee taken from https://github.com/ls1intum/Athena-CoFee to show the old architecture.
]

#feedback[
    Please double-check the type of arrow in the subsystem decomposition diagram. It probably should use a dashed line.
]
#response[
    We double-checked this in "Object-Oriented Software Engineering" by Bruegge and Dutoit and found indeed, "Dependencies among components can be depicted with dashed stick arrows". We changed this in the presentation and in the thesis.
]

#feedback[
    Please think about whether the assessment should be blocked for tutors until feedback suggestions are available.
]
#response[
    TODO: Think about it. // !!!
]

#feedback[
    The wording "Accepted Suggestion" for the suggestion badge in text exercises is not clear. Please change it to "Suggestion", since the tutor did never accept it.
]
#response[
    TODO: Do this
]

#feedback[
    Please add a warning to the tutor if they try to submit an assessment without having explicitly accepted or rejected all suggestions.
]
#response[
    TODO: Do this
]

#feedback[
    In the component diagram where the Playground can be seen, it is a component within Athena. In reality, it is a component outside of Athena. Please change this.
]
#response[
    We changed this in the presentation and in the thesis.
]

#feedback[
    We should arrange a meeting to talk about the technologies involved in Athena in more detail.
]
#response[
    TODO: Schedule meeting
]