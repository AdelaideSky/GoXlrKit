// This file was generated from JSON Schema using quicktype, do not modify it directly.
//
// Status structs.
import Foundation
import Patchable

var liveUD = GoXlr.shared.eligibleForLiveUpdate
// MARK: - Status
/**
 Base Status struct. Only used to decode daemon's JSON. Doesn't contain any useful information.
 */

@Patchable
public class Status: Codable, ObservableObject {
    public var id: Int
    @child public var data: DataClass
    
    enum CodingKeys: String, CodingKey {
        case id, data
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        data = try values.decode(DataClass.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(data, forKey: .data)
    }
}

// MARK: - DataClass
/**
 Enclosing struct of the status.
 */
@Patchable
public class DataClass: Codable, ObservableObject {
    @child @Published public var status: StatusClass

    enum CodingKeys: String, CodingKey {
        case status = "Status"
    }
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decode(StatusClass.self, forKey: .status)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(status, forKey: .status)
    }
}

// MARK: - StatusClass
/**
 Status struct. Root of the Daemon Status.
 */
@Patchable
public class StatusClass: Codable, ObservableObject {
    @child @Published public var config: Config
    @child @Published public var mixers: [String:Mixer]
    @child @Published public var paths: Paths
    @child @Published public var files: Files
    
    enum CodingKeys: String, CodingKey {
        case config, mixers, paths, files
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        config = try values.decode(Config.self, forKey: .config)
        mixers = try values.decode([String:Mixer].self, forKey: .mixers)
        paths = try values.decode(Paths.self, forKey: .paths)
        files = try values.decode(Files.self, forKey: .files)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(config, forKey: .config)
        try container.encode(mixers, forKey: .mixers)
        try container.encode(paths, forKey: .paths)
        try container.encode(files, forKey: .files)
    }
}

// MARK: - Config
@Patchable
public final class Config: Codable, ObservableObject {
    
    @Parameter({.SetAllowNetworkAccess($0) }) public var allowNetworkAccess: Bool = false
    @Published public var autostartEnabled: Bool
    @Published public var daemonVersion: String
    @Parameter({.SetLogLevel($0) }) public var logLevel: Daemon.logLevels = .info
    @Parameter({.SetShowTrayIcon($0) }) public var showTrayIcon: Bool = false
    @Parameter({.SetTTSEnabled($0) }) public var ttsEnabled: Bool = false
    
    @child @Published public var httpSettings: HttpConfig

    enum CodingKeys: String, CodingKey {
        case daemonVersion = "daemon_version"
        case autostartEnabled = "autostart_enabled"
        case ttsEnabled = "tts_enabled"
        case allowNetworkAccess = "allow_network_access"
        case logLevel = "log_level"
        case showTrayIcon = "show_tray_icon"
        case httpSettings = "http_settings"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        allowNetworkAccess = try values.decode(Bool.self, forKey: .allowNetworkAccess)
        daemonVersion = try values.decode(String.self, forKey: .daemonVersion)
        autostartEnabled = try values.decode(Bool.self, forKey: .autostartEnabled)
        logLevel = try values.decode(Daemon.logLevels.self, forKey: .logLevel)
        showTrayIcon = try values.decode(Bool.self, forKey: .showTrayIcon)
        do {
            ttsEnabled = try values.decode(Bool.self, forKey: .ttsEnabled)
        } catch {
            ttsEnabled = false
        }
        httpSettings = try values.decode(HttpConfig.self, forKey: .httpSettings)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(allowNetworkAccess, forKey: .allowNetworkAccess)
        try container.encode(daemonVersion, forKey: .daemonVersion)
        try container.encode(autostartEnabled, forKey: .autostartEnabled)
        try container.encode(logLevel, forKey: .logLevel)
        try container.encode(showTrayIcon, forKey: .showTrayIcon)
        try container.encode(ttsEnabled, forKey: .ttsEnabled)
    }
}

// MARK: - HttpConfig
@Patchable
public class HttpConfig: Codable, ObservableObject {
    @Published public var enabled: Bool
    @Published public var bindAddress: String
    @Published public var corsEnabled: Bool
    @Published public var port: Int

    enum CodingKeys: String, CodingKey {
        case enabled, port
        case bindAddress = "bind_address"
        case corsEnabled = "cors_enabled"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        enabled = try values.decode(Bool.self, forKey: .enabled)
        bindAddress = try values.decode(String.self, forKey: .bindAddress)
        corsEnabled = try values.decode(Bool.self, forKey: .corsEnabled)
        port = try values.decode(Int.self, forKey: .port)
        
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(enabled, forKey: .enabled)
        try container.encode(bindAddress, forKey: .bindAddress)
        try container.encode(corsEnabled, forKey: .corsEnabled)
        try container.encode(port, forKey: .port)
    }
}

// MARK: - Files
@Patchable
public class Files: Codable, ObservableObject {
    @Published public var profiles: [String]
    @Published public var micProfiles: [String]
    @Published public var presets: [String]
    @Published public var samples: [String: String]
    @Published public var icons: [String]

    enum CodingKeys: String, CodingKey {
        case profiles
        case micProfiles = "mic_profiles"
        case presets, samples, icons
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        profiles = try values.decode([String].self, forKey: .profiles)
        micProfiles = try values.decode([String].self, forKey: .micProfiles)
        presets = try values.decode([String].self, forKey: .presets)
        
        samples = try values.decode([String: String].self, forKey: .samples)
        icons = try values.decode([String].self, forKey: .icons)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(profiles, forKey: .profiles)
        try container.encode(micProfiles, forKey: .micProfiles)
        try container.encode(presets, forKey: .presets)
        try container.encode(samples, forKey: .samples)
        try container.encode(icons, forKey: .icons)
    }
}

// MARK: - Paths
@Patchable
public class Paths: Codable, ObservableObject {
    @Published public var profileDirectory: String
    @Published public var micProfileDirectory: String
    @Published public var samplesDirectory: String
    @Published public var presetsDirectory: String
    @Published public var iconsDirectory: String
    @Published public var logsDirectory: String

    enum CodingKeys: String, CodingKey {
        case profileDirectory = "profile_directory"
        case micProfileDirectory = "mic_profile_directory"
        case samplesDirectory = "samples_directory"
        case presetsDirectory = "presets_directory"
        case iconsDirectory = "icons_directory"
        case logsDirectory = "logs_directory"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        profileDirectory = try container.decode(String.self, forKey: .profileDirectory)
        micProfileDirectory = try container.decode(String.self, forKey: .micProfileDirectory)
        samplesDirectory = try container.decode(String.self, forKey: .samplesDirectory)
        presetsDirectory = try container.decode(String.self, forKey: .presetsDirectory)
        iconsDirectory = try container.decode(String.self, forKey: .iconsDirectory)
        logsDirectory = try container.decode(String.self, forKey: .logsDirectory)

    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(profileDirectory, forKey: .profileDirectory)
        try container.encode(micProfileDirectory, forKey: .micProfileDirectory)
        try container.encode(samplesDirectory, forKey: .samplesDirectory)
        try container.encode(presetsDirectory, forKey: .presetsDirectory)
        try container.encode(iconsDirectory, forKey: .iconsDirectory)
        try container.encode(logsDirectory, forKey: .logsDirectory)
    }
}
