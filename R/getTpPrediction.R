# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

getTpPrediction <- function(AWAY_EFG, AWAY_TOVr, AWAY_OREBr, AWAY_DREBr, AWAY_FTF, AWAY_oEFG, AWAY_oTOVr, AWAY_oFTF, HOME_EFG, HOME_TOVr, HOME_OREBr, HOME_DREBr, HOME_FTF, HOME_oEFG, HOME_oTOVr, HOME_oFTF) {

  return(list("AWAY_EFG" = AWAY_EFG, "AWAY_TOVr" = AWAY_TOVr, "AWAY_OREBr" = AWAY_OREBr, "AWAY_DREBr" = AWAY_DREBr, "AWAY_FTF" = AWAY_FTF, "AWAY_oEFG" = AWAY_oEFG, "AWAY_oTOVr" = AWAY_oTOVr, "AWAY_oFTF" = AWAY_oFTF, "HOME_EFG" = HOME_EFG, "HOME_TOVr" = HOME_TOVr, "HOME_OREBr" = HOME_OREBr, "HOME_DREBr" = HOME_DREBr, "HOME_FTF" = HOME_FTF, "HOME_oEFG" = HOME_oEFG, "HOME_oTOVr" = HOME_oTOVr, "HOME_oFTF" = HOME_oFTF))

}
