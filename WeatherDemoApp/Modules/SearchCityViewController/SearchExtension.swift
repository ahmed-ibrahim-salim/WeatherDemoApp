//
//  SearchExtension.swift
//  WeatherDemoApp
//
//  Created by ahmed on 04/04/2024.
//

import UIKit

// MARK: SearchBar delegates
extension SearchCityViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let whiteSpaceChar = CharacterSet.whitespaces

        // allowing white space in between chars, but not at the begining
        if let _ = text.rangeOfCharacter(from: whiteSpaceChar),
           let searchText = searchBar.text,
            searchText.isEmpty {
            return true
        }
        
        let returnKeyChar = CharacterSet(charactersIn: "\n")
        
//      allowing check if char passed is return key, so i can dismiss keyboard
        if text.rangeOfCharacter(from: returnKeyChar) != nil {
            return true
        }
        
        let allowedCharcters = CharacterSet.alphanumerics

        // allowing only Letters and numbers
        guard text.rangeOfCharacter(from: allowedCharcters) != nil else {
            return false
        }
        
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        // when search text is empty
        if searchText.isEmpty {
            self.perform(#selector(startSendingText))
        }

    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // dismiss keyboard & keep search text
        // sending search text when clicked search
        self.perform(#selector(startSendingText))
        
        searchBar.resignFirstResponder()
        
    }
}
