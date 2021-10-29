LanRouter set debug_ 0
set ns [new Simulator]

$ns color 1 Blue
                                  #bus
set nf [open out.nam w]
$ns namtrace-all $nf

proc finish {} {
	global ns nf
	$ns flush-trace
	close $nf
	exec nam out.nam &
	exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

set lan [$ns newLan "$n0 $n2 $n3 $n1 "  10Mb 10ms  LL Queue/DropTail MAC/Csma/Ca Channel]


set udp0 [new Agent/TCP/Newreno]

$ns attach-agent $n0 $udp0

set cbr0 [new Application/FTP]

$cbr0 attach-agent $udp0

set null0 [new Agent/TCPSink]
$ns attach-agent $n2 $null0


set null1 [new Agent/TCPSink]
$ns attach-agent $n1 $null1


set null2 [new Agent/TCPSink]
$ns attach-agent $n3 $null2


$ns connect $udp0 $null1
$ns at 0.5 "$cbr0 start"
$ns at 4.5 "$cbr0 stop"

$ns at 5.0 "finish"

$ns run
