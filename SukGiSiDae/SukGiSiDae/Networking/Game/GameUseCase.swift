//
//  GameUseCase.swift
//  SukGiSiDae
//

import Foundation
import Combine
import GroupActivities

typealias Quiz = String

protocol GameStateOwner {
    var state: AnyPublisher<GameState, Never> { get }
}

protocol HostUseCase: GameStateOwner {
}

protocol PlayerUseCase: GameStateOwner {
    func endRound() // 정답 맞춘 유저가 호출
}

protocol GameUseCaseProtocol: HostUseCase, PlayerUseCase {
    var amIHost: Bool { get }

    func startSession()

    func gameStart()

    func configureGroupSession(_ groupSession: GroupSession<GameActivity>)
}

final class GameUseCase: GameUseCaseProtocol {
    // MARK: - Properties

    var state: AnyPublisher<GameState, Never> {
        _state.eraseToAnyPublisher()
    }

    private var _state: CurrentValueSubject<GameState, Never> = .init(.init())

    @Published private var groupSession: GroupSession<GameActivity>?
    private var messenger: GroupSessionMessenger?
    private var journal: GroupSessionJournal?

    private var cancelBag: Set<AnyCancellable> = .init()
    private var tasks = Set<Task<Void, Never>>()
    private let games: [Game]

    var amIHost: Bool {
        groupSession?.id.uuidString == _state.value.host?.id
    }

    // MARK: - Initializer

    init(games: [Game]) {
        self.games = games
    }

    // MARK: - Methods

    func startSession() {
        Task {
            do {
                _ = try await GameActivity().activate()
            } catch {
                print("Failed to activate GameActivity activity: \(error)")
            }
        }
    }

    func gameStart() {
        let oldValue = self._state.value
        var copiedValue = oldValue

        copiedValue.status = .시작_카운트_다운
        copiedValue.game = .init(game: self.games.first!)

        let newValue = copiedValue

        self.sendState(newValue)

        let countDownValue: Int = 5

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(countDownValue), execute: {
            self.realGameStart()
        })
    }

    private func realGameStart() {
        let oldValue = _state.value
        var copiedValue = oldValue

        copiedValue.status = .게임_시작
        copiedValue.host = copiedValue.player.randomElement()

        let newValue = copiedValue
        sendState(newValue)

        startRound()
    }

    private func startRound() {
        let oldValue = _state.value
        var copiedValue = oldValue

        copiedValue.status = .라운드_시작
        copiedValue.host = copiedValue.player.randomElement()
        copiedValue.currentRound += 1

        let newValue = copiedValue
        sendState(newValue)
    }

    func endRound() {
        let oldValue = _state.value
        var copiedValue = oldValue

        copiedValue.status = .라운드_종료

        let newValue = copiedValue
        sendState(newValue)

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            if newValue.isFinalRound {
                self.gameEnd()
            } else {
                self.startRound()
            }
        })
    }

    private func gameEnd() {
        let oldValue = _state.value
        var copiedValue = oldValue

        copiedValue.status = .게임_종료

        let newValue = copiedValue
        sendState(newValue)
    }

    func configureGroupSession(_ groupSession: GroupSession<GameActivity>) {
        self.groupSession = groupSession

        let messenger = GroupSessionMessenger(session: groupSession)
        self.messenger = messenger

        let journal = GroupSessionJournal(session: groupSession)
        self.journal = journal

        groupSession.$state
            .sink { [weak self] state in
                guard let self = self else { return }
                if case .invalidated = state {
                    self.groupSession = nil
                    self.reset()
                }
            }
            .store(in: &cancelBag)

        groupSession.$activeParticipants
            .sink { activeParticipants in
                let newParticipants = activeParticipants.subtracting(groupSession.activeParticipants)

                let newUsers =  newParticipants.map {
                    User(id: $0.id.uuidString)
                }

                let oldValue = self._state.value
                var copiedValue = oldValue

                copiedValue.player.append(contentsOf: newUsers)
                copiedValue.player = copiedValue.player.uniqued()

                let newValue = copiedValue

                Task {
                    try? await messenger.send(newValue, completion: { (error) in })
                }

                print("sucess!!!!")
            }
            .store(in: &cancelBag)

        var task = Task {
            for await (state, test) in messenger.messages(of: GameState.self) {
                handleGameState(state)
            }
        }
        tasks.insert(task)

        groupSession.join()
    }

    private func reset() {

    }

    private func handleGameState(_ state: GameState) {
        self._state.send(state)
        print("state updated! : \(state)")
    }

    private func sendState(_ state: GameState) {
        Task {
            try? await messenger?.send(state, completion: { (error) in
                print("send state error: \(error)")
            })
        }
    }
}

private extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter{ seen.insert($0).inserted }
    }
}
