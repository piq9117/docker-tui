{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.TaskStatus where

import qualified Control.Applicative
import qualified Control.Exception
import qualified Control.Monad
import qualified Control.Monad.IO.Class
import qualified Data.Aeson
import qualified Data.Aeson.Encoding
import qualified Data.Aeson.Types
import qualified Data.Attoparsec.ByteString
import qualified Data.ByteString
import qualified Data.List
import qualified Data.List.NonEmpty
import qualified Data.Map
import qualified Data.Maybe
import qualified Data.Text
import qualified Data.Text.Encoding
import qualified Data.Time
import qualified GHC.Float
import qualified GHC.Int
import qualified GHC.Records
import qualified GHC.Types
import qualified Network.HTTP.Types
import qualified Network.Wai
import qualified Web.HttpApiData



import OpenAPI.Docker.Schemas.ContainerStatus
import OpenAPI.Docker.Schemas.PortStatus
import OpenAPI.Docker.Schemas.TaskState

data TaskStatus = TaskStatus
    {
        containerStatus :: (Data.Maybe.Maybe (ContainerStatus)),
        err :: (Data.Maybe.Maybe (Data.Text.Text)),
        message :: (Data.Maybe.Maybe (Data.Text.Text)),
        portStatus :: (Data.Maybe.Maybe (PortStatus)),
        state :: (Data.Maybe.Maybe (TaskState)),
        timestamp :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON TaskStatus where
    toJSON TaskStatus {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "ContainerStatus" Data.Aeson..= containerStatus | Just containerStatus <- [containerStatus] ]
        ++ [ "Err" Data.Aeson..= err | Just err <- [err] ]
        ++ [ "Message" Data.Aeson..= message | Just message <- [message] ]
        ++ [ "PortStatus" Data.Aeson..= portStatus | Just portStatus <- [portStatus] ]
        ++ [ "State" Data.Aeson..= state | Just state <- [state] ]
        ++ [ "Timestamp" Data.Aeson..= timestamp | Just timestamp <- [timestamp] ])

    toEncoding TaskStatus {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "ContainerStatus" . Data.Aeson.toEncoding) containerStatus <>
          maybe mempty (Data.Aeson.Encoding.pair "Err" . Data.Aeson.toEncoding) err <>
          maybe mempty (Data.Aeson.Encoding.pair "Message" . Data.Aeson.toEncoding) message <>
          maybe mempty (Data.Aeson.Encoding.pair "PortStatus" . Data.Aeson.toEncoding) portStatus <>
          maybe mempty (Data.Aeson.Encoding.pair "State" . Data.Aeson.toEncoding) state <>
          maybe mempty (Data.Aeson.Encoding.pair "Timestamp" . Data.Aeson.toEncoding) timestamp
        )

instance Data.Aeson.FromJSON TaskStatus where
    parseJSON = Data.Aeson.withObject "TaskStatus" $ \o ->
        TaskStatus
            <$> o Data.Aeson..:? "ContainerStatus"
            <*> o Data.Aeson..:? "Err"
            <*> o Data.Aeson..:? "Message"
            <*> o Data.Aeson..:? "PortStatus"
            <*> o Data.Aeson..:? "State"
            <*> o Data.Aeson..:? "Timestamp"