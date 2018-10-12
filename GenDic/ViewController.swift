//
//  ViewController.swift
//  GenDic
//
//  Created by Igor Sergeevich on 19.09.2018.
//  Copyright © 2018 Igor Sergeevich. All rights reserved.
//

import Cocoa

// Расширение строки
/* let str = "abcdef"
   str[1 ..< 3] // returns "bc"
   str[5] // returns "f"
   str[80] // returns ""
   str.substring(fromIndex: 3) // returns "def"
   str.substring(toIndex: str.length - 2) // returns "abcd"
*/

extension String {
    var length: Int { return self.characters.count }
    subscript (i: Int) -> String { return self[i ..< i + 1] }
    func substring(fromIndex: Int) -> String
    {
        return self[min(fromIndex, length) ..< length]
    }
    func substring(toIndex: Int) -> String
    {
        return self[0 ..< max(0, toIndex)]
    }
    subscript (r: Range<Int>) -> String
    {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

class ViewController: NSViewController {

    // [Timer]
    var progressValue = 0.0
   
    
    
    @IBOutlet weak var ProgressLine: NSProgressIndicator!
    @IBOutlet weak var ProgressText: NSTextField!

    
    
    @IBOutlet weak var EditMaska: NSTextField!
    @IBOutlet weak var ViewConsole: NSTextField!
        
    var StrMas: String = ""
    var MasInt = Array(repeating: 0, count: 1_000_00_00)

    
    @IBAction func ButtonGeneration(_ sender: Any)
    {
        let DO = 999_99_99
        let OT = 100_00_00
        
        var count = OT
        let mask = Int(EditMaska.intValue) * OT * 10
        
        while count != DO+1
        {
            MasInt[count] = mask + count
            
            // 375291000000-375299999999 код
            // 375441000000-375449999999 код
            // 375331000000-375339999999 код
            // 291000000-299999999 код
            // 441000000-449999999 код
            // 331000000-339999999 код
            
            count = count + 1
        }
        
        ViewConsole.stringValue = "МАССИВ СОЗДАН УСПЕШНО!\n"
        ViewConsole.stringValue = ViewConsole.stringValue + "Количество элементов: \(MasInt.count) \n"
        ViewConsole.stringValue = ViewConsole.stringValue + "Индекс первого элемента: \(MasInt.startIndex) \n"
        ViewConsole.stringValue = ViewConsole.stringValue + "Индекс последнего элемента: \(MasInt.endIndex-1) \n"
        ViewConsole.stringValue = ViewConsole.stringValue + "Значение первого элемента: \(MasInt[MasInt.startIndex]) \n"
        ViewConsole.stringValue = ViewConsole.stringValue + "Значение последнего элемента: \(MasInt[MasInt.endIndex-1]) \n"
        ViewConsole.stringValue = ViewConsole.stringValue + "----------------------------------------------------------------------------------------- \n"
        progressValue = 1

    }
    
  
    @IBAction func Button4(_ sender: Any)
    {
        var MasTemp = Array(repeating: 0, count: 1_000_00_00)
        // Удаляет все элементы содержащие число 0
        MasTemp = MasInt.filter { $0 != 0 }
        MasInt = MasTemp
        
        ViewConsole.stringValue = ViewConsole.stringValue + "МАССИВ УСПЕШНО ОТФИЛЬТРОВАН!\n"
        ViewConsole.stringValue = ViewConsole.stringValue + "Количество элементов: \(MasInt.count) \n"
        ViewConsole.stringValue = ViewConsole.stringValue + "Индекс первого элемента: \(MasInt.startIndex) \n"
        ViewConsole.stringValue = ViewConsole.stringValue + "Индекс последнего элемента: \(MasInt.endIndex-1) \n"
        ViewConsole.stringValue = ViewConsole.stringValue + "Значение первого элемента: \(MasInt[MasInt.startIndex]) \n"
        ViewConsole.stringValue = ViewConsole.stringValue + "Значение последнего элемента: \(MasInt[MasInt.endIndex-1]) \n"
    }
    
    
    @IBAction func Button2(_ sender: Any)
    {
        let intArray = MasInt
        // Преобразование [333, 4444, 4444] в ["333", "4444", "4444"]
        let stringArray = intArray.map { $0.description }
        // Преобразование ["333", "4444", "4444"] в "333\n4444\n444\n"
        StrMas = stringArray.joined(separator: "\n")
        
        
        ViewConsole.stringValue =  ""
        ViewConsole.stringValue = ViewConsole.stringValue + "УСПЕШНОЕ ПРЕОБРАЗОВАНИЕ В СТРОКУ!\n"
        ViewConsole.stringValue = ViewConsole.stringValue + "Количество символов в строке: \(StrMas.count-1) \n"
        ViewConsole.stringValue = ViewConsole.stringValue + "Первые 12 символов: \"\(StrMas[0 ..< 12])\" \n" // [0-11]
        ViewConsole.stringValue = ViewConsole.stringValue + "Последние 12 символов: \"\(StrMas[StrMas.count-12 ..< StrMas.count])\" \n"
        ViewConsole.stringValue = ViewConsole.stringValue + "----------------------------------------------------------------------------------------- \n"
    }
    
    
    // --- СОХРАНЕНИЕ В ФАЙЛ
    @IBOutlet weak var EditSave: NSTextField!
    @IBAction func ButtonSave(_ sender: Any)
    {
        // Сохранение на диск
        do {
            // Получение URL адресса папки с документами
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                // Cоздание конечного URL для сохраняемого текстового файла
                let fileURL = documentDirectory.appendingPathComponent(EditSave.stringValue)
                // Запись на диск
                try StrMas.write(to: fileURL, atomically: false, encoding: .utf8)
                print("Сохранение прошло успешно")
        // Чтение из диска
                //let savedText = try String(contentsOf: fileURL)
                //print("savedText:", savedText)
                print("fileURL:", fileURL)
                print("documentDirectory:", documentDirectory)
            }
        } catch { print("error:", error) }
        
        // Вывод Сообщения
        ViewConsole.stringValue = ViewConsole.stringValue + "СОХРАНЕНИЕ ПРОШЛО УСПЕШНО!\n"
        ViewConsole.stringValue = ViewConsole.stringValue + "Путь сохранения: /Users/lawr/Library/Containers/JA.GenDic/Data/Documents/\(EditSave.stringValue)\n"
    }
    
    func ReadToFile(name: String) -> String
    {
        var savedText = ""
        do {
            // Получение URL адресса папки с документами
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            {
                // Добавление к URL имя файла
                let fileURL = documentDirectory.appendingPathComponent(name)
                // Чтение из диска
                savedText = try String(contentsOf: fileURL)
                print("savedText:", savedText)
                print("fileURL:", fileURL)
                print("documentDirectory:", documentDirectory)
                return savedText
            }
        } catch { }
        return savedText
    }
    
    
    // БЛОК ОТВЕЧАЮЩИЙ ЗА РАБОТУ СО СТРОКОЙ
    
    @IBOutlet weak var indexStart: NSTextField!
    @IBOutlet weak var indexFinish: NSTextField!
    @IBOutlet weak var resultSymbol: NSTextField!
    @IBOutlet weak var resultSymbolCount: NSTextField!
    var countSymbol: Int = 0
    @IBAction func EditOt(_ sender: Any)
    {
        countSymbol = indexStart.integerValue
        
    }
    @IBAction func EditDo(_ sender: Any)
    {
        countSymbol = indexStart.integerValue
    }
    @IBAction func buttonResultSymbol(_ sender: Any)
    {
        if countSymbol <= indexFinish.intValue
        {
            resultSymbol.stringValue = StrMas[Int(countSymbol)]
            resultSymbolCount.stringValue = "Символ: \(countSymbol)"
            countSymbol = countSymbol + 1
        }
    }
    
    // ---------------------------------------
    
    
    @IBOutlet weak var ViewAbout: NSBox!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // [Timer] Черезе "timeInterval" запустит функцию "updateProgress" и будет повторять если "repeats" равен true.
        Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.updateProgress), userInfo: nil, repeats: true)
        
        // [Анимация] Прозрачность "ViewAbout" равна 0-лю (невидима) [значения 0..1]
        ViewAbout.alphaValue = 0

    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    // [Timer] Функция (тобишь метод) который будет вызываться таймером
    @objc func updateProgress()
    {
        // [Анимация] Прозрачность "ViewAbout" увеличиваеться на 0.05 каждую 0.1 сек
        ViewAbout.alphaValue = ViewAbout.alphaValue + 0.05
        
        // [Timer]
        if progressValue != 1
        {
            // ProgressLine.doubleValue = ProgressLine.doubleValue + 0.001
        }
        
        
    }
   
    
    // Блок отвечающий за Генерацию даты
    
    // Блок отвечающий за Объединение файлов
    @IBOutlet weak var NameFileStart: NSTextField!
    @IBOutlet weak var NameFileFinish: NSTextField!
    @IBAction func ButtonMerger(_ sender: Any)
    {
       // var x = ReadToFile(name: NameFileStart.stringValue)
        NameFileStart.stringValue = "lk"
    }
    
}

