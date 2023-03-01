//
//  HUDNode.swift
//  Jumpgame
//
//  Created by Yura Mezhik on 14.02.2023.
//



import SpriteKit

class HUDNode: SKNode{
    
    //MARK: - Properties
    private var topScoreShape: SKShapeNode!
    private var topScoreLbl: SKLabelNode!
    private var gameOverShape: SKShapeNode!
    private var gameOverNode: SKSpriteNode!
    private var againNode: SKSpriteNode!
    private var homeNode: SKSpriteNode!
    
    private var scoreTitleLbl: SKLabelNode!
    private var scoreLbl: SKLabelNode!
    private var highScoreLbl: SKLabelNode!
    private var highScoreTitleLbl: SKLabelNode!
    
    
    private var continueNode: SKSpriteNode!
    private var nextNode: SKSpriteNode!
    
    private var panelNode: SKSpriteNode!
    private var panelTitleLbl: SKLabelNode!
    private var panelSubLbl: SKLabelNode!


    
    var easeScene: EaseScene?
    var mediumScene: MediumScene?
    var hardScene: HardScene?

    var skView: SKView!
    


    private var isHome = false{
        didSet {
            updateBtn(node: homeNode, event: isHome)
        }
    }
    private var isAgain = false{
        didSet {
            updateBtn(node: againNode, event: isAgain)
        }
    }
    private var isContinue = false{
        didSet {
            updateBtn(node: continueNode, event: isContinue)
        }
    }
    private var isNext = false{
        didSet {
            updateBtn(node: nextNode, event: isNext)
        }
    }
    private var isPanel = false{
        didSet {
            updateBtn(node: panelNode, event: isPanel)
        }
    }



    
    
    
    
    //MARK: - Initializes
    override init(){
        super.init()
        setupTopScore()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else {return}
        let node = atPoint(touch.location(in: self))
        
        if node.name == "Home" && !isHome{
            isHome = true
        }
        
        if node.name == "PlayAgain" && !isAgain{
            isAgain = true
        }
        if node.name == "Continue" && !isContinue{
            isContinue = true
        }
        if node.name == "Next" && !isNext{
            isNext = true
        }
        if node.name == "Panel" && !isPanel{
            isPanel = true
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if isHome{
            isHome = false
            print("Home")
        }
        
        if isAgain{
            isAgain = false
            if let _ = easeScene{
                let scene = EaseScene(size: CGSize(width: screenWidth, height: screenHeight))
                scene.scaleMode = .aspectFill
                skView.presentScene(scene, transition: .doorway(withDuration: 1.5))
            }
            if let _ = mediumScene{
                let scene = MediumScene(size: CGSize(width: screenWidth, height: screenHeight))
                scene.scaleMode = .aspectFill
                skView.presentScene(scene, transition: .doorway(withDuration: 1.5))
            }
            if let _ = hardScene{
                let scene = HardScene(size: CGSize(width: screenWidth, height: screenHeight))
                scene.scaleMode = .aspectFill
                skView.presentScene(scene, transition: .doorway(withDuration: 1.5))
            }
        }
        if isContinue{
            isContinue = false
            easeScene?.firstTap = true
            mediumScene?.firstTap = true
            hardScene?.firstTap = true
            removeNode()
        }
        
        if isNext{
            isNext = false
            if let _ = easeScene{
                let scene = MediumScene(size: CGSize(width: screenWidth, height: screenHeight))
                scene.scaleMode = .aspectFill
                skView.presentScene(scene, transition: .doorway(withDuration: 1.5))
            }
            if let _ = mediumScene{
                let scene = HardScene(size: CGSize(width: screenWidth, height: screenHeight))
                scene.scaleMode = .aspectFill
                skView.presentScene(scene, transition: .doorway(withDuration: 1.5))
            }
        }
        
        if isPanel{
            isPanel = false
            removeNode()
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let touch = touches.first else { return }
        
        if let parent = homeNode?.parent{
            isHome = homeNode.contains(touch.location(in: parent))
        }
        
        if let parent = againNode?.parent{
            isAgain = againNode.contains(touch.location(in: parent))
        }
        if let parent = continueNode?.parent{
            isContinue = continueNode.contains(touch.location(in: parent))
        }
        if let parent = nextNode?.parent{
            isNext = nextNode.contains(touch.location(in: parent))
        }
        if let parent = panelNode?.parent{
            isPanel = panelNode.contains(touch.location(in: parent))
        }
        
    }
}

//MARK: - Setups
extension HUDNode {
    
    private func updateBtn(node: SKNode, event: Bool){
        var alpha: CGFloat = 1.0
        if event{
            alpha = 0.5
        }
        
        node.run(.fadeAlpha(to: alpha, duration: 0.1))
    }
    
    private func setupTopScore(){
        let statusH: CGFloat = appDl.isIphoneX ? 88 : 40
        let scoreY: CGFloat = screenHeight - (statusH + 90/2 + 20)
        
        topScoreShape = SKShapeNode(rectOf: CGSize(width: 220, height: 90), cornerRadius: 8.0)
        topScoreShape.fillColor = UIColor(hex: 0x00000, alpha: 0.5)
        topScoreShape.zPosition = 20.0
        topScoreShape.position = CGPoint(x: screenWidth/2, y: scoreY)
        addChild(topScoreShape)
        
        topScoreLbl = SKLabelNode(fontNamed: FontName.wheaton)
        topScoreLbl.fontSize = 60.0
        topScoreLbl.text = "0"
        topScoreLbl.fontColor = .white
        topScoreLbl.zPosition = 25.0
        topScoreLbl.position = CGPoint(x: topScoreShape.frame.midX, y: topScoreShape.frame.midY - topScoreLbl.frame.height/2)
        addChild(topScoreLbl)
    }
    func updateScore(_ score: Int){
        topScoreLbl.text = "\(score)"
        topScoreLbl.run(.sequence([.scale(to: 1.3, duration: 0.1),
                                   .scale(to: 1.0, duration: 0.1),
        ]))
    }
    
    func removeNode(){
        gameOverShape?.removeFromParent()
        gameOverNode?.removeFromParent()
        continueNode?.removeFromParent()
        nextNode?.removeFromParent()
        panelNode?.removeFromParent()
        panelTitleLbl?.removeFromParent()
        panelSubLbl?.removeFromParent()
    }
    
}
//MARK: - GameOver
extension HUDNode {
    
    func createGameOverShape(){
        gameOverShape = SKShapeNode(rect: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight))
        gameOverShape.zPosition = 49.0
        gameOverShape.fillColor = UIColor(hex: 0x000000, alpha: 0.7)
        addChild(gameOverShape)
    }
    
    private func createGamePanel(_ name: String){
        gameOverNode =  SKSpriteNode(imageNamed: name)
       
        
        let scale: CGFloat = appDl.isIphoneX ? 0.6 : 0.7
        
        gameOverNode.setScale(scale)
        gameOverNode.zPosition = 50.0
        gameOverNode.position = CGPoint(x: screenWidth/2, y: screenHeight/2)
        addChild(gameOverNode)
    }
    func setupGameOver(_ score: Int, _ highscore: Int){
        createGameOverShape()
        
        isUserInteractionEnabled = true
        let scale: CGFloat = appDl.isIphoneX ? 0.6 : 0.7
        
        //TODO: - gameOverNode
        createGamePanel("panel-gameOver")
        
       
        
        
       
        
        //TODO: - HomeNode
        homeNode =  SKSpriteNode(imageNamed: "icon-home")
        homeNode.setScale(scale)
        homeNode.zPosition = 55.0
        homeNode.position = CGPoint(x: gameOverNode.frame.minX + homeNode.frame.width/2 + 30, y: gameOverNode.frame.minY + homeNode.frame.height/2 + 30)
        homeNode.name = "Home"
        addChild(homeNode)
        
        //TODO: - PlayAgainNode
        againNode = SKSpriteNode(imageNamed: "icon-playAgain")
        againNode.setScale(scale)
        againNode.zPosition = 55.0
        againNode.position = CGPoint(x: gameOverNode.frame.maxX - againNode.frame.width/2 - 30, y: gameOverNode.frame.minY + againNode.frame.height/2 + 30)
        againNode.name = "PlayAgain"
        addChild(againNode)
        
        
        //TODO: - scoreTitleLabel
        scoreTitleLbl = SKLabelNode(fontNamed: FontName.wheaton)
        scoreTitleLbl.text = "Score:"
        scoreTitleLbl.fontSize = 60.0
        scoreTitleLbl.fontColor = .white
        scoreTitleLbl.zPosition = 55.0
        scoreTitleLbl.position = CGPoint(x: gameOverNode.frame.minX + scoreTitleLbl.frame.width/2 + 30, y: screenHeight/2)
        addChild(scoreTitleLbl)
        
        //TODO: - ScoreLabel
        scoreLbl = SKLabelNode(fontNamed: FontName.wheaton)
        scoreLbl.text = "\(score)"
        scoreLbl.fontSize = 60.0
        scoreLbl.fontColor = .white
        scoreLbl.zPosition = 55.0
        scoreLbl.position = CGPoint(
            x: gameOverNode.frame.maxX - scoreLbl.frame.width/2 - 30,
            y: scoreTitleLbl.position.y)
        addChild(scoreLbl)
        
        
        
        
        //TODO: - HighScoreTitleLabel
        highScoreTitleLbl = SKLabelNode(fontNamed: FontName.wheaton)
        highScoreTitleLbl.text = "Highscore:"
        highScoreTitleLbl.fontSize = 60.0
        highScoreTitleLbl.fontColor = .white
        highScoreTitleLbl.zPosition = 55.0
        highScoreTitleLbl.position = CGPoint(
            x: gameOverNode.frame.minX + highScoreTitleLbl.frame.width/2 + 30,
            y: screenHeight/2 - highScoreTitleLbl.frame.height*2)
        addChild(highScoreTitleLbl)
        
        
        //TODO: - HighScoreLabel
        highScoreLbl = SKLabelNode(fontNamed: FontName.wheaton)
        highScoreLbl.text = "\(highscore)"
        highScoreLbl.fontSize = 60.0
        highScoreLbl.fontColor = .white
        highScoreLbl.zPosition = 55.0
        highScoreLbl.position = CGPoint(
            x: gameOverNode.frame.maxX - highScoreLbl.frame.width/2 - 30,
            y: highScoreTitleLbl.position.y)
        addChild(highScoreLbl)
        
    }
}

//MARK: - Success
extension HUDNode {
    
    func setupSuccess(){
        createGameOverShape()
        
        isUserInteractionEnabled = true
        let scale: CGFloat = appDl.isIphoneX ? 0.6 : 0.7
        
        //TODO: - gameOverNode
        createGamePanel("panel-success")
        
        //TODO: - HomeNode
        continueNode =  SKSpriteNode(imageNamed: "icon-continue")
        continueNode.setScale(scale)
        continueNode.zPosition = 55.0
        continueNode.position = CGPoint(x: gameOverNode.frame.minX + continueNode.frame.width/2 + 30, y: gameOverNode.frame.minY + continueNode.frame.height/2 + 30)
        continueNode.name = "Continue"
        addChild(continueNode)
        
        //TODO: - PlayAgainNode
        nextNode = SKSpriteNode(imageNamed: "icon-next")
        nextNode.setScale(scale)
        nextNode.zPosition = 55.0
        nextNode.position = CGPoint(x: gameOverNode.frame.maxX - nextNode.frame.width/2 - 30, y: gameOverNode.frame.minY + nextNode.frame.height/2 + 30)
        nextNode.name = "Next"
        addChild(nextNode)
        
    
    }
}

//MARK: - Notif
extension HUDNode {
    
    func setupPanel(subTxt: String, titleTxt: String, btnName: String){
        createGameOverShape()
        
        isUserInteractionEnabled = true
        let scale: CGFloat = appDl.isIphoneX ? 0.6 : 0.7
        
        //TODO - Panel
        createGamePanel("panel")
        
        //TODO: - PanelNode
        panelNode = SKSpriteNode(imageNamed: btnName)
        panelNode.setScale(scale)
        panelNode.zPosition = 55.0
        panelNode.position = CGPoint(x: gameOverNode.frame.midX,
                                     y: gameOverNode.frame.minY + panelNode.frame.height/2 + 30)
        panelNode.name = "Panel"
        addChild(panelNode)
        
        //TODO: - PanelTitleLbl
        panelTitleLbl = SKLabelNode(fontNamed: FontName.rimouski)
        panelTitleLbl.text = titleTxt
        panelTitleLbl.fontSize = 50.0
        panelTitleLbl.fontColor = .white
        panelTitleLbl.preferredMaxLayoutWidth = gameOverNode.frame.width - 60
        panelTitleLbl.numberOfLines = 0
        panelTitleLbl.zPosition = 55.0
        panelTitleLbl.position = CGPoint(
            x: gameOverNode.frame.midX,
            y: gameOverNode.frame.maxY - panelTitleLbl.frame.height - 20)
        addChild(panelTitleLbl)
        
        
        //TODO: - panelSubLbl
        let para = NSMutableParagraphStyle()
        para.alignment = .center
        para.lineSpacing = 8.0
        
        let subAtt: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: FontName.rimouski, size: 33.0)!,
            .foregroundColor: UIColor.white,
            .paragraphStyle: para
        
        
        ]
        let range = NSRange(location: 0, length: subTxt.count)
        let subAttr = NSMutableAttributedString(string: subTxt)
        subAttr.addAttributes(subAtt, range: range)
        
        panelSubLbl = SKLabelNode(fontNamed: FontName.rimouski)
        panelSubLbl.attributedText = subAttr
        panelSubLbl.fontSize = 30.0
        panelSubLbl.fontColor = .white
        panelSubLbl.preferredMaxLayoutWidth = gameOverNode.frame.width + 0.7
        panelSubLbl.numberOfLines = 0
        panelSubLbl.zPosition = 55.0
        panelSubLbl.position = CGPoint(
            x: gameOverNode.frame.midX,
            y: gameOverNode.frame.midY - panelSubLbl.frame.height/2 + 30)
        addChild(panelSubLbl)
        
        
    }
}
