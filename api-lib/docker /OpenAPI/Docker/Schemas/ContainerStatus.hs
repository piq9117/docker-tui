{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.ContainerStatus where

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





data ContainerStatus = ContainerStatus
    {
        containerID :: (Data.Maybe.Maybe (Data.Text.Text)),
        exitCode :: (Data.Maybe.Maybe (GHC.Int.Int)),
        pID :: (Data.Maybe.Maybe (GHC.Int.Int))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerStatus where
    toJSON ContainerStatus {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "ContainerID" Data.Aeson..= containerID | Just containerID <- [containerID] ]
        ++ [ "ExitCode" Data.Aeson..= exitCode | Just exitCode <- [exitCode] ]
        ++ [ "PID" Data.Aeson..= pID | Just pID <- [pID] ])

    toEncoding ContainerStatus {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "ContainerID" . Data.Aeson.toEncoding) containerID <>
          maybe mempty (Data.Aeson.Encoding.pair "ExitCode" . Data.Aeson.toEncoding) exitCode <>
          maybe mempty (Data.Aeson.Encoding.pair "PID" . Data.Aeson.toEncoding) pID
        )

instance Data.Aeson.FromJSON ContainerStatus where
    parseJSON = Data.Aeson.withObject "ContainerStatus" $ \o ->
        ContainerStatus
            <$> o Data.Aeson..:? "ContainerID"
            <*> o Data.Aeson..:? "ExitCode"
            <*> o Data.Aeson..:? "PID"