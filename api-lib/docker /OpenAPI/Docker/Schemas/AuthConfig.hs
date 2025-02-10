{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.AuthConfig where

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





data AuthConfig = AuthConfig
    {
        email :: (Data.Maybe.Maybe (Data.Text.Text)),
        password :: (Data.Maybe.Maybe (Data.Text.Text)),
        serveraddress :: (Data.Maybe.Maybe (Data.Text.Text)),
        username :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON AuthConfig where
    toJSON AuthConfig {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "email" Data.Aeson..= email | Just email <- [email] ]
        ++ [ "password" Data.Aeson..= password | Just password <- [password] ]
        ++ [ "serveraddress" Data.Aeson..= serveraddress | Just serveraddress <- [serveraddress] ]
        ++ [ "username" Data.Aeson..= username | Just username <- [username] ])

    toEncoding AuthConfig {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "email" . Data.Aeson.toEncoding) email <>
          maybe mempty (Data.Aeson.Encoding.pair "password" . Data.Aeson.toEncoding) password <>
          maybe mempty (Data.Aeson.Encoding.pair "serveraddress" . Data.Aeson.toEncoding) serveraddress <>
          maybe mempty (Data.Aeson.Encoding.pair "username" . Data.Aeson.toEncoding) username
        )

instance Data.Aeson.FromJSON AuthConfig where
    parseJSON = Data.Aeson.withObject "AuthConfig" $ \o ->
        AuthConfig
            <$> o Data.Aeson..:? "email"
            <*> o Data.Aeson..:? "password"
            <*> o Data.Aeson..:? "serveraddress"
            <*> o Data.Aeson..:? "username"