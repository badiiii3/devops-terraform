provider "kubernetes" {
  host                   = "https://127.0.0.1:50262"  # Replace with your Minikube API endpoint
  token                  = "eyJhbGciOiJSUzI1NiIsImtpZCI6IlFzZ0xCaDVGbmZDWS1RTDA5eHYwOVk2WHBuLUtoOVVEMkZiV0FuUlFGaWcifQ.eyJhdWQiOlsiaHR0cHM6Ly9rdWJlcm5ldGVzLmRlZmF1bHQuc3ZjLmNsdXN0ZXIubG9jYWwiXSwiZXhwIjoxNzM0MjYyOTAwLCJpYXQiOjE3MzQyNTkzMDAsImlzcyI6Imh0dHBzOi8va3ViZXJuZXRlcy5kZWZhdWx0LnN2Yy5jbHVzdGVyLmxvY2FsIiwianRpIjoiZmNjYTU4YTItZmZlOS00ODA1LWI5NDgtZjIwOTljNmQ0NmRhIiwia3ViZXJuZXRlcy5pbyI6eyJuYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsInNlcnZpY2VhY2NvdW50Ijp7Im5hbWUiOiJkZWZhdWx0IiwidWlkIjoiYmZkMDc1MmItMjgwOS00YmQ1LTk5ODItZjU0ODdiYmRhOGZkIn19LCJuYmYiOjE3MzQyNTkzMDAsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDprdWJlLXN5c3RlbTpkZWZhdWx0In0.jQt25nbcanbPmhtu5HPSFV2a9WVGZCClDafk5Zk5QbSz4Nu8IsGAFYuPfvx3jx0lpmJwCMzt02lzactx-YERKLsia2oQhyQsrKfzUZzS4Mm8cyZ8cJj3o9MGzsvneB6KF-EbeFCzB-qcLeEH8UAhplDxYBEyChn2UrYfDVIZ0HakvHhWhsklhG_BsBLuWyqlRjfj6LW6f3og1MH8VvwdIfNzoAIgQzW_D5SGvA_4pIaErIxRaMbP_JCQS6e6PSYBpdOVEd20kXCHrQYNw8uHuvCQrWxll2d_oTM1Nhmo5qrvzMnMUlGnGUcaRJnbTwhLzmL_7iUb8hOLc4EsHoa4Zw"  # Replace with your decoded token
  cluster_ca_certificate = file("~/.minikube/ca.crt")  # Path to the Minikube CA certificate
}

resource "kubernetes_namespace" "example" {
  metadata {
    name = "example"
  }
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "nginx-deployment"
    namespace = kubernetes_namespace.example.metadata[0].name
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx:latest"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}
