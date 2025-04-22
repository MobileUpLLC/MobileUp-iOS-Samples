import Foundation

// swiftlint:disable file_length
enum LocalSourceDirectoryType {
    enum TemporarySubdirectoryType {
        /// Главная временная директория приложения.
        case main

        /// Директория медиаисходников текущего жизненного цикла приложения.
        case sessionSources
    }

    enum DocumentsSubdirectoryType {
        /// Главная директория документов модуля редактора.
        case main

        /// Директория черновиков.
        case drafts

        /// Директория конкретного черновика.
        /// - Parameter id: ID конкретного черновика. Должен быть согласован с ID в материнском приложении.
        case draftSources(String)
    }

    case temporary(TemporarySubdirectoryType)
    case documents(DocumentsSubdirectoryType)

    var name: String { getName() }

    private func getName() -> String {
        switch self {
        case .temporary(let temporaryType):
            switch temporaryType {
            case .main:
                return "VideoEditor"
            case .sessionSources:
                return "SessionSources"
            }
        case .documents(let documentsType):
            switch documentsType {
            case .main:
                return "VideoEditor"
            case .drafts:
                return "Drafts"
            case .draftSources(let id):
                return "Draft_\(id)"
            }
        }
    }
}

// swiftlint:disable:next no_protocol_suffix
protocol LocalSourcesServiceProtocol {
    static var shared: LocalSourcesServiceProtocol { get }

    func constructPath(
        fileDirectory: LocalSourceDirectoryType,
        fileName: String?,
        fileExtension: String?
    ) -> URL

    /// - Returns: `true` – задача выполнена успешно, иначе – `false`.
    func copy(fromUrl: URL, toUrl: URL) -> Bool

    /// Метод для формирования файловой системы.
    /// Вызывайте метод единожды внутри `application(
    /// _ application: UIApplication,
    /// didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    /// ) -> Bool`.
    func constructFileSystem() -> Bool

    /// Метод для очистки старых данных.
    /// Вызывайте метод единожды внутри `application(
    /// _ application: UIApplication,
    /// didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    /// ) -> Bool`.
    func removeOldSources() -> Bool

    /// Метод для сохранения типа `Data`.
    func saveData(_ data: Data, toUrl url: URL) -> Bool

    /// Метод для удаления файла или директории.
    /// Удаление несуществующей директории считается успешным.
    func deletePathWithUrl(_ url: URL) -> Bool

    /// Метод для создания директории.
    func createDirectory(_ directory: LocalSourceDirectoryType) -> Bool
    
    /// Метод для создания относительной ссылки из абсолютной.
    func constructRelativeUrlFromAbsolute(_ url: URL) -> URL?

    /// Метод для создания абсолютной ссылки из относительной.
    func constructAbsoluteUrlFromRelative(_ url: URL) -> URL?
}

// swiftlint:disable no_emoji
extension LocalSourcesService: LocalSourcesServiceProtocol {
    func removeOldSources() -> Bool {
        var withoutErrors = true

        withoutErrors = withoutErrors && cleanOldFilesInDirectory(
            constructDirectoryPath(.documents(.drafts)),
            olderThanDays: .two
        )
        withoutErrors = withoutErrors && cleanOldFilesInDirectory(
            constructDirectoryPath(.temporary(.main)),
            olderThanDays: .zero
        )

        return withoutErrors
    }

    func constructPath(
        fileDirectory: LocalSourceDirectoryType,
        fileName: String?,
        fileExtension: String?
    ) -> URL {
        var url = constructDirectoryPath(fileDirectory)

        if let fileName {
            url = url.appendingPathComponent(fileName)
        }

        if let fileExtension {
            url = url.appendingPathExtension(fileExtension)
        }

        return url
    }

    func saveData(_ data: Data, toUrl url: URL) -> Bool {
        do {
            try data.write(to: url)
            Log.localSourcesService.debug(logEntry: .text("📁💾🆗\nИнформация сохранена \(url.path)"))
            return true
        } catch {
            Log.localSourcesService.error(
                logEntry: .text(
                    "📁💾🚨\nИнформация не сохранена. Ошибка \(error.localizedDescription)"
                )
            )
            return false
        }
    }

    func copy(fromUrl: URL, toUrl: URL) -> Bool {
        do {
            try FileManager.default.copyItem(at: fromUrl, to: toUrl)
            Log.localSourcesService.debug(
                logEntry: .text(
                    "📁📚🆗\nФайл скопирован\nиз \(fromUrl.path)\nв \(toUrl.path)"
                )
            )
            return true
        } catch {
            Log.localSourcesService.error(
                logEntry: .text(
                    """
                    📁📚🚨\nОшибка копирования файла
                    из \(fromUrl.path)\nв \(toUrl.path)
                    \(error.localizedDescription)
                    """
                )
            )
            return false
        }
    }

    func deletePathWithUrl(_ url: URL) -> Bool {
        guard fileManager.fileExists(atPath: url.path) else {
            Log.localSourcesService.debug(logEntry: .text("📁🧨🆓\nУдаляемого пути \(url.path) не существует"))
            return true
        }

        do {
            try FileManager.default.removeItem(atPath: url.path)
            Log.localSourcesService.debug(logEntry: .text("📁🪓🆗\nПуть удалён \(url.path)"))
            return true
        } catch {
            Log.localSourcesService.error(
                logEntry: .text(
                    "📁🪓🚨\nОшибка при удалении пути \(url.path)\n\(error.localizedDescription)"
                )
            )
            return false
        }
    }

    func createDirectory(_ directory: LocalSourceDirectoryType) -> Bool {
        let url = constructDirectoryPath(directory)

        do {
            try fileManager.createDirectory(
                at: url,
                withIntermediateDirectories: true,
                attributes: [.posixPermissions: NSNumber(value: Int16(0o777))] // Для удаления
            )
            Log.localSourcesService.debug(logEntry: .text("📁🏗️🆗\nДиректория создана: \(url.path)"))
            return true
        } catch {
            Log.localSourcesService.error(
                logEntry: .text(
                    "📁🏗️🚨\nНе удалось создать директорию \(url.path): \(error)"
                )
            )
            return false
        }
    }

    func constructFileSystem() -> Bool {
        var result = true
        result = result && createDirectory(.documents(.main))
        result = result && createDirectory(.documents(.drafts))
        result = result && createDirectory(.temporary(.main))
        result = result && createDirectory(.temporary(.sessionSources))
        return result
    }

    func constructRelativeUrlFromAbsolute(_ url: URL) -> URL? {
        guard let path = url.path.components(separatedBy: NSHomeDirectory() + "/").last else {
            return nil
        }
        return URL(string: path)
    }

    func constructAbsoluteUrlFromRelative(_ url: URL) -> URL? {
        guard let homeDirectory = URL(string: NSHomeDirectory()) else {
            return nil
        }
        return URL(fileURLWithPath: homeDirectory.appendingPathComponent(url.path).path)
    }
}

final class LocalSourcesService {
    static let shared: LocalSourcesServiceProtocol = LocalSourcesService()

    private let fileManager = FileManager.default

    private init() {
        logDirectorySize(.documents(.main))
        logDirectorySize(.temporary(.main))
    }

    private func cleanOldFilesInDirectory(_ url: URL, olderThanDays days: Int) -> Bool {
        let expirationDate = Date().addingTimeInterval(-TimeInterval(days * 24 * 60 * 60))
        var operationSuccessful = true

        do {
            let fileUrls = try fileManager.contentsOfDirectory(
                at: url,
                includingPropertiesForKeys: [.contentModificationDateKey]
            )
            for fileUrl in fileUrls {
                guard
                    let attributes = try? fileUrl.resourceValues(forKeys: [.contentModificationDateKey]),
                    let modificationDate = attributes.contentModificationDate,
                    modificationDate < expirationDate
                else {
                    continue
                }
                
                do {
                    try fileManager.removeItem(at: fileUrl)
                    let log =
                    """
                    📁🗑️🆗\nУдален файл: \(fileUrl.lastPathComponent) за истечением срока хранения в \(days) дней
                    """
                    Log.localSourcesService.debug(logEntry: .text(log))
                } catch {
                    let log = "📁🧹🚨\nНе удалось удалить файл \(fileUrl.lastPathComponent): \(error)"
                    Log.localSourcesService.error(logEntry: .text(log))
                    operationSuccessful = false
                }
            }
        } catch {
            let log = "📁🧹🚨\nНе удалось прочитать содержимое директории \(url.path): \(error)"
            Log.localSourcesService.error(logEntry: .text(log))
            operationSuccessful = false
        }

        return operationSuccessful
    }

    private func constructDirectoryPath(_ directory: LocalSourceDirectoryType) -> URL {
        switch directory {
        case .temporary(let temporarySubdirectory):
            switch temporarySubdirectory {
            case .main:
                return URL(fileURLWithPath: fileManager.temporaryDirectory.path, isDirectory: true)
                    .appendingPathComponent(LocalSourceDirectoryType.temporary(.main).name)
            case .sessionSources:
                return constructDirectoryPath(.temporary(.main)).appendingPathComponent(directory.name)
            }
        case .documents(let documentsSubdirectory):
            switch documentsSubdirectory {
            case .main:
                guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
                    return constructDirectoryPath(.temporary(.main))
                }
                return url.appendingPathComponent(LocalSourceDirectoryType.documents(.main).name)
            case .draftSources:
                return constructDirectoryPath(.documents(.drafts)).appendingPathComponent(directory.name)
            case .drafts:
                return constructDirectoryPath(.documents(.main)).appendingPathComponent(directory.name)
            }
        }
    }

    private func logDirectorySize(_ directory: LocalSourceDirectoryType) {
        let mainDirectory = constructDirectoryPath(directory)

        do {
            let attributes = try fileManager.attributesOfItem(atPath: mainDirectory.path)
            if let directorySize = attributes[.size] as? NSNumber {
                let sizeInGb = directorySize.doubleValue / (1_024 * 1_024 * 1_024)
                let log = """
                📁💾🆗\nРазмер директории \(mainDirectory.lastPathComponent): \(String(format: "%.2f", sizeInGb)) GB
                """
                Log.localSourcesService.debug(logEntry: .text(log))
            } else {
                let log = "📁💾🚨\nРазмер директории \(mainDirectory.lastPathComponent) не доступен."
                Log.localSourcesService.debug(logEntry: .text(log))
            }
        } catch {
            let log = "📁💾🚨\nНе удалось отпределить размер директории \(mainDirectory.lastPathComponent): \(error)"
            Log.localSourcesService.error(logEntry: .text(log))
        }
    }
}
// swiftlint:enable no_emoji
// swiftlint:enable file_length
