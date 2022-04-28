local opts = {
  settings = {
    schemas = {
      ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "helm/lmify-server-app/templates/credentials.yaml"
    }
  }
}

return opts
