import org.ruboto.Log

class SampleBroadcastReceiver
  # Will get called whenever the BroadcastReceiver receives an intent.
  def onReceive(context, intent)
    Log.v 'SampleBroadcastReceiver', 'Broadcast received!'
    Log.v 'SampleBroadcastReceiver', intent.getExtras.to_s
  rescue Exception
    Log.e "Exception processing broadcast: #{$!.message}\n#{$!.backtrace.join("\n")}"
  end
end
