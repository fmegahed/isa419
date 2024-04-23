if(require(renderthis)==FALSE) remotes::install_github("jhelvy/renderthis", dependencies = TRUE)
if(require(officer) == FALSE) install.packages('officer')

renderthis::to_pdf(from = 'lectures/21_touchalytics_lab/21_touchalytics_lab.html',
                   to = 'pdfs/21_touchalytics_lab.pdf',
                   complex_slides = TRUE,
                   partial_slides = TRUE,
                   delay = 1)

# I am using my adobe to create the ppt since the text is editable (which is more preferable to students)
renderthis::to_pptx(from = 'lectures/21_touchalytics_lab/21_touchalytics_lab.html',
                    to = 'ppts/21_touchalytics_lab.pptx',
                    complex_slides = TRUE,
                    partial_slides = TRUE,
                    delay = 1)
