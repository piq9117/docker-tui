{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.ContainerWaitResponse where

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



import OpenAPI.Docker.Schemas.ContainerWaitExitError

data ContainerWaitResponse = ContainerWaitResponse
    {
        error :: (Data.Maybe.Maybe (ContainerWaitExitError)),
        statusCode :: GHC.Int.Int64
    }
    deriving (Show)

instance Data.Aeson.ToJSON ContainerWaitResponse where
    toJSON ContainerWaitResponse {..} = Data.Aeson.object
        ([ "StatusCode" Data.Aeson..= statusCode
        ]
        ++ [ "Error" Data.Aeson..= error | Just error <- [error] ])

    toEncoding ContainerWaitResponse {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "Error" . Data.Aeson.toEncoding) error <>
          Data.Aeson.Encoding.pair "StatusCode" (Data.Aeson.toEncoding statusCode)
        )

instance Data.Aeson.FromJSON ContainerWaitResponse where
    parseJSON = Data.Aeson.withObject "ContainerWaitResponse" $ \o ->
        ContainerWaitResponse
            <$> o Data.Aeson..:? "Error"
            <*> o Data.Aeson..: "StatusCode"