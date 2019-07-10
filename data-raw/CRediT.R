## code to prepare `CRediT` dataset goes here
#devtools::install_github("alistaire47/read.so")
library(read.so)
library(dplyr)

"
  | #    | Role                           | Definition                                                   |
  | ---- | ------------------------------ | ------------------------------------------------------------ |
  | 1    | **Conceptualization**          | Ideas; formulation or evolution of overarching research goals and aims. |
  | 2    | **Data curation**              | Management activities to annotate (produce metadata), scrub data and maintain research data (including software code, where it is necessary for interpreting the data itself) for initial use and later re-use. |
  | 3    | **Formal analysis**            | Application of statistical, mathematical, computational, or other formal techniques to analyse or synthesize study data. |
  | 4    | **Funding acquisition**        | Acquisition of the financial support for the project leading to this publication. |
  | 5    | **Investigation**              | Conducting a research and investigation process, specifically performing the experiments, or data/evidence collection. |
  | 6    | **Methodology**                | Development or design of methodology; creation of models.    |
  | 7    | **Project administration **    | Management and coordination responsibility for the research activity planning and execution. |
  | 8    | **Resources**                  | Provision of study materials, reagents, materials, patients, laboratory samples, animals, instrumentation, computing resources, or other analysis tools. |
  | 9    | **Software**                   | Programming, software development; designing computer programs; implementation of the computer code and supporting algorithms; testing of existing code components. |
  | 10   | **Supervision**                | Oversight and leadership responsibility for the research activity planning and execution, including mentorship external to the core team. |
  | 11   | **Validation**                 | Verification, whether as a part of the activity or separate, of the overall replication/reproducibility of results/experiments and other research outputs. |
  | 12   | **Visualization**              | Preparation, creation and/or presentation of the published work, specifically visualization/data presentation. |
  | 13   | **Writing – original draft**   | Preparation, creation and/or presentation of the published work, specifically writing the initial draft (including substantive translation). |
  | 14   | **Writing – review & editing** | Preparation, creation and/or presentation of the published work by those from the original research group, specifically critical review, commentary or revision – including pre- or post-publication stages. |
"

CRediT = read_md()
CRediT = CRediT %>%
  dplyr::select(-`#`) %>%
  dplyr::mutate(Role = gsub("\\*", "", Role))

usethis::use_data(CRediT)
