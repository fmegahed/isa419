if(require(renderthis)==FALSE) remotes::install_github("jhelvy/renderthis", dependencies = TRUE)
if(require(officer) == FALSE) install.packages('officer')

renderthis::to_pdf(from = 'lectures/13_clustering/13_clustering.html',
                   to = 'pdfs/13_clustering.pdf',
                   complex_slides = TRUE,
                   partial_slides = TRUE,
                   delay = 1)

# I am using my adobe to create the ppt since the text is editable (which is more preferable to students)
renderthis::to_pptx(from = 'lectures/13_clustering/13_clustering.html',
                    to = 'ppts/13_clustering.pptx',
                    complex_slides = TRUE,
                    partial_slides = TRUE,
                    delay = 1)
