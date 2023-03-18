data "template_file" "jupyter" {
  template = <<EOF
#!/bin/bash
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh
docker run -d -p 80:8888 --name demo jupyter/base-notebook start-notebook.sh --NotebookApp.token=
EOF
}