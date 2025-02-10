{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.PluginPrivilege where

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





data PluginPrivilege = PluginPrivilege
    {
        description :: (Data.Maybe.Maybe (Data.Text.Text)),
        name :: (Data.Maybe.Maybe (Data.Text.Text)),
        value :: (Data.Maybe.Maybe ([ Data.Text.Text ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON PluginPrivilege where
    toJSON PluginPrivilege {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "Description" Data.Aeson..= description | Just description <- [description] ]
        ++ [ "Name" Data.Aeson..= name | Just name <- [name] ]
        ++ [ "Value" Data.Aeson..= value | Just value <- [value] ])

    toEncoding PluginPrivilege {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Description" . Data.Aeson.toEncoding) description <>
          maybe mempty (Data.Aeson.Encoding.pair "Name" . Data.Aeson.toEncoding) name <>
          maybe mempty (Data.Aeson.Encoding.pair "Value" . Data.Aeson.toEncoding) value
        )

instance Data.Aeson.FromJSON PluginPrivilege where
    parseJSON = Data.Aeson.withObject "PluginPrivilege" $ \o ->
        PluginPrivilege
            <$> o Data.Aeson..:? "Description"
            <*> o Data.Aeson..:? "Name"
            <*> o Data.Aeson..:? "Value"