if(require(renderthis)==FALSE) remotes::install_github("jhelvy/renderthis", dependencies = TRUE)
if(require(officer) == FALSE) install.packages('officer')

renderthis::to_pdf(from = 'lectures/07_aggregating_data/07_aggregating_data.html',
                   to = 'pdfs/07_aggregating_data.pdf',
                   complex_slides = TRUE,
                   partial_slides = TRUE,
                   delay = 1)

# I am using my adobe to create the ppt since the text is editable (which is more preferable to students)
renderthis::to_pptx(from = 'lectures/07_aggregating_data/07_aggregating_data.html',
                    to = 'ppts/07_aggregating_data.pptx',
                    complex_slides = TRUE,
                    partial_slides = TRUE,
                    delay = 1)
