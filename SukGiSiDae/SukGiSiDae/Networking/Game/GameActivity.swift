//
//  GameActivity.swift
//  SukGiSiDae
//

import Foundation
import GroupActivities

struct GameActivity: GroupActivity {
    var metadata: GroupActivityMetadata {
        var metadata = GroupActivityMetadata()
        metadata.title = NSLocalizedString("Suk_Gi_Si_Dae", comment: "Title of group activity")
        metadata.type = .generic
        return metadata
    }
}
