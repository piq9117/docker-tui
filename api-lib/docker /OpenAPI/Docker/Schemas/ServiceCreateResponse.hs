{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.ServiceCreateResponse where

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





data ServiceCreateResponse = ServiceCreateResponse
    {
        iD :: (Data.Maybe.Maybe (Data.Text.Text)),
        warnings :: (Data.Maybe.Maybe ([ Data.Text.Text ]))
    }
    deriving (Show)

instance Data.Aeson.ToJSON ServiceCreateResponse where
    toJSON ServiceCreateResponse {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "ID" Data.Aeson..= iD | Just iD <- [iD] ]
        ++ [ "Warnings" Data.Aeson..= warnings | Just warnings <- [warnings] ])

    toEncoding ServiceCreateResponse {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "ID" . Data.Aeson.toEncoding) iD <>
          maybe mempty (Data.Aeson.Encoding.pair "Warnings" . Data.Aeson.toEncoding) warnings
        )

instance Data.Aeson.FromJSON ServiceCreateResponse where
    parseJSON = Data.Aeson.withObject "ServiceCreateResponse" $ \o ->
        ServiceCreateResponse
            <$> o Data.Aeson..:? "ID"
            <*> o Data.Aeson..:? "Warnings"