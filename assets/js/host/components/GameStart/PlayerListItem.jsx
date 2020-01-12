import React from 'react'
import { makeStyles } from '@material-ui/core/styles'
import Typography from '@material-ui/core/Typography'
import Paper from '@material-ui/core/Paper'
import FlagIcon from '@material-ui/icons/Flag'
import grey from '@material-ui/core/colors/grey'

const useStyles = makeStyles(theme => ({
  root: {
    paddingTop: theme.spacing(1),
    paddingLeft: theme.spacing(2),
    paddingBottom: theme.spacing(1),
    paddingRight: theme.spacing(2),
    marginBottom: theme.spacing(2)
  },
  icon: {
    color: grey[500]
  }
}))

const PlayerListItem = ({ player }) => {
  const classes = useStyles()

  return (
    <Paper variant="outlined" className={classes.root}>
      <Typography variant="h4">
        {player.name} {player.is_lead && (
          <FlagIcon className={classes.icon} />
        )}
      </Typography>
    </Paper>
  )
}

export default PlayerListItem
