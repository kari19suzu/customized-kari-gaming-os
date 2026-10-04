rule = {
  matches = {
    {
      { "node.name", "matches", ".*" },
    },
  },
  apply_properties = {
    ["session.suspend-timeout-seconds"] = 0,
  },
}
table.insert(alsa_monitor.rules, rule)
