import Foundation

/// An erased `Encodable`.
public struct AnyEncodable: Encodable {
    /// Closure for encoding, erasing the type of the instance this class was instantiated with.
    private let _encode: (Encoder) throws -> Void
    
    /// Initialize with a generic `Encodable` instance.
    ///
    /// - Parameter wrapped: an instance of `Encodable`.
    public init<T: Encodable>(_ wrapped: T) {
        _encode = wrapped.encode
    }
    
    // MARK: Encodable
    
    public func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}

/// A type erased body of a request.
public protocol AnyBody {
    /// The `Encodable` content of this request.
    var content: AnyEncodable { get }
    
    /// The content type of this body. Currently supports `.json` and `.urlEncoded`.
    var contentType: ContentType { get }
}

/// Indicates the type of a request's content. The content type affects where the content is encoded
/// in the request.
public enum ContentType {
    /// The content of this request is encoded to its body as JSON.
    case json
    /// The content of this request is encoded to its URL.
    case urlEncoded
}

@propertyWrapper
/// Represents the body of a request.
public struct Body<Value: Codable>: Codable, AnyBody {
    /// The value of the this body.
    public var wrappedValue: Value {
        get { _wrappedValue! }
        set { _wrappedValue = newValue }
    }
    
    /// Local storage of the value of this body.
    private var _wrappedValue: Value?
    
    // MARK: AnyBody
    public var contentType: ContentType = .json
    public var content: AnyEncodable { .init(wrappedValue) }
    
    /// Initialize with a content value. The content type is assumed to be `.json`.
    ///
    /// - Parameter wrappedValue: the content of this request.
    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
    
    /// Initialize with a content type.
    ///
    /// - Parameter contentType: content type of this request.
    public init(_ contentType: ContentType) {
        self.contentType = contentType
    }
    
    /// Create a request body with the given content & content type.
    ///
    /// - Parameters:
    ///   - wrappedValue: the content of this request.
    ///   - contentType: the type of the content.
    public init(wrappedValue: Value, _ contentType: ContentType) {
        self.contentType = contentType
        self.wrappedValue = wrappedValue
    }
    
    // MARK: Codable
    
    public init(from decoder: Decoder) throws {
        self.wrappedValue = try decoder.singleValueContainer().decode(Value.self)
    }
    
    public func encode(to encoder: Encoder) throws {}
}