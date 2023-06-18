// This file was generated from JSON Schema using quicktype, do not modify it directly.
//
// Status structs.
import Foundation

public var valueUpdatedByUI = true

// MARK: - Status
/**
 Base Status struct. Only used to decode daemon's JSON. Doesn't contain any useful information.
 */
public class Status: Codable, ObservableObject {
    @Published public var id: Int
    @Published public var data: DataClass
    
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
public class DataClass: Codable, ObservableObject {
    @Published public var status: StatusClass

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
public class StatusClass: Codable, ObservableObject {
    @Published public var config: Config
    @Published public var mixers: [String:Mixer]
    @Published public var paths: Paths
    @Published public var files: Files
    
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
public class Config: Codable, ObservableObject {
    @Published public var allowNetworkAccess: Bool { didSet { GoXlr.shared.command(.SetAllowNetworkAccess(allowNetworkAccess)) } }
    @Published public var daemonVersion: String
    @Published public var autostartEnabled: Bool
    @Published public var logLevel: Daemon.logLevels { didSet { GoXlr.shared.command(.SetLogLevel(logLevel)) } }
    @Published public var showTrayIcon: Bool { didSet { GoXlr.shared.command(.SetShowTrayIcon(showTrayIcon)) } }
    @Published public var ttsEnabled: Bool { didSet { GoXlr.shared.command(.SetTTSEnabled(ttsEnabled)) } }

    enum CodingKeys: String, CodingKey {
        case daemonVersion = "daemon_version"
        case autostartEnabled = "autostart_enabled"
        case ttsEnabled = "tts_enabled"
        case allowNetworkAccess = "allow_network_access"
        case logLevel = "log_level"
        case showTrayIcon = "show_tray_icon"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        allowNetworkAccess = try values.decode(Bool.self, forKey: .allowNetworkAccess)
        daemonVersion = try values.decode(String.self, forKey: .daemonVersion)
        autostartEnabled = try values.decode(Bool.self, forKey: .autostartEnabled)
        logLevel = try values.decode(Daemon.logLevels.self, forKey: .logLevel)
        showTrayIcon = try values.decode(Bool.self, forKey: .showTrayIcon)
        ttsEnabled = try values.decode(Bool.self, forKey: .ttsEnabled)
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

// MARK: - Files
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
