{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.DeviceMapping where

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





data DeviceMapping = DeviceMapping
    {
        cgroupPermissions :: (Data.Maybe.Maybe (Data.Text.Text)),
        pathInContainer :: (Data.Maybe.Maybe (Data.Text.Text)),
        pathOnHost :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON DeviceMapping where
    toJSON DeviceMapping {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "CgroupPermissions" Data.Aeson..= cgroupPermissions | Just cgroupPermissions <- [cgroupPermissions] ]
        ++ [ "PathInContainer" Data.Aeson..= pathInContainer | Just pathInContainer <- [pathInContainer] ]
        ++ [ "PathOnHost" Data.Aeson..= pathOnHost | Just pathOnHost <- [pathOnHost] ])

    toEncoding DeviceMapping {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "CgroupPermissions" . Data.Aeson.toEncoding) cgroupPermissions <>
          maybe mempty (Data.Aeson.Encoding.pair "PathInContainer" . Data.Aeson.toEncoding) pathInContainer <>
          maybe mempty (Data.Aeson.Encoding.pair "PathOnHost" . Data.Aeson.toEncoding) pathOnHost
        )

instance Data.Aeson.FromJSON DeviceMapping where
    parseJSON = Data.Aeson.withObject "DeviceMapping" $ \o ->
        DeviceMapping
            <$> o Data.Aeson..:? "CgroupPermissions"
            <*> o Data.Aeson..:? "PathInContainer"
            <*> o Data.Aeson..:? "PathOnHost"