{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
module OpenAPI.Docker.Api where

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

import OpenAPI.Docker.Request
import OpenAPI.Docker.Response



import OpenAPI.Docker.Schemas.AuthConfig
import OpenAPI.Docker.Schemas.BuildCache
import OpenAPI.Docker.Schemas.ClusterVolumeSpec
import OpenAPI.Docker.Schemas.Config
import OpenAPI.Docker.Schemas.ConfigReference
import OpenAPI.Docker.Schemas.ConfigSpec
import OpenAPI.Docker.Schemas.ContainerConfig
import OpenAPI.Docker.Schemas.ContainerCreateResponse
import OpenAPI.Docker.Schemas.ContainerState
import OpenAPI.Docker.Schemas.ContainerSummary
import OpenAPI.Docker.Schemas.ContainerWaitResponse
import OpenAPI.Docker.Schemas.DeviceMapping
import OpenAPI.Docker.Schemas.DeviceRequest
import OpenAPI.Docker.Schemas.DistributionInspect
import OpenAPI.Docker.Schemas.Driver
import OpenAPI.Docker.Schemas.DriverData
import OpenAPI.Docker.Schemas.EndpointSettings
import OpenAPI.Docker.Schemas.EndpointSpec
import OpenAPI.Docker.Schemas.ErrorResponse
import OpenAPI.Docker.Schemas.EventMessage
import OpenAPI.Docker.Schemas.FilesystemChange
import OpenAPI.Docker.Schemas.HealthConfig
import OpenAPI.Docker.Schemas.HostConfig
import OpenAPI.Docker.Schemas.IPAM
import OpenAPI.Docker.Schemas.IdResponse
import OpenAPI.Docker.Schemas.ImageDeleteResponseItem
import OpenAPI.Docker.Schemas.ImageInspect
import OpenAPI.Docker.Schemas.ImageSummary
import OpenAPI.Docker.Schemas.MountPoint
import OpenAPI.Docker.Schemas.Network
import OpenAPI.Docker.Schemas.NetworkAttachmentConfig
import OpenAPI.Docker.Schemas.NetworkCreateResponse
import OpenAPI.Docker.Schemas.NetworkSettings
import OpenAPI.Docker.Schemas.NetworkingConfig
import OpenAPI.Docker.Schemas.Node
import OpenAPI.Docker.Schemas.NodeSpec
import OpenAPI.Docker.Schemas.Plugin
import OpenAPI.Docker.Schemas.PluginPrivilege
import OpenAPI.Docker.Schemas.ProcessConfig
import OpenAPI.Docker.Schemas.Resources
import OpenAPI.Docker.Schemas.RestartPolicy
import OpenAPI.Docker.Schemas.Secret
import OpenAPI.Docker.Schemas.SecretSpec
import OpenAPI.Docker.Schemas.Service
import OpenAPI.Docker.Schemas.ServiceCreateResponse
import OpenAPI.Docker.Schemas.ServiceSpec
import OpenAPI.Docker.Schemas.ServiceUpdateResponse
import OpenAPI.Docker.Schemas.Swarm
import OpenAPI.Docker.Schemas.SwarmSpec
import OpenAPI.Docker.Schemas.SystemInfo
import OpenAPI.Docker.Schemas.SystemVersion
import OpenAPI.Docker.Schemas.Task
import OpenAPI.Docker.Schemas.TaskSpec
import OpenAPI.Docker.Schemas.ThrottleDevice
import OpenAPI.Docker.Schemas.Volume
import OpenAPI.Docker.Schemas.VolumeCreateOptions
import OpenAPI.Docker.Schemas.VolumeListResponse

import OpenAPI.Docker.Response.BuildPrune
import OpenAPI.Docker.Response.ConfigCreate
import OpenAPI.Docker.Response.ConfigDelete
import OpenAPI.Docker.Response.ConfigInspect
import OpenAPI.Docker.Response.ConfigList
import OpenAPI.Docker.Response.ConfigUpdate
import OpenAPI.Docker.Response.ContainerArchive
import OpenAPI.Docker.Response.ContainerArchiveInfo
import OpenAPI.Docker.Response.ContainerAttach
import OpenAPI.Docker.Response.ContainerAttachWebsocket
import OpenAPI.Docker.Response.ContainerChanges
import OpenAPI.Docker.Response.ContainerCreate
import OpenAPI.Docker.Response.ContainerDelete
import OpenAPI.Docker.Response.ContainerExec
import OpenAPI.Docker.Response.ContainerExport
import OpenAPI.Docker.Response.ContainerInspect
import OpenAPI.Docker.Response.ContainerKill
import OpenAPI.Docker.Response.ContainerList
import OpenAPI.Docker.Response.ContainerLogs
import OpenAPI.Docker.Response.ContainerPause
import OpenAPI.Docker.Response.ContainerPrune
import OpenAPI.Docker.Response.ContainerRename
import OpenAPI.Docker.Response.ContainerResize
import OpenAPI.Docker.Response.ContainerRestart
import OpenAPI.Docker.Response.ContainerStart
import OpenAPI.Docker.Response.ContainerStats
import OpenAPI.Docker.Response.ContainerStop
import OpenAPI.Docker.Response.ContainerTop
import OpenAPI.Docker.Response.ContainerUnpause
import OpenAPI.Docker.Response.ContainerUpdate
import OpenAPI.Docker.Response.ContainerWait
import OpenAPI.Docker.Response.DistributionInspect
import OpenAPI.Docker.Response.ExecInspect
import OpenAPI.Docker.Response.ExecResize
import OpenAPI.Docker.Response.ExecStart
import OpenAPI.Docker.Response.GetPluginPrivileges
import OpenAPI.Docker.Response.ImageBuild
import OpenAPI.Docker.Response.ImageCommit
import OpenAPI.Docker.Response.ImageCreate
import OpenAPI.Docker.Response.ImageDelete
import OpenAPI.Docker.Response.ImageGet
import OpenAPI.Docker.Response.ImageGetAll
import OpenAPI.Docker.Response.ImageHistory
import OpenAPI.Docker.Response.ImageInspect
import OpenAPI.Docker.Response.ImageList
import OpenAPI.Docker.Response.ImageLoad
import OpenAPI.Docker.Response.ImagePrune
import OpenAPI.Docker.Response.ImagePush
import OpenAPI.Docker.Response.ImageSearch
import OpenAPI.Docker.Response.ImageTag
import OpenAPI.Docker.Response.NetworkConnect
import OpenAPI.Docker.Response.NetworkCreate
import OpenAPI.Docker.Response.NetworkDelete
import OpenAPI.Docker.Response.NetworkDisconnect
import OpenAPI.Docker.Response.NetworkInspect
import OpenAPI.Docker.Response.NetworkList
import OpenAPI.Docker.Response.NetworkPrune
import OpenAPI.Docker.Response.NodeDelete
import OpenAPI.Docker.Response.NodeInspect
import OpenAPI.Docker.Response.NodeList
import OpenAPI.Docker.Response.NodeUpdate
import OpenAPI.Docker.Response.PluginCreate
import OpenAPI.Docker.Response.PluginDelete
import OpenAPI.Docker.Response.PluginDisable
import OpenAPI.Docker.Response.PluginEnable
import OpenAPI.Docker.Response.PluginInspect
import OpenAPI.Docker.Response.PluginList
import OpenAPI.Docker.Response.PluginPull
import OpenAPI.Docker.Response.PluginPush
import OpenAPI.Docker.Response.PluginSet
import OpenAPI.Docker.Response.PluginUpgrade
import OpenAPI.Docker.Response.PutContainerArchive
import OpenAPI.Docker.Response.SecretCreate
import OpenAPI.Docker.Response.SecretDelete
import OpenAPI.Docker.Response.SecretInspect
import OpenAPI.Docker.Response.SecretList
import OpenAPI.Docker.Response.SecretUpdate
import OpenAPI.Docker.Response.ServiceCreate
import OpenAPI.Docker.Response.ServiceDelete
import OpenAPI.Docker.Response.ServiceInspect
import OpenAPI.Docker.Response.ServiceList
import OpenAPI.Docker.Response.ServiceLogs
import OpenAPI.Docker.Response.ServiceUpdate
import OpenAPI.Docker.Response.Session
import OpenAPI.Docker.Response.SwarmInit
import OpenAPI.Docker.Response.SwarmInspect
import OpenAPI.Docker.Response.SwarmJoin
import OpenAPI.Docker.Response.SwarmLeave
import OpenAPI.Docker.Response.SwarmUnlock
import OpenAPI.Docker.Response.SwarmUnlockkey
import OpenAPI.Docker.Response.SwarmUpdate
import OpenAPI.Docker.Response.SystemAuth
import OpenAPI.Docker.Response.SystemDataUsage
import OpenAPI.Docker.Response.SystemEvents
import OpenAPI.Docker.Response.SystemInfo
import OpenAPI.Docker.Response.SystemPing
import OpenAPI.Docker.Response.SystemPingHead
import OpenAPI.Docker.Response.SystemVersion
import OpenAPI.Docker.Response.TaskInspect
import OpenAPI.Docker.Response.TaskList
import OpenAPI.Docker.Response.TaskLogs
import OpenAPI.Docker.Response.VolumeCreate
import OpenAPI.Docker.Response.VolumeDelete
import OpenAPI.Docker.Response.VolumeInspect
import OpenAPI.Docker.Response.VolumeList
import OpenAPI.Docker.Response.VolumePrune
import OpenAPI.Docker.Response.VolumeUpdate

data Api m = Api {
    -- | Delete builder cache
    buildPrune ::
        -- @keep-storage@
        -- Amount of disk space in bytes to keep for cache
        (Data.Maybe.Maybe (GHC.Int.Int64)) ->
        -- @all@
        -- Remove all types of build cache
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @filters@
        -- A JSON encoded value of the filters (a `map[string][]string`) to
        -- process on the list of build cache objects.
        -- 
        -- Available filters:
        -- 
        -- - `until=<timestamp>` remove cache older than `<timestamp>`. The `<timestamp>` can be Unix timestamps, date formatted timestamps, or Go duration strings (e.g. `10m`, `1h30m`) computed relative to the daemon's local time.
        -- - `id=<id>`
        -- - `parent=<id>`
        -- - `type=<string>`
        -- - `description=<string>`
        -- - `inuse`
        -- - `shared`
        -- - `private`
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        m BuildPruneResponse,
    -- | Create a config
    configCreate ::
        ConfigCreateRequestBody ->
        m ConfigCreateResponse,
    -- | Delete a config
    configDelete ::
        -- @id@
        -- ID of the config
        Data.Text.Text ->
        m ConfigDeleteResponse,
    -- | Inspect a config
    configInspect ::
        -- @id@
        -- ID of the config
        Data.Text.Text ->
        m ConfigInspectResponse,
    -- | List configs
    configList ::
        -- @filters@
        -- A JSON encoded value of the filters (a `map[string][]string`) to
        -- process on the configs list.
        -- 
        -- Available filters:
        -- 
        -- - `id=<config id>`
        -- - `label=<key> or label=<key>=value`
        -- - `name=<config name>`
        -- - `names=<config name>`
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        m ConfigListResponse,
    -- | Update a Config
    configUpdate ::
        -- @id@
        -- The ID or name of the config
        Data.Text.Text ->
        -- @version@
        -- The version number of the config object being updated. This is
        -- required to avoid conflicting writes.
        GHC.Int.Int64 ->
        -- The spec of the config to update. Currently, only the Labels field
        can be updated. All other fields must remain unchanged from the
        [ConfigInspect endpoint](#operation/ConfigInspect) response values.

        ConfigSpec ->
        m ConfigUpdateResponse,
    -- | Get an archive of a filesystem resource in a container
    containerArchive ::
        -- @id@
        -- ID or name of the container
        Data.Text.Text ->
        -- @path@
        -- Resource in the container’s filesystem to archive.
        Data.Text.Text ->
        m ContainerArchiveResponse,
    -- | Get information about files in a container
    containerArchiveInfo ::
        -- @id@
        -- ID or name of the container
        Data.Text.Text ->
        -- @path@
        -- Resource in the container’s filesystem to archive.
        Data.Text.Text ->
        m ContainerArchiveInfoResponse,
    -- | Attach to a container
    containerAttach ::
        -- @id@
        -- ID or name of the container
        Data.Text.Text ->
        -- @detachKeys@
        -- Override the key sequence for detaching a container.Format is a single
        -- character `[a-Z]` or `ctrl-<value>` where `<value>` is one of: `a-z`,
        -- `@`, `^`, `[`, `,` or `_`.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @logs@
        -- Replay previous logs from the container.
        -- 
        -- This is useful for attaching to a container that has started and you
        -- want to output everything since the container started.
        -- 
        -- If `stream` is also enabled, once all the previous output has been
        -- returned, it will seamlessly transition into streaming current
        -- output.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @stream@
        -- Stream attached streams from the time the request was made onwards.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @stdin@
        -- Attach to `stdin`
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @stdout@
        -- Attach to `stdout`
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @stderr@
        -- Attach to `stderr`
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        m ContainerAttachResponse,
    -- | Attach to a container via a websocket
    containerAttachWebsocket ::
        -- @id@
        -- ID or name of the container
        Data.Text.Text ->
        -- @detachKeys@
        -- Override the key sequence for detaching a container.Format is a single
        -- character `[a-Z]` or `ctrl-<value>` where `<value>` is one of: `a-z`,
        -- `@`, `^`, `[`, `,`, or `_`.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @logs@
        -- Return logs
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @stream@
        -- Return stream
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @stdin@
        -- Attach to `stdin`
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @stdout@
        -- Attach to `stdout`
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @stderr@
        -- Attach to `stderr`
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        m ContainerAttachWebsocketResponse,
    -- | Get changes on a container’s filesystem
    containerChanges ::
        -- @id@
        -- ID or name of the container
        Data.Text.Text ->
        m ContainerChangesResponse,
    -- | Create a container
    containerCreate ::
        -- @name@
        -- Assign the specified name to the container. Must match
        -- `/?[a-zA-Z0-9][a-zA-Z0-9_.-]+`.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @platform@
        -- Platform in the format `os[/arch[/variant]]` used for image lookup.
        -- 
        -- When specified, the daemon checks if the requested image is present
        -- in the local image cache with the given OS and Architecture, and
        -- otherwise returns a `404` status.
        -- 
        -- If the option is not set, the host's native OS and Architecture are
        -- used to look up the image in the image cache. However, if no platform
        -- is passed and the given image does exist in the local image cache,
        -- but its OS or architecture does not match, the container is created
        -- with the available image, and a warning is added to the `Warnings`
        -- field in the response, for example;
        -- 
        --     WARNING: The requested image's platform (linux/arm64/v8) does not
        --              match the detected host platform (linux/amd64) and no
        --              specific platform was requested
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- Container to create
        ContainerCreateRequestBody ->
        m ContainerCreateResponse,
    -- | Remove a container
    containerDelete ::
        -- @id@
        -- ID or name of the container
        Data.Text.Text ->
        -- @v@
        -- Remove anonymous volumes associated with the container.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @force@
        -- If the container is running, kill it before removing it.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @link@
        -- Remove the specified link associated with the container.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        m ContainerDeleteResponse,
    -- | Create an exec instance
    containerExec ::
        -- @id@
        -- ID or name of container
        Data.Text.Text ->
        -- Exec configuration
        ContainerExecRequestBody ->
        m ContainerExecResponse,
    -- | Export a container
    containerExport ::
        -- @id@
        -- ID or name of the container
        Data.Text.Text ->
        m ContainerExportResponse,
    -- | Inspect a container
    containerInspect ::
        -- @id@
        -- ID or name of the container
        Data.Text.Text ->
        -- @size@
        -- Return the size of container as fields `SizeRw` and `SizeRootFs`
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        m ContainerInspectResponse,
    -- | Kill a container
    containerKill ::
        -- @id@
        -- ID or name of the container
        Data.Text.Text ->
        -- @signal@
        -- Signal to send to the container as an integer or string (e.g. `SIGINT`).
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        m ContainerKillResponse,
    -- | List containers
    containerList ::
        -- @all@
        -- Return all containers. By default, only running containers are shown.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @limit@
        -- Return this number of most recently created containers, including
        -- non-running ones.
        (Data.Maybe.Maybe (GHC.Int.Int)) ->
        -- @size@
        -- Return the size of container as fields `SizeRw` and `SizeRootFs`.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @filters@
        -- Filters to process on the container list, encoded as JSON (a
        -- `map[string][]string`). For example, `{"status": ["paused"]}` will
        -- only return paused containers.
        -- 
        -- Available filters:
        -- 
        -- - `ancestor`=(`<image-name>[:<tag>]`, `<image id>`, or `<image@digest>`)
        -- - `before`=(`<container id>` or `<container name>`)
        -- - `expose`=(`<port>[/<proto>]`|`<startport-endport>/[<proto>]`)
        -- - `exited=<int>` containers with exit code of `<int>`
        -- - `health`=(`starting`|`healthy`|`unhealthy`|`none`)
        -- - `id=<ID>` a container's ID
        -- - `isolation=`(`default`|`process`|`hyperv`) (Windows daemon only)
        -- - `is-task=`(`true`|`false`)
        -- - `label=key` or `label="key=value"` of a container label
        -- - `name=<name>` a container's name
        -- - `network`=(`<network id>` or `<network name>`)
        -- - `publish`=(`<port>[/<proto>]`|`<startport-endport>/[<proto>]`)
        -- - `since`=(`<container id>` or `<container name>`)
        -- - `status=`(`created`|`restarting`|`running`|`removing`|`paused`|`exited`|`dead`)
        -- - `volume`=(`<volume name>` or `<mount point destination>`)
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        m ContainerListResponse,
    -- | Get container logs
    containerLogs ::
        -- @id@
        -- ID or name of the container
        Data.Text.Text ->
        -- @follow@
        -- Keep connection after returning logs.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @stdout@
        -- Return logs from `stdout`
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @stderr@
        -- Return logs from `stderr`
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @since@
        -- Only return logs since this time, as a UNIX timestamp
        (Data.Maybe.Maybe (GHC.Int.Int)) ->
        -- @until@
        -- Only return logs before this time, as a UNIX timestamp
        (Data.Maybe.Maybe (GHC.Int.Int)) ->
        -- @timestamps@
        -- Add timestamps to every log line
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @tail@
        -- Only return this number of log lines from the end of the logs.
        -- Specify as an integer or `all` to output all log lines.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        m ContainerLogsResponse,
    -- | Pause a container
    containerPause ::
        -- @id@
        -- ID or name of the container
        Data.Text.Text ->
        m ContainerPauseResponse,
    -- | Delete stopped containers
    containerPrune ::
        -- @filters@
        -- Filters to process on the prune list, encoded as JSON (a `map[string][]string`).
        -- 
        -- Available filters:
        -- - `until=<timestamp>` Prune containers created before this timestamp. The `<timestamp>` can be Unix timestamps, date formatted timestamps, or Go duration strings (e.g. `10m`, `1h30m`) computed relative to the daemon machine’s time.
        -- - `label` (`label=<key>`, `label=<key>=<value>`, `label!=<key>`, or `label!=<key>=<value>`) Prune containers with (or without, in case `label!=...` is used) the specified labels.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        m ContainerPruneResponse,
    -- | Rename a container
    containerRename ::
        -- @id@
        -- ID or name of the container
        Data.Text.Text ->
        -- @name@
        -- New name for the container
        Data.Text.Text ->
        m ContainerRenameResponse,
    -- | Resize a container TTY
    containerResize ::
        -- @id@
        -- ID or name of the container
        Data.Text.Text ->
        -- @h@
        -- Height of the TTY session in characters
        GHC.Int.Int ->
        -- @w@
        -- Width of the TTY session in characters
        GHC.Int.Int ->
        m ContainerResizeResponse,
    -- | Restart a container
    containerRestart ::
        -- @id@
        -- ID or name of the container
        Data.Text.Text ->
        -- @signal@
        -- Signal to send to the container as an integer or string (e.g. `SIGINT`).
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @t@
        -- Number of seconds to wait before killing the container
        (Data.Maybe.Maybe (GHC.Int.Int)) ->
        m ContainerRestartResponse,
    -- | Start a container
    containerStart ::
        -- @id@
        -- ID or name of the container
        Data.Text.Text ->
        -- @detachKeys@
        -- Override the key sequence for detaching a container. Format is a
        -- single character `[a-Z]` or `ctrl-<value>` where `<value>` is one
        -- of: `a-z`, `@`, `^`, `[`, `,` or `_`.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        m ContainerStartResponse,
    -- | Get container stats based on resource usage
    containerStats ::
        -- @id@
        -- ID or name of the container
        Data.Text.Text ->
        -- @stream@
        -- Stream the output. If false, the stats will be output once and then
        -- it will disconnect.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @one-shot@
        -- Only get a single stat instead of waiting for 2 cycles. Must be used
        -- with `stream=false`.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        m ContainerStatsResponse,
    -- | Stop a container
    containerStop ::
        -- @id@
        -- ID or name of the container
        Data.Text.Text ->
        -- @signal@
        -- Signal to send to the container as an integer or string (e.g. `SIGINT`).
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @t@
        -- Number of seconds to wait before killing the container
        (Data.Maybe.Maybe (GHC.Int.Int)) ->
        m ContainerStopResponse,
    -- | List processes running inside a container
    containerTop ::
        -- @id@
        -- ID or name of the container
        Data.Text.Text ->
        -- @ps_args@
        -- The arguments to pass to `ps`. For example, `aux`
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        m ContainerTopResponse,
    -- | Unpause a container
    containerUnpause ::
        -- @id@
        -- ID or name of the container
        Data.Text.Text ->
        m ContainerUnpauseResponse,
    -- | Update a container
    containerUpdate ::
        -- @id@
        -- ID or name of the container
        Data.Text.Text ->
        ContainerUpdateRequestBody ->
        m ContainerUpdateResponse,
    -- | Wait for a container
    containerWait ::
        -- @id@
        -- ID or name of the container
        Data.Text.Text ->
        -- @condition@
        -- Wait until a container state reaches the given condition.
        -- 
        -- Defaults to `not-running` if omitted or empty.
        (Data.Maybe.Maybe (ContainerWaitConditionParam)) ->
        m ContainerWaitResponse,
    -- | Get image information from the registry
    distributionInspect ::
        -- @name@
        -- Image name or id
        Data.Text.Text ->
        m DistributionInspectResponse,
    -- | Inspect an exec instance
    execInspect ::
        -- @id@
        -- Exec instance ID
        Data.Text.Text ->
        m ExecInspectResponse,
    -- | Resize an exec instance
    execResize ::
        -- @id@
        -- Exec instance ID
        Data.Text.Text ->
        -- @h@
        -- Height of the TTY session in characters
        GHC.Int.Int ->
        -- @w@
        -- Width of the TTY session in characters
        GHC.Int.Int ->
        m ExecResizeResponse,
    -- | Start an exec instance
    execStart ::
        -- @id@
        -- Exec instance ID
        Data.Text.Text ->
        ExecStartRequestBody ->
        m ExecStartResponse,
    -- | Get plugin privileges
    getPluginPrivileges ::
        -- @remote@
        -- The name of the plugin. The `:latest` tag is optional, and is the
        -- default if omitted.
        Data.Text.Text ->
        m GetPluginPrivilegesResponse,
    -- | Build an image
    imageBuild ::
        -- @dockerfile@
        -- Path within the build context to the `Dockerfile`. This is ignored if `remote` is specified and points to an external `Dockerfile`.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @t@
        -- A name and optional tag to apply to the image in the `name:tag` format. If you omit the tag the default `latest` value is assumed. You can provide several `t` parameters.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @extrahosts@
        -- Extra hosts to add to /etc/hosts
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @remote@
        -- A Git repository URI or HTTP/HTTPS context URI. If the URI points to a single text file, the file’s contents are placed into a file called `Dockerfile` and the image is built from that file. If the URI points to a tarball, the file is downloaded by the daemon and the contents therein used as the context for the build. If the URI points to a tarball and the `dockerfile` parameter is also specified, there must be a file with the corresponding path inside the tarball.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @q@
        -- Suppress verbose build output.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @nocache@
        -- Do not use the cache when building the image.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @cachefrom@
        -- JSON array of images used for build cache resolution.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @pull@
        -- Attempt to pull the image even if an older image exists locally.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @rm@
        -- Remove intermediate containers after a successful build.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @forcerm@
        -- Always remove intermediate containers, even upon failure.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @memory@
        -- Set memory limit for build.
        (Data.Maybe.Maybe (GHC.Int.Int)) ->
        -- @memswap@
        -- Total memory (memory + swap). Set as `-1` to disable swap.
        (Data.Maybe.Maybe (GHC.Int.Int)) ->
        -- @cpushares@
        -- CPU shares (relative weight).
        (Data.Maybe.Maybe (GHC.Int.Int)) ->
        -- @cpusetcpus@
        -- CPUs in which to allow execution (e.g., `0-3`, `0,1`).
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @cpuperiod@
        -- The length of a CPU period in microseconds.
        (Data.Maybe.Maybe (GHC.Int.Int)) ->
        -- @cpuquota@
        -- Microseconds of CPU time that the container can get in a CPU period.
        (Data.Maybe.Maybe (GHC.Int.Int)) ->
        -- @buildargs@
        -- JSON map of string pairs for build-time variables. Users pass these values at build-time. Docker uses the buildargs as the environment context for commands run via the `Dockerfile` RUN instruction, or for variable expansion in other `Dockerfile` instructions. This is not meant for passing secret values.
        -- 
        -- For example, the build arg `FOO=bar` would become `{"FOO":"bar"}` in JSON. This would result in the query parameter `buildargs={"FOO":"bar"}`. Note that `{"FOO":"bar"}` should be URI component encoded.
        -- 
        -- [Read more about the buildargs instruction.](https://docs.docker.com/engine/reference/builder/#arg)
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @shmsize@
        -- Size of `/dev/shm` in bytes. The size must be greater than 0. If omitted the system uses 64MB.
        (Data.Maybe.Maybe (GHC.Int.Int)) ->
        -- @squash@
        -- Squash the resulting images layers into a single layer. *(Experimental release only.)*
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @labels@
        -- Arbitrary key/value labels to set on the image, as a JSON map of string pairs.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @networkmode@
        -- Sets the networking mode for the run commands during build. Supported
        -- standard values are: `bridge`, `host`, `none`, and `container:<name|id>`.
        -- Any other value is taken as a custom network's name or ID to which this
        -- container should connect to.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @platform@
        -- Platform in the format os[/arch[/variant]]
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @target@
        -- Target build stage
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @outputs@
        -- BuildKit output configuration
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @version@
        -- Version of the builder backend to use.
        -- 
        -- - `1` is the first generation classic (deprecated) builder in the Docker daemon (default)
        -- - `2` is [BuildKit](https://github.com/moby/buildkit)
        (Data.Maybe.Maybe (ImageBuildVersionParam)) ->
        -- @Content-type@
        (Data.Maybe.Maybe (ImageBuildContentTypeParam)) ->
        -- @X-Registry-Config@
        -- This is a base64-encoded JSON object with auth configurations for multiple registries that a build may refer to.
        -- 
        -- The key is a registry URL, and the value is an auth configuration object, [as described in the authentication section](#section/Authentication). For example:
        -- 
        -- ```
        -- {
        --   "docker.example.com": {
        --     "username": "janedoe",
        --     "password": "hunter2"
        --   },
        --   "https://index.docker.io/v1/": {
        --     "username": "mobydock",
        --     "password": "conta1n3rize14"
        --   }
        -- }
        -- ```
        -- 
        -- Only the registry domain name (and port if not the default 443) are required. However, for legacy reasons, the Docker Hub registry must be specified with both a `https://` prefix and a `/v1/` suffix even though Docker will prefer to use the v2 registry API.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- A tar archive compressed with one of the following algorithms: identity (no compression), gzip, bzip2, xz.
        Data.Text.Text ->
        m ImageBuildResponse,
    -- | Create a new image from a container
    imageCommit ::
        -- @container@
        -- The ID or name of the container to commit
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @repo@
        -- Repository name for the created image
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @tag@
        -- Tag name for the create image
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @comment@
        -- Commit message
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @author@
        -- Author of the image (e.g., `John Hannibal Smith <hannibal@a-team.com>`)
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @pause@
        -- Whether to pause the container before committing
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @changes@
        -- `Dockerfile` instructions to apply while committing
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- The container configuration
        ContainerConfig ->
        m ImageCommitResponse,
    -- | Create an image
    imageCreate ::
        -- @fromImage@
        -- Name of the image to pull. The name may include a tag or digest. This parameter may only be used when pulling an image. The pull is cancelled if the HTTP connection is closed.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @fromSrc@
        -- Source to import. The value may be a URL from which the image can be retrieved or `-` to read the image from the request body. This parameter may only be used when importing an image.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @repo@
        -- Repository name given to an image when it is imported. The repo may include a tag. This parameter may only be used when importing an image.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @tag@
        -- Tag or digest. If empty when pulling an image, this causes all tags for the given image to be pulled.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @message@
        -- Set commit message for imported image.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @changes@
        -- Apply `Dockerfile` instructions to the image that is created,
        -- for example: `changes=ENV DEBUG=true`.
        -- Note that `ENV DEBUG=true` should be URI component encoded.
        -- 
        -- Supported `Dockerfile` instructions:
        -- `CMD`|`ENTRYPOINT`|`ENV`|`EXPOSE`|`ONBUILD`|`USER`|`VOLUME`|`WORKDIR`
        (Data.Maybe.Maybe (Data.List.NonEmpty.NonEmpty ( Data.Text.Text ))) ->
        -- @platform@
        -- Platform in the format os[/arch[/variant]].
        -- 
        -- When used in combination with the `fromImage` option, the daemon checks
        -- if the given image is present in the local image cache with the given
        -- OS and Architecture, and otherwise attempts to pull the image. If the
        -- option is not set, the host's native OS and Architecture are used.
        -- If the given image does not exist in the local image cache, the daemon
        -- attempts to pull the image with the host's native OS and Architecture.
        -- If the given image does exists in the local image cache, but its OS or
        -- architecture does not match, a warning is produced.
        -- 
        -- When used with the `fromSrc` option to import an image from an archive,
        -- this option sets the platform information for the imported image. If
        -- the option is not set, the host's native OS and Architecture are used
        -- for the imported image.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @X-Registry-Auth@
        -- A base64url-encoded auth configuration.
        -- 
        -- Refer to the [authentication section](#section/Authentication) for
        -- details.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- Image content if the value `-` has been specified in fromSrc query parameter
        Data.Text.Text ->
        m ImageCreateResponse,
    -- | Remove an image
    imageDelete ::
        -- @name@
        -- Image name or ID
        Data.Text.Text ->
        -- @force@
        -- Remove the image even if it is being used by stopped containers or has other tags
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @noprune@
        -- Do not delete untagged parent images
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        m ImageDeleteResponse,
    -- | Export an image
    imageGet ::
        -- @name@
        -- Image name or ID
        Data.Text.Text ->
        m ImageGetResponse,
    -- | Export several images
    imageGetAll ::
        -- @names@
        -- Image names to filter by
        (Data.Maybe.Maybe (Data.List.NonEmpty.NonEmpty ( Data.Text.Text ))) ->
        m ImageGetAllResponse,
    -- | Get the history of an image
    imageHistory ::
        -- @name@
        -- Image name or ID
        Data.Text.Text ->
        m ImageHistoryResponse,
    -- | Inspect an image
    imageInspect ::
        -- @name@
        -- Image name or id
        Data.Text.Text ->
        m ImageInspectResponse,
    -- | List Images
    imageList ::
        -- @all@
        -- Show all images. Only images from a final layer (no children) are shown by default.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @filters@
        -- A JSON encoded value of the filters (a `map[string][]string`) to
        -- process on the images list.
        -- 
        -- Available filters:
        -- 
        -- - `before`=(`<image-name>[:<tag>]`,  `<image id>` or `<image@digest>`)
        -- - `dangling=true`
        -- - `label=key` or `label="key=value"` of an image label
        -- - `reference`=(`<image-name>[:<tag>]`)
        -- - `since`=(`<image-name>[:<tag>]`,  `<image id>` or `<image@digest>`)
        -- - `until=<timestamp>`
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @shared-size@
        -- Compute and show shared size as a `SharedSize` field on each image.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @digests@
        -- Show digest information as a `RepoDigests` field on each image.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @manifests@
        -- Include `Manifests` in the image summary.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        m ImageListResponse,
    -- | Import images
    imageLoad ::
        -- @quiet@
        -- Suppress progress details during load.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- Tar archive containing images
        Data.Text.Text ->
        m ImageLoadResponse,
    -- | Delete unused images
    imagePrune ::
        -- @filters@
        -- Filters to process on the prune list, encoded as JSON (a `map[string][]string`). Available filters:
        -- 
        -- - `dangling=<boolean>` When set to `true` (or `1`), prune only
        --    unused *and* untagged images. When set to `false`
        --    (or `0`), all unused images are pruned.
        -- - `until=<string>` Prune images created before this timestamp. The `<timestamp>` can be Unix timestamps, date formatted timestamps, or Go duration strings (e.g. `10m`, `1h30m`) computed relative to the daemon machine’s time.
        -- - `label` (`label=<key>`, `label=<key>=<value>`, `label!=<key>`, or `label!=<key>=<value>`) Prune images with (or without, in case `label!=...` is used) the specified labels.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        m ImagePruneResponse,
    -- | Push an image
    imagePush ::
        -- @name@
        -- Name of the image to push. For example, `registry.example.com/myimage`.
        -- The image must be present in the local image store with the same name.
        -- 
        -- The name should be provided without tag; if a tag is provided, it
        -- is ignored. For example, `registry.example.com/myimage:latest` is
        -- considered equivalent to `registry.example.com/myimage`.
        -- 
        -- Use the `tag` parameter to specify the tag to push.
        Data.Text.Text ->
        -- @tag@
        -- Tag of the image to push. For example, `latest`. If no tag is provided,
        -- all tags of the given image that are present in the local image store
        -- are pushed.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @platform@
        -- JSON-encoded OCI platform to select the platform-variant to push.
        -- If not provided, all available variants will attempt to be pushed.
        -- 
        -- If the daemon provides a multi-platform image store, this selects
        -- the platform-variant to push to the registry. If the image is
        -- a single-platform image, or if the multi-platform image does not
        -- provide a variant matching the given platform, an error is returned.
        -- 
        -- Example: `{"os": "linux", "architecture": "arm", "variant": "v5"}`
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @X-Registry-Auth@
        -- A base64url-encoded auth configuration.
        -- 
        -- Refer to the [authentication section](#section/Authentication) for
        -- details.
        Data.Text.Text ->
        m ImagePushResponse,
    -- | Search images
    imageSearch ::
        -- @term@
        -- Term to search
        Data.Text.Text ->
        -- @limit@
        -- Maximum number of results to return
        (Data.Maybe.Maybe (GHC.Int.Int)) ->
        -- @filters@
        -- A JSON encoded value of the filters (a `map[string][]string`) to process on the images list. Available filters:
        -- 
        -- - `is-official=(true|false)`
        -- - `stars=<number>` Matches images that has at least 'number' stars.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        m ImageSearchResponse,
    -- | Tag an image
    imageTag ::
        -- @name@
        -- Image name or ID to tag.
        Data.Text.Text ->
        -- @repo@
        -- The repository to tag in. For example, `someuser/someimage`.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @tag@
        -- The name of the new tag.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        m ImageTagResponse,
    -- | Connect a container to a network
    networkConnect ::
        -- @id@
        -- Network ID or name
        Data.Text.Text ->
        NetworkConnectRequestBody ->
        m NetworkConnectResponse,
    -- | Create a network
    networkCreate ::
        -- Network configuration
        NetworkCreateRequestBody ->
        m NetworkCreateResponse,
    -- | Remove a network
    networkDelete ::
        -- @id@
        -- Network ID or name
        Data.Text.Text ->
        m NetworkDeleteResponse,
    -- | Disconnect a container from a network
    networkDisconnect ::
        -- @id@
        -- Network ID or name
        Data.Text.Text ->
        NetworkDisconnectRequestBody ->
        m NetworkDisconnectResponse,
    -- | Inspect a network
    networkInspect ::
        -- @id@
        -- Network ID or name
        Data.Text.Text ->
        -- @verbose@
        -- Detailed inspect output for troubleshooting
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @scope@
        -- Filter the network by scope (swarm, global, or local)
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        m NetworkInspectResponse,
    -- | List networks
    networkList ::
        -- @filters@
        -- JSON encoded value of the filters (a `map[string][]string`) to process
        -- on the networks list.
        -- 
        -- Available filters:
        -- 
        -- - `dangling=<boolean>` When set to `true` (or `1`), returns all
        --    networks that are not in use by a container. When set to `false`
        --    (or `0`), only networks that are in use by one or more
        --    containers are returned.
        -- - `driver=<driver-name>` Matches a network's driver.
        -- - `id=<network-id>` Matches all or part of a network ID.
        -- - `label=<key>` or `label=<key>=<value>` of a network label.
        -- - `name=<network-name>` Matches all or part of a network name.
        -- - `scope=["swarm"|"global"|"local"]` Filters networks by scope (`swarm`, `global`, or `local`).
        -- - `type=["custom"|"builtin"]` Filters networks by type. The `custom` keyword returns all user-defined networks.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        m NetworkListResponse,
    -- | Delete unused networks
    networkPrune ::
        -- @filters@
        -- Filters to process on the prune list, encoded as JSON (a `map[string][]string`).
        -- 
        -- Available filters:
        -- - `until=<timestamp>` Prune networks created before this timestamp. The `<timestamp>` can be Unix timestamps, date formatted timestamps, or Go duration strings (e.g. `10m`, `1h30m`) computed relative to the daemon machine’s time.
        -- - `label` (`label=<key>`, `label=<key>=<value>`, `label!=<key>`, or `label!=<key>=<value>`) Prune networks with (or without, in case `label!=...` is used) the specified labels.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        m NetworkPruneResponse,
    -- | Delete a node
    nodeDelete ::
        -- @id@
        -- The ID or name of the node
        Data.Text.Text ->
        -- @force@
        -- Force remove a node from the swarm
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        m NodeDeleteResponse,
    -- | Inspect a node
    nodeInspect ::
        -- @id@
        -- The ID or name of the node
        Data.Text.Text ->
        m NodeInspectResponse,
    -- | List nodes
    nodeList ::
        -- @filters@
        -- Filters to process on the nodes list, encoded as JSON (a `map[string][]string`).
        -- 
        -- Available filters:
        -- - `id=<node id>`
        -- - `label=<engine label>`
        -- - `membership=`(`accepted`|`pending`)`
        -- - `name=<node name>`
        -- - `node.label=<node label>`
        -- - `role=`(`manager`|`worker`)`
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        m NodeListResponse,
    -- | Update a node
    nodeUpdate ::
        -- @id@
        -- The ID of the node
        Data.Text.Text ->
        -- @version@
        -- The version number of the node object being updated. This is required
        -- to avoid conflicting writes.
        GHC.Int.Int64 ->
        NodeSpec ->
        m NodeUpdateResponse,
    -- | Create a plugin
    pluginCreate ::
        -- @name@
        -- The name of the plugin. The `:latest` tag is optional, and is the
        -- default if omitted.
        Data.Text.Text ->
        -- Path to tar containing plugin rootfs and manifest
        Data.Text.Text ->
        m PluginCreateResponse,
    -- | Remove a plugin
    pluginDelete ::
        -- @name@
        -- The name of the plugin. The `:latest` tag is optional, and is the
        -- default if omitted.
        Data.Text.Text ->
        -- @force@
        -- Disable the plugin before removing. This may result in issues if the
        -- plugin is in use by a container.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        m PluginDeleteResponse,
    -- | Disable a plugin
    pluginDisable ::
        -- @name@
        -- The name of the plugin. The `:latest` tag is optional, and is the
        -- default if omitted.
        Data.Text.Text ->
        -- @force@
        -- Force disable a plugin even if still in use.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        m PluginDisableResponse,
    -- | Enable a plugin
    pluginEnable ::
        -- @name@
        -- The name of the plugin. The `:latest` tag is optional, and is the
        -- default if omitted.
        Data.Text.Text ->
        -- @timeout@
        -- Set the HTTP client timeout (in seconds)
        (Data.Maybe.Maybe (GHC.Int.Int)) ->
        m PluginEnableResponse,
    -- | Inspect a plugin
    pluginInspect ::
        -- @name@
        -- The name of the plugin. The `:latest` tag is optional, and is the
        -- default if omitted.
        Data.Text.Text ->
        m PluginInspectResponse,
    -- | List plugins
    pluginList ::
        -- @filters@
        -- A JSON encoded value of the filters (a `map[string][]string`) to
        -- process on the plugin list.
        -- 
        -- Available filters:
        -- 
        -- - `capability=<capability name>`
        -- - `enable=<true>|<false>`
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        m PluginListResponse,
    -- | Install a plugin
    pluginPull ::
        -- @remote@
        -- Remote reference for plugin to install.
        -- 
        -- The `:latest` tag is optional, and is used as the default if omitted.
        Data.Text.Text ->
        -- @name@
        -- Local name for the pulled plugin.
        -- 
        -- The `:latest` tag is optional, and is used as the default if omitted.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @X-Registry-Auth@
        -- A base64url-encoded auth configuration to use when pulling a plugin
        -- from a registry.
        -- 
        -- Refer to the [authentication section](#section/Authentication) for
        -- details.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        [ PluginPrivilege ] ->
        m PluginPullResponse,
    -- | Push a plugin
    pluginPush ::
        -- @name@
        -- The name of the plugin. The `:latest` tag is optional, and is the
        -- default if omitted.
        Data.Text.Text ->
        m PluginPushResponse,
    -- | Configure a plugin
    pluginSet ::
        -- @name@
        -- The name of the plugin. The `:latest` tag is optional, and is the
        -- default if omitted.
        Data.Text.Text ->
        [ Data.Text.Text ] ->
        m PluginSetResponse,
    -- | Upgrade a plugin
    pluginUpgrade ::
        -- @name@
        -- The name of the plugin. The `:latest` tag is optional, and is the
        -- default if omitted.
        Data.Text.Text ->
        -- @remote@
        -- Remote reference to upgrade to.
        -- 
        -- The `:latest` tag is optional, and is used as the default if omitted.
        Data.Text.Text ->
        -- @X-Registry-Auth@
        -- A base64url-encoded auth configuration to use when pulling a plugin
        -- from a registry.
        -- 
        -- Refer to the [authentication section](#section/Authentication) for
        -- details.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        [ PluginPrivilege ] ->
        m PluginUpgradeResponse,
    -- | Extract an archive of files or folders to a directory in a container
    putContainerArchive ::
        -- @id@
        -- ID or name of the container
        Data.Text.Text ->
        -- @path@
        -- Path to a directory in the container to extract the archive’s contents into. 
        Data.Text.Text ->
        -- @noOverwriteDirNonDir@
        -- If `1`, `true`, or `True` then it will be an error if unpacking the
        -- given content would cause an existing directory to be replaced with
        -- a non-directory and vice versa.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @copyUIDGID@
        -- If `1`, `true`, then it will copy UID/GID maps to the dest file or
        -- dir
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- The input stream must be a tar archive compressed with one of the
        following algorithms: `identity` (no compression), `gzip`, `bzip2`,
        or `xz`.

        Data.Text.Text ->
        m PutContainerArchiveResponse,
    -- | Create a secret
    secretCreate ::
        SecretCreateRequestBody ->
        m SecretCreateResponse,
    -- | Delete a secret
    secretDelete ::
        -- @id@
        -- ID of the secret
        Data.Text.Text ->
        m SecretDeleteResponse,
    -- | Inspect a secret
    secretInspect ::
        -- @id@
        -- ID of the secret
        Data.Text.Text ->
        m SecretInspectResponse,
    -- | List secrets
    secretList ::
        -- @filters@
        -- A JSON encoded value of the filters (a `map[string][]string`) to
        -- process on the secrets list.
        -- 
        -- Available filters:
        -- 
        -- - `id=<secret id>`
        -- - `label=<key> or label=<key>=value`
        -- - `name=<secret name>`
        -- - `names=<secret name>`
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        m SecretListResponse,
    -- | Update a Secret
    secretUpdate ::
        -- @id@
        -- The ID or name of the secret
        Data.Text.Text ->
        -- @version@
        -- The version number of the secret object being updated. This is
        -- required to avoid conflicting writes.
        GHC.Int.Int64 ->
        -- The spec of the secret to update. Currently, only the Labels field
        can be updated. All other fields must remain unchanged from the
        [SecretInspect endpoint](#operation/SecretInspect) response values.

        SecretSpec ->
        m SecretUpdateResponse,
    -- | Create a service
    serviceCreate ::
        -- @X-Registry-Auth@
        -- A base64url-encoded auth configuration for pulling from private
        -- registries.
        -- 
        -- Refer to the [authentication section](#section/Authentication) for
        -- details.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        ServiceCreateRequestBody ->
        m ServiceCreateResponse,
    -- | Delete a service
    serviceDelete ::
        -- @id@
        -- ID or name of service.
        Data.Text.Text ->
        m ServiceDeleteResponse,
    -- | Inspect a service
    serviceInspect ::
        -- @id@
        -- ID or name of service.
        Data.Text.Text ->
        -- @insertDefaults@
        -- Fill empty fields with default values.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        m ServiceInspectResponse,
    -- | List services
    serviceList ::
        -- @filters@
        -- A JSON encoded value of the filters (a `map[string][]string`) to
        -- process on the services list.
        -- 
        -- Available filters:
        -- 
        -- - `id=<service id>`
        -- - `label=<service label>`
        -- - `mode=["replicated"|"global"]`
        -- - `name=<service name>`
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @status@
        -- Include service status, with count of running and desired tasks.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        m ServiceListResponse,
    -- | Get service logs
    serviceLogs ::
        -- @id@
        -- ID or name of the service
        Data.Text.Text ->
        -- @details@
        -- Show service context and extra details provided to logs.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @follow@
        -- Keep connection after returning logs.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @stdout@
        -- Return logs from `stdout`
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @stderr@
        -- Return logs from `stderr`
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @since@
        -- Only return logs since this time, as a UNIX timestamp
        (Data.Maybe.Maybe (GHC.Int.Int)) ->
        -- @timestamps@
        -- Add timestamps to every log line
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @tail@
        -- Only return this number of log lines from the end of the logs.
        -- Specify as an integer or `all` to output all log lines.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        m ServiceLogsResponse,
    -- | Update a service
    serviceUpdate ::
        -- @id@
        -- ID or name of service.
        Data.Text.Text ->
        -- @version@
        -- The version number of the service object being updated. This is
        -- required to avoid conflicting writes.
        -- This version number should be the value as currently set on the
        -- service *before* the update. You can find the current version by
        -- calling `GET /services/{id}`
        GHC.Int.Int ->
        -- @registryAuthFrom@
        -- If the `X-Registry-Auth` header is not specified, this parameter
        -- indicates where to find registry authorization credentials.
        (Data.Maybe.Maybe (ServiceUpdateRegistryAuthFromParam)) ->
        -- @rollback@
        -- Set to this parameter to `previous` to cause a server-side rollback
        -- to the previous service spec. The supplied spec will be ignored in
        -- this case.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @X-Registry-Auth@
        -- A base64url-encoded auth configuration for pulling from private
        -- registries.
        -- 
        -- Refer to the [authentication section](#section/Authentication) for
        -- details.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        ServiceUpdateRequestBody ->
        m ServiceUpdateResponse,
    -- | Initialize interactive session
    session ::
        m SessionResponse,
    -- | Initialize a new swarm
    swarmInit ::
        SwarmInitRequestBody ->
        m SwarmInitResponse,
    -- | Inspect swarm
    swarmInspect ::
        m SwarmInspectResponse,
    -- | Join an existing swarm
    swarmJoin ::
        SwarmJoinRequestBody ->
        m SwarmJoinResponse,
    -- | Leave a swarm
    swarmLeave ::
        -- @force@
        -- Force leave swarm, even if this is the last manager or that it will
        -- break the cluster.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        m SwarmLeaveResponse,
    -- | Unlock a locked manager
    swarmUnlock ::
        SwarmUnlockRequestBody ->
        m SwarmUnlockResponse,
    -- | Get the unlock key
    swarmUnlockkey ::
        m SwarmUnlockkeyResponse,
    -- | Update a swarm
    swarmUpdate ::
        -- @version@
        -- The version number of the swarm object being updated. This is
        -- required to avoid conflicting writes.
        GHC.Int.Int64 ->
        -- @rotateWorkerToken@
        -- Rotate the worker join token.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @rotateManagerToken@
        -- Rotate the manager join token.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @rotateManagerUnlockKey@
        -- Rotate the manager unlock key.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        SwarmSpec ->
        m SwarmUpdateResponse,
    -- | Check auth configuration
    systemAuth ::
        -- Authentication to check
        AuthConfig ->
        m SystemAuthResponse,
    -- | Get data usage information
    systemDataUsage ::
        -- @type@
        -- Object types, for which to compute and return data.
        (Data.Maybe.Maybe (Data.List.NonEmpty.NonEmpty ( SystemDataUsageTypeParam ))) ->
        m SystemDataUsageResponse,
    -- | Monitor events
    systemEvents ::
        -- @since@
        -- Show events created since this timestamp then stream new events.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @until@
        -- Show events created until this timestamp then stop streaming.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        -- @filters@
        -- A JSON encoded value of filters (a `map[string][]string`) to process on the event list. Available filters:
        -- 
        -- - `config=<string>` config name or ID
        -- - `container=<string>` container name or ID
        -- - `daemon=<string>` daemon name or ID
        -- - `event=<string>` event type
        -- - `image=<string>` image name or ID
        -- - `label=<string>` image or container label
        -- - `network=<string>` network name or ID
        -- - `node=<string>` node ID
        -- - `plugin`=<string> plugin name or ID
        -- - `scope`=<string> local or swarm
        -- - `secret=<string>` secret name or ID
        -- - `service=<string>` service name or ID
        -- - `type=<string>` object to filter by, one of `container`, `image`, `volume`, `network`, `daemon`, `plugin`, `node`, `service`, `secret` or `config`
        -- - `volume=<string>` volume name
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        m SystemEventsResponse,
    -- | Get system information
    systemInfo ::
        m SystemInfoResponse,
    -- | Ping
    systemPing ::
        m SystemPingResponse,
    -- | Ping
    systemPingHead ::
        m SystemPingHeadResponse,
    -- | Get version
    systemVersion ::
        m SystemVersionResponse,
    -- | Inspect a task
    taskInspect ::
        -- @id@
        -- ID of the task
        Data.Text.Text ->
        m TaskInspectResponse,
    -- | List tasks
    taskList ::
        -- @filters@
        -- A JSON encoded value of the filters (a `map[string][]string`) to
        -- process on the tasks list.
        -- 
        -- Available filters:
        -- 
        -- - `desired-state=(running | shutdown | accepted)`
        -- - `id=<task id>`
        -- - `label=key` or `label="key=value"`
        -- - `name=<task name>`
        -- - `node=<node id or name>`
        -- - `service=<service name>`
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        m TaskListResponse,
    -- | Get task logs
    taskLogs ::
        -- @id@
        -- ID of the task
        Data.Text.Text ->
        -- @details@
        -- Show task context and extra details provided to logs.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @follow@
        -- Keep connection after returning logs.
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @stdout@
        -- Return logs from `stdout`
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @stderr@
        -- Return logs from `stderr`
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @since@
        -- Only return logs since this time, as a UNIX timestamp
        (Data.Maybe.Maybe (GHC.Int.Int)) ->
        -- @timestamps@
        -- Add timestamps to every log line
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        -- @tail@
        -- Only return this number of log lines from the end of the logs.
        -- Specify as an integer or `all` to output all log lines.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        m TaskLogsResponse,
    -- | Create a volume
    volumeCreate ::
        -- Volume configuration
        VolumeCreateOptions ->
        m VolumeCreateResponse,
    -- | Remove a volume
    volumeDelete ::
        -- @name@
        -- Volume name or ID
        Data.Text.Text ->
        -- @force@
        -- Force the removal of the volume
        (Data.Maybe.Maybe (GHC.Types.Bool)) ->
        m VolumeDeleteResponse,
    -- | Inspect a volume
    volumeInspect ::
        -- @name@
        -- Volume name or ID
        Data.Text.Text ->
        m VolumeInspectResponse,
    -- | List volumes
    volumeList ::
        -- @filters@
        -- JSON encoded value of the filters (a `map[string][]string`) to
        -- process on the volumes list. Available filters:
        -- 
        -- - `dangling=<boolean>` When set to `true` (or `1`), returns all
        --    volumes that are not in use by a container. When set to `false`
        --    (or `0`), only volumes that are in use by one or more
        --    containers are returned.
        -- - `driver=<volume-driver-name>` Matches volumes based on their driver.
        -- - `label=<key>` or `label=<key>:<value>` Matches volumes based on
        --    the presence of a `label` alone or a `label` and a value.
        -- - `name=<volume-name>` Matches all or part of a volume name.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        m VolumeListResponse,
    -- | Delete unused volumes
    volumePrune ::
        -- @filters@
        -- Filters to process on the prune list, encoded as JSON (a `map[string][]string`).
        -- 
        -- Available filters:
        -- - `label` (`label=<key>`, `label=<key>=<value>`, `label!=<key>`, or `label!=<key>=<value>`) Prune volumes with (or without, in case `label!=...` is used) the specified labels.
        -- - `all` (`all=true`) - Consider all (local) volumes for pruning and not just anonymous volumes.
        (Data.Maybe.Maybe (Data.Text.Text)) ->
        m VolumePruneResponse,
    -- | "Update a volume. Valid only for Swarm cluster volumes"

    volumeUpdate ::
        -- @name@
        -- The name or ID of the volume
        Data.Text.Text ->
        -- @version@
        -- The version number of the volume being updated. This is required to
        -- avoid conflicting writes. Found in the volume's `ClusterVolume`
        -- field.
        GHC.Int.Int64 ->
        -- The spec of the volume to update. Currently, only Availability may
        change. All other fields must remain unchanged.

        VolumeUpdateRequestBody ->
        m VolumeUpdateResponse
}

application :: (Control.Monad.IO.Class.MonadIO m) => (forall a . Network.Wai.Request -> m a -> IO a) -> Api m -> Network.Wai.Application -> Network.Wai.Application
application run api notFound request respond =
    case Network.Wai.pathInfo request of
        ["_ping"] ->
            case Network.Wai.requestMethod request of
                "HEAD" ->
                    run request (do
                        response <- systemPingHead api
                        Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                    )
                "GET" ->
                    run request (do
                        response <- systemPing api
                        Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                    )
                x ->
                    unsupportedMethod x

        ["auth"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    parseRequestBody [jsonBodyParser] (\body request respond ->
                        run request (do
                            response <- systemAuth api body
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )) request respond
                x ->
                    unsupportedMethod x

        ["build"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    optionalQueryParameter "dockerfile" False (\__dockerfile request respond ->
                        optionalQueryParameter "t" False (\__t request respond ->
                            optionalQueryParameter "extrahosts" False (\__extrahosts request respond ->
                                optionalQueryParameter "remote" False (\__remote request respond ->
                                    optionalQueryParameter "q" False (\__q request respond ->
                                        optionalQueryParameter "nocache" False (\__nocache request respond ->
                                            optionalQueryParameter "cachefrom" False (\__cachefrom request respond ->
                                                optionalQueryParameter "pull" False (\__pull request respond ->
                                                    optionalQueryParameter "rm" False (\__rm request respond ->
                                                        optionalQueryParameter "forcerm" False (\__forcerm request respond ->
                                                            optionalQueryParameter "memory" False (\__memory request respond ->
                                                                optionalQueryParameter "memswap" False (\__memswap request respond ->
                                                                    optionalQueryParameter "cpushares" False (\__cpushares request respond ->
                                                                        optionalQueryParameter "cpusetcpus" False (\__cpusetcpus request respond ->
                                                                            optionalQueryParameter "cpuperiod" False (\__cpuperiod request respond ->
                                                                                optionalQueryParameter "cpuquota" False (\__cpuquota request respond ->
                                                                                    optionalQueryParameter "buildargs" False (\__buildargs request respond ->
                                                                                        optionalQueryParameter "shmsize" False (\__shmsize request respond ->
                                                                                            optionalQueryParameter "squash" False (\__squash request respond ->
                                                                                                optionalQueryParameter "labels" False (\__labels request respond ->
                                                                                                    optionalQueryParameter "networkmode" False (\__networkmode request respond ->
                                                                                                        optionalQueryParameter "platform" False (\__platform request respond ->
                                                                                                            optionalQueryParameter "target" False (\__target request respond ->
                                                                                                                optionalQueryParameter "outputs" False (\__outputs request respond ->
                                                                                                                    optionalQueryParameter "version" False (\__version request respond ->
                                                                                                                        optionalHeader "Content-type" (\__Content_type request respond ->
                                                                                                                            optionalHeader "X-Registry-Config" (\__X_Registry_Config request respond ->
                                                                                                                                parseRequestBody [jsonBodyParser] (\body request respond ->
                                                                                                                                    run request (do
                                                                                                                                        response <- imageBuild api __dockerfile __t __extrahosts __remote __q __nocache __cachefrom __pull __rm __forcerm __memory __memswap __cpushares __cpusetcpus __cpuperiod __cpuquota __buildargs __shmsize __squash __labels __networkmode __platform __target __outputs __version __Content_type __X_Registry_Config body
                                                                                                                                        Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                                                                                                                    )) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond
                x ->
                    unsupportedMethod x

        ["build", "prune"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    optionalQueryParameter "keep-storage" False (\__keep_storage request respond ->
                        optionalQueryParameter "all" False (\__all request respond ->
                            optionalQueryParameter "filters" False (\__filters request respond ->
                                run request (do
                                    response <- buildPrune api __keep_storage __all __filters
                                    Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                )) request respond) request respond) request respond
                x ->
                    unsupportedMethod x

        ["commit"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    optionalQueryParameter "container" False (\__container request respond ->
                        optionalQueryParameter "repo" False (\__repo request respond ->
                            optionalQueryParameter "tag" False (\__tag request respond ->
                                optionalQueryParameter "comment" False (\__comment request respond ->
                                    optionalQueryParameter "author" False (\__author request respond ->
                                        optionalQueryParameter "pause" False (\__pause request respond ->
                                            optionalQueryParameter "changes" False (\__changes request respond ->
                                                parseRequestBody [jsonBodyParser] (\body request respond ->
                                                    run request (do
                                                        response <- imageCommit api __container __repo __tag __comment __author __pause __changes body
                                                        Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                                    )) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond
                x ->
                    unsupportedMethod x

        ["configs"] ->
            case Network.Wai.requestMethod request of
                "GET" ->
                    optionalQueryParameter "filters" False (\__filters request respond ->
                        run request (do
                            response <- configList api __filters
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )) request respond
                x ->
                    unsupportedMethod x

        ["configs", "create"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    parseRequestBody [jsonBodyParser] (\body request respond ->
                        run request (do
                            response <- configCreate api body
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )) request respond
                x ->
                    unsupportedMethod x

        ["configs", __id] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "GET" ->
                        run request (do
                            response <- configInspect api __id
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )
                    "DELETE" ->
                        run request (do
                            response <- configDelete api __id
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )
                    x ->
                        unsupportedMethod x) request respond

        ["configs", __id, "update"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        requiredQueryParameter "version" (\__version request respond ->
                            parseRequestBody [jsonBodyParser] (\body request respond ->
                                run request (do
                                    response <- configUpdate api __id __version body
                                    Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                )) request respond) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["containers", "create"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    optionalQueryParameter "name" False (\__name request respond ->
                        optionalQueryParameter "platform" False (\__platform request respond ->
                            parseRequestBody [jsonBodyParser] (\body request respond ->
                                run request (do
                                    response <- containerCreate api __name __platform body
                                    Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                )) request respond) request respond) request respond
                x ->
                    unsupportedMethod x

        ["containers", "json"] ->
            case Network.Wai.requestMethod request of
                "GET" ->
                    optionalQueryParameter "all" False (\__all request respond ->
                        optionalQueryParameter "limit" False (\__limit request respond ->
                            optionalQueryParameter "size" False (\__size request respond ->
                                optionalQueryParameter "filters" False (\__filters request respond ->
                                    run request (do
                                        response <- containerList api __all __limit __size __filters
                                        Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                    )) request respond) request respond) request respond) request respond
                x ->
                    unsupportedMethod x

        ["containers", "prune"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    optionalQueryParameter "filters" False (\__filters request respond ->
                        run request (do
                            response <- containerPrune api __filters
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )) request respond
                x ->
                    unsupportedMethod x

        ["containers", __id, "exec"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        parseRequestBody [jsonBodyParser] (\body request respond ->
                            run request (do
                                response <- containerExec api __id body
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["containers", __id] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "DELETE" ->
                        optionalQueryParameter "v" False (\__v request respond ->
                            optionalQueryParameter "force" False (\__force request respond ->
                                optionalQueryParameter "link" False (\__link request respond ->
                                    run request (do
                                        response <- containerDelete api __id __v __force __link
                                        Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                    )) request respond) request respond) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["containers", __id, "archive"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "PUT" ->
                        requiredQueryParameter "path" (\__path request respond ->
                            optionalQueryParameter "noOverwriteDirNonDir" False (\__noOverwriteDirNonDir request respond ->
                                optionalQueryParameter "copyUIDGID" False (\__copyUIDGID request respond ->
                                    parseRequestBody [jsonBodyParser] (\body request respond ->
                                        run request (do
                                            response <- putContainerArchive api __id __path __noOverwriteDirNonDir __copyUIDGID body
                                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                        )) request respond) request respond) request respond) request respond
                    "HEAD" ->
                        requiredQueryParameter "path" (\__path request respond ->
                            run request (do
                                response <- containerArchiveInfo api __id __path
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond
                    "GET" ->
                        requiredQueryParameter "path" (\__path request respond ->
                            run request (do
                                response <- containerArchive api __id __path
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["containers", __id, "attach"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        optionalQueryParameter "detachKeys" False (\__detachKeys request respond ->
                            optionalQueryParameter "logs" False (\__logs request respond ->
                                optionalQueryParameter "stream" False (\__stream request respond ->
                                    optionalQueryParameter "stdin" False (\__stdin request respond ->
                                        optionalQueryParameter "stdout" False (\__stdout request respond ->
                                            optionalQueryParameter "stderr" False (\__stderr request respond ->
                                                run request (do
                                                    response <- containerAttach api __id __detachKeys __logs __stream __stdin __stdout __stderr
                                                    Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                                )) request respond) request respond) request respond) request respond) request respond) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["containers", __id, "attach", "ws"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "GET" ->
                        optionalQueryParameter "detachKeys" False (\__detachKeys request respond ->
                            optionalQueryParameter "logs" False (\__logs request respond ->
                                optionalQueryParameter "stream" False (\__stream request respond ->
                                    optionalQueryParameter "stdin" False (\__stdin request respond ->
                                        optionalQueryParameter "stdout" False (\__stdout request respond ->
                                            optionalQueryParameter "stderr" False (\__stderr request respond ->
                                                run request (do
                                                    response <- containerAttachWebsocket api __id __detachKeys __logs __stream __stdin __stdout __stderr
                                                    Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                                )) request respond) request respond) request respond) request respond) request respond) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["containers", __id, "changes"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "GET" ->
                        run request (do
                            response <- containerChanges api __id
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )
                    x ->
                        unsupportedMethod x) request respond

        ["containers", __id, "export"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "GET" ->
                        run request (do
                            response <- containerExport api __id
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )
                    x ->
                        unsupportedMethod x) request respond

        ["containers", __id, "json"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "GET" ->
                        optionalQueryParameter "size" False (\__size request respond ->
                            run request (do
                                response <- containerInspect api __id __size
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["containers", __id, "kill"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        optionalQueryParameter "signal" False (\__signal request respond ->
                            run request (do
                                response <- containerKill api __id __signal
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["containers", __id, "logs"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "GET" ->
                        optionalQueryParameter "follow" False (\__follow request respond ->
                            optionalQueryParameter "stdout" False (\__stdout request respond ->
                                optionalQueryParameter "stderr" False (\__stderr request respond ->
                                    optionalQueryParameter "since" False (\__since request respond ->
                                        optionalQueryParameter "until" False (\__until request respond ->
                                            optionalQueryParameter "timestamps" False (\__timestamps request respond ->
                                                optionalQueryParameter "tail" False (\__tail request respond ->
                                                    run request (do
                                                        response <- containerLogs api __id __follow __stdout __stderr __since __until __timestamps __tail
                                                        Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                                    )) request respond) request respond) request respond) request respond) request respond) request respond) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["containers", __id, "pause"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        run request (do
                            response <- containerPause api __id
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )
                    x ->
                        unsupportedMethod x) request respond

        ["containers", __id, "rename"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        requiredQueryParameter "name" (\__name request respond ->
                            run request (do
                                response <- containerRename api __id __name
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["containers", __id, "resize"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        requiredQueryParameter "h" (\__h request respond ->
                            requiredQueryParameter "w" (\__w request respond ->
                                run request (do
                                    response <- containerResize api __id __h __w
                                    Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                )) request respond) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["containers", __id, "restart"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        optionalQueryParameter "signal" False (\__signal request respond ->
                            optionalQueryParameter "t" False (\__t request respond ->
                                run request (do
                                    response <- containerRestart api __id __signal __t
                                    Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                )) request respond) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["containers", __id, "start"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        optionalQueryParameter "detachKeys" False (\__detachKeys request respond ->
                            run request (do
                                response <- containerStart api __id __detachKeys
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["containers", __id, "stats"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "GET" ->
                        optionalQueryParameter "stream" False (\__stream request respond ->
                            optionalQueryParameter "one-shot" False (\__one_shot request respond ->
                                run request (do
                                    response <- containerStats api __id __stream __one_shot
                                    Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                )) request respond) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["containers", __id, "stop"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        optionalQueryParameter "signal" False (\__signal request respond ->
                            optionalQueryParameter "t" False (\__t request respond ->
                                run request (do
                                    response <- containerStop api __id __signal __t
                                    Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                )) request respond) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["containers", __id, "top"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "GET" ->
                        optionalQueryParameter "ps_args" False (\__ps_args request respond ->
                            run request (do
                                response <- containerTop api __id __ps_args
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["containers", __id, "unpause"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        run request (do
                            response <- containerUnpause api __id
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )
                    x ->
                        unsupportedMethod x) request respond

        ["containers", __id, "update"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        parseRequestBody [jsonBodyParser] (\body request respond ->
                            run request (do
                                response <- containerUpdate api __id body
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["containers", __id, "wait"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        optionalQueryParameter "condition" False (\__condition request respond ->
                            run request (do
                                response <- containerWait api __id __condition
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["distribution", __name, "json"] ->
            pathVariable __name (\__name request respond ->
                case Network.Wai.requestMethod request of
                    "GET" ->
                        run request (do
                            response <- distributionInspect api __name
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )
                    x ->
                        unsupportedMethod x) request respond

        ["events"] ->
            case Network.Wai.requestMethod request of
                "GET" ->
                    optionalQueryParameter "since" False (\__since request respond ->
                        optionalQueryParameter "until" False (\__until request respond ->
                            optionalQueryParameter "filters" False (\__filters request respond ->
                                run request (do
                                    response <- systemEvents api __since __until __filters
                                    Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                )) request respond) request respond) request respond
                x ->
                    unsupportedMethod x

        ["exec", __id, "json"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "GET" ->
                        run request (do
                            response <- execInspect api __id
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )
                    x ->
                        unsupportedMethod x) request respond

        ["exec", __id, "resize"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        requiredQueryParameter "h" (\__h request respond ->
                            requiredQueryParameter "w" (\__w request respond ->
                                run request (do
                                    response <- execResize api __id __h __w
                                    Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                )) request respond) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["exec", __id, "start"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        parseRequestBody [jsonBodyParser] (\body request respond ->
                            run request (do
                                response <- execStart api __id body
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["images", "create"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    optionalQueryParameter "fromImage" False (\__fromImage request respond ->
                        optionalQueryParameter "fromSrc" False (\__fromSrc request respond ->
                            optionalQueryParameter "repo" False (\__repo request respond ->
                                optionalQueryParameter "tag" False (\__tag request respond ->
                                    optionalQueryParameter "message" False (\__message request respond ->
                                        optionalQueryParameters CommaDelimitedStyle "changes" (\__changes request respond ->
                                            optionalQueryParameter "platform" False (\__platform request respond ->
                                                optionalHeader "X-Registry-Auth" (\__X_Registry_Auth request respond ->
                                                    parseRequestBody [jsonBodyParser] (\body request respond ->
                                                        run request (do
                                                            response <- imageCreate api __fromImage __fromSrc __repo __tag __message __changes __platform __X_Registry_Auth body
                                                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                                        )) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond) request respond
                x ->
                    unsupportedMethod x

        ["images", "get"] ->
            case Network.Wai.requestMethod request of
                "GET" ->
                    optionalQueryParameters CommaDelimitedStyle "names" (\__names request respond ->
                        run request (do
                            response <- imageGetAll api __names
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )) request respond
                x ->
                    unsupportedMethod x

        ["images", "json"] ->
            case Network.Wai.requestMethod request of
                "GET" ->
                    optionalQueryParameter "all" False (\__all request respond ->
                        optionalQueryParameter "filters" False (\__filters request respond ->
                            optionalQueryParameter "shared-size" False (\__shared_size request respond ->
                                optionalQueryParameter "digests" False (\__digests request respond ->
                                    optionalQueryParameter "manifests" False (\__manifests request respond ->
                                        run request (do
                                            response <- imageList api __all __filters __shared_size __digests __manifests
                                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                        )) request respond) request respond) request respond) request respond) request respond
                x ->
                    unsupportedMethod x

        ["images", "load"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    optionalQueryParameter "quiet" False (\__quiet request respond ->
                        parseRequestBody [jsonBodyParser] (\body request respond ->
                            run request (do
                                response <- imageLoad api __quiet body
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond) request respond
                x ->
                    unsupportedMethod x

        ["images", "prune"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    optionalQueryParameter "filters" False (\__filters request respond ->
                        run request (do
                            response <- imagePrune api __filters
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )) request respond
                x ->
                    unsupportedMethod x

        ["images", "search"] ->
            case Network.Wai.requestMethod request of
                "GET" ->
                    requiredQueryParameter "term" (\__term request respond ->
                        optionalQueryParameter "limit" False (\__limit request respond ->
                            optionalQueryParameter "filters" False (\__filters request respond ->
                                run request (do
                                    response <- imageSearch api __term __limit __filters
                                    Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                )) request respond) request respond) request respond
                x ->
                    unsupportedMethod x

        ["images", __name] ->
            pathVariable __name (\__name request respond ->
                case Network.Wai.requestMethod request of
                    "DELETE" ->
                        optionalQueryParameter "force" False (\__force request respond ->
                            optionalQueryParameter "noprune" False (\__noprune request respond ->
                                run request (do
                                    response <- imageDelete api __name __force __noprune
                                    Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                )) request respond) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["images", __name, "get"] ->
            pathVariable __name (\__name request respond ->
                case Network.Wai.requestMethod request of
                    "GET" ->
                        run request (do
                            response <- imageGet api __name
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )
                    x ->
                        unsupportedMethod x) request respond

        ["images", __name, "history"] ->
            pathVariable __name (\__name request respond ->
                case Network.Wai.requestMethod request of
                    "GET" ->
                        run request (do
                            response <- imageHistory api __name
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )
                    x ->
                        unsupportedMethod x) request respond

        ["images", __name, "tag"] ->
            pathVariable __name (\__name request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        optionalQueryParameter "repo" False (\__repo request respond ->
                            optionalQueryParameter "tag" False (\__tag request respond ->
                                run request (do
                                    response <- imageTag api __name __repo __tag
                                    Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                )) request respond) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["images", __name, "json"] ->
            pathVariable __name (\__name request respond ->
                case Network.Wai.requestMethod request of
                    "GET" ->
                        run request (do
                            response <- imageInspect api __name
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )
                    x ->
                        unsupportedMethod x) request respond

        ["images", __name, "push"] ->
            pathVariable __name (\__name request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        optionalQueryParameter "tag" False (\__tag request respond ->
                            optionalQueryParameter "platform" False (\__platform request respond ->
                                requiredHeader "X-Registry-Auth" (\__X_Registry_Auth request respond ->
                                    run request (do
                                        response <- imagePush api __name __tag __platform __X_Registry_Auth
                                        Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                    )) request respond) request respond) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["info"] ->
            case Network.Wai.requestMethod request of
                "GET" ->
                    run request (do
                        response <- systemInfo api
                        Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                    )
                x ->
                    unsupportedMethod x

        ["networks"] ->
            case Network.Wai.requestMethod request of
                "GET" ->
                    optionalQueryParameter "filters" False (\__filters request respond ->
                        run request (do
                            response <- networkList api __filters
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )) request respond
                x ->
                    unsupportedMethod x

        ["networks", "create"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    parseRequestBody [jsonBodyParser] (\body request respond ->
                        run request (do
                            response <- networkCreate api body
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )) request respond
                x ->
                    unsupportedMethod x

        ["networks", "prune"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    optionalQueryParameter "filters" False (\__filters request respond ->
                        run request (do
                            response <- networkPrune api __filters
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )) request respond
                x ->
                    unsupportedMethod x

        ["networks", __id] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "GET" ->
                        optionalQueryParameter "verbose" False (\__verbose request respond ->
                            optionalQueryParameter "scope" False (\__scope request respond ->
                                run request (do
                                    response <- networkInspect api __id __verbose __scope
                                    Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                )) request respond) request respond
                    "DELETE" ->
                        run request (do
                            response <- networkDelete api __id
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )
                    x ->
                        unsupportedMethod x) request respond

        ["networks", __id, "connect"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        parseRequestBody [jsonBodyParser] (\body request respond ->
                            run request (do
                                response <- networkConnect api __id body
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["networks", __id, "disconnect"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        parseRequestBody [jsonBodyParser] (\body request respond ->
                            run request (do
                                response <- networkDisconnect api __id body
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["nodes"] ->
            case Network.Wai.requestMethod request of
                "GET" ->
                    optionalQueryParameter "filters" False (\__filters request respond ->
                        run request (do
                            response <- nodeList api __filters
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )) request respond
                x ->
                    unsupportedMethod x

        ["nodes", __id, "update"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        requiredQueryParameter "version" (\__version request respond ->
                            parseRequestBody [jsonBodyParser] (\body request respond ->
                                run request (do
                                    response <- nodeUpdate api __id __version body
                                    Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                )) request respond) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["nodes", __id] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "GET" ->
                        run request (do
                            response <- nodeInspect api __id
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )
                    "DELETE" ->
                        optionalQueryParameter "force" False (\__force request respond ->
                            run request (do
                                response <- nodeDelete api __id __force
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["plugins"] ->
            case Network.Wai.requestMethod request of
                "GET" ->
                    optionalQueryParameter "filters" False (\__filters request respond ->
                        run request (do
                            response <- pluginList api __filters
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )) request respond
                x ->
                    unsupportedMethod x

        ["plugins", "create"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    requiredQueryParameter "name" (\__name request respond ->
                        parseRequestBody [jsonBodyParser] (\body request respond ->
                            run request (do
                                response <- pluginCreate api __name body
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond) request respond
                x ->
                    unsupportedMethod x

        ["plugins", "privileges"] ->
            case Network.Wai.requestMethod request of
                "GET" ->
                    requiredQueryParameter "remote" (\__remote request respond ->
                        run request (do
                            response <- getPluginPrivileges api __remote
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )) request respond
                x ->
                    unsupportedMethod x

        ["plugins", "pull"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    requiredQueryParameter "remote" (\__remote request respond ->
                        optionalQueryParameter "name" False (\__name request respond ->
                            optionalHeader "X-Registry-Auth" (\__X_Registry_Auth request respond ->
                                parseRequestBody [jsonBodyParser] (\body request respond ->
                                    run request (do
                                        response <- pluginPull api __remote __name __X_Registry_Auth body
                                        Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                    )) request respond) request respond) request respond) request respond
                x ->
                    unsupportedMethod x

        ["plugins", __name] ->
            pathVariable __name (\__name request respond ->
                case Network.Wai.requestMethod request of
                    "DELETE" ->
                        optionalQueryParameter "force" False (\__force request respond ->
                            run request (do
                                response <- pluginDelete api __name __force
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["plugins", __name, "disable"] ->
            pathVariable __name (\__name request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        optionalQueryParameter "force" False (\__force request respond ->
                            run request (do
                                response <- pluginDisable api __name __force
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["plugins", __name, "enable"] ->
            pathVariable __name (\__name request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        optionalQueryParameter "timeout" False (\__timeout request respond ->
                            run request (do
                                response <- pluginEnable api __name __timeout
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["plugins", __name, "json"] ->
            pathVariable __name (\__name request respond ->
                case Network.Wai.requestMethod request of
                    "GET" ->
                        run request (do
                            response <- pluginInspect api __name
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )
                    x ->
                        unsupportedMethod x) request respond

        ["plugins", __name, "push"] ->
            pathVariable __name (\__name request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        run request (do
                            response <- pluginPush api __name
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )
                    x ->
                        unsupportedMethod x) request respond

        ["plugins", __name, "set"] ->
            pathVariable __name (\__name request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        parseRequestBody [jsonBodyParser] (\body request respond ->
                            run request (do
                                response <- pluginSet api __name body
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["plugins", __name, "upgrade"] ->
            pathVariable __name (\__name request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        requiredQueryParameter "remote" (\__remote request respond ->
                            optionalHeader "X-Registry-Auth" (\__X_Registry_Auth request respond ->
                                parseRequestBody [jsonBodyParser] (\body request respond ->
                                    run request (do
                                        response <- pluginUpgrade api __name __remote __X_Registry_Auth body
                                        Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                    )) request respond) request respond) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["secrets"] ->
            case Network.Wai.requestMethod request of
                "GET" ->
                    optionalQueryParameter "filters" False (\__filters request respond ->
                        run request (do
                            response <- secretList api __filters
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )) request respond
                x ->
                    unsupportedMethod x

        ["secrets", "create"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    parseRequestBody [jsonBodyParser] (\body request respond ->
                        run request (do
                            response <- secretCreate api body
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )) request respond
                x ->
                    unsupportedMethod x

        ["secrets", __id] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "GET" ->
                        run request (do
                            response <- secretInspect api __id
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )
                    "DELETE" ->
                        run request (do
                            response <- secretDelete api __id
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )
                    x ->
                        unsupportedMethod x) request respond

        ["secrets", __id, "update"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        requiredQueryParameter "version" (\__version request respond ->
                            parseRequestBody [jsonBodyParser] (\body request respond ->
                                run request (do
                                    response <- secretUpdate api __id __version body
                                    Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                )) request respond) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["services"] ->
            case Network.Wai.requestMethod request of
                "GET" ->
                    optionalQueryParameter "filters" False (\__filters request respond ->
                        optionalQueryParameter "status" False (\__status request respond ->
                            run request (do
                                response <- serviceList api __filters __status
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond) request respond
                x ->
                    unsupportedMethod x

        ["services", "create"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    optionalHeader "X-Registry-Auth" (\__X_Registry_Auth request respond ->
                        parseRequestBody [jsonBodyParser] (\body request respond ->
                            run request (do
                                response <- serviceCreate api __X_Registry_Auth body
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond) request respond
                x ->
                    unsupportedMethod x

        ["services", __id] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "GET" ->
                        optionalQueryParameter "insertDefaults" False (\__insertDefaults request respond ->
                            run request (do
                                response <- serviceInspect api __id __insertDefaults
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond
                    "DELETE" ->
                        run request (do
                            response <- serviceDelete api __id
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )
                    x ->
                        unsupportedMethod x) request respond

        ["services", __id, "update"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "POST" ->
                        requiredQueryParameter "version" (\__version request respond ->
                            optionalQueryParameter "registryAuthFrom" False (\__registryAuthFrom request respond ->
                                optionalQueryParameter "rollback" False (\__rollback request respond ->
                                    optionalHeader "X-Registry-Auth" (\__X_Registry_Auth request respond ->
                                        parseRequestBody [jsonBodyParser] (\body request respond ->
                                            run request (do
                                                response <- serviceUpdate api __id __version __registryAuthFrom __rollback __X_Registry_Auth body
                                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                            )) request respond) request respond) request respond) request respond) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["services", __id, "logs"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "GET" ->
                        optionalQueryParameter "details" False (\__details request respond ->
                            optionalQueryParameter "follow" False (\__follow request respond ->
                                optionalQueryParameter "stdout" False (\__stdout request respond ->
                                    optionalQueryParameter "stderr" False (\__stderr request respond ->
                                        optionalQueryParameter "since" False (\__since request respond ->
                                            optionalQueryParameter "timestamps" False (\__timestamps request respond ->
                                                optionalQueryParameter "tail" False (\__tail request respond ->
                                                    run request (do
                                                        response <- serviceLogs api __id __details __follow __stdout __stderr __since __timestamps __tail
                                                        Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                                    )) request respond) request respond) request respond) request respond) request respond) request respond) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["session"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    run request (do
                        response <- session api
                        Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                    )
                x ->
                    unsupportedMethod x

        ["swarm"] ->
            case Network.Wai.requestMethod request of
                "GET" ->
                    run request (do
                        response <- swarmInspect api
                        Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                    )
                x ->
                    unsupportedMethod x

        ["swarm", "init"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    parseRequestBody [jsonBodyParser] (\body request respond ->
                        run request (do
                            response <- swarmInit api body
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )) request respond
                x ->
                    unsupportedMethod x

        ["swarm", "join"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    parseRequestBody [jsonBodyParser] (\body request respond ->
                        run request (do
                            response <- swarmJoin api body
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )) request respond
                x ->
                    unsupportedMethod x

        ["swarm", "leave"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    optionalQueryParameter "force" False (\__force request respond ->
                        run request (do
                            response <- swarmLeave api __force
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )) request respond
                x ->
                    unsupportedMethod x

        ["swarm", "unlock"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    parseRequestBody [jsonBodyParser] (\body request respond ->
                        run request (do
                            response <- swarmUnlock api body
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )) request respond
                x ->
                    unsupportedMethod x

        ["swarm", "unlockkey"] ->
            case Network.Wai.requestMethod request of
                "GET" ->
                    run request (do
                        response <- swarmUnlockkey api
                        Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                    )
                x ->
                    unsupportedMethod x

        ["swarm", "update"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    requiredQueryParameter "version" (\__version request respond ->
                        optionalQueryParameter "rotateWorkerToken" False (\__rotateWorkerToken request respond ->
                            optionalQueryParameter "rotateManagerToken" False (\__rotateManagerToken request respond ->
                                optionalQueryParameter "rotateManagerUnlockKey" False (\__rotateManagerUnlockKey request respond ->
                                    parseRequestBody [jsonBodyParser] (\body request respond ->
                                        run request (do
                                            response <- swarmUpdate api __version __rotateWorkerToken __rotateManagerToken __rotateManagerUnlockKey body
                                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                        )) request respond) request respond) request respond) request respond) request respond
                x ->
                    unsupportedMethod x

        ["system", "df"] ->
            case Network.Wai.requestMethod request of
                "GET" ->
                    optionalQueryParameters FormStyle "type" (\__type request respond ->
                        run request (do
                            response <- systemDataUsage api __type
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )) request respond
                x ->
                    unsupportedMethod x

        ["tasks"] ->
            case Network.Wai.requestMethod request of
                "GET" ->
                    optionalQueryParameter "filters" False (\__filters request respond ->
                        run request (do
                            response <- taskList api __filters
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )) request respond
                x ->
                    unsupportedMethod x

        ["tasks", __id] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "GET" ->
                        run request (do
                            response <- taskInspect api __id
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )
                    x ->
                        unsupportedMethod x) request respond

        ["tasks", __id, "logs"] ->
            pathVariable __id (\__id request respond ->
                case Network.Wai.requestMethod request of
                    "GET" ->
                        optionalQueryParameter "details" False (\__details request respond ->
                            optionalQueryParameter "follow" False (\__follow request respond ->
                                optionalQueryParameter "stdout" False (\__stdout request respond ->
                                    optionalQueryParameter "stderr" False (\__stderr request respond ->
                                        optionalQueryParameter "since" False (\__since request respond ->
                                            optionalQueryParameter "timestamps" False (\__timestamps request respond ->
                                                optionalQueryParameter "tail" False (\__tail request respond ->
                                                    run request (do
                                                        response <- taskLogs api __id __details __follow __stdout __stderr __since __timestamps __tail
                                                        Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                                    )) request respond) request respond) request respond) request respond) request respond) request respond) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["version"] ->
            case Network.Wai.requestMethod request of
                "GET" ->
                    run request (do
                        response <- systemVersion api
                        Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                    )
                x ->
                    unsupportedMethod x

        ["volumes"] ->
            case Network.Wai.requestMethod request of
                "GET" ->
                    optionalQueryParameter "filters" False (\__filters request respond ->
                        run request (do
                            response <- volumeList api __filters
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )) request respond
                x ->
                    unsupportedMethod x

        ["volumes", "create"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    parseRequestBody [jsonBodyParser] (\body request respond ->
                        run request (do
                            response <- volumeCreate api body
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )) request respond
                x ->
                    unsupportedMethod x

        ["volumes", "prune"] ->
            case Network.Wai.requestMethod request of
                "POST" ->
                    optionalQueryParameter "filters" False (\__filters request respond ->
                        run request (do
                            response <- volumePrune api __filters
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )) request respond
                x ->
                    unsupportedMethod x

        ["volumes", __name] ->
            pathVariable __name (\__name request respond ->
                case Network.Wai.requestMethod request of
                    "PUT" ->
                        requiredQueryParameter "version" (\__version request respond ->
                            parseRequestBody [jsonBodyParser] (\body request respond ->
                                run request (do
                                    response <- volumeUpdate api __name __version body
                                    Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                                )) request respond) request respond
                    x ->
                        unsupportedMethod x) request respond

        ["volumes", __name] ->
            pathVariable __name (\__name request respond ->
                case Network.Wai.requestMethod request of
                    "GET" ->
                        run request (do
                            response <- volumeInspect api __name
                            Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                        )
                    "DELETE" ->
                        optionalQueryParameter "force" False (\__force request respond ->
                            run request (do
                                response <- volumeDelete api __name __force
                                Control.Monad.IO.Class.liftIO (respond $! (toResponse response))
                            )) request respond
                    x ->
                        unsupportedMethod x) request respond

        _ ->
            notFound request respond
    where
        unsupportedMethod _ =
            respond (Network.Wai.responseBuilder Network.HTTP.Types.status405 [] mempty)
{-# INLINABLE application #-}