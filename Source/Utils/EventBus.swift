import Foundation

protocol Eventable {
    static var eventId: UUID { get }
}

// swiftlint:disable convenience_type
class BaseEventBus {
    fileprivate static var storage = [UUID: [(UUID, Closure.Generic<Any>)]]()
}
// swiftlint:enable convenience_type

class EventBus<Event: Eventable>: BaseEventBus {
    private let id = UUID()
    
    init(subscribe: Closure.Generic<Event>? = nil) {
        guard let subscribe else {
            return
        }
        
        if BaseEventBus.storage[Event.eventId] == nil {
            BaseEventBus.storage[Event.eventId] = []
        }
        
        let closure: Closure.Generic<Any> = { value in
            if let value = value as? Event {
                subscribe(value)
            } else {
                assertionFailure("Failed co map \(value) to \(Event.self)")
            }
        }
        
        BaseEventBus.storage[Event.eventId]?.append((id, closure))
    }
    
    func send(event: Event) {
        BaseEventBus.storage[Event.eventId]?.forEach {
            $0.1(event)
        }
    }
    
    deinit {
        BaseEventBus.storage[Event.eventId]?.removeAll { $0.0 == id }
    }
}
