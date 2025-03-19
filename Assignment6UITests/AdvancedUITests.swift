/*
 * Copyright (C) 2022-2023 David C. Harrison. All right reserved.
 *
 * You may not use, distribute, publish, or modify this code without
 * the express written permission of the copyright holder.
 */

/*
 * The grading system does not simply check the pass/fail of these test; it also
 * checks the contents of the database after each excution to ensure correct
 * functionality.
 */

import XCTest

final class AdvancedUITests: XCTestCase {
  
  // Change these to your UCSC email, student number and name
  static private var email = "hdhillo3@ucsc.edu"
  static private var passwd = "1789850"

  private var app: XCUIApplication!

  override func setUpWithError() throws {
    try super.setUpWithError()
    continueAfterFailure = false
    app = XCUIApplication()
    app.launchEnvironment = ["animations": "0"]
    app.launch()
  }
  
  private func waitFor(_ element : XCUIElement, timeout: Double = 5.0) -> XCUIElement {
    let expectation = expectation(
      for: NSPredicate(format: "exists == true"),
      evaluatedWith: element,
      handler: .none
    )
    let _ = XCTWaiter.wait(for: [expectation], timeout: timeout)
    return element
  }
                   
  private func loginWill(_ email: String = "will@cse118.com", _ passwd: String = "will") {
    let field = app.textFields["EMail"]
    field.tap()
    field.typeText(email)
    let password = app.secureTextFields["Password"]
    waitFor(password).tap()
    password.typeText(passwd)
    waitFor(app.buttons["Login"]).tap()
  }
  
  private func login(_ email: String = email, _ passwd: String = passwd) {
    let field = app.textFields["EMail"]
    field.tap()
    field.typeText(email)
    let password = app.secureTextFields["Password"]
    waitFor(password).tap()
    password.typeText(passwd)
    waitFor(app.buttons["Login"]).tap()
  }
  
  /*
   TEST 1:
   * Log in
   * Add a workspace
   * Assert workspace exists
   */
  func testAddWorkspace() throws {
    login()
    app.navigationBars["Workspaces"].buttons["Reset"].tap()
    app.navigationBars["Workspaces"].buttons["New Workspace"].tap()
    let name = app.textFields["Name"]
    let content = "Test Workspace"
    name.tap()
    name.typeText(content)
    waitFor(app.buttons["OK"]).tap()
    XCTAssert(app.staticTexts[content].waitForExistence(timeout: 5))
  }
  
  /* Test 2:
   * Log in
   * Add a workspace
   * Press reset
   * Assert workspace no longer exists
   */
  func testAddWorkspaceThenReset() throws {
    login()
    app.navigationBars["Workspaces"].buttons["Reset"].tap()
    app.navigationBars["Workspaces"].buttons["New Workspace"].tap()
    let name = app.textFields["Name"]
    let content = "Test Workspace"
    name.tap()
    name.typeText(content)
    waitFor(app.buttons["OK"]).tap()
    waitFor(app.navigationBars["Workspaces"].buttons["Reset"]).tap()
    XCTAssertFalse(app.staticTexts[content].waitForExistence(timeout: 5))
  }
  
  /* Test 3:
   * Log in
   * Start to add a workspace
   * Cancel
   */
  func testTryAddWorkspaceThenCancel() throws {
    login()
    waitFor(app.navigationBars["Workspaces"].buttons["Reset"]).tap()
    waitFor(app.navigationBars["Workspaces"].buttons["New Workspace"]).tap()
    let name = app.textFields["Name"]
    let content = "Test Wor"
    name.tap()
    name.typeText(content)
    waitFor(app.buttons["Cancel"]).tap()
    XCTAssert(app.navigationBars["Workspaces"].staticTexts["Workspaces"].waitForExistence(timeout: 5))
  }
  
  /* Test 4:
   * Log in
   * Add a workspace
   * Assert workspace exists
   * Delete the workspace
   * Assert workspace does not exist
   */
  func testAddWorkspaceThenDelete() throws {
    let name = app.textFields["Name"]
    let content = "Test Workspace"
    login()
    waitFor(app.navigationBars["Workspaces"].buttons["Reset"]).tap()
    waitFor(app.navigationBars["Workspaces"].buttons["New Workspace"]).tap()
    name.tap()
    name.typeText(content)
    waitFor(app.buttons["OK"]).tap()
    XCTAssert(app.staticTexts[content].waitForExistence(timeout: 5))
    waitFor(app.collectionViews.buttons[content]).swipeLeft()
    app.collectionViews.buttons["Delete"].tap()
    XCTAssertFalse(app.staticTexts[content].waitForExistence(timeout: 5))
  }

  
  /* Test 5
   * Log in
   * Select a workspace
   * Add a channel
   * Assert channel exists
   */
  func testAddChannel() throws {
    let name = app.textFields["Name"]
    let content = "Test Channel"
    login()
    app.navigationBars["Workspaces"].buttons["Reset"].tap()
    waitFor(app.collectionViews.buttons["Student Workspace"]).tap()
    app.navigationBars["Student Workspace"].buttons["New Channel"].tap()
    app.textFields["Name"].tap()
    name.typeText(content)
    app.buttons["OK"].tap()
    XCTAssert(app.staticTexts[content].waitForExistence(timeout: 5))
  }
  
  
  /* Test 6
   * Log in
   * Select a workspace
   * Start to add a channel
   * Cancel
   */
  func testTryAddChannelThenCancel() throws {
    let name = app.textFields["Name"]
    let content = "Test Cha"
    login()
    app.navigationBars["Workspaces"].buttons["Reset"].tap()
    waitFor(app.collectionViews.buttons["Student Workspace"]).tap()
    app.navigationBars.buttons["New Channel"].tap()
    app.textFields["Name"].tap()
    name.typeText(content)
    app.buttons["Cancel"].tap()
    XCTAssert(app.navigationBars["Student Workspace"].staticTexts["Student Workspace"].waitForExistence(timeout: 5))
  }
  
  
  /* Test 7
   * Log in
   * Select a workspace
   * Add a channel
   * Assert channel exists
   * Delete the channel
   * Assert channel does not exist
   */
  func testAddChannelThenDelete() throws {
    let name = app.textFields["Name"]
    let content = "Test Channel"
    login()
    app.navigationBars["Workspaces"].buttons["Reset"].tap()
    waitFor(app.collectionViews.buttons["Student Workspace"]).tap()
    app.navigationBars["Student Workspace"].buttons["New Channel"].tap()
    app.textFields["Name"].tap()
    name.typeText(content)
    app.buttons["OK"].tap()
    XCTAssert(app.staticTexts[content].waitForExistence(timeout: 5))
    let channelButton =  app.collectionViews.buttons[content]
    channelButton.swipeLeft()
    app.collectionViews.buttons["Delete"].tap()
    XCTAssertFalse(app.staticTexts[content].waitForExistence(timeout: 5))

  }
  
  
  /* Test 8:
   * Log in
   * Add a workspace
   * Select the workspace
   * Add Molly Member and Anna Admin as members
   * Assert Molly and Anna are members of the workspace
   */
  func testAddMembersToWorkspace() throws {
    login()
    app.navigationBars["Workspaces"].buttons["Reset"].tap()
    let name = app.textFields["Name"]
    let content = "Test Workspace"
    let addMemberButton = app.navigationBars["Members"].buttons["Add Member"]
    app.navigationBars["Workspaces"].buttons["New Workspace"].tap()
    name.tap()
    name.typeText(content)
    app.buttons["OK"].tap()
    waitFor(app.collectionViews.buttons[content]).tap()
    app.navigationBars[content].buttons["Add Members"].tap()
    waitFor(addMemberButton).tap()
    app.collectionViews.staticTexts["Anna Admin"].swipeLeft()
    app.collectionViews.buttons["Add"].tap()
    waitFor(addMemberButton).tap()
    while !app.staticTexts["Molly Member"].exists {
      app.collectionViews.element.swipeUp()
    }
    app.collectionViews.staticTexts["Molly Member"].swipeLeft()
    app.collectionViews.buttons["Add"].tap()
    XCTAssert(app.staticTexts["Anna Admin"].waitForExistence(timeout: 5))
    XCTAssert(app.staticTexts["Molly Member"].waitForExistence(timeout: 5))
  }
  
  
  /* Test 9:
   * Log in
   * Add a workspace
   * Select the workspaca
   * Add William Shakespeare as a member
   * Assert Will is a member of the workspace
   * Remove Will as a member
   * Assert Will is no longer a member of the workspace
   */
  func testDeleteMembersFromWorkspace() throws {
    login()
    app.navigationBars["Workspaces"].buttons["Reset"].tap()
    let name = app.textFields["Name"]
    let content = "Test Workspace"
    let addMemberButton = app.navigationBars["Members"].buttons["Add Member"]
    waitFor(app.navigationBars["Workspaces"].buttons["New Workspace"]).tap()
    waitFor(name).tap()
    name.typeText(content)
    app.buttons["OK"].tap()
    waitFor(app.collectionViews.buttons[content]).tap()
    app.navigationBars[content].buttons["Add Members"].tap()
    waitFor(addMemberButton).tap()
    while !app.staticTexts["William Shakespeare"].exists {
      app.collectionViews.element.swipeUp()
    }
    app.collectionViews.staticTexts["William Shakespeare"].swipeLeft()
    app.collectionViews.buttons["Add"].tap()
    XCTAssert(app.staticTexts["William Shakespeare"].waitForExistence(timeout: 5))
    app.collectionViews.staticTexts["William Shakespeare"].swipeLeft()
    app.collectionViews.buttons["Delete"].tap()
    XCTAssertFalse(app.staticTexts["William Shakespeare"].waitForExistence(timeout: 5))
  }
    
  /* Test 10:
   * Log in
   * Add a workspace
   * Select the workspace
   * Add William Shakespeare as a member
   * Log out
   * Log in as will@cse118.com password "will"
   * Assert workspace is visiable
   */
  func testDeleteMembersFromWorkspaceAdvanced() throws {
    login()
    app.navigationBars["Workspaces"].buttons["Reset"].tap()
    let name = app.textFields["Name"]
    let content = "Test Workspace"
    let addMemberButton = app.navigationBars["Members"].buttons["Add Member"]
    waitFor(app.navigationBars["Workspaces"].buttons["New Workspace"]).tap()
    waitFor(name).tap()
    name.typeText(content)
    app.buttons["OK"].tap()
    app.collectionViews.buttons[content].tap()
    waitFor(app.navigationBars[content].buttons["Add Members"]).tap()
    waitFor(addMemberButton).tap()
    while !app.staticTexts["William Shakespeare"].exists {
      app.collectionViews.element.swipeUp()
    }
    app.collectionViews.staticTexts["William Shakespeare"].swipeLeft()
    app.collectionViews.buttons["Add"].tap()
    app.navigationBars["Members"].buttons["Test Workspace"].tap()
    app.navigationBars["Test Workspace"].buttons["Workspaces"].tap()
    app.navigationBars["Workspaces"].buttons["Logout"].tap()
    loginWill()
    XCTAssert(app.staticTexts[content].waitForExistence(timeout: 5))
  }
  
  /* Test 11:
   * Log in
   * Add a workspace
   * Select the workspace
   * Add William Shakespeare as a member
   * Add a channel
   * Log out
   * Log in as will@cse118.com password "will"
   * Select the workspace
   * Select the channel
   * Add a new message
   * Assert message is visible
   */
  func testAddChannelAndMessageAdvanced() throws {
    login()
    app.navigationBars["Workspaces"].buttons["Reset"].tap()
    let name = app.textFields["Name"]
    let messageName = app.textViews["Message"]
    let content = "Test Workspace"
    let content2 = "Test Channel"
    let addMemberButton = app.navigationBars["Members"].buttons["Add Member"]
    waitFor(app.navigationBars["Workspaces"].buttons["New Workspace"]).tap()
    waitFor(name).tap()
    name.typeText(content)
    app.buttons["OK"].tap()
    waitFor(app.collectionViews.buttons[content]).tap()
    waitFor(app.navigationBars[content].buttons["Add Members"]).tap()
    waitFor(addMemberButton).tap()
    while !app.staticTexts["William Shakespeare"].exists {
      app.collectionViews.element.swipeUp()
    }
    app.collectionViews.staticTexts["William Shakespeare"].swipeLeft()
    app.collectionViews.buttons["Add"].tap()
    waitFor(app.navigationBars["Members"].buttons["Test Workspace"]).tap()
    let testWorkspaceNavigationBar = app.navigationBars["Test Workspace"]
    testWorkspaceNavigationBar.buttons["New Channel"].tap()
    app.textFields["Name"].tap()
    name.typeText(content2)
    app.buttons["OK"].tap()
    waitFor(testWorkspaceNavigationBar.buttons["Workspaces"]).tap()
    app.navigationBars["Workspaces"].buttons["Logout"].tap()
    loginWill()
    app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Test Workspace"]/*[[".cells",".buttons[\"Test Workspace, 1\"]",".buttons[\"Test Workspace\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
    waitFor(app.collectionViews.buttons[content2]).tap()
    app.navigationBars.buttons["New Message"].tap()
    app.textViews["Message"].tap()
    messageName.typeText("This is a test message")
    app.buttons["OK"].tap()
    XCTAssert(app.staticTexts["This is a test message"].waitForExistence(timeout: 5))
  }
  
  /* Test 12
   * Log in
   * Add a workspace
   * Select the workspace
   * Add William Shakespeare as a member
   * Add a channel
   * Add a new message
   * Log out
   * Log in as will@cse118.com password "will"
   * Select the workspace
   * Select the channel
   * Assert message cannot be deleted
   */
  func testAddChannelAndDeleteMessagePermission() throws {
    login()
    app.navigationBars["Workspaces"].buttons["Reset"].tap()
    let name = app.textFields["Name"]
    let messageName = app.textViews["Message"]
    let content = "Test Workspace"
    let content2 = "Test Channel"
    let addMemberButton = app.navigationBars["Members"].buttons["Add Member"]
    app.navigationBars["Workspaces"].buttons["New Workspace"].tap()
    name.tap()
    name.typeText(content)
    app.buttons["OK"].tap()
    waitFor(app.collectionViews.buttons[content]).tap()
    app.navigationBars[content].buttons["Add Members"].tap()
    addMemberButton.tap()
    while !app.staticTexts["William Shakespeare"].exists {
      app.collectionViews.element.swipeUp()
    }
    app.collectionViews.staticTexts["William Shakespeare"].swipeLeft()
    waitFor(app.collectionViews.buttons["Add"]).tap()
    waitFor(app.navigationBars["Members"].buttons["Test Workspace"]).tap()
    let testWorkspaceNavigationBar = app.navigationBars["Test Workspace"]
    testWorkspaceNavigationBar.buttons["New Channel"].tap()
    app.textFields["Name"].tap()
    name.typeText(content2)
    app.buttons["OK"].tap()
    app.collectionViews.buttons[content2].tap()
    app.navigationBars.buttons["New Message"].tap()
    app.textViews["Message"].tap()
    messageName.typeText("Test")
    app.buttons["OK"].tap()
    app.navigationBars[content2].buttons[content].tap()
    app.navigationBars[content].buttons["Workspaces"].tap()
    app.navigationBars["Workspaces"].buttons["Logout"].tap()
    loginWill()
    waitFor(app.collectionViews.buttons["Test Workspace"]).tap()
    waitFor(app.collectionViews.buttons[content2]).tap()
    waitFor(app.staticTexts["Test"]).swipeLeft()
    XCTAssertFalse(app.buttons["Delete"].exists)
  }
  
}
