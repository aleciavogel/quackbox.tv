import React from 'react'
import Typography from '@material-ui/core/Typography'

const PlayerListItem = ({ name }) => {
  return (
    <li>
      <Typography>
        {name}
      </Typography>
    </li>
  )
}

export default PlayerListItem