//
//  ViewController.swift
//  8XO
//
//  Created by bmtech on 26.01.2022.
//

import UIKit

class ViewController: UIViewController {
  let userChart = "X"
  let computerChart = "0"
  let defaultChart = "*"

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var setButton: UIButton!
  @IBOutlet weak var playAgainButton: UIButton!
  @IBOutlet weak var xTextField: UITextField!
  @IBOutlet weak var oTextField: UITextField!
  


  @IBOutlet var fieldsImageView: [UIImageView]!

  var fieldsItems: [[String]]!

  override func viewDidLoad() {
    super.viewDidLoad()
      
      setButton.layer.cornerRadius = 15
      playAgainButton.layer.cornerRadius = 15

    fieldsItems = [
      [defaultChart, defaultChart, defaultChart],
      [defaultChart, defaultChart, defaultChart],
      [defaultChart, defaultChart, defaultChart]
    ]

    setButton.layer.cornerRadius = 5.0
    //setButton.isEnabled = false
    playAgainButton.layer.cornerRadius = 5.0
    playAgainButton.isEnabled = false
  }

  @IBAction func playAgain(_ sender: Any) {
    titleLabel.text = "Let's play XO"
    titleLabel.textColor = .black
    xTextField.text = ""
    oTextField.text = ""

    for i in 0..<fieldsItems.count {
      for j in 0..<fieldsItems[i].count {
        fieldsItems[i][j] = defaultChart
        fieldsImageView[(i * fieldsItems.count) + j].image = UIImage(systemName: "pencil")
      }
    }

    draw()
  }


  @IBAction func setTochDown(_ sender: Any) {

    guard  let xText = xTextField.text,
           let yText = oTextField.text,
           let x = Int(xText),
           let y = Int(yText)
    else {
      return
    }


    if fieldsItems[y][x] != defaultChart {
      titleLabel.text = "Error"
      titleLabel.textColor = .red
      //playAgainButton.isEnabled = true
      return
    } else {
      fieldsItems[y][x] = userChart
      draw()

      // check if user winned
      if isRightDiagonalWin(with: userChart) || isLeftDiagonalWin(with: userChart) || isVertWin(with: userChart) /*|| isHorizontWin()*/{
        titleLabel.text = "You win!!!"
        titleLabel.textColor = .green
        playAgainButton.isEnabled = true
        return
      }

      playComputer()

      if isRightDiagonalWin(with: computerChart) || isLeftDiagonalWin(with: computerChart) || isVertWin(with: computerChart) /*|| isHorizontWin()*/{
        titleLabel.text = "Computer win!!!"
        titleLabel.textColor = .blue
        playAgainButton.isEnabled = true
        return
      }
    }
  }

  func isRightDiagonalWin(with char: String) -> Bool {
    var count = 0
    for i in 0..<fieldsItems.count {
      for j in 0..<fieldsItems[i].count {
        if i == j && fieldsItems[i][j] == char {
          count += 1
        }
      }
    }
    return count == 3
  }


  func isLeftDiagonalWin(with char: String) -> Bool {
    var count = 0
    for i in 0..<fieldsItems.count {
      for j in 0..<fieldsItems[i].count {
        if i == fieldsItems.count - 1 - j && fieldsItems[i][j] == char {
          count += 1
        }
      }
    }
    return count == 3
  }

  func isVertWin(with char: String) -> Bool {
    var count = 0
    for i in 0..<fieldsItems.count {
      for j in 0..<fieldsItems[i].count {
        if j == j   && fieldsItems[i][j] == char {
          count += 1
        }
      }
    }
    return count == 3
  }

  func playComputer() {
    var indexI = 0, indexJ = 0

    for i in 0..<fieldsItems.count {
      for j in 0..<fieldsItems[i].count {
        if fieldsItems[i][j] == "*" {
          indexI = i
          indexJ = j
        }
      }
    }

    fieldsItems[indexI][indexJ] = computerChart
    draw()
  }

  func draw() {
    var index = 0
    for item in fieldsItems {
      for items in item {
        switch items {
          case "*":
            fieldsImageView[index].image = UIImage(systemName: "pencil")
          case "X":
            fieldsImageView[index].image = UIImage(named: "icon.x")
          case computerChart:
            fieldsImageView[index].image = UIImage(named: "icon.o")
          default:
            break
        }
        index += 1
      }
    }
  }
}

