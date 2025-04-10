import 'package:flutter/material.dart';
import 'dart:async';

class LoadingOverlay {
  static final LoadingOverlay _instance = LoadingOverlay._internal();
  factory LoadingOverlay() => _instance;
  
  OverlayEntry? _overlayEntry;
  bool _isVisible = false;
  
  final StreamController<void> _rebuildStreamController = StreamController<void>.broadcast();
  late StreamSubscription _subscription;
  
  LoadingOverlay._internal() {
    _subscription = _rebuildStreamController.stream.listen((_) {
      if (_isVisible) {
        _dismissOverlay();
      }
    });
  }
  
  void _notifyRebuild() {
    _rebuildStreamController.add(null);
  }
  
  void show(BuildContext context) {
    if (_isVisible) return;
    
    _overlayEntry = OverlayEntry(
      builder: (context) => _LoadingOverlayWidget(
        onRebuild: _notifyRebuild,
        child: Stack(
          children: [
            ModalBarrier(dismissible: false, color: Colors.black.withOpacity(0.5)),
            const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
    
    Overlay.of(context).insert(_overlayEntry!);
    _isVisible = true;
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WidgetsBinding.instance.addObserver(_LifecycleObserver(_notifyRebuild));
    });
  }
  
  void _dismissOverlay() {
    if (_isVisible) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isVisible = false;
    }
  }
  
  void dispose() {
    _subscription.cancel();
    _rebuildStreamController.close();
  }
}

class _LoadingOverlayWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback onRebuild;
  
  const _LoadingOverlayWidget({
    required this.child,
    required this.onRebuild,
  });
  
  @override
  State<_LoadingOverlayWidget> createState() => _LoadingOverlayWidgetState();
}

class _LoadingOverlayWidgetState extends State<_LoadingOverlayWidget> {
  @override
  void didUpdateWidget(_LoadingOverlayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.onRebuild();
  }
  
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class _LifecycleObserver extends WidgetsBindingObserver {
  final VoidCallback onAppLifecycleChange;
  
  _LifecycleObserver(this.onAppLifecycleChange);
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    onAppLifecycleChange();
  }
}

class OverlayNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    LoadingOverlay()._notifyRebuild();
  }
  
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    LoadingOverlay()._notifyRebuild();
  }
  
  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    LoadingOverlay()._notifyRebuild();
  }
  
  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    LoadingOverlay()._notifyRebuild();
  }
}