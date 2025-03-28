import SwiftUI

struct GenericButtonColorsSet {
    let active: Color
    let pressed: Color
    let disabled: Color
    let loading: Color
    
    func getColor(isLoading: Bool, isPressed: Bool, isActive: Bool) -> Color {
        if isLoading {
            return loading
        } else if isPressed {
            return pressed
        } else if isActive {
            return active
        } else {
            return disabled
        }
    }
}
