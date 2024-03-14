//
//  BlueToothRocketManager.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/10.
//

import Foundation
import CoreBluetooth

//import APPBase

class BlueToothRocketManager: NSObject {
    
    static let shared = BlueToothRocketManager()
    
    /// 中心管理者(管理设备的扫描和连接)
    private var centralManager: CBCentralManager!
    /// 存储的设备
    var peripherals: [PPCBPeripheral] = []
    
    /// 扫描到的服务
    var cbService: CBService!
    /// 扫描到的特征
    var cbCharacteristic: CBCharacteristic!
    /// 外设状态
    var peripheralState: CBManagerState!
    
    
    var discoverDevice:(()->Void)?
    
    private override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
    }
    
    override func copy() -> Any {
        return self // SingletonClass.shared
    }
    
    override func mutableCopy() -> Any {
        return self // SingletonClass.shared
    }
    /// 清楚单例持有的信息
    func reset() {}
        
  
}

extension BlueToothRocketManager {
    
    func registAcceptDevice(callBack: @escaping (()->Void)) {
        self.discoverDevice = callBack
    }
    
    /// 扫描设备
    func beginScanPeripheral() {
        
        if peripheralState == .poweredOn {
            let option = [
                // 设置为NO表示不重复扫瞄已发现设备，为YES就是允许
                CBCentralManagerScanOptionAllowDuplicatesKey: false,
                // 设置为YES就是在蓝牙未打开的时候显示弹框
                CBCentralManagerOptionShowPowerAlertKey: true
                
            ]
            // 第一个参数填nil代表扫描所有蓝牙设备,第二个参数options也可以写nil
            centralManager.scanForPeripherals(withServices: nil, options: option)
        }
    }
    
    /// 停止扫描设备
    func stopScanPeripheral() {
        
        centralManager.stopScan()
        
    }
    
    
    func scanServers(peripheral: CBPeripheral) {
        // 设置设备的代理
        peripheral.delegate = self;
        // services:传入nil  代表扫描所有服务
        peripheral.discoverServices(nil)
    }
}

extension BlueToothRocketManager: CBCentralManagerDelegate {
    
    
    /// 连接成功
    /// - Parameters:
    ///   - central: 中心设备
    ///   - peripheral: 连接的设备
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("连接设备:\(String(describing: peripheral.name))成功")
    }
    
    /// 连接失败
    /// - Parameters:
    ///   - central: 中心管理者
    ///   - peripheral: 链接的设备
    ///   - error: 错误信息
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("连接失败")
    }
    
    /// 断开连接
    /// - Parameters:
    ///   - central: 中心管理者
    ///   - peripheral: 链接的设备
    ///   - error: 错误信息
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("断开连接")
    }

    /// 扫描到设备
    /// - Parameters:
    ///   - central: 中心管理者
    ///   - peripheral: 扫描到的设备
    ///   - advertisementData: 广播信息
    ///   - RSSI: 信号强度
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if let title = peripheral.name {
            
            let localName = advertisementData["kCBAdvDataLocalName"]
            
            print("发现设备设备名称：\(title)(\(String(describing: localName)) uuid：\(peripheral.identifier.uuidString) 信号值：\(RSSI.stringValue)")
            
            let device = PPCBPeripheral(peripheral: peripheral, signValue: RSSI, advertisementData: advertisementData)
            
            peripherals.append(device)
            
            if let call = discoverDevice {
                call()
            }
            if let adata = advertisementData["kCBAdvDataManufacturerData"] as? Data {
                // data转16进制字符串
                let adve = adata.hexString
//                if (adve.count > 16) {
//                    print("广播包：\(adve)")
//
//                    let s = adve.index(adve.startIndex, offsetBy: 4)
//                    let e = adve.index(adve.startIndex, offsetBy: 12)
//
//                    let macStr = String(adve[s...e])
//                    print("MAC地址：\(macStr)")
//                }
            }
        }
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        peripheralState = central.state
        switch central.state {
        case .unknown:
            print("未知")
        case .resetting:
            print("重置")
        case .unsupported:
            print("不支持")
        case .unauthorized:
            print("未授权")
        case .poweredOff:
            print("关闭")
        case .poweredOn:
            print("正常")
            beginScanPeripheral()
        default:
            break
        }
    }
}

//MARK: - 操作

extension BlueToothRocketManager {
    
    /// 连接
    func connect(peripheral: CBPeripheral) {
        centralManager.connect(peripheral)
    }
    
    /// 断开连接
    func disConnect(peripheral: PPCBPeripheral) {
        centralManager.cancelPeripheralConnection(peripheral.peripheral)
    }
    
    /// 发送检查蓝牙命令
    func writeCheckBleWithBle() {
//        Byte byte[] = {0xA1,0x02,0x01,0x00,0x55};
//        NSData *data = [[NSData alloc]initWithBytes:byte length:5];
//        [self.cbPeripheral writeValue:data forCharacteristic:self.cbCharacteristic type:CBCharacteristicWriteWithResponse];
    }
    
}


extension BlueToothRocketManager: CBPeripheralDelegate {
    
    /// 写入数据完成
    /// - Parameters:
    ///   - peripheral: 设备
    ///   - characteristic: 特征
    ///   - error: 错误信息
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print("写入成功")
    }
    
    
    /// 读到特征读到数据
    /// - Parameters:
    ///   - peripheral: 设备
    ///   - characteristic: 特征
    ///   - error: 错误信息
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        print("characteristic uuid:\(characteristic.uuid.uuidString)  value:\(characteristic.value ?? Data())")
        
        if let charac = characteristic.value, charac.count >= 12 {
//            let str = charac.hexString
            
//            NSString *circleStr = [str substringWithRange:NSMakeRange(6, 8)];
//            NSString *timeStr = [str substringWithRange:NSMakeRange(14, 8)];
//            NSString *circle10 = [NSString stringWithFormat:@"%lu",strtoul([circleStr UTF8String],0,16)];
//            NSString *time10 = [NSString stringWithFormat:@"%lu",strtoul([timeStr UTF8String],0,16)];
//            NSLog(@"圈数：%@ 时间：%@",circle10,time10);
        }
    }
    
    /// 特征的状态
    /// - Parameters:
    ///   - peripheral: 设备
    ///   - characteristic: 特征
    ///   - error: 错误信息
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        if characteristic.isNotifying {
//            [peripheral readValueForCharacteristic:characteristic];
        } else {
    //        NSLog(@"Notification stopped on %@.  Disconnecting", characteristic);
    //        NSLog(@"%@", characteristic);
    //        [self.centralManager cancelPeripheralConnection:peripheral];
        }
    }
    
    /// 扫到特征对应的服务
    /// - Parameters:
    ///   - peripheral: 设备
    ///   - service: 服务
    ///   - error: 错误
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
//        for (CBCharacteristic *characteristic in service.characteristics) {
//            NSLog(@">>>服务:%@ 的 特征: %@",service.UUID,characteristic.UUID);
//            if ([characteristic.UUID.UUIDString isEqualToString:@"FFB1"]) {
//                self.readCharacteristic = characteristic;
//            }
//            //选一个订阅
//            if (!self.peripheralsView) {
//                self.peripheralsView = [[PeripheralListView alloc] initWithFrame:CGRectMake(50, 100, self.view.frame.size.width - 100, self.view.frame.size.height - 200)];
//                self.peripheralsView.dataArr = service.characteristics;
//                [self.view addSubview:self.peripheralsView];
//
//                __weak typeof(self) weakSelf = self;
//                self.peripheralsView.selectedPeripheralBlock = ^(NSArray * _Nonnull dataArr, NSInteger index) {
//
//                    if ([dataArr[index] isKindOfClass:[CBCharacteristic class]]) {
//                        CBCharacteristic *characteristic = dataArr[index];
//                        weakSelf.characteristicLabel.text = [NSString stringWithFormat:@"已选择特征：%@",characteristic.UUID.UUIDString];
//                        weakSelf.cbCharacteristic = characteristic;
//
//                        [weakSelf.cbPeripheral readValueForCharacteristic:characteristic];
//
//                        //订阅,实时接收
//                        [weakSelf.cbPeripheral setNotifyValue:YES forCharacteristic:characteristic];
//                    }
//
//                    [weakSelf.peripheralsView removeFromSuperview];
//                    weakSelf.peripheralsView = nil;
//                };
//            }
//        }
    }
    
    /// 发现服务
    /// - Parameters:
    ///   - peripheral: 设备
    ///   - error: 错误信息
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
//        // 遍历所有的服务
//        for (CBService *service in peripheral.services)
//        {
//            NSLog(@"服务:%@",service.UUID.UUIDString);
//        }
//
//        if (!self.peripheralsView) {
//            self.peripheralsView = [[PeripheralListView alloc] initWithFrame:CGRectMake(50, 100, self.view.frame.size.width - 100, self.view.frame.size.height - 200)];
//            self.peripheralsView.dataArr = peripheral.services;
//            [self.view addSubview:self.peripheralsView];
//
//            __weak typeof(self) weakSelf = self;
//            self.peripheralsView.selectedPeripheralBlock = ^(NSArray * _Nonnull dataArr, NSInteger index) {
//
//                if ([dataArr[index] isKindOfClass:[CBService class]]) {
//                    CBService *service = dataArr[index];
//                    weakSelf.serviceLabel.text = [NSString stringWithFormat:@"已选择服务：%@",service.UUID.UUIDString];
//                    weakSelf.cbService = service;
//                    weakSelf.characteristicBtn.hidden = NO;
//                }
//
//                [weakSelf.peripheralsView removeFromSuperview];
//                weakSelf.peripheralsView = nil;
//            };
//        }
    }
}


extension Data {
    
    func hexString() -> String {
        String(data: self, encoding: .utf8) ?? ""
    }
}
