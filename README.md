# SignIn Framework

**로그인 관련 로직을 구현한 개인 프레임워크**
<br>

## 🎯 프로젝트 목표

```
    1. 일반/소셜 로그인에 대한 로직을 담당하는 개인 프레임워크 구현
    2. 프레임워크 생성과 적용에 대한 학습
    3. 기능들을 프레임워크화하기 위해서 필요한 고민에 대한 연습
```
<br>

## 🙊 목표 선정 이유
- 어플의 가장 기본 요소인 일반/소셜 로그인 로직을 프레임워크로 만들어서 신규 프로젝트 진행 시에 들이는 공수를 최소화하기 위해
- 프레임워크를 많이 사용하지만 어떻게 만들고 적용해야할 지에 대한 고민은 부족했었던 터라 이를 학습하고자 선정

## ⚙️ 개발 환경


[![Swift](https://img.shields.io/badge/swift-v5.6.1-orange?logo=swift)](https://developer.apple.com/kr/swift/)
[![Xcode](https://img.shields.io/badge/xcode-v14.1-blue?logo=xcode)](https://developer.apple.com/kr/xcode/)
[![RxSwift](https://img.shields.io/badge/RxSwift-6.5.0-red)]()
<img src="https://img.shields.io/badge/UIkit-000000?style=flat&logo=UIkit" alt="uikit" maxWidth="100%">


<br>

## 🌟 고민과 해결

### 1) 서버 API
#### 🤞 고민
로그인을 하기 위해서는 서버에 요청을 해야하는데 해당 프레임워크를 사용할 프로젝트는 각각 다른 EndPoint들을 가지고 있을 것이므로 외부에서 자유롭게 수정해서 요청을 보낼 수 있도록 작성해야 했다.
처음에는 프로토콜을 활용하여 제네릭하게 작성하려 했으나, 프로토콜은 본인 스스로를 준수하지 못 하다보니 구체 타입을 전달해줘야 하는 부분에서 문제가 생길 수 밖에 없었다.
차선으로 EndPoint 관련 구조체를 만들어놓고 외부에서 해당 구조체를 직접 생성해서 적절한 인자 값을 전달할 수 있도록 구현했지만, 로직을 활용하는 것이 아니라 프레임워크에 있는 구조체를 직접 생성할 수 있도록 만드는 것은 다소 이상한 구조이지 않을까라는 생각이 들었다.

#### 👍 해결
이 방법이 옳은 방향인지에 대해서는 여전히 의문점이기는 하나, 위의 문제점들을 최대한 피할 수 있는 방법으로서 인자 타입을 URLRequest로 받는 형태를 고안했다.
구체 타입이긴 하므로 제네릭과 관련한 문제도 없고, 사용자가 커스텀이 가능하지만 해당 프레임워크의 것을 활용하지도 않으니 괜찮을 거라는 생각이 들었다. 이 부분은 차후에 지속적으로 눈여겨 보면서 더 나은 방향을 찾아봐야될 것 같다.

### 2) Apple Social Login
#### 🤞 고민
Apple 로그인의 경우에는 인증이 완료된 후 넘어오는 값이 ASAuthorizationControllerDelegate를 통해 전달된다. 그러다보니 기존 Kakao에서는 토큰 값을 받아오는 메서드를 호출하면 해당 값을 Single에 담아서 리턴해줄 수 있는 로직을 다소 수정할 필요가 있었다.

#### 👍 해결
토큰 값을 주고받을 수 있는 PublishRelay를 생성하고 토큰 값을 담은 Single을 리턴하는 메서드에서 해당 Relay에 대한 subscribe를 하여 토큰 값이 방출되면 observer에 담아주도록 구현하였다.
