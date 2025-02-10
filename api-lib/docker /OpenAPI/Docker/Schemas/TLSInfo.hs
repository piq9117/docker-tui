{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Schemas.TLSInfo where

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





data TLSInfo = TLSInfo
    {
        certIssuerPublicKey :: (Data.Maybe.Maybe (Data.Text.Text)),
        certIssuerSubject :: (Data.Maybe.Maybe (Data.Text.Text)),
        trustRoot :: (Data.Maybe.Maybe (Data.Text.Text))
    }
    deriving (Show)

instance Data.Aeson.ToJSON TLSInfo where
    toJSON TLSInfo {..} = Data.Aeson.object
        ([ 
        ]
        ++ [ "CertIssuerPublicKey" Data.Aeson..= certIssuerPublicKey | Just certIssuerPublicKey <- [certIssuerPublicKey] ]
        ++ [ "CertIssuerSubject" Data.Aeson..= certIssuerSubject | Just certIssuerSubject <- [certIssuerSubject] ]
        ++ [ "TrustRoot" Data.Aeson..= trustRoot | Just trustRoot <- [trustRoot] ])

    toEncoding TLSInfo {..} = Data.Aeson.Encoding.pairs
        ( maybe mempty (Data.Aeson.Encoding.pair "CertIssuerPublicKey" . Data.Aeson.toEncoding) certIssuerPublicKey <>
          maybe mempty (Data.Aeson.Encoding.pair "CertIssuerSubject" . Data.Aeson.toEncoding) certIssuerSubject <>
          maybe mempty (Data.Aeson.Encoding.pair "TrustRoot" . Data.Aeson.toEncoding) trustRoot
        )

instance Data.Aeson.FromJSON TLSInfo where
    parseJSON = Data.Aeson.withObject "TLSInfo" $ \o ->
        TLSInfo
            <$> o Data.Aeson..:? "CertIssuerPublicKey"
            <*> o Data.Aeson..:? "CertIssuerSubject"
            <*> o Data.Aeson..:? "TrustRoot"