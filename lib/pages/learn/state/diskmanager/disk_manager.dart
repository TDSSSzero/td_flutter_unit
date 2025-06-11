
typedef HandleDiskMessage = void Function(NotifyStatus status,String msg);
class DiskManager {
  final int total;
  final HandleDiskMessage? handleDiskMessage;
  final double notifyThreshold;
  int usage = 0;

  DiskManager(this.total,{this.notifyThreshold = 0.8,this.handleDiskMessage});


  void use(int size) {
    if (total - usage < size) {
      String message = '[磁盘警告]: 磁盘已满,无法使用。 [用量: $usage/$total]';
      handleDiskMessage?.call(NotifyStatus.full,message);
      return;
    }
    usage += size;
    String message = '[磁盘使用]:$size , [用量: $usage/$total]';
    handleDiskMessage?.call(NotifyStatus.log,message);

    if (usage > total * notifyThreshold) {
      String message = '[磁盘警告]: 磁盘容量已超过:${(notifyThreshold * 100).toStringAsFixed(1)}% [用量: $usage/$total]';
      handleDiskMessage?.call(NotifyStatus.threshold,message);
    }
  }

  reset(){
    usage = 0;
  }

  double getProgress(){
    return usage / total;
  }
}

enum NotifyStatus{
  log,
  threshold,
  full
}