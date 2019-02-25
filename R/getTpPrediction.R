# libraries
library(nnet)

# load the saved model
#load("logit_models")

getTpPrediction <- function(AWAY_EFG, AWAY_TOVr, AWAY_OREBr, AWAY_DREBr, AWAY_FTF, AWAY_oEFG, AWAY_oTOVr, AWAY_oFTF, HOME_EFG, HOME_TOVr, HOME_OREBr, HOME_DREBr, HOME_FTF, HOME_oEFG, HOME_oTOVr, HOME_oFTF) {

  # turn inputs into new data data frame
  df_inputs <- as.data.frame(list("AWAY_EFG" = AWAY_EFG, "AWAY_TOVr" = AWAY_TOVr, "AWAY_OREBr" = AWAY_OREBr,
                                  "AWAY_DREBr" = AWAY_DREBr, "AWAY_FTF" = AWAY_FTF, "AWAY_oEFG" = AWAY_oEFG,
                                  "AWAY_oTOVr" = AWAY_oTOVr, "AWAY_oFTF" = AWAY_oFTF, "HOME_EFG" = HOME_EFG,
                                  "HOME_TOVr" = HOME_TOVr, "HOME_OREBr" = HOME_OREBr, "HOME_DREBr" = HOME_DREBr,
                                  "HOME_FTF" = HOME_FTF, "HOME_oEFG" = HOME_oEFG, "HOME_oTOVr" = HOME_oTOVr,
                                  "HOME_oFTF" = HOME_oFTF))

  # declare Markov-chain states
  states_temp <- c("HOME_JUMP_BALL", "AWAY_JUMP_BALL",
                   "HOME_TURNOVER_DEAD", "AWAY_TURNOVER_DEAD",
                   "HOME_TURNOVER_LIVE", "AWAY_TURNOVER_LIVE",
                   "HOME_FOULED_NON_SHOOTING", "AWAY_FOULED_NON_SHOOTING",
                   "HOME_FOULED_INBOUNDS_LAST_2_MINS", "AWAY_FOULED_INBOUNDS_LAST_2_MINS",
                   "HOME_FOULED_INBOUNDS", "AWAY_FOULED_INBOUNDS",
                   "HOME_FOULED_CLEAR_PATH", "AWAY_FOULED_CLEAR_PATH",
                   "HOME_FOULED_FLAGRANT", "AWAY_FOULED_FLAGRANT",
                   "HOME_FOULED_TECHNICAL", "AWAY_FOULED_TECHNICAL",
                   "HOME_FT_WITH_POSSESSION_1_OF_1_MADE", "AWAY_FT_WITH_POSSESSION_1_OF_1_MADE",
                   "HOME_FT_WITH_POSSESSION_1_OF_1_MISSED", "AWAY_FT_WITH_POSSESSION_1_OF_1_MISSED",
                   "HOME_FT_WITH_POSSESSION_1_OF_2_MADE", "AWAY_FT_WITH_POSSESSION_1_OF_2_MADE",
                   "HOME_FT_WITH_POSSESSION_1_OF_2_MISSED", "AWAY_FT_WITH_POSSESSION_1_OF_2_MISSED",
                   "HOME_FT_WITH_POSSESSION_2_OF_2_MADE", "AWAY_FT_WITH_POSSESSION_2_OF_2_MADE",
                   "HOME_FT_WITH_POSSESSION_2_OF_2_MISSED", "AWAY_FT_WITH_POSSESSION_2_OF_2_MISSED",
                   "HOME_FT_1_OF_1_MADE", "AWAY_FT_1_OF_1_MADE",
                   "HOME_FT_1_OF_1_MISSED", "AWAY_FT_1_OF_1_MISSED",
                   "HOME_FT_1_OF_2_MADE", "AWAY_FT_1_OF_2_MADE",
                   "HOME_FT_1_OF_2_MISSED", "AWAY_FT_1_OF_2_MISSED",
                   "HOME_FT_2_OF_2_MADE", "AWAY_FT_2_OF_2_MADE",
                   "HOME_FT_2_OF_2_MISSED", "AWAY_FT_2_OF_2_MISSED",
                   "HOME_FT_1_OF_3_MADE", "AWAY_FT_1_OF_3_MADE",
                   "HOME_FT_1_OF_3_MISSED", "AWAY_FT_1_OF_3_MISSED",
                   "HOME_FT_2_OF_3_MADE", "AWAY_FT_2_OF_3_MADE",
                   "HOME_FT_2_OF_3_MISSED", "AWAY_FT_2_OF_3_MISSED",
                   "HOME_FT_3_OF_3_MADE", "AWAY_FT_3_OF_3_MADE",
                   "HOME_FT_3_OF_3_MISSED", "AWAY_FT_3_OF_3_MISSED",
                   "HOME_DREB", "AWAY_DREB",
                   "HOME_OREB", "AWAY_OREB",
                   "HOME_2PT_FG_MADE_AND_FOUL", "AWAY_2PT_FG_MADE_AND_FOUL",
                   "HOME_2PT_FG_MADE", "AWAY_2PT_FG_MADE",
                   "HOME_2PT_FG_MISSED_AND_FOUL", "AWAY_2PT_FG_MISSED_AND_FOUL",
                   "HOME_2PT_FG_MISSED", "AWAY_2PT_FG_MISSED",
                   "HOME_3PT_FG_MADE_AND_FOUL", "AWAY_3PT_FG_MADE_AND_FOUL",
                   "HOME_3PT_FG_MADE", "AWAY_3PT_FG_MADE",
                   "HOME_3PT_FG_MISSED_AND_FOUL", "AWAY_3PT_FG_MISSED_AND_FOUL",
                   "HOME_3PT_FG_MISSED", "AWAY_3PT_FG_MISSED",
                   "HOME_TIMEOUT", "AWAY_TIMEOUT",
                   "HOME_KICKED_BALL", "AWAY_KICKED_BALL")

  # create skeleton transition matrix
  m <- matrix(0.0000, nrow = 78, ncol = 78)
  colnames(m) <- states_temp
  rownames(m) <- states_temp

  # use multinomial logit models to predict games in training set
  for (i in rownames(m)) {
    #print(i)
    if (is.numeric(logit_models[[i]])) {
      next
    }
    temp_predict <- as.list(predict(returnData="TRUE", logit_models[[i]], type="probs", newdata=df_inputs))
    for (j in names(temp_predict)) {
      if (j == "1") {
        break
      }
      m[i, j] <- temp_predict[[j]]
    }
  }

  # return predicted transition matrix
  return(m)

}
