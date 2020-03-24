//
//  ContentView.swift
//  PreviewScreenshotSample
//
//  Created by Takuya Yokoyama on 2020/03/24.
//  Copyright © 2020 Takuya Yokoyama. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Rectangle()
    }
}

struct ContentView_Previews: PreviewProvider {
    enum Context: String, Previewable {
        case red
        case green
        case blue
        
        var preview: some View {
            switch self {
            case .red:
                return ContentView()
                    .foregroundColor(.red)
            case .green:
                return ContentView()
                    .foregroundColor(.green)
            case .blue:
                return ContentView()
                    .foregroundColor(.blue)
            }
        }
    }
    
    static var previews: some View {
        Context.groupedAllContext
    }
}

protocol Previewable: CaseIterable, Hashable, RawRepresentable {
    associatedtype Preview: View
    var preview: Preview { get }
}

extension Previewable where Self.AllCases: RandomAccessCollection, Self.RawValue == String {
    static var groupedAllContext: some View {
        Group {
            ForEach(Self.allCases, id: \.self) {
                $0.preview.previewDisplayName($0.rawValue)
            }
        }
    }

    static var stackedAllContext: some View {
        VStack {
            ForEach(Self.allCases, id: \.self) {
                $0.preview.previewDisplayName($0.rawValue)
            }
        }
    }
}
