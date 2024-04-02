if(require(renderthis)==FALSE) remotes::install_github("jhelvy/renderthis", dependencies = TRUE)
if(require(officer) == FALSE) install.packages('officer')

renderthis::to_pdf(from = 'lectures/16_ml_regression/16_ml_regression.html',
                   to = 'pdfs/16_ml_regression.pdf',
                   complex_slides = TRUE,
                   partial_slides = TRUE,
                   delay = 1)

# I am using my adobe to create the ppt since the text is editable (which is more preferable to students)
renderthis::to_pptx(from = 'lectures/16_ml_regression/16_ml_regression.html',
                    to = 'ppts/16_ml_regression.pptx',
                    complex_slides = TRUE,
                    partial_slides = TRUE,
                    delay = 1)
