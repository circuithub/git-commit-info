{exec} = require "child_process"

exports.getInfo = (gitDir, callback) ->
	cmd = "git --git-dir=#{gitDire}/.git log -1"
  metadata = {}
  exec cmd, (err, stdout, stderr) ->
    if err
      callback err
    else
      rows = stdout.split "\n"
      commit = rows[0].split " "
      metadata.commit = commit[1]
      rows = rows[1..] # all rows without commit
      for row in rows
        pair = row.split(":", 2)
        if pair and pair.length == 2
          key = pair[0].trim().toLowerCase().replace(" ", "_")
          value = pair[1].trim()
          metadata[key] = value
      callback undefined, metadata    