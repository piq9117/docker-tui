{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.ProcessConfig where

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





data ProcessConfig = ProcessConfig
    {
        arguments :: (Data.Maybe.Maybe ([ Data.Text.Text ])),
        entrypoint :: (Data.Maybe.Maybe (Data.Text.Text)),
        privileged :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        tty :: (Data.Maybe.Maybe (GHC.Types.Bool)),
        user :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ProcessConfig where
    toJSON ProcessConfig {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "arguments" Data.Aeson..= arguments | Just arguments <- [arguments] ]
        ++ [ "entrypoint" Data.Aeson..= entrypoint | Just entrypoint <- [entrypoint] ]
        ++ [ "privileged" Data.Aeson..= privileged | Just privileged <- [privileged] ]
        ++ [ "tty" Data.Aeson..= tty | Just tty <- [tty] ]
        ++ [ "user" Data.Aeson..= user | Just user <- [user] ])

    toEncoding ProcessConfig {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "arguments" . Data.Aeson.toEncoding) arguments <>
          maybe mempty (Data.Aeson.Encoding.pair "entrypoint" . Data.Aeson.toEncoding) entrypoint <>
          maybe mempty (Data.Aeson.Encoding.pair "privileged" . Data.Aeson.toEncoding) privileged <>
          maybe mempty (Data.Aeson.Encoding.pair "tty" . Data.Aeson.toEncoding) tty <>
          maybe mempty (Data.Aeson.Encoding.pair "user" . Data.Aeson.toEncoding) user
        )

instance Data.Aeson.FromJSON ProcessConfig where
    parseJSON = Data.Aeson.withObject "ProcessConfig" $ \o ->
        ProcessConfig
            <$> o Data.Aeson..:? "arguments"
            <*> o Data.Aeson..:? "entrypoint"
            <*> o Data.Aeson..:? "privileged"
            <*> o Data.Aeson..:? "tty"
            <*> o Data.Aeson..:? "user"