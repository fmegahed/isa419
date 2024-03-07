if(require(renderthis)==FALSE) remotes::install_github("jhelvy/renderthis", dependencies = TRUE)
if(require(officer) == FALSE) install.packages('officer')

renderthis::to_pdf(from = 'lectures/12_intro_to_ml/12_intro_to_ml.html',
                   to = 'pdfs/12_intro_to_ml.pdf',
                   complex_slides = TRUE,
                   partial_slides = TRUE,
                   delay = 2)

# I am using my adobe to create the ppt since the text is editable (which is more preferable to students)
renderthis::to_pptx(from = 'lectures/12_intro_to_ml/12_intro_to_ml.html',
                    to = 'ppts/12_intro_to_ml.pptx',
                    complex_slides = TRUE,
                    partial_slides = TRUE,
                    delay = 2)
