import 'package:redeem/theme/colors.dart';
import 'package:flutter/material.dart';

class InfiniteGridView extends StatefulWidget {
  final double scrollThreshold;
  final Function nextData;
  final bool hasNext;
  final Widget? loadingWidget;
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final SliverGridDelegate gridDelegate;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final int? semanticChildCount;
  final bool forOffice;
  final bool withoutDisposeScrool;

  const InfiniteGridView({
    required this.nextData,
    required this.itemBuilder,
    required this.itemCount,
    required this.gridDelegate,
    Key? key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.semanticChildCount,
    this.scrollThreshold = 300,
    this.hasNext = false,
    this.loadingWidget,
    this.forOffice = false,
    this.withoutDisposeScrool=false,
  }) : super(key: key);

  @override
  _InfiniteGridViewState createState() {
    return new _InfiniteGridViewState();
  }
}

class _InfiniteGridViewState extends State<InfiniteGridView> {
  late ScrollController _scrollController;
  late ScrollController _OffscrollController;
  int? _lastLoadedEvent;

  @override
  void initState() {
    print("withoutDisposeScrool${widget.withoutDisposeScrool}");
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_onScroll);
    _OffscrollController = ScrollController();
    /* _scrollController.addListener(_onScroll);     */
    super.initState();
  }

  @override
  void dispose() {
    if(!widget.withoutDisposeScrool){
       print("withoutDisposeScrooldispose${widget.withoutDisposeScrool}");

    _scrollController.dispose();
    _OffscrollController.dispose();
    }else{
      print("withoutDisposeScrooldisposeelse");
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(InfiniteGridView oldWidget) {
    if (oldWidget.itemCount != widget.itemCount) {
      _lastLoadedEvent = null;
    }
    super.didUpdateWidget(oldWidget);
  }

  bool _hasScroll() {
  //  print(
  //        "_hasScroll ${_scrollController.position.haveDimensions} ${_scrollController.position.maxScrollExtent}");
    return _scrollController.position.haveDimensions &&
        _scrollController.position.maxScrollExtent > 0;
  }

  bool enableScroll = false;
  setenableScroll(bool s) {
    enableScroll = s;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      borderOnForeground: false,
      shape: Border.all(
        width: 0,
        color: Colors.transparent,
      ),
      child: GridTile(
        footer: enableScroll
            ? (widget.loadingWidget ??
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(color: CustomColors.primarycolor,),
                )))
            : null,
        child: GridView.builder(
          itemCount: widget.hasNext ? widget.itemCount + 1 : widget.itemCount,
          gridDelegate: widget.gridDelegate,
          addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
          addRepaintBoundaries: widget.addRepaintBoundaries,
          addSemanticIndexes: widget.addSemanticIndexes,
          cacheExtent: widget.cacheExtent,
          padding: widget.padding,
          physics: widget.physics,
          primary: widget.primary,
          reverse: widget.reverse,
          scrollDirection: widget.scrollDirection,
          semanticChildCount: widget.semanticChildCount,
          shrinkWrap: widget.shrinkWrap,
          controller:
              widget.forOffice ? _OffscrollController : _scrollController,
          itemBuilder: (context, index) {
            if (
                /*  !widget.forOffice && */
                !_hasScroll() &&
                    index == widget.itemCount &&
                    _lastLoadedEvent == null &&
                    widget.hasNext) {
              _lastLoadedEvent = widget.itemCount;
              WidgetsBinding.instance!
                  .addPostFrameCallback((_) => widget.nextData());
            }
            if (index == widget.itemCount) {
              // setenableScroll(true);

              /* return Container(); */
              return widget.loadingWidget ??
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(color: CustomColors.primarycolor,),
                  ));
            } else {
              // setenableScroll(false);
            }
            return widget.itemBuilder(context, index);
          },
        ),
      ),
    );
    //return;
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    /* print("Max Scroll ${maxScroll}");
    print("currentScroll ${currentScroll}"); */
    if (maxScroll - currentScroll <= widget.scrollThreshold &&
        _lastLoadedEvent == null &&
        widget.hasNext) {
      _lastLoadedEvent = widget.itemCount;
      widget.nextData();
    }
  }
}

class InfiniteListView extends StatefulWidget {
  final double scrollThreshold;
  final Function nextData;
  final bool hasNext;
  final Widget? loadingWidget;
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final bool _separated;
  final Widget Function(BuildContext, int)? _separatorBuilder;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final int? semanticChildCount;
  final double? itemExtent;
  final bool forOffice;

  const InfiniteListView({
    required this.itemBuilder,
    required this.itemCount,
    required this.nextData,
    Key? key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.loadingWidget,
    this.scrollThreshold = 300,
    this.forOffice = false,
    this.hasNext = false,
  })  : _separated = false,
        _separatorBuilder = null,
        semanticChildCount = null,
        itemExtent = null,
        super(key: key);

  const InfiniteListView.separated({
    required this.itemBuilder,
    required this.itemCount,
    required this.nextData,
    required Function(BuildContext, int) separatorBuilder,
    Key? key,
    this.semanticChildCount,
    this.itemExtent,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.loadingWidget,
    this.scrollThreshold = 300,
    this.hasNext = false,
    this.forOffice = false,
  })  : _separated = true,
        _separatorBuilder =
            separatorBuilder as Widget Function(BuildContext, int)?,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DentalInfiniteListViewState();
  }
}

class _DentalInfiniteListViewState extends State<InfiniteListView> {
  late ScrollController _scrollController;
  late ScrollController _OffscrollController;

  int? _lastLoadedEvent;

  @override
  void initState() {
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_onScroll);
    _OffscrollController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _OffscrollController.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(InfiniteListView oldWidget) {
    if (oldWidget.itemCount != widget.itemCount) {
      _lastLoadedEvent = null;
    }
    super.didUpdateWidget(oldWidget);
  }

  bool _hasScroll() {
    return _scrollController.position.haveDimensions &&
        _scrollController.position.maxScrollExtent > 0;
  }

  @override
  Widget build(BuildContext context) {
    final itemBuilder = (BuildContext context, int index) {
      if (!_hasScroll() &&
          index == widget.itemCount &&
          _lastLoadedEvent == null &&
          widget.hasNext) {
        _lastLoadedEvent = widget.itemCount;
        WidgetsBinding.instance!.addPostFrameCallback((_) => widget.nextData());
      }

      if (index == widget.itemCount) {
        return widget.loadingWidget ??
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(color: CustomColors.primarycolor,),
            ));
      }
      return widget.itemBuilder(context, index);
    };

    if (widget._separated) {
      return ListView.separated(
        itemBuilder: itemBuilder,
        controller: widget.forOffice ? _OffscrollController : _scrollController,
        scrollDirection: widget.scrollDirection,
        reverse: widget.reverse,
        padding: widget.padding,
        addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
        addRepaintBoundaries: widget.addRepaintBoundaries,
        addSemanticIndexes: widget.addSemanticIndexes,
        cacheExtent: widget.cacheExtent,
        primary: widget.primary,
        physics: widget.physics,
        shrinkWrap: widget.shrinkWrap,
        separatorBuilder: widget._separatorBuilder!,
        itemCount: widget.hasNext ? widget.itemCount + 1 : widget.itemCount,
      );
    }

    return ListView.builder(
      itemBuilder: itemBuilder,
      controller: widget.forOffice ? _OffscrollController : _scrollController,
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      itemExtent: widget.itemExtent,
      padding: widget.padding,
      semanticChildCount: widget.semanticChildCount,
      addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
      addRepaintBoundaries: widget.addRepaintBoundaries,
      addSemanticIndexes: widget.addSemanticIndexes,
      cacheExtent: widget.cacheExtent,
      primary: widget.primary,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      itemCount: widget.hasNext ? widget.itemCount + 1 : widget.itemCount,
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= widget.scrollThreshold &&
        _lastLoadedEvent == null &&
        widget.hasNext) {
      _lastLoadedEvent = widget.itemCount;
      widget.nextData();
    }
  }
}
