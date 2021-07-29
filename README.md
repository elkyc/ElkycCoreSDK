Real-time identity verification & onboarding. We help banks, fintech’s and other businesses to increase the number of services they provide as well as attract new customers by automating the onboarding and verification process. 

- [Features](#features)
- [Component Libraries](#component-libraries)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [ElkycStep Protocol](#elkycstep-protocol)
- [Predefined steps](#predefined-steps)
- [Starting flow](#starting-flow)

# Features
- [x] Read passport data using a smartphone (NFC) or webcam;
- [x] Doc type identification (Machine Learning);
- [x] Parsing doc data (OCR);
- [x] Document authenticity control (data cross-check from visual zone, chip, MRZ);
- [x] Document ownership checks (Liveness detection, Facematch)
- [x] Video verification;
- [x] Electronic signature;
- [x] Database checks (AML);
- [x] Data input automation (into client’s software);
- [x] Web workplace; 
- [x] On-premises (all data is processed on client’s side);
- [x] And much more

# Component Libraries
ElkycCoreSDK is the main component that is used by other components. It contains common logic and steps for other components. Other components can't work without it.

- [ElkycDocumentSDK](https://github.com/elkyc/ElkycDocumentSDK) - This library focuses on all kinds of document scanning(Passport, Driver's Licence, Tax Number, etc) and RFID scan(ID Cards with NFC chip). But as well it can scan Credit Cards, Barcode, QRCode and capture Selfie with Document.
- [ElkycSpecificToolsSDK](https://github.com/elkyc/ElkycSpecificToolsSDK) - It contains additional steps for a verification process - Signature Pad and OTP Verification.
- [ElkycFaceSDK](https://github.com/elkyc/ElkycFaceSDK) - This library is built for biometrical face verification. You can match faces, verify is person alive or not, get the selfie.

# Requirements

- iOS 11.0+ 
- Xcode 11+
- Swift 5.1+

# Installation
## CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate ElkycCoreSDK into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'git@github.com:elkyc/ElkycPodsRepo.git'

pod 'ElkycCoreSDK'
```
## Manually

If you prefer not to use any of the aforementioned dependency managers, you can integrate ElkycCoreSDK into your project manually.

- Open up Terminal, `cd` into your directory, and run the following:

  ```bash
  $ git clone git@github.com:elkyc/ElkycCoreSDK.git ElkycCoreSDK
  ```
- Open the new `ElkycCoreSDK ` folder, and drag the `ElkycCoreSDK.xcframework` into the Project Navigator of your application's Xcode project.

# Usage
## Introduction
This Framework will help you to build a verification process for your project, the goal is to build easy steps which you can run and get the result to your system or in your application. It is built on top of standard Apple Libraries. This part of our SDK's contains common logic for other frameworks and it helps to run the verification process. 

The whole process is going synchronously from the first to the last step. During the process, data will be sent to our or your backend. The process will stop if **any** of the steps will return an error.

## Configuration
SDK can be configured via `config` property on the shared instance.
Config has these properties:

- **workplaceHost**, HTTPS Host to which data will be sent. If nil then SDK will use default host. Example: https://example.com
- **sendToCRM**, Bool property if true then data will be sent to the backend, else you can use your code to send the data.

```swift
ElkycSDK.shared.config.sendToCRM = true
ElkycSDK.shared.config.workplaceHost = "https://example.com"
```

## ElkycStep Protocol
All our frameworks contain many predefined steps which you can configure. Usually, you should not implement your step but you can, probably you will need this if you want to add your custom UI to the verification process. In this section, you can find a way how to do that, as well as what basic operations on steps you can perform.

```swift
public protocol ElkycStep: AnyObject {
    associatedtype Output

    var stepId: ElkycStepId { get set}
    func start(from viewController: UIViewController, completion: @escaping ((Result<Output, Error>) -> Void))
}

public struct ElkycStepId {
    public var id: String = UUID().uuidString
    public var stepType: StepType
}
```

### Basic Operations
All basic operations help you transform and connect all steps into one chain - flow.
Below you can find the quick explanation about each function with an example.

- next - A function that transforms output from step into a new step. 

```swift
func next<Second: ElkycStep>(_ next: @escaping (Output) -> Second) -> AnyElkycStep<Second.Output>

DocumentScan(documentMask: .empty).next { docResult -> DocumentConfirm in
   return DocumentConfirm(docImage: docResult.mainDocumentImage())
}
```

- combine - A function that combines two steps result into one.

```swift
func combine<Second: ElkycStep>(_ zipped: @escaping (Output) -> Second) -> AnyElkycStep<(Self.Output, Second.Output)>

DocumentScan(documentMask: .empty).combine { docResult -> DocumentConfirm in
   return DocumentConfirm(docImage: docResult.mainDocumentImage())
}
```

- retry - A function that attempts to recreate its step when closure returns true.

```swift
func retry(when: @escaping (Self.Output) -> Bool) -> AnyElkycStep<Self.Output>

DocumentConfirm(docImage: UIImage()).retry { result -> Bool in
	switch result {
	case .retry:
		return true
	case .next:
		return false
	}
}
```

- map - A function that transforms output from the step with a provided closure.

```swift
func map<NewOutput>(_ map: @escaping (Self.Output) -> NewOutput) -> AnyElkycStep<NewOutput>

AcceptTerms().map { return "Success" }
```

- eraseToAnyStep - Wraps the step with a type eraser.

```swift
func eraseToAnyStep() -> AnyElkycStep<Self.Output>

AcceptTerms().map { return "Success" }.eraseToAnyStep()
```

- just - Constructor which helps to create just a step with a value inside
 
```swift
AnyElkycStep.just("Hello World!")
```

### Customization
If you want to create your step this is not something hard, you should just implement ElkycStep protocol with custom id. Here is an example.
 
```swift
public class Custom: ElkycStep {
    public let stepId: ElkycStepId = .custom

    public func start(from viewController: UIViewController, completion: @escaping ((Result<Void, Error>) -> Void)) {
        let customViewController: CustomViewController = CustomViewController()        
        customViewController.completion = completion
        setCurrent(step: customViewController, from: viewController)
    }
}
```

## Predefined steps
All our frameworks have predefined steps which can be easily used. Almost all steps have configs and inputs. In this section, I will describe all available steps in the current framework, their configs and will show how they look like. 

Right now all steps localized in Russian and English.

### Intro
This step is intro for other steps in the chain.

**Input:**

- config

```swift
public var image: UIImage?
public var title: String?
public var attributedTitle: NSAttributedString?
public var description: String?
public var mainBtnTint: UIColor
public var mainBtnTitle: String?
```


#### Config
Config has predefined static variables:

- startVerification

![](https://github.com/elkyc/ElkycCoreSDK/blob/main/Images/Intro_Start_verification.jpeg?raw=true)

- rfid

![](https://github.com/elkyc/ElkycCoreSDK/blob/main/Images/Intro_Rfid.jpeg?raw=true)

- liveness

![](https://github.com/elkyc/ElkycCoreSDK/blob/main/Images/Intro_Liveness.jpeg?raw=true)

- world

![](https://github.com/elkyc/ElkycCoreSDK/blob/main/Images/Intro_Ukrainian.jpeg?raw=true)

- selfieWithDoc

![](https://github.com/elkyc/ElkycCoreSDK/blob/main/Images/Intro_Selfie.jpeg?raw=true)

- signature

![](https://github.com/elkyc/ElkycCoreSDK/blob/main/Images/Intro_Signature.jpeg?raw=true)

### Confirm
You can use this step in the end of the process.

**Input:**

- config

```swift
public var title: String
public var description: String
public var image: UIImage?
public var mainBtnBackgroundColor: UIColor
public var mainBtnTintColor: UIColor
public var mainBtnTitle: String

public var showCloseBtn: Bool
public var closeBtnTint: UIColor
public var alertTitle: String
public var alertDescription: String
public var alertDestructiveBtnTitle: String
public var alertMainBtnTitle: String
```

**Output:**

As output, you will receive a Response enum. Which lets you understand what action was chosen by the user.

```swift
public enum Response {
	case mainAction
	case close
}
```

#### Config

Config has predefined static variables:

- livenessSuccess

![](https://github.com/elkyc/ElkycCoreSDK/blob/main/Images/Confirm_liveness_success.jpeg?raw=true)

- livenessFail

![](https://github.com/elkyc/ElkycCoreSDK/blob/main/Images/Confirm_liveness_fail.jpeg?raw=true)

- congrats

![](https://github.com/elkyc/ElkycCoreSDK/blob/main/Images/Confirm_congrats.jpeg?raw=true)

### AcceptTerms
Do not use this step it is only for our internal demo project. Maybe we will share it with everybody later

### DocumentSelection
If you want to allow a user to select a type of the document before verification process, you can use this step.

![](https://github.com/elkyc/ElkycCoreSDK/blob/main/Images/DocumentSelection.jpg?raw=true)

**Input:**

- documents - instances which implement DocumentTypeViewProtocol

```swift
public protocol DocumentTypeViewProtocol {
    var image: UIImage? { get }
    var name: String { get }
}
```

- config

```swift
public var title: String
public var mainBtnBackgroundColor: UIColor
public var mainBtnTintColor: UIColor
public var mainBtnTitle: String
public var documentTypeViewTintColor: UIColor
```

**Output:**

As output, you will receive an Int value, this gives you an index of the selected type

### DocumentIntro
You can use this step as a step before some document scan.

**Input:**

- config

```swift
public var title: String
public var description: String
public var image: UIImage?
public var mainBtnBackgroundColor: UIColor
public var mainBtnTintColor: UIColor
public var mainBtnTitle: String
public var galleryBtnBackgroundColor: UIColor
public var galleryBtnTintColor: UIColor
public var galleryBtnTitle: String
public var isGalleryBtnHidden: Bool
```

**Output:**

As output, you will receive a StepResult enum. Which lets you understand what action was chosen by the user. This step has two action buttons - take photo and take image from gallery

```swift
enum StepResult {
	case takePhoto
	case galleryImage(UIImage)
}
```

#### Config

Config has predefined static variables:

- worldwide

![](https://github.com/elkyc/ElkycCoreSDK/blob/main/Images/DocumentIntro_WorldWide.jpeg?raw=true)

- worldwideBack

![](https://github.com/elkyc/ElkycCoreSDK/blob/main/Images/DocumentIntro_WorldWideBack.jpeg?raw=true)

- utilityBill

![](https://github.com/elkyc/ElkycCoreSDK/blob/main/Images/DocumentIntro_Utility.jpeg?raw=true)

- travelDocument

![](https://github.com/elkyc/ElkycCoreSDK/blob/main/Images/DocumentIntro_UkrWorld.jpeg?raw=true)

- idCard

![](https://github.com/elkyc/ElkycCoreSDK/blob/main/Images/DocumentIntro_UkrID.jpeg?raw=true)

- ukrainianPassportFirst

![](https://github.com/elkyc/ElkycCoreSDK/blob/main/Images/DocumentIntro_UkrFirst.jpeg?raw=true)

- ukrainianPassportSecond

![](https://github.com/elkyc/ElkycCoreSDK/blob/main/Images/DocumentIntro_UkrSecond.jpeg?raw=true)

- ukrainianPassportThird

![](https://github.com/elkyc/ElkycCoreSDK/blob/main/Images/DocumentIntro_UkrThird.jpeg?raw=true)

- ukrainianPassportFourth

![](https://github.com/elkyc/ElkycCoreSDK/blob/main/Images/DocumentIntro_UkrFourth.jpeg?raw=true)

### DocumentConfirm
You can use this step as a step after some document scan.

![](https://github.com/elkyc/ElkycCoreSDK/blob/main/Images/DocumentConfirm.jpg?raw=true)

**Input:**

- config

```swift
public var title: String
public var docImage: UIImage?
public var mainBtnBackgroundColor: UIColor
public var mainBtnTintColor: UIColor
public var mainBtnTitle: String
public var retryBtnBackgroundColor: UIColor
public var retryBtnTintColor: UIColor
public var retryBtnTitle: String
public var isRetryBtnHidden: Bool
public var hints: [DocumentConfirmHintViewModel]?
```

**Output:**

As output, you will receive a StepResult enum. Which lets you understand what action was chosen by the user. This step has two action buttons - retry and next

```swift
enum StepResult {
	case retry
	case next
}
```

### SelfieIntro
This step is intro selfie step.

![](https://github.com/elkyc/ElkycCoreSDK/blob/main/Images/Selfie_Intro.jpg?raw=true)

**Input:**

- config

```swift
public var title: String
public var description: String
public var image: UIImage?
public var mainBtnBackgroundColor: UIColor
public var mainBtnTintColor: UIColor
public var mainBtnTitle: String
```

### SelfieWithDocConfirm
You can use this step as a step after selfie with doc photo.

![](https://github.com/elkyc/ElkycCoreSDK/blob/main/Images/SelfieWithDocConfirm.jpg?raw=true)

**Input:**

- config

```swift
public var title: String
public var docImage: UIImage?
public var mainBtnBackgroundColor: UIColor
public var mainBtnTintColor: UIColor
public var mainBtnTitle: String
public var retryBtnBackgroundColor: UIColor
public var retryBtnTintColor: UIColor
public var retryBtnTitle: String
public var isRetryBtnHidden: Bool
public var hints: [DocumentConfirmHintViewModel]?
```

**Output:**

As output, you will receive a StepResult enum. Which lets you understand what action was chosen by the user. This step has two action buttons - retry and next

```swift
enum StepResult {
	case retry
	case next
}
```

## Starting flow
To start your prepared flow all you should do is call a method on shared **ElkycSDK**.

```swift
ElkycSDK.shared.startFlow(appKey: Registration.appKey,
                                  clientKey: Registration.clientKey,
                                  clientSession: "test session", flow: flow,
                                  from: self)
        { result in
	switch result {
	case .success(let response):
		print(response)
	case .failure(let error):
		print("ERROR: \(error.localizedDescription)")
	}
}
```
This method take 5 parameters

- **appKey** - application key, this key could be obtained at the portal
- **clientKey** - client key, this key could be obtained at the portal
- **clientSession** - Optional. This is unique identifier which you can use to identify your client session.
- **flow** - flow variable, it should consist one or more steps
- **viewController** - viewController from which flow will be presented
- **completion** - completion handler, here you will receive error from any step or an array with FlowResult struct

### FlowResult
FlowResult is a struct where you can find the answer from a step, the array of FlowResult's will be received in the end of the flow.
An array should be ordered by steps order.

```swift
public struct FlowResult {

    public let id: String
    public let type: FlowResultType
    public let result: Any
    
    public init(id: String, type: FlowResultType, result: Any)
    public func resultObject<T>(type: T.Type) -> T?
}
```

The response result should be casted to a specific object. 
For that the **type** field have typeHint variable which can help cast result to a right object.

```swift
for result in results {
	switch result.type {
	case .selfieWithDoc:
		let object = result.resultObject(type: UIImage.self)
	case .innScan:
		let object = result.resultObject(type: InnDocumentScanResponse.self)
	case .captureScan:
		let object = result.resultObject(type: CaptureResponse.self)
	case .documentScan:
		let object = result.resultObject(type: DocumentResult.self)
	case .signature:
		let object = result.resultObject(type: UIImage.self)
	case .faceLiveness:
		let object = result.resultObject(type: FaceLiveness.Response.self)
	case .faceMatching:
		let object = result.resultObject(type: FaceMatching.Response.self)
	case .faceCapturing:
		let object = result.resultObject(type: UIImage.self)
	default:
		()
	}
}
```

If you want to add your specific result to a flow use this method on a **ElkycSDK** shared instance.

```swift
public func addFlowResult(_ flowResult: FlowResult)
```
