if(require(renderthis)==FALSE) remotes::install_github("jhelvy/renderthis", dependencies = TRUE)
if(require(officer) == FALSE) install.packages('officer')

renderthis::to_pdf(from = 'lectures/02_python_basics/02_python_basics.html',
                   to = 'pdfs/02_python_basics.pdf',
                   complex_slides = TRUE,
                   partial_slides = TRUE,
                   delay = 1)

# I am using my adobe to create the ppt since the text is editable (which is more preferable to students)
renderthis::to_pptx(from = 'lectures/02_python_basics/02_python_basics.html',
                    to = 'ppts/02_python_basics.pptx',
                    complex_slides = TRUE,
                    partial_slides = TRUE,
                    delay = 1)
