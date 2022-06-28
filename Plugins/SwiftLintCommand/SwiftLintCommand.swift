//
//  SwiftLintPlugin.swift
//  
//
//  Created by Quentin Fasquel on 24/04/2022.
//

import PackagePlugin
import Foundation

@main
struct SwiftLintCommand: CommandPlugin {

    func performCommand(context: PackagePlugin.PluginContext, arguments: [String]) async throws {
        let swiftlintPath = try context.tool(named: "swiftlint").path
        let swiftlint = URL(fileURLWithPath: swiftlintPath.string)
        var args = arguments
        args += ["--in-process-sourcekit", "--strict"]
        let process = try Process.run(swiftlint, arguments: args)
        process.waitUntilExit()
        
        if process.terminationReason == .exit && process.terminationStatus == 0 {
            print("Lint checks passed")
        }
        else {
            let problem = "\(process.terminationReason):\(process.terminationStatus)"
            Diagnostics.error("Linting error: \(problem)")
        }
    }
}
