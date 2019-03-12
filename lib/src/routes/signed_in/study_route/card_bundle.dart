import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:saraka/blocs.dart';
import './draggable_card.dart';

class CardBundle extends StatefulWidget {
  State<CardBundle> createState() => _CardBundleState();
}

class _CardBundleState extends State<CardBundle> {
  CardLearningBloc _cardLearningBloc;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      final cardLearningBloc = Provider.of<CardLearningBloc>(context);

      setState(() {
        _cardLearningBloc = cardLearningBloc;
      });
    });
  }

  @override
  Widget build(BuildContext context) => _cardLearningBloc == null
      ? Container()
      : StreamBuilder<Iterable<Card>>(
          stream: _cardLearningBloc.cards,
          initialData: [],
          builder: (context, snapshot) {
            final children = <Widget>[];
            final firstFiveCards =
                snapshot.requireData.take(5).toList().reversed.toList();

            for (int i = 0; i < firstFiveCards.length; ++i) {
              children.add(DraggableCard(
                key: Key(firstFiveCards[i].id),
                card: firstFiveCards[i],
                cardsInFront: firstFiveCards.length - i - 1,
              ));
            }

            return Stack(children: children);
          });
}