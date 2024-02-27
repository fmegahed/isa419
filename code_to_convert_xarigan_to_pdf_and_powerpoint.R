if(require(renderthis)==FALSE) remotes::install_github("jhelvy/renderthis", dependencies = TRUE)
if(require(officer) == FALSE) install.packages('officer')

renderthis::to_pdf(from = 'lectures/09_data_viz_intro/09_data_viz_intro.html',
                   to = 'pdfs/09_data_viz_intro.pdf',
                   complex_slides = TRUE,
                   partial_slides = TRUE,
                   delay = 3)

# I am using my adobe to create the ppt since the text is editable (which is more preferable to students)
renderthis::to_pptx(from = 'lectures/09_data_viz_intro/09_data_viz_intro.html',
                    to = 'ppts/09_data_viz_intro.pptx',
                    complex_slides = TRUE,
                    partial_slides = TRUE,
                    delay = 3)
