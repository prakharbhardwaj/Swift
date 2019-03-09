//
//  MockCodeReader.swift
//  AVFoundationQRcodeTests
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit
@testable import AVFoundationQRcode


class MockCodeReader: CodeReader {
    private(set) var videoPreview = CALayer()
    var completion: ((CodeReadResult) -> Void)?
    
    func startReading(completion: @escaping (CodeReadResult) -> Void) {
        self.completion = completion
    }
    
    func stopReading() {
    }
}
