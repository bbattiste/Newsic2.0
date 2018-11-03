//
//  Constants.swift
//  Newsic
//
//  Created by Bryan's Air on 10/25/18.
//  Copyright © 2018 Bryborg Inc. All rights reserved.
//

import Foundation
import UIKit

// Mark: Constants
struct Constants {
    
    // MARK: Spotify
    struct Spotify {
        static let ApiScheme = "https"
        static let ApiHost = "accounts.spotify.com"
        static let ApiPath = "/authorize/"
    }
    
    // MARK: Spotify Parameter Keys
    
    struct SpotifyParameterKeys {
        static let ClientID = "client_id"
        static let ResponseType = "response_type"
        static let Redirect_URI = "redirect_uri"
        static let State = "state" // optional
        static let Scope = "scope" // optional
        static let ShowDialog = "show_dialog" // optional
    }
    
    
    // MARK: Spotify Parameter Values
    struct SpotifyParameterValues {
        static let ClientID = "e1371bdcd3b44517ba13621776d0ba42"
        static let ClientSecret = "5301b601351a4b5c8dad81aebf462159"
        static let ResponseType = "code"
        static let Redirect_URI = NSURL(string: "newsic://")
        static let State = "" // optional
        static let Scope = "" // optional
        static let ShowDialog = "" // optional
        static var Username = ""
        static var Password = ""
    }
    
    
    
    //---------------------------------------
    //// Ideas for constants
    //
    //    // MARK: Udacity
    //    struct Udacity {
    //        static let ApiScheme = "https"
    //        static let ApiHost = "www.udacity.com"
    //        static let ApiPath = "/api/session"
    //    }
    //
    //    // MARK: Udacity Parameter Keys
    //    struct UdacityParameterKeys {
    //        static let Dictionary = "udacity"
    //        static let Username = "username"
    //        static let Password = "password"
    //        static let ApplicationIDKey = "X-Parse-Application-Id"
    //        static let ApiKey = "X-Parse-REST-API-Key"
    //    }
    //
    //    // MARK: Flickr Parameter Keys
    //    struct FlickrParameterKeys {
    //        static let Method = "method"
    //        static let APIKey = "api_key"
    //        static let GalleryID = "gallery_id"
    //        static let Extras = "extras"
    //        static let Format = "format"
    //        static let NoJSONCallback = "nojsoncallback"
    //        static let SafeSearch = "safe_search"
    //        static let Text = "text"
    //        static let BoundingBox = "bbox"
    //        static let Page = "page"
    //    }
    //
    //    // MARK: Udacity Parameter Values
    //    struct UdacityParameterValues {
    //        static let ApiKeyValue = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    //        static let ApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    //        static var Username = ""
    //        static var Password = ""
    //    }
    //
    //    // MARK: Flickr Parameter Values
    //    struct FlickrParameterValues {
    //        static let SearchMethod = "flickr.photos.search"
    //        static let APIKey = "f9d0262f06a020df2e458a3d7c4b07a2"
    //        static let ResponseFormat = "json"
    //        static let DisableJSONCallback = "1" /* 1 means "yes" */
    //        static let GalleryPhotosMethod = "flickr.galleries.getPhotos"
    //        static let GalleryID = "5704-72157622566655097"
    //        static let MediumURL = "url_m"
    //        static let UseSafeSearch = "1"
    //    }
    //
    //    // MARK: Udacity Response Values
    //    struct UdacityResponseValues {
    //        static var AccountKey = "" // Udacity AccountKey is Parse UniqueKey
    //    }
    //
    //    // MARK: Flickr Response Keys
    //    struct FlickrResponseKeys {
    //        static let Status = "stat"
    //        static let Photos = "photos"
    //        static let Photo = "photo"
    //        static let Title = "title"
    //        static let MediumURL = "url_m"
    //        static let Pages = "pages"
    //        static let Total = "total"
    //    }
    //
    //    // MARK: Flickr Response Values
    //    struct FlickrResponseValues {
    //        static let OKStatus = "ok"
    //    }
    
}


/*
 example request:
 GET https :// accounts.spotify.com/authorize /?
 client_id=5fe01282e44241328a84e7c5cc169165&
 response_type=code&
 redirect_uri=https%3A%2F%2Fexample.com%2Fcallback&
 scope=user-read-private%20user-read-email&
 state=34fFs29kd09
 
 If the user accepts your request:
 https :// example.com/callback?
 code=NApCCg..BkWtQ&
 state=profile%2Factivity
 
 If the user does not accepted your request or an error has occurred:
 https :// example.com/callback?
 error=access_denied&
 state=STATE
 
 -------------------------
 GET Request
 QUERY PARAMETER    VALUE
 
 -client_id    Required.
 When you register your application, Spotify provides you a Client ID.
 
 -response_type    Required.
 Set to code.
 
 -redirect_uri    Required.
 The URI to redirect to after the user grants or denies permission. This URI needs to have been entered in the Redirect URI whitelist that you specified when you registered your application. The value of redirect_uri here must exactly match one of the values you entered when you registered your application, including upper or lowercase, terminating slashes, and such.
 
 -state    Optional, but strongly recommended.
 The state can be useful for correlating requests and responses. Because your redirect_uri can be guessed, using a state value can increase your assurance that an incoming connection is the result of an authentication request. If you generate a random string, or encode the hash of some client state, such as a cookie, in this state variable, you can validate the response to additionally ensure that both the request and response originated in the same browser. This provides protection against attacks such as cross-site request forgery. See RFC-6749.
 
 -scope    Optional.
 A space-separated list of scopes.If no scopes are specified, authorization will be granted only to access publicly available information: that is, only information normally visible in the Spotify desktop, web, and mobile players.
 
 -show_dialog    Optional.
 Whether or not to force the user to approve the app again if they’ve already done so. If false (default), a user who has already approved the application may be automatically redirected to the URI specified by redirect_uri. If true, the user will not be automatically redirected and will have to approve the app again.
 
 -------------------------
 If the user accepts your request
 
 QUERY PARAMETER    VALUE
 -code    An authorization code that can be exchanged for an access token.
 -state    The value of the state parameter supplied in the request.
 
 -------------------------
 If the user does not accepted your request or an error has occurred
 
 QUERY PARAMETER    VALUE
 -error    The reason authorization failed, for example: “access_denied”
 -state    The value of the state parameter supplied in the request.
 
 */

