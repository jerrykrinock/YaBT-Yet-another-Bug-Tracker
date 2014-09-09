YaBT-Yet-another-Bug-Tracker
============================

Core Data demo project which shows the latest techniques for Concurrency in Core Data, with 3 levels of
parent/child managed object contexts.  When you run the project, you will see simulated "Product" objects
being added, as if from the network, every 20 seconds.  Requires Xcode 6+, iOS 8 SDK.

The file FakeData.sqlite is *built* by the MakeFakeDB target and is not included in the repository.
It is required as a resource to build the YaBT app target.  Therefore, you need to build and run the
MakeFakeDB target once, before the YaBT iOS app target will build.

This project will be discussed at a Meetup at Sandbox Suites, 888 E. Arques Ave. Sunnyvale CA on Tuesday
Sept 9 2014 at 7:00 PM.  I'll probably make a few more commits between now and then :)
