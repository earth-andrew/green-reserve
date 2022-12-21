extensions [bitmap csv]



breed [borders border]
breed [raindrops raindrop]
breed [grassBars grassBar]
breed [grassTicks grassTick]
breed [animals animal]
breed [people person]
breed [scorecards scorecard]
breed [blocks block]
breed [phaseMarkers phaseMarker]
breed [currentMarkers currentMarker]
breed [herdLines herdLine]
breed [herdCrosses herdCross]
breed [pathCrosses pathCross]
breed [permCrosses permCross]
breed [permChecks permCheck]
breed [dayBoxes dayBox]
breed [restIcons restIcon]
breed [moveIcons moveIcon]
breed [workIcons workIcon]
breed [connections connection]
breed [pointers pointer]
breed [bales bale]
breed [pendingSquares pendingSquare]
breed [panelEdges panelEdge]
breed [displayElements displayElement]





turtles-own [avatar? viewer startTurnPatch projection? currentStep? arrivedOn owner herd]
people-own [ active?  schedule personID ]
patches-own [inGame? selected? selectedBy ownedBy viewedBy? shared? pastureGrowth playerHerdCountHere storedGrass]
animals-own [  age consumptionHistory state herdNumber herdedBy]
herdCrosses-own [slot ]
pathCrosses-own [pathOwner]
scorecards-own [identity playerNumber]
blocks-own [identity playerNumber]
phaseMarkers-own [identity]
currentMarkers-own [identity]
dayBoxes-own [day state]
restIcons-own [day ID]
moveIcons-own [day ID]
workIcons-own [day ID]
pointers-own [pathOf]
connections-own [pathOf]
pendingSquares-own [permissions pathOf]
displayElements-own [phase rain? toggle? seenBy]


globals [
  testerVar
  numPlayers
  playerHHID
  playerConfirm
  playerShortNames
  playerNames
  playerPosition
  playerHerds
  playerCalves
  playerScores
  messageAddressed
  parameterHandled
  gameInProgress
  langSuffix
  numPatches
  currentYear
  currentPhase
  phasePasture
  choosingSharedLand
  choosingPrivateLand
  playerTempCalves
  playerTempHerds
  initialHerdSize
  numHH
  numStates
  moveID
  workID
  restID

  ;;visualization parameters and variables
  playerHerdColor
  playerChoosingMove
  colorList
  patchesPerInfoLine
  rgb_R
  rgb_G
  rgb_B
  border_color
  herdFracLoc
  herdPixLoc
  herdPatchLoc
  herdTile
  otherLabelFracLoc
  otherLabelPixLoc
  otherLabelPatchLoc
  otherLabelTile
  unassignedLabelFracLoc
  unassignedLabelPixLoc
  unassignedLabelPatchLoc
  unassignedLabelTile
  confirmFracLoc
  confirmPixLoc
  confirmPatchLoc
  confirmTile
  pasturePlusTile
  greenBoxTile
  assignedHerdFracLoc
  assignedHerdPixLoc
  assignedHerdPatchLoc
  unassignedHerdFracLoc
  unassignedHerdPixLoc
  unassignedHerdPatchLoc
  otherHerdFracLoc
  otherHerdPixLoc
  otherHerdPatchLoc
  pasturePlusFracLoc
  pasturePlusPixLoc
  PasturePlusPatchLoc
  x_pixels
  y_pixels
  x_panel_pixels
  pixelsPerPatch
  patchAnimalSize
  panelAnimalSize
  patchPersonSize
  panelPersonSize
  panelFracHerdCrossSize
  panelHerdCrossSize
  panelFracPersonSize
  selectedShading
  playerViewingPatch
  dayBoxFracLoc
  dayBoxPixLoc
  dayBoxPatchLoc
  toggleFracLoc
  togglePixLoc
  togglePatchLoc
  panelDayBoxSize
  dayDistanceShading
  projectionColorShift
  patchPointerSize
  patchBaleSize
  rainBoxPatchLoc
  climBoxPatchLoc
  displayRainBoxSize
  displayRaindropSize
  grassLabelFracLoc
  grassLabelPixLoc
  grassLabelPatchloc
  grassLabelTile
  grassBarFracLoc
  grassBarPixLoc
  grassBarPatchloc
  grassBarTickSpace
  grassBarSquareSpace
  raindropMaxLength
  raindropHeading
  raindropsPerSquareMax
  permCheckCrossScalar
  permCheckCrossOffset


  ;;variables related to parsing parameter input
  inputFileLabels
  completedGamesIDs
  parsedInput
  currentSessionParameters
  gameTag
  sessionList

  ;;parameters to be set by input file
  numYears
  numPhases
  hasChoosingShared?
  hasChoosingPrivate?
  maxPrivateSquares
  gameName
  phaseLengthDays
  initialScore
  probDeathPoor
  probDeathOk
  probDeathGood
  grassR
  grassK
  grassE0
  grassPhaseList
  climList
  phaseList
  pastGrassList
  calfNeeds
  animalNeeds
  downThreshold
  upThreshold
  grassUndergroundFraction
  baseSquaresPerDay
  fracBaseSlowPerAnimal
  pS_base
  HpA_base
  dP_dHpA
  dP_dfNeeds
  needsDays
  harvest_day
  maxColorRain
  showToggleButton
  hasForage?
  ]

to start-hubnet

  ;; clean the slate
  clear-all
  hubnet-reset

  ;; set all session variables that are preserved across games
  set playerNames (list)
  set playerShortNames (list)
  set playerHHID (list)
  set playerPosition (list)
  set playerHerdColor (list)
  set numPlayers 0
  set gameInProgress 0
  set-default-shape animals "sheep 2"
  set-default-shape scorecards "blank"
  set-default-shape blocks "square"
  set-default-shape phaseMarkers "square"
  set-default-shape currentMarkers "square outline"
  set-default-shape borders "line"
  set-default-shape herdLines "line"
  set-default-shape people "person"
  set-default-shape herdCrosses "x"
  set-default-shape pathCrosses "x"
  set-default-shape permCrosses "x"
  set-default-shape permChecks "check"
  set-default-shape dayBoxes "square outline"
  set-default-shape restIcons "person resting"
  set-default-shape moveIcons "person walking"
  set-default-shape workIcons "person cutting"
  set-default-shape connections "line"
  set-default-shape bales "hay"
  set-default-shape pendingSquares "square outline"
  set-default-shape panelEdges "bar"
  set-default-shape raindrops "line"


  set x_pixels 1080
  set y_pixels 720
  set x_panel_pixels 360
  set selectedShading 0.8
  set dayDistanceShading 0.12
  set projectionColorShift 3

  set patchAnimalSize 0.1
  set patchBaleSize 0.15
  set panelAnimalSize 0.3
  set patchPersonSize 0.25
  set panelFracPersonSize 0.13
  set panelFracHerdCrossSize 0.05
  set panelDayBoxSize 0.6
  set patchPointerSize 0.3
  set displayRainBoxSize 0.6
  set displayRaindropSize 2
  set restID 1
  set moveID 2
  set workID 3
  set grassBarTickSpace 10 ;; 'animal-days' of grass
  set grassBarSquareSpace 0.05 ;; patch spacing of squares making up 'bar'
  set raindropMaxLength 0.5 ;;
  set raindropHeading 30 ;;
  set raindropsPerSquareMax 10 ;;

  set permCheckCrossScalar 1.2 ;;times
  set permCheckCrossOffset 0.25 ;;patches

  set rgb_G 100
  set rgb_B 0
  set rgb_R 150
  set border_color 5
  set colorList (list 95 15 25 115 125 5 135 93 13 23 113 123 3 133 98 18 28 118 128 8 138)  ;; add to this if you will have more than 21 players, but really, you shouldn't!!!

  ;; clear anything from the display, just in case
  clear-ticks
  clear-patches
  clear-turtles
  clear-drawing

  ;; try to read in the input parameter data - stop if the file doesn't exist
  if not file-exists? inputParameterFileName [ ;;if game parameter file is incorrect
    user-message "Please enter valid file name for input data"
    stop
  ]

  ;; open the file and read it in line by line
  set parsedInput csv:from-file inputParameterFileName
  set inputFileLabels item 0 parsedInput
  set sessionList []
  foreach but-first parsedInput [ ?1 -> set sessionList lput (item 0 ?1) sessionList ]
  set sessionList remove-duplicates sessionList

  ;; look in the list of completed game IDs, and take an initial guess that the session of interest is one higher than the highest session completed previously
  set completedGamesIDs []
  ifelse file-exists? "completedGames.csv" [
  file-open "completedGames.csv"
  while [not file-at-end?] [
    let tempValue file-read-line
    set completedGamesIDs lput read-from-string substring tempValue 0 position "_" tempValue completedGamesIDs
  ]
  set completedGamesIDs remove-duplicates completedGamesIDs
  set sessionID max completedGamesIDs + 1
  file-close
  ] [
  set sessionID -9999
  ]



  set currentSessionParameters []

end

to initialize-session

  ;; stop if we are currently in a session
  if (length currentSessionParameters > 0)
  [user-message "Current session is not complete.  Please continue current session.  Otherwise, to start new session, please first clear settings by clicking 'Launch Broadcast'"
    stop]

  ;; if the session requested isn't in our input parameters, stop
  if (not member? sessionID sessionList)
  [user-message "Session ID not found in input records"
    stop]

  ;; if the session requested has prior game data available, let the user know
  if (member? sessionID completedGamesIDs)
  [user-message "Warning: At least one game file with this sessionID has been found"]

  ;; pick the appropriate set of parameters for the current session from the previously parsed input file (i.e., all games listed as part of session 1)
  set currentSessionParameters filter [ ?1 -> item 0 ?1 = sessionID ] parsedInput

end

to set-game-parameters

  ;; this procedure takes the list of parameters names and values and processes them for use in the current game

  ;; take the current game's set of parameters
  let currentGameParameters item 0 currentSessionParameters
  set currentSessionParameters sublist currentSessionParameters 1 length currentSessionParameters

  ;; there are two lists - one with variable names, one with values
  (foreach inputFileLabels currentGameParameters [ [?1 ?2] -> ;; first element is variable name, second element is value

    ;; we use a 'parameter handled' structure to avoid having nested foreach statements
    set parameterHandled 0

    ;; if it's the game id, set the game tag as being a practice (if it's 0) or game number otherwise
    if ?1 = "gameID" and parameterHandled = 0[
      ifelse ?2 = 0 [ set gameTag "GP" output-print (word "Game: GP") file-print (word "Game: GP")] [ set gameTag (word "G" ?2) output-print (word "Game: G" ?2) file-print (word "Game: G" ?2)]
      output-print " "
      output-print " "
      output-print "Relevant Game Parameters:"
      output-print " "
      file-print (word ?1 ": " ?2 )
      set parameterHandled 1
    ]

    ;; add any particular cases for parameter handling here

    ;;;;;;;;;;;;;;;
    ;;EXAMPLE
    ;;;;;;;;;;;;;;;
    ;; if there is a list of grass growth (i.e., evapotranspiration) structures, read in as below
    if length ?1 >= 6 [
      if substring ?1 0 6 = "grass_" [

        let grassNumber read-from-string substring ?1 6 (length ?1)
        let numGrassSoFar length grassPhaseList
        while [numGrassSoFar < grassNumber] [
          set grassPhaseList lput 0 grassPhaseList
          set numGrassSoFar numGrassSoFar + 1
        ]
        set grassPhaseList replace-item (grassNumber - 1) grassPhaseList ?2



        ; set parameter handled
        output-print (word ?1 ": " ?2 )
        file-print (word ?1 ": " ?2 )
        set parameterHandled 1
      ]
    ]

;; if there is a list of 'typical' climate , read in as below
    if length ?1 >= 5 [
      if substring ?1 0 5 = "clim_" [
        let climNumber read-from-string substring ?1 5 (length ?1)
        let numClimSoFar length climList
        while [numClimSoFar < climNumber] [
          set climList lput 0 climList
          set numClimSoFar numClimSoFar + 1
        ]
        set climList replace-item (climNumber - 1) climList ?2

        ; set parameter handled
        output-print (word ?1 ": " ?2 )
        file-print (word ?1 ": " ?2 )
        set parameterHandled 1
      ]
    ]


    ;; if there is a list of phase structures, read in as below
    if length ?1 >= 6 [
      if substring ?1 0 6 = "phase_" [
        let phaseNumber read-from-string substring ?1 6 (length ?1)
        let numPhaseSoFar length phaseList
        while [numPhaseSoFar < phaseNumber] [
          set phaseList lput 0 phaseList
          set phasePasture lput 0 phasePasture
          set numPhaseSoFar numPhaseSoFar + 1
        ]
        set phaseList replace-item (phaseNumber - 1) phaseList ?2

        let currentString ?2
        let stringHandled? false
        while [length currentString > 0] [

          ;;add here code to pull out other particular phase elements
          if first currentString = "P" and not stringHandled? [
            set phasePasture replace-item (phaseNumber - 1) phasePasture 1
            set stringHandled? true
          ]

          set currentString but-first currentString
          ]

        ; set parameter handled
        output-print (word ?1 ": " ?2 )
        file-print (word ?1 ": " ?2 )
        set parameterHandled 1
      ]
    ]

    ;; all other cases not specified above are handled as below - the parameter of the same name is set to the specified value
    if parameterHandled = 0 [  ;; any other case
      output-print (word ?1 ": " ?2 )
      file-print (word ?1 ": " ?2 )
      let currentParameter (word "set " ?1 " " ?2 )
      run currentParameter
    ]
  ])
  file-print ""

  output-print " "
  output-print " "

end

to set-language

  if language = "English" [ set langSuffix "en"]

  ;;LOAD IN THE LANGUAGE TILES BASED ON LANGUAGE SELECTION

  ;;The following code fixes the locations and sizes of the in-game text.  It was optimized to an 50 x 50 box with a patch size of 14 pixels, for use with a Dell Venue 8 as a client.
  ;;The structure of the location variables is [xmin ymin width height].  They have been 'converted' to scale with a changing patch size and world size, but this is not widely tested

  let yConvertPatch (numPatches / y_pixels)  ;;scaling vertical measures based on the currently optimized size of 50
  let xyConvertPatchPixel (patch-size / pixelsPerPatch)  ;; scaling vertical and horizontal measures based on currently optimized patch size of 14

  ;;SPECIFY PLACEMENT IN TERMS OF THE FRACTION OF THE PANEL, STARTING FROM UPPER LEFT, AS [Xorigin Yorigin Width Height]

  ;;;;;;;;;;;;;;
  ;;EXAMPLE OF LABEL IMAGE PLACEMENT
  ;;;;;;;;;;;;;;
  set greenBoxTile bitmap:import (word "./image_label/green_box"  ".png")
  set confirmTile bitmap:import (word "./image_label/confirm_" langSuffix ".png")
  set herdTile bitmap:import (word "./image_label/herds_" langSuffix ".png")
  set grassLabelTile bitmap:import (word "./image_label/grass_" langSuffix ".png")
  set otherLabelTile bitmap:import (word "./image_label/other_animals_" langSuffix ".png")
  set unassignedLabelTile bitmap:import (word "./image_label/unassigned_animals_" langSuffix ".png")
  set pasturePlusTile bitmap:import (word "./image_label/plus_active" ".png")

  set herdFracLoc (list 0.2 0.22 0.3 0.1) ;;fraction of height and width of panel
  set herdPixLoc convertFracPix herdFracLoc
  set herdPatchLoc convertPixPatch herdPixLoc
  bitmap:copy-to-drawing (bitmap:scaled herdTile (item 2 herdPixLoc) (item 3 herdPixLoc)) (item 0 herdPixLoc) (item 1 herdPixLoc)

  set grassLabelFracLoc (list 0.58 0.155 0.3 0.1) ;;fraction of height and width of panel
  set grassLabelPixLoc convertFracPix grassLabelFracLoc
  set grassLabelPatchLoc convertPixPatch grassLabelPixLoc
  bitmap:copy-to-drawing (bitmap:scaled grassLabelTile (item 2 grassLabelPixLoc) (item 3 grassLabelPixLoc)) (item 0 grassLabelPixLoc) (item 1 grassLabelPixLoc)


  set unassignedLabelFracLoc (list 0.2 0.48 0.6 0.1) ;;fraction of height and width of panel
  set unassignedLabelPixLoc convertFracPix unassignedLabelFracLoc
  set unassignedLabelPatchLoc convertPixPatch unassignedLabelPixLoc
  bitmap:copy-to-drawing (bitmap:scaled unassignedLabelTile (item 2 unassignedLabelPixLoc) (item 3 unassignedLabelPixLoc)) (item 0 unassignedLabelPixLoc) (item 1 unassignedLabelPixLoc)

  set otherLabelFracLoc (list 0.2 0.65 0.5 0.1) ;;fraction of height and width of panel
  set otherLabelPixLoc convertFracPix otherLabelFracLoc
  set otherLabelPatchLoc convertPixPatch otherLabelPixLoc
  bitmap:copy-to-drawing (bitmap:scaled otherLabelTile (item 2 otherLabelPixLoc) (item 3 otherLabelPixLoc)) (item 0 otherLabelPixLoc) (item 1 otherLabelPixLoc)

  set confirmFracLoc (list 0.55 0.025 0.4 0.08) ;;fraction of height and width of panel
  set confirmPixLoc convertFracPix confirmFracLoc
  set confirmPatchLoc convertPixPatch confirmPixLoc
  bitmap:copy-to-drawing (bitmap:scaled confirmTile (item 2 confirmPixLoc) (item 3 confirmPixLoc)) (item 0 confirmPixLoc) (item 1 confirmPixLoc)

  set assignedHerdFracLoc (list 0.2 0.29 0.7 0.2) ;;fraction of height and width of panel
  set assignedHerdPixLoc convertFracPix assignedHerdFracLoc
  set assignedHerdPatchLoc convertPixPatch assignedHerdPixLoc
  bitmap:copy-to-drawing (bitmap:scaled greenBoxTile (item 2 assignedHerdPixLoc) (item 3 assignedHerdPixLoc)) (item 0 assignedHerdPixLoc) (item 1 assignedHerdPixLoc)

  set unassignedHerdFracLoc (list 0.2 0.56 0.7 0.1) ;;fraction of height and width of panel
  set unassignedHerdPixLoc convertFracPix unassignedHerdFracLoc
  set unassignedHerdPatchLoc convertPixPatch unassignedHerdPixLoc
  bitmap:copy-to-drawing (bitmap:scaled greenBoxTile (item 2 unassignedHerdPixLoc) (item 3 unassignedHerdPixLoc)) (item 0 unassignedHerdPixLoc) (item 1 unassignedHerdPixLoc)

  set otherHerdFracLoc (list 0.2 0.73 0.7 0.1) ;;fraction of height and width of panel
  set otherHerdPixLoc convertFracPix otherHerdFracLoc
  set otherHerdPatchLoc convertPixPatch otherHerdPixLoc
  bitmap:copy-to-drawing (bitmap:scaled greenBoxTile (item 2 otherHerdPixLoc) (item 3 otherHerdPixLoc)) (item 0 otherHerdPixLoc) (item 1 otherHerdPixLoc)

  set pasturePlusFracLoc (list 0.1 0.29 0.08 0.04) ;;fraction of height and width of panel
  set pasturePlusPixLoc convertFracPix pasturePlusFracLoc
  set pasturePlusPatchLoc convertPixPatch pasturePlusPixLoc
  bitmap:copy-to-drawing (bitmap:scaled pasturePlusTile (item 2 pasturePlusPixLoc) (item 3 pasturePlusPixLoc)) (item 0 pasturePlusPixLoc) (item 1 pasturePlusPixLoc)

  set dayBoxFracLoc (list 0.2 0.88 0.7 0.1) ;;fraction of height and width of panel
  set dayBoxPixLoc convertFracPix dayBoxFracLoc
  set dayBoxPatchLoc convertPixPatch dayBoxPixLoc

  set toggleFracLoc (list 0.12 0.07 0.15 0.15) ;;fraction of height and width of panel
  set togglePixLoc convertFracPix toggleFracLoc
  set togglePatchLoc convertPixPatch togglePixLoc

  set climBoxPatchLoc (list (min-pxcor + world-width * 0.25 ) (min-pycor + world-height * 0.75) (world-width * 0.5) (world-height * 0.05))
  set rainBoxPatchLoc (list (min-pxcor + world-width * 0.25 ) (min-pycor + world-height * 0.65) (world-width * 0.5) (world-height * 0.05))

  set grassBarFracLoc (list 0.73 0.18 0.3 0.025)
  set grassBarPixLoc convertFracPix grassBarFracLoc
  set grassBarPatchLoc convertPixPatch grassBarPixLoc


  ;;make the activity boxes along the bottom
  make-day-boxes

  ;;add rain boxes to the display
  make-rain-boxes

  ;;add border to panel
  make-panel-border

  ;;add toggle button
  if showToggleButton [
    create-displayElements 1 [
      set toggle? true
      set rain? false
      set size (item 2 togglePatchLoc)
      setxy (item 0 togglePatchLoc) (item 1 togglePatchLoc)
      set shape "raindrops"
      set seenBy n-values numPlayers [false]
      hubnet-send-override "display" self "hidden?" [true]

    ]
  ]

  ;;add grass growth bar
  let grassMarker (item 3 grassBarPatchLoc) / 2
  while [grassMarker + grassBarSquareSpace <= (item 2 grassBarPatchLoc) ] [
    create-grassBars 1 [setxy item 0 grassBarPatchLoc - (item 2 grassBarPatchloc) / 2 + grassMarker (item 1 grassBarPatchLoc) + (item 3 grassBarPatchLoc) / 2  set shape "square" set size (item 3 grassBarPatchLoc) set hidden? true]
    set grassMarker grassMarker + grassBarSquareSpace
    ]

  create-grassTicks 1 [setxy item 0 grassBarPatchLoc item 1 grassBarPatchLoc set shape "line" set heading 90 set size (item 2 grassBarPatchLoc) set color white]
  let grassTickSpacePatch (item 2 grassBarPatchLoc) / grassK * animalNeeds * grassBarTickSpace
  let currentTick 0
  while [currentTick < (item 2 grassBarPatchLoc)] [
   create-grassTicks 1 [setxy (item 0 grassBarPatchLoc) - (item 2 grassBarPatchLoc) / 2 + currentTick (item 1 grassBarPatchLoc) + (item 3 grassBarPatchLoc) / 2 set shape "line" set heading 0 set size (item 3 grassBarPatchLoc) set color white]
    set currentTick currentTick + grassTickSpacePatch
  ]


end

to-report convertFracPix [fracLoc]
  let pixLoc (list ((item 0 fracLoc) * x_panel_pixels) ((item 1 fracLoc) * y_pixels) ((item 2 fracLoc) * x_panel_pixels) ((item 3 fracLoc) * y_pixels))
  report pixLoc
end

to-report convertPixPatch [pixLoc]
  let patchLoc (list (min-pxcor - 0.5 + (item 0 pixLoc) / pixelsPerPatch) (max-pycor + 0.5 - (item 1 pixLoc) / pixelsPerPatch) ((item 2 pixLoc) / pixelsPerPatch) ((item 3 pixLoc) / pixelsPerPatch))
  report patchLoc
end

to start-game

  ;; stop if a game is already running
  if (gameInProgress = 1 and allowGameSkip = FALSE)
  [user-message "Current game is not complete.  Please continue current game.  Otherwise, to start new session, please first clear settings by clicking 'Launch Broadcast'"
    stop]


  ;; stop if there are no more game parameters queued up
  if (length currentSessionParameters = 0)
  [user-message "No games left in session.  Re-initialize or choose new session ID"
    stop]


  ;; clear the output window and display
  clear-output
  clear-patches
  clear-turtles
  clear-drawing
  foreach playerPosition [ ?1 ->
    hubnet-clear-overrides (item (?1 - 1) playerNames)
  ]
  output-print "Output/Display cleared."

  ;;Set any parameters not set earlier, and not to be set from the read-in game file

  ;set-default-shape borders "line"
  ;set pastureColor [35 45 55]
  ;set phasePasture (list)
  set phaseList (list)
  set climList (list)
  set phasePasture (list)
  set grassPhaseList (list)
  output-print "Game parameters initialized."

  ;; Start the game output file
  let tempDate date-and-time
  foreach [2 5 8 12 15 18 22] [ ?1 -> set tempDate replace-item ?1 tempDate "_" ]
  let playerNameList (word (item 0 playerNames) "_")
  foreach n-values (numPlayers - 1) [ ?1 ->  ?1 + 1 ] [ ?1 ->
   set playerNameList (word playerNameList "_" (item ?1 playerNames))
  ]
  set gameName (word sessionID "_" gameTag "_" playerNameList "_" tempDate ".csv" )
  carefully [file-delete gameName file-open gameName] [file-open gameName]
  output-print "Game output file created."

  ;; read in game file input
  set-game-parameters

  ;;trim and re-fit the game grass file if necessary
  set grassPhaseList filter [ ?1 -> ?1 >= 0 ] grassPhaseList
  let inputGrass grassPhaseList
  while [length grassPhaseList <= numYears * numPhases] [
    set grassPhaseList (sentence grassPhaseList inputGrass)
  ]

  ;;lay out the game board
  set pixelsPerPatch y_pixels / numPatches
  let patches_panel round(x_panel_pixels / pixelsPerPatch)

  resize-world (- patches_panel) (numPatches - 1) 0 (numPatches - 1)
  set-patch-size pixelsPerPatch ;;

  set panelPersonSize panelFracPersonSize * x_panel_pixels / pixelsPerPatch
  set panelHerdCrossSize panelFracHerdCrossSize * x_panel_pixels / pixelsPerPatch
  ;; separate the pasture land from the display area, and seed the landscape
  ask patches [

    set ownedBy -9999
    set selectedBy -9999
    set viewedBy? n-values numPlayers [false]
    set playerHerdCountHere n-values numPlayers [0]
    set shared? false
    set selected? false
    ifelse (pxcor < 0) [
      set inGame? false
      set pcolor 0

    ][
      set inGame? true
      set storedGrass 0
      set pastureGrowth grassK
      let currentRGB_R (1 - (pastureGrowth / grassK)) * rgb_R
      let currentColor (list currentRGB_R rgb_G rgb_B)
      set pcolor currentColor ]
  ]

  ;;show divisions between patches
  make-borders


  ;;PREPARE THE 'DISPLAY'
  ;;add the black screen for weather display; elements added later
  create-displayElements 1 [

    ;;z-ordering bug in Hubnet (where breed ordering is not preserving z-order) means we have to have all display elements be the same breed, with this one at the bottom (lowest who number)
    set phase -9999
    set rain? false
    set toggle? false
    set shape "square"
    set color black
    set size world-width * 1.25

    setxy ((max-pxcor + min-pxcor) / 2) ((max-pycor + min-pycor) / 2)
    set hidden? true
    hubnet-send-override "display" self "hidden?" [false]
  ]


  ;;initialize all of the list variables

  ;;;;;;;;;;;;;;
  ;;EXAMPLES
  ;;;;;;;;;;;;;;
  set playerHerds n-values numPlayers [(list initialHerdSize 0)]
  set playerConfirm n-values numPlayers [0]
  set playerViewingPatch n-values numPlayers [0]
  set playerChoosingMove n-values numPlayers [false]


  ;; get the game progress variables initialized
  set gameInProgress 1
  set currentYear 0
  set choosingSharedLand 0
  set choosingPrivateLand 0
  set currentPhase 0

  ifelse hasForage? [
    set numStates 4
  ][
    set numStates 3
  ]

  if hasChoosingShared? [
    set choosingSharedLand 1
       output-print " CHOOSING SHARED LAND PHASE"
    file-print (word "Choosing shared land at " date-and-time)
  ]

  if not hasChoosingShared? and not hasChoosingPrivate? [
    ;;move into first actual-time phase
    populate-game-board
    set currentYear 1
    set currentPhase 1
    reset-rain-boxes
    create-raindrops (numPatches * numPatches * raindropsPerSquareMax) [
      set size random-float raindropMaxLength * (item 0 grassPhaseList)
      set color sky
      set heading raindropHeading
      setxy random-xcor random-ycor
    ]
    output-print " BEGINNING PASTURING PHASES"
    file-print (word "Beginning pasturing phases at " date-and-time)

  ]

end

to listen

  ;; this is the main message processing procedure for the game.  this procedure responds to hubnet messages, one at a time, as long as the 'Listen Clients' button is down
  ;; where appropriate, procedures have been exported

  ;; while there are messages to be processed
  while [hubnet-message-waiting?] [

    ;; we use a 'message addressed' flag to avoid having to nest foreach loops (there is no switch/case structure in netlogo)
    set messageAddressed 0

    ;; get the next message in the queue
    hubnet-fetch-message


    ;; CASE 1 if the message is that someone has entered the game
    if (hubnet-enter-message? and messageAddressed = 0)[

      ;; CASE 1.1 if the player has already been in the game, link them back in.  if the player is new, set them up to join
      ifelse (member? hubnet-message-source (lput "display" playerNames) ) [

        ifelse (hubnet-message-source = "display") [

         send-display-info "display"

        ] [
          ;; pre-existing player whose connection cut out
          let newMessage word hubnet-message-source " is back."
          hubnet-broadcast-message newMessage

          ;; give the player the current game information
          let currentMessagePosition (position hubnet-message-source playerNames);
          let currentPlayer currentMessagePosition + 1
          send-game-info currentMessagePosition
        ]
      ] ;; end previous player re-entering code

      [ ;; CASE 1.2 otherwise it's a new player trying to join

        ;; new players can only get registered if a game isn't underway
        if (gameInProgress = 0) [  ;;only let people join if we are between games


          ;; names are of the form name_ID - separate out the ID and store the names, IDs separately
          let tempName hubnet-message-source
          let hasHHID position "_" tempName
          let tempID []
          ifelse hasHHID != false [
            set tempID substring tempName (hasHHID + 1) (length tempName)
              set tempName substring tempName 0 hasHHID
          ] [
            set tempID 0
          ]
          set playerShortNames lput tempName playerShortNames
          set playerNames lput hubnet-message-source playerNames
          set playerHHID lput tempID playerHHID

          ;; add the new player, and give them a color
            set numPlayers numPlayers + 1
          set playerPosition lput numPlayers playerPosition
          set playerHerdColor lput (item (numPlayers - 1) colorList) playerHerdColor

          ;; let everyone know
          let newMessage word hubnet-message-source " has joined the game."
          hubnet-broadcast-message newMessage
          ;file-print (word hubnet-message-source " has joined the game as Player " numPlayers " at " date-and-time)

        ]  ;; end new player code
      ]

      ;; mark this message as done
      set messageAddressed 1
    ]

    ;; CASE 2 if the message is that someone left
    if (hubnet-exit-message? and messageAddressed = 0)[

      ;; nothing to do but let people know
      let newMessage word hubnet-message-source " has left.  Waiting."
      hubnet-broadcast-message newMessage

      ;; mark the message done
      set messageAddressed 1
    ]

    ;;CASE 3 the remaining cases are messages that something has been tapped, which are only processed if 1) a game is underway, 2) the message hasn't been addressed earlier, and 3) the player is in the game
    if (gameInProgress = 1 and messageAddressed = 0 and (member? hubnet-message-source playerNames))[

      ;;Declare all the local variables you might want to use for more than one case here, since they remain in scope
      let currentAvatars 0
      let currentAnimals 0
      let currentCrossAvatars 0
      let currentPathCrosses 0

      ;; identify the sender
      let currentMessagePosition (position hubnet-message-source playerNames);  ;;who the message is coming from, indexed from 0
      let currentPlayer (currentMessagePosition + 1); ;;who the player is, indexed from 1

      let notYetConfirmed? (item (currentPlayer - 1) playerConfirm = 0)

      if (hubnet-message-tag = "View" )  [  ;; the current player tapped something in the view


        ;;identify the patch
        let xPatch (item 0 hubnet-message)
        let yPatch (item 1 hubnet-message)
        let xPixel (xPatch - min-pxcor + 0.5) * patch-size
        let yPixel (max-pycor + 0.5 - yPatch) * patch-size

        let currentPXCor [pxcor] of patch xPatch yPatch
        let currentPYCor [pycor] of patch xPatch yPatch

        ;; CASE 3.0 if the tap is selecting pasture as shared or not
        ;; if it is the choosingSharedLand phase and the player taps a pasture, toggle the selection (patches whose x is >= 0 are pasture)
        if (xPatch >= -0.5 and messageAddressed = 0 and (choosingSharedLand = 1)) and notYetConfirmed? [

          output-print "Tap Case 3.0"
          ask patch xPatch yPatch [
            ifelse selected? [
              set selected? false
              file-print (word "Case 3.0 - Player " currentPlayer " unselected patch " pxcor " " pycor " at " date-and-time)
            ] [
              set selected? true
              file-print (word "Case 3.0 - Player " currentPlayer " selected patch " pxcor " " pycor " at " date-and-time)
            ]
            set pcolor update-patch-color
          ]
          ;; message is done
          set messageAddressed 1

        ]

        ;; CASE 3.1 if the tap is selecting pasture as own home or not
        ;; if it is the choosingSharedLand phase and the player taps a pasture, toggle the selection (patches whose x is >= 0 are pasture)
        if (xPatch >= -0.5 and messageAddressed = 0 and (choosingPrivateLand = 1)) and notYetConfirmed? [
          output-print "Tap Case 3.1"
          ask patch xPatch yPatch [
            ifelse selected? and selectedBy = currentPlayer [
              set selected? false
              set selectedBy -9999
              file-print (word "Case 3.1 - Player " currentPlayer " unselected patch " pxcor " " pycor " at " date-and-time)

            ] [
              if count patches with [selectedBy = currentPlayer] < maxPrivateSquares [
                set selected? true
                set selectedBy currentPlayer
                file-print (word "Case 3.1 - Player " currentPlayer " selected patch " pxcor " " pycor " at " date-and-time)

              ]
            ]
            set pcolor update-patch-color
          ]


          ;; message is done
          set messageAddressed 1

        ]

        ;; CASE 3.11 if the tap is on a path cross to clear the projected path
        ;;this is inactive if an avatar is currently selected

        set currentPathCrosses pathCrosses with [owner = currentPlayer and viewer = currentPlayer]
        let currentArrivalDay 0
        let cutProjections? false
        let currentPathOwner 0
        ask currentPathCrosses [
          let crossLoc (list (xcor - panelHerdCrossSize / 2) (ycor - panelHerdCrossSize / 2) (panelHerdCrossSize) panelHerdCrossSize )
          if clicked-avatar (crossLoc) and messageAddressed = 0 and notYetConfirmed? [
            output-print "Tap Case 3.2"
            set currentArrivalDay arrivedOn
            set cutProjections? true
            set currentPathOwner pathOwner


          ]
        ]
        if cutProjections? and messageAddressed = 0 and notYetConfirmed? [
          ;(this can't be in the prior loop since an agent that would be cut, would be calling it
           undo-projections currentArrivalDay currentPlayer currentPathOwner xPatch yPatch
          file-print (word "Case 3.2 - Player " currentPlayer " cancelled their own path to patch " currentPXCor " " currentPYCor " at " date-and-time)

          set cutProjections? false
           ;; mark message done
            set messageAddressed 1
        ]

        ;; CASE 3.3 if the tap is on a permissions checkmark

        let currentPermissionChecks permChecks with [not (owner = currentPlayer)]
        let granted? false
        ask currentPermissionChecks [
          let crossLoc (list (xcor - panelHerdCrossSize / 2) (ycor - panelHerdCrossSize / 2) (panelHerdCrossSize) panelHerdCrossSize )
          if clicked-avatar (crossLoc) and messageAddressed = 0  [



            ;we've clicked on a permissions check in this square, but we always deal with the most recent one first
            ask min-one-of permChecks-here with [not (owner = currentPlayer)][pycor] [

              let myOwner owner

              let alreadyChosen? false
              ask pendingSquares-here with [owner = myOwner] [
                if item (currentPlayer - 1) permissions = true [set alreadyChosen? true]
              ]

              if not alreadyChosen? [
                output-print "Tap Case 3.3"
                ;;this is a check for someone else's pending decision, that we can permit
                ask pendingSquares-here with [owner = myOwner] [
                  set permissions replace-item (currentPlayer - 1) permissions true

                  if [shared?] of patch-here [
                    if length (filter [ ?1 -> ?1 = true ] permissions) = numPlayers - 1 [
                      set granted? true
                    ]
                  ]
                  if [ownedBy > 0] of patch-here [
                    if item (ownedBy - 1) permissions = true [
                      set granted? true
                    ]
                  ]
                  hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [true]
                ]
                hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [true]
                ask permCrosses-here with [owner = myOwner] [hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [true]]
                ;; mark message done
                set messageAddressed 1
                file-print (word "Case 3.3 - Player " currentPlayer " allowed Player " myOwner "'s  path to patch " currentPXCor " " currentPYCor " at " date-and-time)
                if granted? [
                  ask pendingSquares-here with [owner = myOwner] [die]
                  ask permCrosses-here with [owner = myOwner] [die]
                  ask permChecks-here with [owner = myOwner] [die]
                  file-print (word "Case 3.3 - All players approved Player " myOwner "'s  path to patch " currentPXCor " " currentPYCor " at " date-and-time)
                ]
              ]
            ]
          ]

        ]





        ;; CASE 3.4 if the tap is on a permissions cross - which would clear the projection

        let currentPermissionCrosses permCrosses with [not (owner = currentPlayer)]
        let owningPlayer 0
        ask currentPermissionCrosses [
          let crossLoc (list (xcor - panelHerdCrossSize / 2) (ycor - panelHerdCrossSize / 2) (panelHerdCrossSize) panelHerdCrossSize )
          set cutProjections? false
          if clicked-avatar (crossLoc) and messageAddressed = 0  [




            ;we've clicked on a permissions cross in this square, but we always deal with the most recent one first
            ask min-one-of permCrosses-here with [not (owner = currentPlayer)][pycor] [

              let myOwner owner
              let alreadyChosen? false
              ask pendingSquares-here with [owner = myOwner] [
                if item (currentPlayer - 1) permissions = true [set alreadyChosen? true]
              ]

              if not alreadyChosen? and ([shared?] of patch-here) or ([ownedBy] of patch-here = currentPlayer) [

                output-print "Tap Case 3.4"

                ;; this is a cross that will reject the whole projection from here forward
                set cutProjections? true
                set owningPlayer owner
                set currentPathOwner 0
                set currentArrivalDay 0
                ask pendingSquares-here with [owner = owningPlayer] [set currentPathOwner pathOf set currentArrivalDay arrivedOn]

              ;; mark message done
              set messageAddressed 1
              ]
              ]
          ]
        ]
        if cutProjections?  [
          ;(this can't be in the prior loop since an agent that would be cut, would be calling it
          undo-projections currentArrivalDay owningPlayer currentPathOwner xPatch yPatch
          set cutProjections? false
          file-print (word "Case 3.4 - Player " currentPlayer " denied Player " owningPlayer "'s  path to patch " currentPXCor " " currentPYCor " at " date-and-time)
        ]

        ;; CASE 3.5 if the tap is selecting pasture to view/amend during actual time play
        if (xPatch >= -0.5 and messageAddressed = 0 and (currentPhase > 0) and notYetConfirmed? and item (currentPlayer - 1) playerChoosingMove = false) [
          output-print "Tap Case 3.5"
          update-panel xPatch yPatch currentPlayer


          ;; message is done
          set messageAddressed 1
          file-print (word "Case 3.5 - Player " currentPlayer " viewing patch " currentPXCor " " currentPYCor " at " date-and-time)

        ]

        ;; CASE 3.6 if the tap is on own avatars in panel
        set currentAvatars people with [avatar? and viewer = currentPlayer and owner = currentPlayer]
        ask currentAvatars [


          let personLoc (list (xcor - panelPersonSize / 4) (ycor - panelPersonSize / 2) (panelPersonSize / 2) panelPersonSize )

          if clicked-avatar (personLoc) and currentStep? and messageAddressed = 0 and notYetConfirmed? [
            output-print "Tap Case 3.6"
            ifelse active? [

              update-color

              set active? false
              ask dayBoxes [hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [true]]
              ask workIcons [hubnet-clear-override (item (currentPlayer - 1) playerNames) self "hidden?"]
              ask restIcons [hubnet-clear-override (item (currentPlayer - 1) playerNames) self "hidden?"]
              ask moveIcons [hubnet-clear-override (item (currentPlayer - 1) playerNames) self "hidden?"]
              file-print (word "Case 3.6 - Player " currentPlayer " deactivating avatar" " at " date-and-time)
            ] [

              set color color + 2
              set active? true
              ask other currentAvatars [set active? false
                update-color
              ]

              file-print (word "Case 3.6 - Player " currentPlayer " activating avatar" " at " date-and-time)
              show-schedule self
            ]

            ;; mark message done
            set messageAddressed 1

          ]

        ]


        ;; CASE 3.7 if the tap is on add herds in a patch that currently has animals for that player (i.e., not just those that will arrive later)
        set currentAnimals animals with [avatar? and viewer = currentPlayer and owner = currentPlayer]

        if any? currentAnimals and clicked-button (pasturePlusPixLoc) and messageAddressed = 0 and notYetConfirmed? [

          output-print "Tap Case 3.7"
          add-herd currentPlayer
          file-print (word "Case 3.7 - Player " currentPlayer " adding herd divider to patch " currentPXCor " " currentPYCor " at " date-and-time)

          ;; mark message done
          set messageAddressed 1
        ]

        ;; CASE 3.8 if the tap is on a herd cross (to empty the herd space, or remove an empty herd space)
        ;;this is inactive if an avatar is currently selected

        set currentAvatars people with [avatar? and viewer = currentPlayer and owner = currentPlayer]
        set currentCrossAvatars herdCrosses with [avatar? and viewer = currentPlayer]

        ask currentCrossAvatars [
          let crossLoc (list (xcor - panelHerdCrossSize / 2) (ycor - panelHerdCrossSize / 2) (panelHerdCrossSize) panelHerdCrossSize )
          if clicked-avatar (crossLoc) and currentStep? and messageAddressed = 0 and notYetConfirmed? [

            ;;if there is an active avatar, or if the herd is already sent elsewhere, clear the message but don't do anything else
            if currentStep? and not any? currentAvatars with [active?] [
              output-print "Tap Case 3.8"
              let myHerd herd
              let animalsInHerd animals with [avatar? and viewer = currentPlayer and owner = currentPlayer and herdNumber = myHerd]

              ifelse any? animalsInHerd [
                ;;this request is to empty this herd back to unassigned
                ask animalsInHerd [
                  set herdNumber -9999
                  set herdedBy -9999
                  let currentHerdNumber herdNumber
                  ask link-neighbors [set herdNumber currentHerdNumber
                    set herdedBy -9999                 ]
                  setxy  ((item 0 unassignedHerdPatchLoc) + random-float (item 2 unassignedHerdPatchLoc)) ((item 1 unassignedHerdPatchLoc) - random-float (item 3 unassignedHerdPatchLoc))
                ]
                let peopleInHerd people with [avatar? and viewer = currentPlayer and owner = currentPlayer and herd = myHerd]
                if any? peopleInHerd [
                  ask peopleInHerd [set herd -9999
                    ask link-neighbors [set herd -9999]
                  ]
                ]
                place-people-avatars currentPlayer
                file-print (word "Case 3.8 - Player " currentPlayer " emptying herd space " myHerd " at patch " currentPXCor " " currentPYCor " at " date-and-time)
              ] [
                ;;this request is to remove this herd space, which is already empty
                cut-herd currentPlayer
                file-print (word "Case 3.8 - Player " currentPlayer " removing herd divider from patch " currentPXCor " " currentPYCor " at " date-and-time)
              ]
            ]
            ;; mark message done
            set messageAddressed 1
          ]
        ]



        ;; CASE 3.9 if the tap is on the assigned pasture in a patch that currently has animals for that player (i.e., not just those that will arrive later), but not where avatar is selected
        set currentCrossAvatars herdCrosses with [avatar? and viewer = currentPlayer]
        set currentAvatars people with [avatar? and viewer = currentPlayer and owner = currentPlayer]
        let currentAnimalsToAdd animals with [avatar? and viewer = currentPlayer and owner = currentPlayer and herdNumber < 0]


        if any? currentAnimalsToAdd and not any? currentAvatars with [active?] and clicked-button (assignedHerdPixLoc) and notYetConfirmed? and messageAddressed = 0 [
          output-print "Tap Case 3.9"
          let currentNumHerds [item (currentPlayer - 1) playerHerdCountHere] of (item (currentPlayer - 1) playerViewingPatch)
          let herdWidth (item 2 assignedHerdPatchLoc) / max(list 1 currentNumHerds)
          let currentSlotNumber ceiling ((xPatch - (item 0 assignedHerdPatchLoc)) / herdWidth) ;; find out how many slots from the left you are
          let currentCross one-of herdCrosses with [viewer = currentPlayer and slot = currentSlotNumber]; this cross corresponds to this herd

          if [currentStep?] of currentCross [
            let currentHerdNumber [herd] of currentCross ;; find out the actual herdID associated with this slot
            let herdXPatchLoc (item 0 assignedHerdPatchLoc) + (currentSlotNumber - 1) * herdWidth
            ask one-of currentAnimalsToAdd [
              set herdNumber currentHerdNumber
              ask link-neighbors [set herdNumber currentHerdNumber]
              setxy (herdXPatchLoc + random-float herdWidth) ((item 1 assignedHerdPatchLoc) - random-float (item 3 assignedHerdPatchLoc) )
            ]
            file-print (word "Case 3.9 - Player " currentPlayer " added animal to herd " currentHerdNumber " at patch " currentPXCor " " currentPYCor " at " date-and-time)
          ]
          ;; mark message done
          set messageAddressed 1
        ]

        ;; CASE 3.10 if the tap is on assigned pasture in a HERD that has animals in it, and there is an active avatar (being assigned to this herd), and there is not already an assigned avatar

        set currentAvatars people with [avatar? and viewer = currentPlayer and owner = currentPlayer]
        if any? currentAvatars with [active?] and clicked-button (assignedHerdPixLoc) and messageAddressed = 0 and notYetConfirmed? [
          output-print "Tap Case 3.10"
          set currentAnimals animals with [avatar? and viewer = currentPlayer and owner = currentPlayer]
          let currentNumHerds [item (currentPlayer - 1) playerHerdCountHere] of (item (currentPlayer - 1) playerViewingPatch)

          if currentNumHerds > 0 [
            let herdWidth (item 2 assignedHerdPatchLoc) / max(list 1 currentNumHerds)
            let currentSlotNumber ceiling ((xPatch - (item 0 assignedHerdPatchLoc)) / herdWidth) ;; find out how many slots from the left you are
            let currentHerdNumber [herd] of one-of herdCrosses with [viewer = currentPlayer and slot = currentSlotNumber] ;; find out the actual herdID associated with this slot
            let herdXPatchLoc (item 0 assignedHerdPatchLoc) + (currentSlotNumber - 1) * herdWidth
            let currentCross one-of herdCrosses with [viewer = currentPlayer and slot = currentSlotNumber]; this cross corresponds to this herd

            let currentHerdAnimals currentAnimals with [herdNumber = currentHerdNumber]
            if any? currentHerdAnimals  and [currentStep?] of currentCross and not any? currentAvatars with [herd = currentHerdNumber] [ ;; this is a present herd with animals in it, and no other avatar, that can be assigned to the active avatar

              let currentPersonID -9999
              ask one-of currentAvatars with [active? and viewer = currentPlayer] [
                set currentPersonID personID


                set herd currentHerdNumber
                ask link-neighbors [set herd currentHerdNumber]

              ]
              place-people-avatars currentPlayer

              ask currentHerdAnimals [set herdedBy currentPersonID
                ask link-neighbors [set herdedBy currentPersonID]]
              file-print (word "Case 3.10 - Player " currentPlayer " assigned avatar to herd " currentHerdNumber " at patch " currentPXCor " " currentPYCor " at " date-and-time)
            ]
          ]

          ;; mark message done
          set messageAddressed 1
        ]



        ;; CASE 3.11 if the tap is on the active day box and there is an active avatar
        set currentAvatars people with [avatar? and viewer = currentPlayer and owner = currentPlayer]
        if any? currentAvatars with [active? and viewer = currentPlayer] and messageAddressed = 0 and notYetConfirmed? [

          let singleCurrentAvatar one-of currentAvatars with [active? and viewer = currentPlayer and owner = currentPlayer]
          let currentDay 1
          let currentSchedule [schedule] of singleCurrentAvatar

          if not empty?  currentSchedule [
            set currentDay (length currentSchedule) + 1 ]
          ask dayBoxes [
            let myDay day
            let boxLoc (list (xcor - panelDayBoxSize / 2) (ycor - panelDayBoxSize / 2) (panelDayBoxSize) panelDayBoxSize )
            let currentState 0
            if clicked-avatar (boxLoc) and (myDay = currentDay - 1 or myDay = currentDay) and (myDay > [arrivedOn] of singleCurrentAvatar)[
              output-print "Tap Case 3.11"
              if (myDay = currentDay - 1) [
                set currentState [item (myDay - 1) schedule] of singleCurrentAvatar
              ]
              set currentState currentState + 1
              if currentState = numStates [set currentState 0]
              ifelse (myDay = currentDay - 1) [
                set currentSchedule replace-item (myDay - 1) ([schedule] of singleCurrentAvatar) currentState
              ] [
                set currentSchedule lput currentState ([schedule] of singleCurrentAvatar)
              ]

              file-print (word "Case 3.11 - Player " currentPlayer " cycling avatar schedule to " currentState " at day " currentDay " at " date-and-time)
              ;;don't keep a '0' - leave it blank so that it highlights as the next spot to change
              if last currentSchedule = 0 [set currentSchedule but-last currentSchedule]

              ;;make sure all points with this herder have the same schedule
              ask people with [personID = [personID] of singleCurrentAvatar] [set schedule currentSchedule]

              show-schedule singleCurrentAvatar

              ifelse currentState = moveID [
                set playerChoosingMove replace-item (currentPlayer - 1) playerChoosingMove true
               view-next-location singleCurrentAvatar
              ] [
                ask borders [die]
                ask patches with [inGame?] [
                    hubnet-clear-override (item (currentPlayer - 1) playerNames) self "pcolor"
                ]
                set playerChoosingMove replace-item (currentPlayer - 1) playerChoosingMove false
              ]
              ;; mark message done
              set messageAddressed 1
            ]

          ]

        ]

        ;; CASE 3.12 if the tap is on the toggle button between screens
        let currentToggle displayElements with [toggle?]
        if any? currentToggle [ ;; if button is shown in game
          ask one-of currentToggle [ ;; there is only one possible toggle
            let toggleSize (item 2 togglePatchLoc)
            let toggleloc (list (xcor - toggleSize / 2) (ycor - toggleSize / 2) (toggleSize) toggleSize )
            if clicked-avatar(toggleLoc) [
              let showingRain? item (currentPlayer - 1) seenBy
              ifelse showingRain? [
                output-print "Tap Case 3.12 - switching to pasture"
                file-print (word "Case 3.12 - Player " currentPlayer " viewing pasture screen" " at " date-and-time)
                ;;breed-ordered painting not perfectly preserved in hubnet; these particular turtles always bleed through so we set additional overrides for them
                ask people with [not avatar?] [hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [false]]
                ask animals with [not avatar?] [hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [false]]
                ask people with [currentPlayer = owner and  avatar?] [hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [false]]
                ask animals with [currentPlayer = owner and  avatar?] [hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [false]]
                ask grassTicks [hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [false]]
                ask pathCrosses [hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [false]]
                ask bales [hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [false]]

                hubnet-send-override (item (currentPlayer - 1) playerNames) self "shape" ["raindrops"]
                ask displayElements with [not toggle?] [hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [true]]
                set seenBy replace-item (currentPlayer - 1) seenBy false
              ][
                output-print "Tap Case 3.12 - switching to rain"
                file-print (word "Case 3.12 - Player " currentPlayer " viewing rain screen" " at " date-and-time)
                ;;breed-ordered painting not perfectly preserved in hubnet; these particular turtles always bleed through so we set additional overrides for them
                ask people [hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [true]]
                ask animals [hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [true]]
                ask grassTicks [hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [true]]
                ask pathCrosses [hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [true]]
                ask bales [hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [true]]

                hubnet-send-override (item (currentPlayer - 1) playerNames) self "shape" ["sheep 2"]
                ask displayElements with [not toggle?] [hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [false]]
                set seenBy replace-item (currentPlayer - 1) seenBy true
              ]
            ]
          ]

        ]

        ;; CASE 3.13 if the tap is outside the assigned herd area, and there is an active avatar in a herd (being removed); excludes the case where an active avatar in herd is looking for a new home
        set currentAvatars people with [avatar? and viewer = currentPlayer and owner = currentPlayer]

        if any? currentAvatars with [active? and herd > 0 ]
        and not clicked-button (confirmPixLoc)
        and (yPatch > item 1 assignedHerdPatchLoc)
        and (xPatch > item 0 assignedHerdPatchLoc)
        and messageAddressed = 0 and item (currentPlayer - 1) playerChoosingMove = false and notYetConfirmed? [
          output-print "Tap Case 3.13"
            ask one-of currentAvatars with [active? and viewer = currentPlayer] [
            set herd -9999
            ask link-neighbors [set herd -9999]
            let myPersonID personID
            ask animals with [herdedBy = myPersonID and avatar?] [
              set herdedBy -9999
              ask link-neighbors [set herdedBy -9999]
            ]


            ]
            place-people-avatars currentPlayer
          file-print (word "Case 3.13 - Player " currentPlayer " removed avatar from herd " " at " date-and-time)

        ;; mark message done
        set messageAddressed 1
        ]


        ;; CASE 3.14 if the tap is selecting pasture to move to
        set currentAvatars people with [active? and avatar? and viewer = currentPlayer and owner = currentPlayer]
        if (xPatch >= -0.5 and messageAddressed = 0 and notYetConfirmed? and (currentPhase > 0) and any? currentAvatars and item (currentPlayer - 1) playerChoosingMove = true) [
          output-print "Tap Case 3.14"
          select-new-location xPatch yPatch currentPlayer (one-of currentAvatars)
          file-print (word "Case 3.14 - Player " currentPlayer " selecting patch " currentPXCor " " currentPYCor " to move to" " at " date-and-time)
          ;; message is done
          set messageAddressed 1

        ]


        ;; CASE 3.15 if the tap is on the 'confirm button'

        if clicked-button (confirmPixLoc) and messageAddressed = 0 and notYetConfirmed? and (not item (currentPlayer - 1) playerChoosingMove = true)[
          ;; if the player hasn't already clicked confirm this phase
          if item (currentPlayer - 1) playerConfirm = 0 and not (any? pendingSquares with [owner = currentPlayer]) [

            ;; mark the confirm and record
            let newMessage word (item (currentPlayer - 1) playerNames) " clicked confirm."
            hubnet-broadcast-message newMessage
            file-print (word "Case 3.15 - Player " currentPlayer " clicked confirm at " date-and-time)

            set playerConfirm replace-item (currentPlayer - 1) playerConfirm 1



            ;; darken the pasture to mark the confirm to the player
            ask patches with [pxcor >= 0] [hubnet-send-override (item (currentPlayer - 1) playerNames) self "pcolor" [(map [ ?1 -> ?1 / 5 ] pcolor)]];


            ;; update the player's information
            send-game-info (currentPlayer - 1)

            ;; if EVERYONE has now confirmed, move to advance-phase
            if (sum playerConfirm = numPlayers) [
              advance-phase
            ]
          ]

          ;; mark message done
          set messageAddressed 1
        ]


        ;; CASE 4 if the message still hasn't been addressed, it means players clicked in a place that they weren't meant to - ignore it
        set messageAddressed 1
        output-print "Unhandled message"
      ] ;; end ifelse view


    ]


  ]


end


to show-schedule [avatar]

  let currentPlayer [owner] of avatar

  let scheduleLength length [schedule] of avatar

  ask dayBoxes [hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [false]
    ifelse not (scheduleLength = (day - 1)) [
      hubnet-send-override (item (currentPlayer - 1) playerNames) self "color" [gray]
    ] [
      hubnet-clear-override (item (currentPlayer - 1) playerNames) self "color"
    ]
  ]

  ask workIcons [hubnet-clear-override (item (currentPlayer - 1) playerNames) self "hidden?"]
  ask moveIcons [hubnet-clear-override (item (currentPlayer - 1) playerNames) self "hidden?"]
  ask restIcons [hubnet-clear-override (item (currentPlayer - 1) playerNames) self "hidden?"]
  let lengthSchedule length [schedule] of avatar
  ask workIcons with [day <= lengthSchedule] [
    if (item (day - 1) [schedule] of avatar) = ID [
      hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [false]
    ]
  ]
  ask moveIcons with [day <= lengthSchedule] [
    if (item (day - 1) [schedule] of avatar) = ID [
      hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [false]
    ]
  ]
  ask restIcons with [day <= lengthSchedule] [
    if (item (day - 1) [schedule] of avatar) = ID [
      hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [false]
    ]
  ]
end

to show-game-information

  ;; provide a summary of the current game state, between years

  ;; make all pasture patches black
  foreach playerPosition [ ?1 ->
    set playerConfirm replace-item (?1 - 1) playerConfirm 0
    ask patches with [pxcor >= 0] [hubnet-send-override (item (?1 - 1) playerNames) self "pcolor" [0]];
  ]

  ;;BELOW THIS ANY ADDITIONAL INFORMATION TO SHOW

end

to clear-game-information

  ;; clear away the information displayed between years as game summary

  foreach playerPosition [ ?1 ->
    set playerConfirm replace-item (?1 - 1) playerConfirm 0
    ask patches with [pxcor >= 0] [hubnet-clear-override (item (?1 - 1) playerNames) self "pcolor"]

  ]

end

to advance-phase

  ;; called once at the end of every phase, once all players have clicked 'confirm'.  depending on the phases listed for the current turn, different things happen


  ;; it is called twice between the end of the last phase of a year and the first phase of another.  the first time, it will launch the 'show-game-information' routine and exit;
  ;; once players have clicked confirm to exit the game information, it will be called again to finish advancing the phase

  ; if game information is not currently showing (i.e., this is the first time executed after end of phase)

  ;; use advanceHandled? as a flag to mark a particular case as being handled
  let advanceHandled? false



  ;;CASE 1 - ADVANCING OUT OF CHOOSING SHARED LAND
  if (not advanceHandled? and choosingSharedLand = 1) [

    ;;mark us out of the choosing shared land phase
    set choosingSharedLand 0

    ;;mark out the shared village
    ask patches with [selected?] [set selected? false set shared? true file-print (word "Patch " pxcor " " pycor " shared")]
    ask patches [set pcolor update-patch-color]
    make-shared-borders

    ;;reset player confirms
    foreach playerPosition [ ?1 ->
      set playerConfirm replace-item (?1 - 1) playerConfirm 0
      send-game-info (?1 - 1)
    ]


    ;;clear any overrides before moving to next phase
    foreach playerPosition [ ?1 ->
      ask patches with [inGame?] [hubnet-clear-override (item (?1 - 1) playerNames) self "pcolor"]
    ]

    ;;if the game includes marking of private lands, move to that; otherwise  move into first actual-time phase
    ifelse hasChoosingPrivate? [
      set choosingPrivateLand 1
      output-print " CHOOSING PRIVATE LAND PHASE"
      file-print (word "Choosing private land at " date-and-time)
    ] [
      populate-game-board
      set currentYear 1
      set currentPhase 1
      reset-rain-boxes
      create-raindrops (numPatches * numPatches * raindropsPerSquareMax) [
        set size random-float raindropMaxLength * (item 0 grassPhaseList)
        set color sky
        set heading raindropHeading
        setxy random-xcor random-ycor
      ]
      output-print " BEGINNING PASTURING PHASES"
      file-print (word "Beginning pasture phases at " date-and-time)
    ]

    ;;mark the phase as advanced
    set advanceHandled? true
  ]



  ;;CASE 2 - ADVANCING OUT OF CHOOSING PRIVATE LAND
  if (not advanceHandled? and choosingPrivateLand = 1) [

    ;;mark us out of the choosing private land phase
    set choosingPrivateLand 0

    ;;mark out the shared village
    ask patches with [selected?] [set selected? false set shared? false set ownedBy selectedBy file-print (word "Patch " pxcor " " pycor " owned by Player " selectedBy)]
    ask patches [set pcolor update-patch-color]
    make-private-borders

    ;;reset player confirms
    foreach playerPosition [ ?1 ->
      set playerConfirm replace-item (?1 - 1) playerConfirm 0
      send-game-info (?1 - 1)
    ]


    ;;clear any overrides before moving to next phase
    foreach playerPosition [ ?1 ->
      ask patches with [inGame?] [hubnet-clear-override (item (?1 - 1) playerNames) self "pcolor"]
    ]

    ;;move into first actual-time phase
    populate-game-board
    set currentYear 1
    set currentPhase 1
    reset-rain-boxes
    create-raindrops (numPatches * numPatches * raindropsPerSquareMax) [
      set size random-float raindropMaxLength * (item 0 grassPhaseList)
      set color sky
      set heading raindropHeading
      setxy random-xcor random-ycor
    ]
    output-print " BEGINNING PASTURING PHASES"
    file-print (word "Beginning pasture phases at " date-and-time)

    ;;mark the phase as advanced
    set advanceHandled? true
  ]


  if (not advanceHandled?) [
  ;;CASE 3 - advancing pasture

    output-print "Advance phase - Case 3"
    ;; do everything here that should happen before information is shared

    ;;PASTURE TURN: UPDATE GRASS AND ANIMALS.
    ;;If the previous turn was a pasturing turn (i.e., actual time passed), then run grass model.
    if item (currentPhase - 1) phasePasture = 1 [

      output-print "Advance phase - Updating Pasture"
      file-print (word "Updating pastures at " date-and-time)
      let currentRain item 0 grassPhaseList
      set grassPhaseList but-first grassPhaseList

      ask people with [not projection?] [
        file-print (word "Person " personID " for Player " owner " has schedule " schedule)
      ]


      let currentDay 0
      while [currentDay <= phaseLengthDays] [


        ;;move animals as appropriate, working through their 'herders' schedules

        ;;remove all previous markers of the projection, before currentDay
        ask people with [projection? and arrivedOn <= currentDay] [die]
        ask animals with [projection? and arrivedOn <= currentDay] [
          ;;update the herdedBy only as we move to the new projection, in case a herd has been left along the way
          let myHerdedBy herdedBy
          ask link-neighbors [
            set herdedBy myHerdedBy
          ]
          die]
        ask connections with [arrivedOn <= currentDay] [die]
        ask pointers with [arrivedOn <= currentDay] [die]
        ask pathCrosses with [arrivedOn <= currentDay] [die]
        ask people with [not projection? and not avatar?] [
          if length schedule > currentDay [
            let myID personID
            let remainingProjections people with [personID = myID and projection? and not avatar?]

            if item currentDay schedule = moveID and any? remainingProjections [

              let nextStep min-one-of remainingProjections [arrivedOn]

              let destination [patch-here] of nextStep
              let arrivalDate [arrivedOn] of nextStep


              set heading towards destination

              forward (distance destination) / (arrivalDate - currentDay)
              let myX xcor
              let myY ycor
              ask animals with [not projection? and herdedBy = myID] [
                ;make sure we put animals somewhere in bounds
                let newX (myX - 0.5 + random-float 1)
                set newX max list -0.49 newX
                set newX min list (max-pxcor + 0.49) newX
                let newY (myY - 0.5 + random-float 1)
                set newY max list -0.49 newY
                set newY min list (max-pycor + 0.49) newY
                setxy newX newY
              ]

              ;; now randomize my own a little bit
              let newX (myX - 0.5 + random-float 1)
              set newX max list -0.49 newX
              set newX min list (max-pxcor + 0.49) newX
              let newY (myY - 0.5 + random-float 1)
              set newY max list -0.49 newY
              set newY min list (max-pycor + 0.49) newY
              setxy newX newY            ]
          ]
        ]


        output-print (word "Advance phase - Updating Pasture Day " currentDay)
        ask patches with [pxcor >= 0] [

          ;; first have new grass grow
          let currentGrass pastureGrowth
          let newGrowth grassR * currentGrass * (1 - (currentGrass / grassK) ) * (currentRain / grassE0)
          set currentGrass currentGrass + newGrowth

          ;; now have cattle consume grass
          let undergroundGrass (min (list (grassUndergroundFraction * grassK ) (currentGrass )))
          let totalAvailableGreenGrass currentGrass  - undergroundGrass
          let totalAvailableGrass totalAvailableGreenGrass + storedGrass
          ask animals-here with [not projection?] [
            let currentNeed animalNeeds
            if totalAvailableGrass > 0 [

              ;;eat what is available, green
              let consumedGrass min (list totalAvailableGreenGrass currentNeed)
              set totalAvailableGreenGrass totalAvailableGreenGrass - consumedGrass

              ;;if necessary, tap into the reserve
              let consumedReserve 0
              if consumedGrass < currentNeed [
                let deficit currentNeed - consumedGrass
                set consumedReserve min (list deficit storedGrass)
              ]
              set storedGrass storedGrass - consumedReserve

              set consumedGrass consumedGrass + consumedReserve
              set consumptionHistory lput consumedGrass (but-first consumptionHistory)



            ]
          ]
          set currentGrass (totalAvailableGreenGrass + undergroundGrass)
          set pastureGrowth currentGrass

          ;; now have harvesting of grass, if it's the case that there is a person there 'working' on this day
          let newCutGrass 0
          set totalAvailableGreenGrass currentGrass  - undergroundGrass
          ask people-here with [not projection?] [
            if length schedule > currentDay [
              if item currentDay schedule = workID [
                let currentGoal harvest_Day
                if totalAvailableGreenGrass > 0 [
                  let cutGrass min (list totalAvailableGreenGrass currentGoal)
                  set newCutGrass newCutGrass + cutGrass
                  set totalAvailableGreenGrass totalAvailableGreenGrass - newCutGrass
                ]

              ]
            ]

          ]
          set storedGrass storedGrass + newCutGrass
          set currentGrass (totalAvailableGreenGrass + undergroundGrass)
          set pastureGrowth currentGrass

          ;; update appearance of grass patches
          set pcolor update-patch-color
          update-reserve


        ]

        ask people with [not projection?] [
          file-print (word "Person " personID " for Player " owner " is at patch " [pxcor] of patch-here " " [pycor] of patch-here " and has schedule " schedule)
        ]
        set currentDay currentDay + 1
      ]

      ask patches with [inGame?] [file-print (word "Patch " pxcor " " pycor " has " pastureGrowth " live grass; " storedGrass " cut grass")]

      ;;update the display
      update-rain-boxes currentRain

      ;;(still within pasture turn) update state of animals and see if they survive
      ask animals [

        let pSurvival estimate-p-survival
        if random-float 1 > pSurvival [
          ;; animal dies
          file-print (word (item (owner - 1) playerNames) " lost one animal")
          ask link-neighbors [die]
          die

        ]
      ]

      file-print "LIVE ANIMAL SUMMARY"
      ask animals [ file-print (word "Player " owner " has animal at patch " [pxcor] of patch-here " " [pycor] of patch-here " with history " consumptionHistory)]

    ] ;;END UPDATE GRASS AND ANIMALS




    ;; now that we've done all the things we might want to do before advancing the phase, move on and update the phase
    ;; if we are in the last phase of the year, we either need to advance to the next year or end game
    ifelse currentPhase = numPhases [ ;; LAST PHASE OF YEAR


      ifelse currentYear = numYears [
        output-print "Advance Phase - ending game"
        file-print (word "Game ended at " date-and-time)

        ;;CASE 1.1 - END GAME
        ask currentMarkers [set color gray]

        ;; game is over
        end-game
        stop
      ] [

        ;;CASE 1.2 - END OF YEAR, ADVANCE TO NEXT YEAR
        ;; year is advanced by one.  go to the 'game-information' routine, but leave a marker that we're doing that.
        ;; after that has been shown, we'll come back here, but we don't want to advance the counters again.  we unfortunately can't
        ;; just stay in this loop because we need to listen for 'confirms' again, and while we're in here, hubnet isn't listening

        output-print "Advance Phase - advancing year"
        file-print (word "Advancing to next year at" date-and-time)
        set currentPhase 1
        set currentYear (currentYear + 1)

        reset-rain-boxes


        ;stop
      ]


    ] [

      ;;CASE 1.3 - MIDDLE OF A YEAR, ADVANCE TO NEXT PHASE

      output-print "Advance Phase - advancing phase in year"
      file-print (word "Advancing to next phase at " date-and-time)
      set currentPhase (currentPhase + 1)

    ] ;; end of ifelse currentPhase = numPhases


    ;; update game file
    ;file-print (word "Advance to Year " currentYear ", Phase " currentPhase " at " date-and-time)
    ;file-print (word "Player Names: " playerNames)
    ;file-print (word "Player Calves: " playerCalves)


    ;; update all players' information
    foreach playerPosition [ ?1 ->
      set playerConfirm replace-item (?1 - 1) playerConfirm 0
      ask patches with [pxcor >= 0] [
        hubnet-clear-override (item (?1 - 1) playerNames) self "pcolor"
        set playerHerdCountHere replace-item (?1 - 1) playerHerdCountHere length remove-duplicates [herdedBy] of animals-here with [owner = ?1]

      ]
      send-game-info (?1 - 1)

    ]

    send-display-info "display"
    ;;now that we've finished walking through time, update all people and animals to be ready for next phase
    ask animals [set currentStep? true set arrivedOn 0 update-color]
    ask people [set schedule (list) set currentStep? true set arrivedOn 0 update-color]
    ask raindrops [die]
    create-raindrops (numPatches * numPatches * raindropsPerSquareMax) [
     set size random-float raindropMaxLength * (item 0 grassPhaseList)
     set color sky
     set heading raindropHeading
     setxy random-xcor random-ycor
    ]
  ]
end

to end-game

  ;; at the end of the game, show final information, mark the game as stopped, and finalize files

  set gameInProgress 0
  show-game-information

  file-close

  file-open "completedGames.csv"
  file-print gameName
  file-close



end

to send-game-info [currentPosition]

  ;; sends current, player-specific game info to the specified player.

  ask dayBoxes [hubnet-send-override (item currentPosition playerNames) self "hidden?" [true]]
  ask workIcons [hubnet-send-override (item currentPosition playerNames) self "hidden?" [true]
  hubnet-send-override (item currentPosition playerNames) self "color" [item currentPosition playerHerdColor]]
  ask moveIcons [hubnet-send-override (item currentPosition playerNames) self "hidden?" [true]
  hubnet-send-override (item currentPosition playerNames) self "color" [item currentPosition playerHerdColor]]
  ask restIcons [hubnet-send-override (item currentPosition playerNames) self "hidden?" [true]
  hubnet-send-override (item currentPosition playerNames) self "color" [item currentPosition playerHerdColor]]
  ask panelEdges [hubnet-send-override (item currentPosition playerNames) self "color" [item currentPosition playerHerdColor]]
end


to send-display-info [ playerName ]

  ask turtles [hubnet-send-override playerName self "hidden?" [true]]
  ask displayElements [hubnet-send-override playerName self "hidden?" [false]]


end

to-report clicked-button [ currentPixLoc ]

  ;; checks the boundaries of a click message against those of a 'button' to see if it was the one clicked
  ;; inputs are boundaries in PIXEL SPACE

  let xPixel ((item 0 hubnet-message) - min-pxcor + 0.5) * patch-size
  let yPixel (max-pycor + 0.5 - (item 1 hubnet-message)) * patch-size
  let xPixMin item 0 currentPixLoc
  let xPixMax item 0 currentPixLoc + item 2 currentPixLoc
  let yPixMin item 1 currentPixLoc
  let yPixMax item 1 currentPixLoc + item 3 currentPixLoc
  ifelse xPixel > xPixMin and xPixel < xPixMax and yPixel > yPixMin and yPixel < yPixMax [  ;; player "clicked"  the current button
    report true
  ] [
    report false
  ]

end

to-report clicked-avatar [ currentPatchLoc ]

  ;; checks the boundaries of a click message against those of an avatar to see if it was the one clicked
  ;; inputs are boundaries in PATCH SPACE

  let xPatch ((item 0 hubnet-message))
  let yPatch ((item 1 hubnet-message))
  let xPatchMin item 0 currentPatchLoc
  let xPatchMax item 0 currentPatchLoc + item 2 currentPatchLoc
  let yPatchMin item 1 currentPatchLoc
  let yPatchMax item 1 currentPatchLoc + item 3 currentPatchLoc
  ifelse xPatch > xPatchMin and xPatch < xPatchMax and yPatch > yPatchMin and yPatch < yPatchMax [  ;; player "clicked"  the current avatar
    report true
  ] [
    report false
  ]

end

to make-borders
    ;; make border around pasture parcels
  ;; do this using 'border' agents that stamp an image of themselves between patches and then die
  ;; note:  if you have wraparound, the setxy line has to be modified to account for this



  ask patches with [pxcor >= 0 and pycor < max-pycor] [
    sprout-borders 1 [set color border_color
      setxy pxcor pycor + 0.5
      set heading 90
      stamp die]
  ]

  ask patches with [pxcor >= 0 and pxcor < max-pxcor] [
    sprout-borders 1 [set color border_color
      setxy pxcor + 0.5 pycor
      set heading 0
      stamp die]
  ]
end

to-report update-patch-color

  let currentColor 0
  if inGame? [
    ;; update appearance of grass patches
    let currentRGB_R (1 - (pastureGrowth / grassK)) * rgb_R

    ifelse selected? [
      set currentColor (list (currentRGB_R * selectedShading) (rgb_G * selectedShading) (rgb_B * selectedShading) )


    ] [
      set currentColor (list currentRGB_R rgb_G rgb_B)


    ]
  ]

  report currentColor
end

to mark-day-travel [currentPatch patchesPerDay currentPlayer]
    ;; make border around travel radii
  ;; do this using 'border' agents that stamp an image of themselves between patches and then die
  ;; note:  if you have wraparound, the setxy line has to be modified to account for this

  ask patches with [inGame?] [
    let euclidDist distance currentPatch
    let numDays ceiling (euclidDist / patchesPerDay)
    let x1 pxcor
    let y1 pycor
    let myDay numDays
    ask neighbors4 [
      let neighborDist distance currentPatch
      let neighborDays ceiling (neighborDist / patchesPerDay)
      let x2 pxcor
      let y2 pycor
     if neighborDays != myDay [
       sprout-borders 1 [
          set hidden? true
          hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [false]
          set color red
          setxy mean (list x1 x2) mean (list y1 y2)
          ifelse y1 != y2 [set heading 90] [set heading 0]
         ]
      ]
    ]

    let shadedColor (list ((item 0 pcolor) * (1 + numDays * dayDistanceShading)) ((item 1 pcolor) * (1 + numDays * dayDistanceShading)) ((item 2 pcolor) * (1 + numDays * dayDistanceShading)))
    hubnet-send-override (item (currentPlayer - 1) playerNames) self "pcolor" [shadedColor]
  ]



end

to make-shared-borders
    ;; make border around shared parcels
  ;; do this using 'border' agents that stamp an image of themselves between patches and then die
  ;; note:  if you have wraparound, the setxy line has to be modified to account for this

  ask patches with [shared?] [
    let x1 pxcor
    let y1 pycor
    ask neighbors4 [
      let x2 pxcor
      let y2 pycor
     if not shared?  [
       sprout-borders 1 [set color black

         setxy mean (list x1 x2) mean (list y1 y2)
         ifelse y1 != y2 [set heading 90] [set heading 0]
         stamp die]


      ]
    ]

  ]

end

to make-private-borders
    ;; make border around shared parcels
  ;; do this using 'border' agents that stamp an image of themselves between patches and then die
  ;; note:  if you have wraparound, the setxy line has to be modified to account for this

  ask patches with [ownedBy > 0] [
    let currentOwner ownedBy
    let x1 pxcor
    let y1 pycor

    sprout 1 [set size 0.2 setxy pxcor - 0.25 pycor + 0.25 set shape "house" set color (item (currentOwner - 1) playerHerdColor) stamp die]

    ask neighbors4 [
      let x2 pxcor
      let y2 pycor
      let neighborOwner ownedBy
     if neighborOwner != currentOwner  [
       sprout-borders 1 [set color (item (currentOwner - 1) playerHerdColor)
         setxy mean (list x1 x2) mean (list y1 y2)
         ifelse y1 != y2 [set heading 90] [set heading 0]
         stamp die]


      ]
    ]

  ]

end

to update-rain-boxes [ currentRain]
  ask displayElements with [phase = currentPhase and rain?] [
    set shape "square"
    set color scale-color blue currentRain 0 maxColorRain

  ]
  ask displayElements with [phase = (currentPhase + 1) and rain?] [
   set color red
  ]
end

to reset-rain-boxes
  ask displayElements with [rain?] [
    set shape "square outline"
    set color white
  ]
  ask displayElements with [rain? and phase = currentPhase] [
   set color red
  ]
end

to make-rain-boxes
  let maxRainBoxSize (item 2 climBoxPatchLoc) / (length climList)
  set displayRainBoxSize (min list displayRainBoxSize maxRainBoxSize )

  let boxSpots 0
  create-displayElements length climList [
    setxy ((item 0 climBoxPatchLoc) + displayRainBoxSize / 2 + boxSpots * displayRainBoxSize) (item 1 climBoxPatchLoc) - displayRainBoxSize / 2
    set boxSpots boxSpots + 1
    set phase boxSpots
    set rain? false
    set toggle? false
    set color scale-color blue (item (phase - 1) climList) 0 maxColorRain
    set shape "square"
    set size displayRainBoxSize
    set hidden? true
    hubnet-send-override "display" self "hidden?" [false]
  ]

  set boxSpots 0
  create-displayElements length climList [
    setxy ((item 0 rainBoxPatchLoc) + displayRainBoxSize / 2 + boxSpots * displayRainBoxSize) (item 1 rainBoxPatchLoc) - displayRainBoxSize / 2
    set boxSpots boxSpots + 1
    set phase boxSpots
    set rain? true
    set toggle? false
    set color white
    set shape "square outline"
    set size displayRainBoxSize
    set hidden? true
    hubnet-send-override "display" self "hidden?" [false]
  ]

  create-displayElements 1 [
   setxy ((item 0 rainBoxPatchLoc) - displayRaindropSize / 2 ) (item 1 climBoxPatchLoc) + displayRainBoxSize / 2 - displayRaindropSize / 2
    set shape "raindrops"
    set rain? false
    set toggle? false
    set phase -9999
    set size displayRaindropSize
    set hidden? true
    hubnet-send-override "display" self "hidden?" [false]
  ]
end

to make-panel-border
  ask patches with [pxcor = min-pxcor] [sprout-panelEdges 1 [set heading -90]]
  ask patches with [pxcor = -1] [sprout-panelEdges 1 [set heading 90]]
  ask patches with [(pycor = min-pycor) and (pxcor < 0)] [sprout-panelEdges 1 [set heading 180]]
  ask patches with [(pycor = max-pycor) and (pxcor < 0)] [sprout-panelEdges 1 [set heading 0]]

  ask panelEdges [
    set color white
        foreach (playerPosition) [ ?1 ->
        hubnet-send-override (item (?1 - 1) playerNames) self "color" [item (?1 - 1) playerHerdColor]
      ]
  ]
end

to make-day-boxes
  let maxDayBoxSize (item 2 dayBoxPatchLoc) / phaseLengthDays
  set panelDayBoxSize (min list panelDayBoxSize maxDayBoxSize )

  let boxSpots 0
  create-dayBoxes phaseLengthDays [
    setxy ((item 0 dayBoxPatchLoc) + panelDayBoxSize / 2 + boxSpots * panelDayBoxSize) (item 1 dayBoxPatchLoc) - panelDayBoxSize / 2
    set boxSpots boxSpots + 1
    set day boxSpots
    set color white
    set size panelDayBoxSize
    set state 0
    foreach (playerPosition) [ ?1 ->
      hubnet-send-override (item (?1 - 1) playerNames) self "hidden?" [true]
    ]
    hatch-workIcons 1 [
      set size panelDayBoxSize * 0.7
      set hidden? true
      set ID workID
      foreach (playerPosition) [ ?1 ->
        hubnet-send-override (item (?1 - 1) playerNames) self "color" [item (?1 - 1) playerHerdColor]
      ]
    ]
    hatch-restIcons 1 [
      set size panelDayBoxSize * 0.7
      set hidden? true
      set ID restID
      foreach (playerPosition) [ ?1 ->
        hubnet-send-override (item (?1 - 1) playerNames) self "color" [item (?1 - 1) playerHerdColor]
      ]
    ]
    hatch-moveIcons 1 [
      set size panelDayBoxSize * 0.7
      set hidden? true
      set ID moveID
      foreach (playerPosition) [ ?1 ->
        hubnet-send-override (item (?1 - 1) playerNames) self "color" [item (?1 - 1) playerHerdColor]
      ]
    ]
  ]


end

to populate-game-board

  foreach playerPosition [ ?1 ->
    let homePatch []
    ifelse any? patches with [ownedBy = ?1] [

      set homePatch one-of patches with [ownedBy = ?1]
    ] [

      set homePatch one-of patches with [inGame? and ownedBy < 0]
    ]

    ask homePatch [
      set playerHerdCountHere replace-item (?1 - 1) playerHerdCountHere 1
      sprout-animals (item 0 (item (?1 - 1) playerHerds)) [
        set size patchAnimalSize
        setxy pxcor - 0.5 + random-float 1 pycor - 0.5 + random-float 1
        set consumptionHistory n-values needsDays [animalNeeds]
        set avatar? false
        set projection? false
        set currentStep? true
        set herdNumber 1
        set herdedBy -9999
        set startTurnPatch homePatch
        set arrivedOn 0
        set owner ?1
        hubnet-send-override "display" self "hidden?" [true]
      update-color]


      sprout-people numHH [
        set personID who
        set size patchPersonSize
        setxy pxcor - 0.5 + random-float 1 pycor - 0.5 + random-float 1

        set owner ?1
        set avatar? false
        set active? false
        set projection? false
        set currentStep? true
        set viewer -9999
        set startTurnPatch homePatch
        set arrivedOn 0
        set schedule (list)
        set herd -9999
        update-color
        hubnet-send-override "display" self "hidden?" [true]
      ]
    ]


  ]

end

to update-panel [xPatch yPatch currentPlayer]

  ;; wipe whatever was in the panel viewed by this player
  ask turtles with [avatar? = true and viewer = currentPlayer] [die]

  ask dayBoxes [hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [true]]
  ask workIcons [hubnet-clear-override (item (currentPlayer - 1) playerNames) self "hidden?"]
  ask restIcons [hubnet-clear-override (item (currentPlayer - 1) playerNames) self "hidden?"]
  ask moveIcons [hubnet-clear-override (item (currentPlayer - 1) playerNames) self "hidden?"]
  ask grassBars [hubnet-clear-override (item (currentPlayer - 1) playerNames) self "hidden?"]
  ask grassBars [hubnet-clear-override (item (currentPlayer - 1) playerNames) self "color"]

  ask patch xPatch yPatch [
    ifelse item (currentPlayer - 1) viewedBy? [ ;; the square has previously been selected, and needs to be unselected

      set viewedBy? replace-item (currentPlayer - 1) viewedBy? false
      hubnet-clear-override (item (currentPlayer - 1) playerNames) self "pcolor"
      set playerViewingPatch replace-item (currentPlayer - 1) playerViewingPatch 0

    ] [ ;; the square was not previously selected and now is; previous view needs to be cleared and previous cell released

      ;;clear the markers from what was previously being viewed
      if is-agent? item (currentPlayer - 1) playerViewingPatch [
        ask item (currentPlayer - 1) playerViewingPatch [
          set viewedBy? replace-item (currentPlayer - 1) viewedBy? false
          hubnet-clear-override (item (currentPlayer - 1) playerNames) self "pcolor"]
      ]
      set playerViewingPatch replace-item (currentPlayer - 1) playerViewingPatch self


      ;;mark existing herds
      mark-herds currentPlayer

      let numHerdsHere count herdCrosses with [viewer = currentPlayer]

      ;;instantiate the animal 'avatars' for the current view
      ask animals-here [

        let myColor color
        let myOwner owner
        let myHerd herdNumber
        let myProjection projection?
        let myArrived arrivedOn
        let myHerdedBy herdedBy
        hatch  1 [
          create-link-with myself [set hidden? true]
          set hidden? true
          hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [false]
          set owner myOwner
          set color myColor
          set size panelAnimalSize
          set avatar? true
          set projection? myProjection
          set viewer currentPlayer
          set arrivedOn myArrived
          set herdNumber myHerd
          set herdedBy myHerdedBy

        ]
      ]

      place-animal-avatars currentPlayer

      ask people-here [

        let myColor color
        let myOwner owner
        let mySchedule schedule
        let myProjection projection?
        let myArrived arrivedOn
        let myStep currentStep?
        let myID personID
        hatch  1 [
          set personID myID
          create-link-with myself [set hidden? true]
          set hidden? true
          hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [false]
          set owner myOwner
          set color myColor
          set schedule mySchedule
          set size panelPersonSize
          set avatar? true
          set active? false
          set projection? myProjection
          set arrivedOn myArrived
          set currentStep? myStep
          set viewer currentPlayer

        ]
      ]

      place-people-avatars currentPlayer

      ;;update the grassbar
      let grassSize pastureGrowth / grassK * (item 2 grassBarPatchLoc)
      let currentColor pcolor
      ask grassBars with [xcor <= (item 0 grassBarPatchLoc) - (item 2 grassBarPatchloc) / 2 + grassSize] [
        hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [false]
        hubnet-send-override (item (currentPlayer - 1) playerNames) self "color" [currentColor]

      ]

      let shadedColor (list ((item 0 pcolor) * selectedShading) ((item 1 pcolor) * selectedShading) ((item 2 pcolor) * selectedShading))
      hubnet-send-override (item (currentPlayer - 1) playerNames) self "pcolor" [shadedColor]
      set viewedBy? replace-item (currentPlayer - 1) viewedBy? true



    ]



  ]

end

to place-people-avatars [currentPlayer]

  let topSpots 0
  let bottomSpots 0
  ask people with [avatar? and viewer = currentPlayer] [

    ifelse owner = viewer [ ;;person is assigned to a herd already
     let myHerd herd
      let assignedHerdMarker herdCrosses with [viewer = currentPlayer and herd = myHerd]
      let numHerdsHere count herdCrosses with [viewer = currentPlayer]

      ifelse any? assignedHerdMarker  [

        let currentSlot [slot] of one-of assignedHerdMarker
        let herdWidth (item 2 assignedHerdPatchLoc) / numHerdsHere
        let herdXPatchLoc (item 0 assignedHerdPatchLoc) + (currentSlot - 1) * herdWidth
        setxy (herdXPatchLoc + panelPersonSize / 2) ((item 1 assignedHerdPatchLoc) - panelPersonSize / 2 )

      ] [
        setxy  ((item 0 assignedHerdPatchLoc) + 0.02 * world-width + topSpots * panelPersonSize ) ((item 1 assignedHerdPatchLoc) + .08 * world-height )
        set topSpots topSpots + 1
      ]

    ] [
      setxy  ((item 0 otherHerdPatchLoc) + 0.2 * world-width + bottomSpots * panelPersonSize ) ((item 1 otherHerdPatchLoc) - (item 3 otherHerdPatchLoc) - 0.05 * world-height )
      set bottomSpots bottomSpots + 1
    ]
  ]
end

to place-animal-avatars [currentPlayer]

  ask animals with [avatar? and viewer = currentPlayer] [

    ifelse owner = viewer [
     let myHerd herdNumber
      let assignedHerdMarker herdCrosses with [viewer = currentPlayer and herd = myHerd]
      let numHerdsHere count herdCrosses with [viewer = currentPlayer]

      ifelse any? assignedHerdMarker  [

        let currentSlot [slot] of one-of assignedHerdMarker
        let herdWidth (item 2 assignedHerdPatchLoc) / numHerdsHere
        let herdXPatchLoc (item 0 assignedHerdPatchLoc) + (currentSlot - 1) * herdWidth
        setxy (herdXPatchLoc + random-float herdWidth) ((item 1 assignedHerdPatchLoc) - random-float (item 3 assignedHerdPatchLoc) )

        ;;check - if these animals are not 'currentStep?' then the cross shouldn't be either
        let myCurrentStep currentStep?
        ask one-of assignedherdMarker [set currentStep? myCurrentStep]

      ] [
        setxy  ((item 0 unassignedHerdPatchLoc) + random-float (item 2 unassignedHerdPatchLoc)) ( (item 1 unassignedHerdPatchLoc) - random-float (item 3 unassignedHerdPatchLoc))
      ]

    ] [
      setxy  ((item 0 otherHerdPatchLoc) + random-float (item 2 otherHerdPatchLoc)) ((item 1 otherHerdPatchLoc) - random-float (item 3 otherHerdPatchLoc))
    ]
  ]
end

to add-herd [currentPlayer]

  let currentPatch item (currentPlayer - 1) playerViewingPatch
  let currentCount 0
  ask currentPatch [
    set currentCount (item (currentPlayer - 1) playerHerdCountHere) + 1
    set playerHerdCountHere replace-item (currentPlayer - 1) playerHerdCountHere currentCount
  ]

  ask currentPatch [mark-herds currentPlayer place-animal-avatars currentPlayer]


end

to cut-herd [currentPlayer]

  let currentPatch item (currentPlayer - 1) playerViewingPatch
  let currentCount 0
  ask currentPatch [
    set currentCount (item (currentPlayer - 1) playerHerdCountHere) - 1

    ;; if there are any animals here of the owner's, there must be at least one herd
    if any? animals-here with [owner = currentPlayer] [ set currentCount (max (list currentCount 1))]

    set playerHerdCountHere replace-item (currentPlayer - 1) playerHerdCountHere currentCount
  ]

  ask currentPatch [
    mark-herds currentPlayer
    place-animal-avatars currentPlayer
    place-people-avatars currentPlayer
  ]

end

to mark-herds [currentPlayer]


  let currentCount [item (currentPlayer - 1) playerHerdCountHere] of self

  if currentCount > 0 [ ;; if there are animals of the current player, currently here

    let herdList sort remove-duplicates ([herdNumber] of animals-here with [herdNumber > 0 and owner = currentPlayer])
    let maxHerdNumber 0
    if not empty? herdList [set maxHerdNumber max herdList]

    ask herdLines with [viewer = currentPlayer] [die]
    ask herdCrosses with [viewer = currentPlayer] [die]
    let herdWidth (item 2 assignedHerdPatchLoc) / currentCount
    let herdSpots 0
    sprout-herdLines currentCount [
      set hidden? true
      hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [false]
      set viewer currentPlayer
      set avatar? true
      setxy  ((item 0 assignedHerdPatchLoc) + herdSpots * herdWidth ) ((item 1 assignedHerdPatchLoc) - (item 3 assignedHerdPatchLoc) / 2)
      set size item 3 assignedHerdPatchLoc
      set heading 0
      set color black
      hatch-herdCrosses 1 [
        set hidden? true
        hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [false]
        set viewer currentPlayer
        set avatar? true
        set currentStep? true
        set size panelHerdCrossSize
        setxy  ((item 0 assignedHerdPatchLoc) + (herdSpots + 1) * herdWidth - panelHerdCrossSize ) ((item 1 assignedHerdPatchLoc) + panelHerdCrossSize )
        set heading 0
        set color red
        ifelse not empty? herdList [
         set herd item 0 herdList
         set  herdList but-first herdList
        ] [
         set maxHerdNumber maxHerdNumber + 1
         set herd maxHerdNumber
        ]
      set herdSpots herdSpots + 1
      set slot herdSpots
      ]


    ]

  ]

end

to-report walking-speed [numAnimals]

  let speed baseSquaresPerDay * (1 - numAnimals * fracBaseSlowPerAnimal)
  report speed

end

to view-next-location [avatar]
  let herdSize 0
  let patchesPerDay baseSquaresPerDay

  if [herd] of avatar > 0 [
    let numAnimals count animals with [avatar? and viewer = [owner] of avatar and herdNumber = [herd] of avatar]
    set patchesPerDay walking-speed numAnimals
  ]



  let currentPatch one-of [patch-here] of [link-neighbors] of avatar

  mark-day-travel currentPatch patchesPerDay ([owner] of avatar)

end

to-report estimate-p-survival

  let currentHpA 0
  if herdedBy > 0 [
    let myID herdedBy
    let numAnimals count animals with [herdedBy = myID and not projection?]
    set currentHpA (1 / numAnimals)
  ]
  let dHpA max (list 0 (HpA_base - currentHpA))

  let fracNeeds (length filter [ ?1 -> ?1 >= animalNeeds ] consumptionHistory) / needsDays

  let dfNeeds 1 - fracNeeds


  let pSurvival pS_base - dP_dHpA * dHpA - dP_dfNeeds * dfNeeds

  report pSurvival

end

to update-reserve

  ask bales-here [die]
  let baleSize animalNeeds * grassBarTickSpace
  let numBales floor (storedGrass  / baleSize)

  let balesPerRow floor (1 / patchBaleSize) - 1
  let baleSpots 0
  let xStart pxcor - 0.5 + patchBaleSize / 2
  let yStart pycor - 0.5 + patchBaleSize / 2
  while [numBales > 0] [
    sprout-bales 1 [set size patchBaleSize
      setxy (xStart + (baleSpots mod balesPerRow) * patchBaleSize) (yStart + floor (baleSpots / balesPerRow) * patchBaleSize)
      hubnet-send-override "display" self "hidden?" [true]
    ]
    set numBales numBales - 1
    set baleSpots baleSpots + 1

  ]

end

to update-color


    ifelse currentStep? [
      set color (item (owner - 1) playerHerdColor)
    ][
      set color (item (owner - 1) playerHerdColor) - projectionColorShift
    ]

end

to select-new-location [xPatch yPatch currentPlayer avatar]

  ;;identify the patch
  let newPatch patch xPatch yPatch
  let currentPatch [patch-here] of one-of [link-neighbors] of avatar

  ;;figure out if we can get there in time
  let patchesPerDay baseSquaresPerDay
  let numAnimals 0
  let animalSet []
  if [herd] of avatar > 0 [
    ask currentPatch [
    set animalSet animals-here with [owner  = [owner] of avatar and herdNumber = [herd] of avatar]
    ]
    set numAnimals count animalSet
    set patchesPerDay walking-speed numAnimals
  ]

  let daysLeft phaseLengthDays - (length [schedule] of avatar) + 1
  let euclidDist 0
  ask currentPatch [set euclidDist distance newPatch]
  let numDays ceiling (euclidDist / patchesPerDay)

  if numDays <= daysLeft [ ;;if it is an allowable move

    ;;fill up the schedule from currentDay to currentDay + numDays - 1 with moveID
    let currentSchedule [schedule] of avatar
    set currentSchedule sentence (but-last currentSchedule) (n-values numDays [moveID])
    let arrivalDay length currentSchedule


    ;;mark animals, herd, and herder as no longer the current step
    ask avatar [set schedule currentSchedule
      set currentStep? false
      set active? false
      ask link-neighbors [set schedule currentSchedule
        set currentStep? false
        update-color
        let myHerd herd
        let myOwner owner
        ask animals-here with [owner = myOwner and herdNumber = myHerd] [
          set currentStep? false
          update-color
        ]
      ]
      update-color
    ]

    ;;make sure all points with this herder have the same schedule
    ask people with [personID = [personID] of avatar] [set schedule currentSchedule]

    let myHerd [herd] of avatar
    ask animals with [viewer = currentPlayer and herdNumber = myHerd] [

      set currentStep? false
      update-color
    ]
    ask herdCrosses with [viewer = currentPlayer and herd = myHerd] [
     set currentStep? false
    ]

    ;;make new projection for current avatar/herd in new location
    ask newPatch [

      ;; assign a new number to animals, in case there is another herd there already with the same number
      let herdList sort remove-duplicates ([herdNumber] of animals-here with [herdNumber > 0])
      let maxHerdNumber 0
      if not empty? herdList [set maxHerdNumber max herdList]
      let newHerdNumber maxHerdNumber + 1

      if numAnimals > 0 [
        ask avatar [set herd newHerdNumber]
        let previousHerdcount item (currentPlayer - 1) playerHerdCountHere
        set playerHerdCountHere replace-item (currentPlayer - 1) playerHerdCountHere (previousHerdCount + 1)


        ask animalSet [hatch 1 [
          output-print "new animal"
          create-link-with myself [set hidden? true]
          set size patchAnimalSize
          setxy ([pxcor] of newPatch - 0.5 + random-float 1) ([pycor] of newPatch - 0.5 + random-float 1)

          set avatar? false
          set projection? true
          set currentStep? true

          set herdNumber newHerdNumber
          set herdedBy [personID] of avatar
          set startTurnPatch currentPatch
          set arrivedOn arrivalDay
          set owner currentPlayer
          update-color
           hubnet-send-override "display" self "hidden?" [true]
          ]
        ]
      ]

      sprout-people 1 [
        set personID [personID] of avatar
        set size patchPersonSize
        setxy pxcor - 0.5 + random-float 1 pycor - 0.5 + random-float 1

        set owner currentPlayer
        set avatar? false
        set active? false
        set projection? true
        set currentStep? true
        update-color
        set viewer -9999
        set startTurnPatch currentPatch
        set schedule [schedule] of avatar
        set arrivedOn arrivalDay
        set herd [herd] of avatar
        hubnet-send-override "display" self "hidden?" [true]
      ]

      ask borders [die]
      ask patches with [inGame?] [
        hubnet-clear-override (item (currentPlayer - 1) playerNames) self "pcolor"
      ]
      set playerChoosingMove replace-item (currentPlayer - 1) playerChoosingMove false


    ]

    ask currentPatch [ask pointers-here with [owner = currentPlayer] [die]]


    let currentPathOwner [personID] of avatar

    create-connections 1 [
      setxy ([pxcor] of newPatch + [pxcor] of currentPatch) / 2 ([pycor] of newPatch + [pycor] of currentPatch) / 2
      set size euclidDist
      set heading atan ([pxcor] of newPatch - [pxcor] of currentPatch)  ([pycor] of newPatch - [pycor] of currentPatch)
      set color (item (currentPlayer - 1) playerHerdColor)
      set arrivedOn arrivalDay
      set owner currentPlayer
      set projection? true
      set pathOf [personID] of avatar
      set herd [herd] of avatar
      hatch-pointers 1 [
        setxy ([pxcor] of newPatch ) ([pycor] of newPatch )
        set size patchPointerSize
        set heading atan ([pxcor] of newPatch - [pxcor] of currentPatch)  ([pycor] of newPatch - [pycor] of currentPatch)
        set color (item (currentPlayer - 1) playerHerdColor)
        set arrivedOn arrivalDay
        set owner currentPlayer
        set projection? true
        set pathOf [personID] of avatar
        set herd [herd] of avatar
         hubnet-send-override "display" self "hidden?" [true]
      ]

    ]

    ask newPatch [
      sprout-pathCrosses 1 [
        set hidden? true
        hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [false]
        set viewer currentPlayer
        set owner currentPlayer
        set projection? true
        set avatar? false
        set currentStep? true
        set size panelHerdCrossSize
        setxy  ([pxcor] of newPatch + 0.5 - (panelHerdCrossSize / 2)) ([pycor] of newPatch + 0.5 - (panelHerdCrossSize / 2))
        set pathOwner [personID] of avatar
        set arrivedOn arrivalDay
        set heading 0
        set color red
         hubnet-send-override "display" self "hidden?" [true]
      ]
    ]
    update-panel xPatch yPatch currentPlayer


    ;;if this patch is private or shared and herder is bringing animals, need to mark it pending
    ask newPatch [
      if numAnimals > 0 and (shared? or (ownedBy > 0 and not (ownedBy = currentPlayer))) [
        sprout-pendingSquares 1 [
          set permissions n-values numPlayers [false]
          set color item (currentPlayer - 1) playerHerdColor
          set size 1.15
          set owner currentPlayer
          set pathOf currentPathOwner
          set arrivedOn arrivalDay
          if ownedBy > 0 [
            ;; only the owner and the mover need to see it
            foreach playerPosition [ ?1 ->
              if (not (?1 = ownedBy) and not (?1 = currentPlayer)) [
                hubnet-send-override (item (?1 - 1) playerNames) self "hidden?" [true]
              ]
            ]
          ]

        ]

        ;if this isn't the first one here, position it down just a little bit
        let countChecks count permChecks-here

        let checkCrossSize panelHerdCrossSize * permCheckCrossScalar

        sprout-permChecks 1 [set color item (currentPlayer - 1) playerHerdColor; sky
          setxy pxcor - 0.5 + checkCrossSize  pycor + 0.5 - checkCrossSize - permCheckCrossOffset * countChecks
          set size checkCrossSize
          set owner currentPlayer
          hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [true]
          if ownedBy > 0 [
            ;; only the owner and the mover need to see it
            foreach playerPosition [ ?1 ->
              if (not (?1 = ownedBy)) [
                hubnet-send-override (item (?1 - 1) playerNames) self "hidden?" [true]
              ]
            ]
          ]
        ]
        sprout-permCrosses 1 [set color item (currentPlayer - 1) playerHerdColor; red
          setxy pxcor + 0.5 - checkCrossSize   pycor + 0.5 - checkCrossSize - permCheckCrossOffset * countChecks
          set size checkCrossSize
          set owner currentPlayer
          hubnet-send-override (item (currentPlayer - 1) playerNames) self "hidden?" [true]
          if ownedBy > 0 [
            ;; only the owner and the mover need to see it
            foreach playerPosition [ ?1 ->
              if (not (?1 = ownedBy)) [
                hubnet-send-override (item (?1 - 1) playerNames) self "hidden?" [true]
              ]
            ]
          ]
        ]
      ]
    ]
  ]
end

to unconfirm-all
  foreach playerPosition [ ?1 ->
    set playerConfirm replace-item (?1 - 1) playerConfirm 0
    ask patches with [inGame?] [hubnet-clear-override (item (?1 - 1) playerNames) self "pcolor"]

    send-game-info (?1 - 1)
  ]

end

to undo-projections [arrivalDay currentPlayer currentPathOwner xPatch yPatch]

  ask animals with [herdedBy = currentPathOwner and arrivedOn >= arrivalDay and owner = currentPlayer] [if projection? [die]]
  ask people with [personID = currentPathOwner and arrivedOn >= arrivalDay and owner = currentPlayer] [if projection? [die]]
  ask connections with [pathOf = currentPathOwner and arrivedOn >= arrivalDay and owner = currentPlayer] [if projection? [die]]
  ask pathCrosses with [pathOwner = currentPathOwner and arrivedOn >= arrivalDay and owner = currentPlayer] [if projection? [die]]
  ask pointers with [pathOf = currentPathOwner and arrivedOn >= arrivalDay and owner = currentPlayer] [if projection? [die]]
  ask patch xPatch yPatch [
    ask pendingSquares-here with [owner = currentPlayer] [die]
    ask permCrosses-here with [owner = currentPlayer] [die]
    ask permChecks-here with [owner = currentPlayer] [die]

    ;;update the number of herds the patch believes are here from this player
    set playerHerdCountHere replace-item (currentPlayer - 1) playerHerdCountHere (length remove-duplicates [herdNumber] of animals-here with [herdedBy = currentPathOwner])
  ]
  let currentSchedule [schedule] of one-of people with [personID = currentPathOwner]
  let latestArrival max [arrivedOn] of people with [personID = currentPathOwner]


  set currentSchedule sublist currentSchedule 0 (arrivalDay - 1)

  let finished? false
  while [not finished? and length currentSchedule > 0] [
   ifelse (last currentSchedule = moveID) and length currentSchedule > latestArrival [
      set currentSchedule but-last currentSchedule
    ] [
      set finished? true
    ]
  ]

  ask people with [personID = currentPathOwner] [set schedule currentSchedule]

  ask animals with [arrivedOn = latestArrival and herdedBy = currentPathOwner and owner = currentPlayer] [set currentStep? true]
  ask people with [arrivedOn = latestArrival and personID = currentPathOwner and owner = currentPlayer] [set currentStep? true]

  ask animals with [owner = currentPlayer] [update-color]
  ask people with [owner = currentPlayer] [update-color]

  set playerChoosingMove replace-item (currentPlayer - 1) playerChoosingMove false

end
@#$#@#$#@
GRAPHICS-WINDOW
279
10
1367
739
-1
-1
120.0
1
50
1
1
1
0
0
0
1
-3
5
0
5
0
0
0
ticks
30.0

BUTTON
22
306
169
339
Launch Next Game
start-game
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
24
87
165
120
Launch Broadcast
start-hubnet
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
24
126
155
159
Listen to Clients
listen
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

CHOOSER
26
669
164
714
language
language
"English"
0

BUTTON
27
721
185
754
Set up Panel
set-language
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

INPUTBOX
24
12
259
72
inputParameterFileName
sharedGrassParams_test.csv
1
0
String

INPUTBOX
23
173
252
233
sessionID
101.0
1
0
Number

BUTTON
22
254
165
287
Initialize Session
initialize-session
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

OUTPUT
10
370
250
628
13

TEXTBOX
462
796
612
824
Buttons for emergency use ONLY:
11
14.0
1

BUTTON
636
792
760
825
Unconfirm ALL
unconfirm-all
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
772
780
975
825
playerConfirm
playerConfirm
17
1
11

TEXTBOX
774
756
993
784
A '1' means the player has confirmed
11
0.0
1

SWITCH
1029
784
1177
817
allowGameSkip
allowGameSkip
0
1
-1000

@#$#@#$#@
## WHAT IS IT?

A multiplayer game for the use of a pasture commons, including options of land with private and and shared restricted use.

## HOW IT WORKS

This is a turn-based game, with each turn (phase) ending when all players have confirmed their actions for the phase.  Each game may open with the following phases:

> Marking land out as shared village reserve land - all players may visit or work on this land, but grazing this land requires permission of all other players.

> Marking land out as private - any player may visit or work on another's privately held land, but grazing this land requires permission of the owner.

Following these initial phases, game play begins, with each turn continuing until all players have 'confirmed' their choices.  Each player will have several household members and some number of animals.  The turn consists of planning the household members' actions for the duration of the turn, which may include i) doing nothing, ii) moving (with or without animals), or iii) harvesting grass to dry.  Animals require grass every day and must be moved when grass reserves are too low.

Specific actions:

> Tap on a grass square to select it, and see who and what is there in the left-hand panel

> Tap one of your own household members above the Herds to select them and assign them to herds, or remove them from herds they are assigned to

> Tap the + sign to add additional 'herds' to which animals can be assigned

> Tap the x signs to empty herds (into unassigned) or remove empty herds

> Tap the white boxes at the bottom when a person is selected to choose their actions

> Tap a 'destination' grass square when a 'move' action is selected in the white box to choose a place to move to

> Tap x signs around destinations you've chosen to eliminate those plans

> Tap x or check marks around decisions others have made in your or shared land to reject or approve them.

## GAME START INSTRUCTIONS

> 1. Log all of your tablets onto the same network.  If you are in the field using a portable router, this is likely to be the only available wifi network.

> 2. Open the game file on your host tablet.  Zoom out until it fits in your screen

> 3. If necessary, change the language setting on the host.

> 4. Click ‘Launch Broadcast’.  This will reset the software, as well as read in the file containing all game settings.

> 5. Select ‘Mirror 2D view on clients’ on the Hubnet Control Center.

> 6. Click ‘Listen Clients’ on the main screen.  This tells your tablet to listen for the actions of the client computers.  If there ever are any errors generated by Netlogo, this will turn off.  Make sure you turn it back on after clearing the error.

> 7. Open Hubnet on all of the client computers.  Enter the player names in the client computers, in the form ‘PlayerName_HHID’.

> 8. If the game being broadcast shows up in the list, select it.  Otherwise, manually type in the server address (shown in ‘Hubnet Control Center’).

> 9. Click ‘Enter’ on each client.

> 10. Back on the host tablet, select the appropriate session ID, and click ‘Initialize Session’.

> 11. Click 'Launch Next Game' to start game.

** A small bug – once you start *EACH* new game, you must have one client exit and re-enter.  For some reason the image files do not load initially, but will load on all client computers once a player has exited and re-entered.  I believe this is something to do with an imperfect match between the world size and the client window size, which auto-corrects on re-entry.  Be sure not to change the player name or number when they re-enter.


## SUBMODELS

> Grass growth model

> Animal survival model

> Walking pace (with and without animals)

## NETLOGO FEATURES


SharedGrass exploits the use of the bitmap extension, agent labeling, and hubnet overrides to get around the limitations of NetLogo's visualization capacities.

In the hubnet client, all actual buttons are avoided.  Instead, the world is extended, with patches to the right of the origin capturing elements of the game play, and patches to the left of the origin being used only to display game messages.

Language support is achieved by porting all in-game text to bitmap images that are loaded into the view.

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

bar
true
0
Rectangle -7500403 true true 0 0 300 30

blank
true
0

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

check
false
0
Polygon -7500403 true true 55 138 22 155 53 196 72 232 91 288 111 272 136 258 147 220 167 174 208 113 280 24 257 7 192 78 151 138 106 213 87 182

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

crook
false
0
Polygon -7500403 true true 135 285 135 90 90 60 90 30 135 0 180 15 210 60 195 75 180 30 135 15 105 30 105 60 150 75 150 285 135 285

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

hay
false
0
Polygon -1184463 true false 50 187 97 222 119 234 178 236 219 234 248 211 272 182 205 122 219 50 204 78 203 40 194 95 190 29 178 111 168 22 160 103 142 34 139 98 126 37 128 99 118 45 124 124 96 38 108 114
Polygon -6459832 true false 110 116 138 127 164 126 210 118 214 129 171 144 123 143 102 125 99 121 106 113

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

person cutting
false
0
Circle -7500403 true true 65 5 80
Polygon -7500403 true true 60 90 75 195 45 285 60 300 90 300 105 225 120 300 150 300 165 285 135 195 150 90
Rectangle -7500403 true true 82 79 127 94
Polygon -7500403 true true 150 90 195 150 180 180 120 105
Polygon -7500403 true true 60 90 15 150 30 180 90 105
Polygon -6459832 true false 165 210 210 120 240 120 255 120 270 90 285 60 285 30 255 15 210 0 255 45 255 90 225 105 210 105 165 195

person resting
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105
Line -16777216 false 125 39 140 39
Line -16777216 false 155 39 170 39
Circle -16777216 true false 136 55 15

person walking
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 165 285 135 270 150 225 210 270 255 210 225 225 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 255 105 240 135 165 120
Polygon -7500403 true true 105 90 60 150 75 180 135 105
Polygon -16777216 true false 120 105 150 105 150 90 180 120 150 150 150 135 120 135

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

raindrops
false
0
Polygon -13345367 true false 114 51 97 82 98 101 115 116 138 108 145 84 145 48 144 20
Polygon -13345367 true false 120 156 103 187 104 206 121 221 144 213 151 189 151 153 150 125
Polygon -13345367 true false 190 96 173 127 174 146 191 161 214 153 221 129 221 93 220 65
Polygon -13345367 true false 216 204 199 235 200 254 217 269 240 261 247 237 247 201 246 173
Polygon -13345367 true false 47 179 30 210 31 229 48 244 71 236 78 212 78 176 77 148

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

sheep 2
false
0
Polygon -7500403 true true 209 183 194 198 179 198 164 183 164 174 149 183 89 183 74 168 59 198 44 198 29 185 43 151 28 121 44 91 59 80 89 80 164 95 194 80 254 65 269 80 284 125 269 140 239 125 224 153 209 168
Rectangle -7500403 true true 180 195 195 225
Rectangle -7500403 true true 45 195 60 225
Rectangle -16777216 true false 180 225 195 240
Rectangle -16777216 true false 45 225 60 240
Polygon -7500403 true true 245 60 250 72 240 78 225 63 230 51
Polygon -7500403 true true 25 72 40 80 42 98 22 91
Line -16777216 false 270 137 251 122
Line -16777216 false 266 90 254 90

square
false
0
Rectangle -7500403 true true 30 30 270 270

square outline
false
4
Polygon -1184463 true true 15 15 285 15 285 285 15 285 15 30 30 30 30 270 270 270 270 30 15 30

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.2.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
VIEW
7
10
1087
730
0
0
0
1
1
1
1
1
0
1
1
1
-3
5
0
5

@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
