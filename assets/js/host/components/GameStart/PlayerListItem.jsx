import React from 'react'
import { makeStyles } from '@material-ui/core/styles'
import Typography from '@material-ui/core/Typography'
import Paper from '@material-ui/core/Paper'

const useStyles = makeStyles(theme => ({
  root: {
    paddingTop: theme.spacing(1),
    paddingLeft: theme.spacing(2),
    paddingBottom: theme.spacing(1),
    paddingRight: theme.spacing(2),
    marginBottom: theme.spacing(2)
  }
}))

const PlayerListItem = ({ name }) => {
  const classes = useStyles()

  return (
    <Paper variant="outlined" className={classes.root}>
      <Typography variant="h4">
        {name}
      </Typography>
    </Paper>
  )
}

export default PlayerListItem