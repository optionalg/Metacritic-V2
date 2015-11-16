//
//  String.swift
//  Metacritic-V2
//
//  Created by Ajay Raj on 12/11/2015.
//  Copyright (c) 2015 Ajay Raj. All rights reserved.
//

extension String{
    public func indexOfCharacter(char: Character) -> Int? {
        if let idx = find(self, char) {
            return distance(self.startIndex, idx)
        }
        return nil
    }
}
