if(require(renderthis)==FALSE) remotes::install_github("jhelvy/renderthis", dependencies = TRUE)
if(require(officer) == FALSE) install.packages('officer')

renderthis::to_pdf(from = 'lectures/06_cleaning_and_combining_data/06_cleaning_and_combining_data.html',
                   to = 'pdfs/06_cleaning_and_combining_data.pdf',
                   complex_slides = TRUE,
                   partial_slides = TRUE,
                   delay = 1)

# I am using my adobe to create the ppt since the text is editable (which is more preferable to students)
renderthis::to_pptx(from = 'lectures/06_cleaning_and_combining_data/06_cleaning_and_combining_data.html',
                    to = 'ppts/06_cleaning_and_combining_data.pptx',
                    complex_slides = TRUE,
                    partial_slides = TRUE,
                    delay = 1)