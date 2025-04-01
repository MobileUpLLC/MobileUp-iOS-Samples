//
//  String+Subscript.swift
//  com.samples.app
//
//  Created by Кирилл Кошкарёв on 31.03.2025.
//

import UIKit

/// Используем для получения символа из строки по индексу
extension String {
    subscript(safe i: Int) -> Character? {
        if i >= self.count {
            return nil
        }
        
        return self[i]
    }
    
    subscript(_ n: Int) -> Character {
        get {
            let idx = self.index(startIndex, offsetBy: n)
            
            return self[idx]
        }
        set {
            let idx = self.index(startIndex, offsetBy: n)
            
            self.replaceSubrange(idx...idx, with: [newValue])
        }
    }
}
