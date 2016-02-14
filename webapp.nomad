job "webapp" {
  datacenters = ["dc1"]
  constraint {
    attribute = "$attr.kernel.name"
    value = "linux"
  }

  update {
    stagger = "10s"
    max_parallel = 1
  }

  group "web" {
    count = 3

    restart {
      interval = "5m"
      attempts = 10
      delay = "25s"
      mode = "delay" #0.3-dev
    }

    task "webapp" {
      driver = "docker"
      config {
        image = "docker:15000/webapp"
         port_map {
          http = 80
        }
      }

      service {
        name = "web"
        tags = ["webapp"]
        port = "http"
        check {
          name = "alive"
          type = "tcp"
          interval = "10s"
          timeout = "2s"
        }
      }
      resources {
        cpu = 10 # 500 Mhz
        memory = 128 # 256MB
        network {
          mbits = 10
          port "webapp" {
          }  
        }
      }
    }
  }
}
