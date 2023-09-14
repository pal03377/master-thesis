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
#feedback[ // Example
    Since the attention span of the audience is rather short, try getting to the problem as fast as possible. Several slides in the presentation display redundant or repetitive information and could be deleted
]
#response[ // Example
    To get to the problem earlier in the presentation as well as to present only relevant information, some of the slides are removed (Agenda) and some of them are merged (Context, Motivation and Objectives). Therefore the "Problem" slide is now at slide 4. 
]

#feedback[ // Example
    The structure of the presentation is rather unique; it would be great if you could help the audience to follow it easier.
]
#response[ // Example
    To help the audience to follow the presentation easier, a progress-bar was added at the bottom of the slides to show the milestones of the presentation and highlight the one that indicates the current slide.
]