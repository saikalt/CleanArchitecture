//
//  MainViewModel.swift
//  test-task-halbestunde
//
//  Created by Iurii Gubanov on 18.05.2022.
//

import Foundation

struct PiecesViewModelActions {
    var showPieceDetails: (PieceDetails, @escaping (PieceDetails) -> Void) -> Void
    var popViewController: () -> Void
    var addNewPiece: () -> Void
}

protocol PiecesViewModel: AnyObject {

    var pieces: Observable<[PieceDetails]> { get }
    var actions: PiecesViewModelActions? { get set }

    func addRandomPiece()
    func didTapOnPiece(at row: Int)
    func addNewPiece()
}

class PiecesViewModelImpl: PiecesViewModel {
    
    var pieces: Observable<[PieceDetails]> = Observable([])
    var buffer: Set<PieceDetails> = []
    var actions: PiecesViewModelActions?
    
    init(actions: PiecesViewModelActions) {
        self.actions = actions

        setupInitialBuffer()
    }

    private func setupInitialBuffer() {
        buffer.insert(PieceDetails(title: "Moonlight", author: "Ludwig van Beethoven", description: "The Piano Sonata No. 14 in C-sharp minor, marked Quasi una fantasia, Op. 27, No. 2, is a piano sonata by Ludwig van Beethoven. It was completed in 1801 and dedicated in 1802 to his pupil Countess Giulietta Guicciardi.[b] The popular name Moonlight Sonata goes back to a critic's remark after Beethoven's death.\n\nThe piece is one of Beethoven's most popular compositions for the piano, and it was a popular favorite even in his own day.[1] Beethoven wrote the Moonlight Sonata in his early thirties, after he had finished with some commissioned work; there is no evidence that he was commissioned to write this sonata.", iconName: "moonlight"))
        buffer.insert(PieceDetails(title: "In the Hall of the Mountain King", author: "Edvard Grieg", description: "\"In the Hall of the Mountain King\" (Norwegian: I Dovregubbens hall, lit. 'In the Dovre man's hall') is a piece of orchestral music composed by Edvard Grieg in 1875 as incidental music for the sixth scene of act 2 in Henrik Ibsen's 1867 play Peer Gynt. It was originally part of Opus 23 but was later extracted as the final piece of Peer Gynt, Suite No. 1, Op. 46. Its easily recognizable theme has helped it attain iconic status in popular culture,[citation needed] where it has been arranged by many artists (See Grieg's music in popular culture).\n\nThe English translation of the name is not literal. Dovre is a mountainous region in Norway, and \"gubbe\" translates into (old) man or husband. \"Gubbe\" is used along with its female counterpart \"kjerring\" to differentiate male and female trolls, \"trollgubbe\" and \"trollkjerring\". In the play, Dovregubben is a troll king that Peer Gynt invents in a fantasy.", iconName: "in_the_hall"))
        buffer.insert(PieceDetails(title: "Eine kleine Nachtmusik", author: "Wolfgang Amadeus Mozart", description: "Eine kleine Nachtmusik (Serenade No. 13 for strings in G major), K. 525, is a 1787 composition for a chamber ensemble by Wolfgang Amadeus Mozart. The German title means \"a little night music\". The work is written for an ensemble of two violins, viola, cello and double bass, but is often performed by string orchestras.", iconName: "eine_kleine_nachtmusik"))
        buffer.insert(PieceDetails(title: "Für Elise", author: "Ludwig van Beethoven", description: "Bagatelle No. 25 in A minor for solo piano, commonly known as \"Für Elise\", is one of Ludwig van Beethoven's most popular compositions. It was not published during his lifetime, only being discovered 40 years after his death, and may be termed either a Bagatelle or an Albumblatt. The identity of \"Elise\" is unknown; researchers have suggested Therese Malfatti, Elisabeth Röckel, or Elise Barensfeld.", iconName: "fur_elise"))

        buffer.insert(PieceDetails(title: "The Four Seasons", author: "Vivaldi", description: "The Four Seasons (Italian: Le quattro stagioni) is a group of four violin concertos by Italian composer Antonio Vivaldi, each of which gives musical expression to a season of the year. These were composed around 1718−1720, when Vivaldi was the court chapel master in Mantua. They were published in 1725 in Amsterdam, together with eight additional concerti, as Il cimento dell'armonia e dell'inventione (The Contest Between Harmony and Invention).\n\nThe Four Seasons is the best known of Vivaldi's works. Though three of the concerti are wholly original, the first, \"Spring\", borrows patterns from a sinfonia in the first act of Vivaldi's contemporaneous opera Il Giustino. The inspiration for the concertos is not the countryside around Mantua, as initially supposed, where Vivaldi was living at the time, since according to Karl Heller[1] they could have been written as early as 1716–1717, while Vivaldi was engaged with the court of Mantua only in 1718.\n\nThey were a revolution in musical conception: in them Vivaldi represented flowing creeks, singing birds (of different species, each specifically characterized), a shepherd and his barking dog, buzzing flies, storms, drunken dancers, hunting parties from both the hunters' and the prey's point of view, frozen landscapes, and warm winter fires.\n\n Unusual for the period, Vivaldi published the concerti with accompanying sonnets (possibly written by the composer himself) that elucidated what it was in the spirit of each season that his music was intended to evoke. The concerti therefore stand as one of the earliest and most detailed examples of what would come to be called program music—in other words, music with a narrative element. Vivaldi took great pains to relate his music to the texts of the poems, translating the poetic lines themselves directly into the music on the page. For example, in the middle section of \"Spring\", when the goatherd sleeps, his barking dog can be heard in the viola section. The music is elsewhere similarly evocative of other natural sounds. Vivaldi divided each concerto into three movements (fast–slow–fast), and, likewise, each linked sonnet into three sections.", iconName: "four_seasons"))

        buffer.insert(PieceDetails(title: "William Tell Overture", author: "Rossini", description: "The William Tell Overture is the overture to the opera William Tell (original French title Guillaume Tell), whose music was composed by Gioachino Rossini. William Tell premiered in 1829 and was the last of Rossini's 39 operas, after which he went into semi-retirement (he continued to compose cantatas, sacred music and secular vocal music). The overture is in four parts, each following without pause.\n\nThere has been repeated use (and sometimes parody) of parts of this overture in both classical music and popular media. It was the theme music for The Lone Ranger in radio, television and film,[1] and has become widely associated with horseback riding since then. Two different parts were also used as theme music for the British television series The Adventures of William Tell, the fourth part (popularly identified in the US with The Lone Ranger) in the UK, and the third part, rearranged as a stirring march, in the US.\n\nFranz Liszt prepared a piano transcription of the overture in 1838 (S.552) which became a staple of his concert repertoire.[2] There are also transcriptions by other composers, including versions by Louis Gottschalk for two and four pianos and a duet for piano and violin.", iconName: "william_tell"))
    }
    
    func addRandomPiece() {
        guard let piece = buffer.randomElement() else { return }

        if !pieces.value.contains(piece) {
            pieces.value.append(piece)
        }
    }

    func didTapOnPiece(at row: Int) {
        actions?.showPieceDetails(pieces.value[row], { [weak self] piece in
            guard let self = self else { return }

            self.pieces.value[row] = piece
            self.actions?.popViewController()
        })
    }

    func addNewPiece() {
        actions?.addNewPiece()
    }
}
