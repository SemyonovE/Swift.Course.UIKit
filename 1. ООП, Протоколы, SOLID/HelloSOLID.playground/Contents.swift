
// MARK: 1. The Single Responsibility Principle
/// A class should have one, and only one, reason to change.

// MARK: 2. The Open Closed Principle
/// You should be able to extend a classes behavior, without modifying it.

// MARK: 3. The Liskov Substitution Principle
/// Derived classes must be substitutable for their base classes.

// MARK: 4. The Interface Segregation Principle
/// Make fine grained interfaces that are client specific.

// MARK: 5. The Dependency Inversion Principle
/// Depend on abstractions, not on concretions.

// MARK: - PROTOCOLS -

// The Interface Segregation Principle
protocol TurningOn {
    func turnOn()
}

protocol TurningOff {
    func turnOff()
}

protocol Executable {
    func execute()
}

// MARK: - ENTITIES -

class Device {
    
    private enum State {
        case on, off
    }
    
    private var state: State = .off
    
    func turnOn() {
        state = .on
    }
    
    func turnOff() {
        state = .off
    }
}

class Radio: Device, TurningOn, TurningOff {

    override func turnOn() {
        super.turnOn()
        print("Radio turned on")
        print("On wave: Pshhhhhh")
    }
    
    override func turnOff() {
        super.turnOff()
        print("Radio turned off")
    }
}

class Computer: Device, TurningOn, TurningOff {

    override func turnOn() {
        super.turnOn()
        print("Computer turned on")
        print("Motherboard: Pip")
    }
    
    override func turnOff() {
        super.turnOff()
        print("Computer turned off")
    }
}

class Supercomputer: Computer {
    
    // The Liskov Substitution Principle
    override func turnOn() {
        print("Start cooling system: pshhhh")
        print("Supercomputer as", terminator: " ")
        super.turnOn()
    }
}

class PerpetualEngine: Device, TurningOn {

    override func turnOn() {
        super.turnOn()
        print("Perpetual engine turned on")
        print("Engine: Vrrrrrr")
    }
    
    override func turnOff() {
        print("Can't stop!")
    }
}


// The Single Responsibility Principle
final class OnSwitcher: Executable {
    
    // The Dependency Inversion Principle
    private let device: TurningOn
    
    init(device: TurningOn) {
        self.device = device
    }
    
    func execute() {
        device.turnOn()
    }
}

// The Single Responsibility Principle
final class OffSwitcher: Executable {
    
    // The Dependency Inversion Principle
    private let device: TurningOff
    
    init(device: TurningOff) {
        self.device = device
    }
    
    func execute() {
        device.turnOff()
    }
}

class CommandPanel {
    
    // The Dependency Inversion Principle
    var commands: [Executable]
    
    init(commands: [Executable]) {
        self.commands = commands
    }
    
    // The Open Closed Principle
    func execute() {
        commands.forEach { $0.execute() }
    }
}

CommandPanel(commands: [
    OnSwitcher(device: Computer()),
    OnSwitcher(device: Radio()),
    OnSwitcher(device: Supercomputer()),
    OnSwitcher(device: PerpetualEngine())
]).execute()

print("---------")

CommandPanel(commands: [
    OnSwitcher(device: Computer()),
    OffSwitcher(device: Computer()),
    OnSwitcher(device: PerpetualEngine())
]).execute()

print("---------")

// The Dependency Inversion Principle
let devicesForLaunch: [TurningOn] = [Computer(), Radio(), Supercomputer(), PerpetualEngine()]

devicesForLaunch.forEach { $0.turnOn() }


// Other:
// DRY – Don’t repeat yourself
// KISS – keep it short simple
// YAGNI — You ain’t gonna need it
