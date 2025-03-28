import Foundation

func onMain(execute: @escaping Closure.Void) {
    DispatchQueue.main.async(execute: execute)
}

func onMainAfter(deadline: DispatchTime, execute: @escaping Closure.Void) {
    DispatchQueue.main.asyncAfter(deadline: deadline, execute: execute)
}
