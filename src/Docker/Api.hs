module Docker.Api
  (
  )
where

newtype DockerT input m a = DockerT
  { runDocker :: input -> m a
  }

