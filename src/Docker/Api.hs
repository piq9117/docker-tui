module Docker.Api
  ( DockerImage (..),
  )
where

import Data.Aeson (FromJSON (..), ToJSON (..))
import Data.Time (UTCTime)

data DockerImage = DockerImage
  { containers :: Text,
    createdAt :: UTCTime,
    createdSince :: Text,
    digest :: ByteString,
    id :: Text,
    repository :: Text,
    shardSize :: Text,
    tag :: Text,
    uniqueSize :: Text,
    virtualizeSize :: Text
  }
