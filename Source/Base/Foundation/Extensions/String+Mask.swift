import Foundation
import InputMask

extension String {
    func formattedValue(mask: String) -> String {
        guard let mask: Mask = try? Mask(format: mask) else {
            return self
        }
        
        let caretString = CaretString(
            string: self,
            caretPosition: self.endIndex,
            caretGravity: .forward(autocomplete: false)
        )
        let result: Mask.Result = mask.apply(toText: caretString)
        
        return result.formattedText.string
    }
}
