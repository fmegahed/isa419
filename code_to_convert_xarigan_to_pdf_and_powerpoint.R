if(require(renderthis)==FALSE) remotes::install_github("jhelvy/renderthis", dependencies = TRUE)
if(require(officer) == FALSE) install.packages('officer')

renderthis::to_pdf(from = 'lectures/10_data_viz_cont/10_data_viz_cont.html',
                   to = 'pdfs/10_data_viz_cont.pdf',
                   complex_slides = TRUE,
                   partial_slides = TRUE,
                   delay = 3)

# I am using my adobe to create the ppt since the text is editable (which is more preferable to students)
renderthis::to_pptx(from = 'lectures/10_data_viz_cont/10_data_viz_cont.html',
                    to = 'ppts/10_data_viz_cont.pptx',
                    complex_slides = TRUE,
                    partial_slides = TRUE,
                    delay = 3)
