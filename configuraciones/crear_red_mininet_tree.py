#!/usr/bin/python


from mininet.net import Mininet
from mininet.node import RemoteController
from mininet.cli import CLI
from mininet.node import CPULimitedHost
from mininet.link import TCLink
from mininet.util import dumpNodeConnections
from mininet.log import setLogLevel, info

def treeNet():
    # Create a tree network without a local controller and constrained links
    net = Mininet( controller=None, link=TCLink )

    # Adding remote controller
    net.addController( 'c1', controller=RemoteController, ip='127.0.0.1', port=6633 )

    # Adding hosts
    h1 = net.addHost( 'h1', ip='10.0.0.1' )
    h2 = net.addHost( 'h2', ip='10.0.0.2' )
    h3 = net.addHost( 'h3', ip='10.0.0.3' )
    h4 = net.addHost( 'h4', ip='10.0.0.4' )

    # Adding switches
    s1 = net.addSwitch( 's1' )
    s2 = net.addSwitch( 's2' )
    s3 = net.addSwitch( 's3' )

    # Creating core links 100Mbps, 100ms delay and user links 1000Mbps and 1ms delay
    net.addLink( s2, s1 )
    net.addLink( s3, s1 )
    net.addLink( h1, s2 )
    net.addLink( h2, s2 )
    net.addLink( h3, s3 )
    net.addLink( h4, s3 )

    # Starting network
    net.start()

    # Dumping host connections
    dumpNodeConnections(net.hosts)

    # Testing network connectivity
    net.pingAll()

    # Testing bandwidth between nodes
    h1, h2 = net.get('h1', 'h2')
    net.iperf((h1, h2))

    h2, h1 = net.get('h2', 'h1')
    net.iperf((h2, h1))

    h2, h3 = net.get('h2', 'h3')
    net.iperf((h2, h3))

    h2, h4 = net.get('h2', 'h4')
    net.iperf((h2, h4))

    h3, h4 = net.get('h3', 'h4')
    net.iperf((h3, h4))

    # Running CLI
    CLI( net )

    # Stopping network
    net.stop()

if __name__ == '__main__':
    setLogLevel( 'info' )
    treeNet()