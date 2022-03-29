data "external" "resouce_name" {
  program = ["python3", "${path.module}/external/namegenerator.py"]
}