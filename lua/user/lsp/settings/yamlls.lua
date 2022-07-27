local opts = {
  settings = {
    schemas = {
      ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "helm/lmify-server-app/templates/credentials.yaml",
    },
    {
      ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.yml"
    },
  }
}

return opts
