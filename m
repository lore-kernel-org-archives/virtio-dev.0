Return-Path: virtio-dev-return-4012-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 78BD7581810F
	for <virtio-dev@lists.oasis-open.org>; Sun, 29 Apr 2018 21:17:11 -0700 (PDT)
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
 <1524848820-42258-4-git-send-email-sridhar.samudrala@intel.com>
 <20180428094205.GM5632@nanopsycho.orion>
Message-ID: <638e52c7-64db-9d8d-7530-f6b000d3e292@intel.com>
Date: Sun, 29 Apr 2018 21:16:58 -0700
MIME-Version: 1.0
In-Reply-To: <20180428094205.GM5632@nanopsycho.orion>
Content-Type: multipart/alternative;
 boundary="------------69D41547C8B777D68912A203"
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v9 3/4] virtio_net: Extend virtio to use VF
 datapath when available
To: Jiri Pirko <jiri@resnulli.us>
Cc: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--------------69D41547C8B777D68912A203
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

On 4/28/2018 2:42 AM, Jiri Pirko wrote:
> Fri, Apr 27, 2018 at 07:06:59PM CEST,sridhar.samudrala@intel.com  wrote:
>> This patch enables virtio_net to switch over to a VF datapath when a VF
>> netdev is present with the same MAC address. It allows live migration
>> of a VM with a direct attached VF without the need to setup a bond/team
>> between a VF and virtio net device in the guest.
>>
>> The hypervisor needs to enable only one datapath at any time so that
>> packets don't get looped back to the VM over the other datapath. When a VF
>> is plugged, the virtio datapath link state can be marked as down. The
>> hypervisor needs to unplug the VF device from the guest on the source host
>> and reset the MAC filter of the VF to initiate failover of datapath to
>> virtio before starting the migration. After the migration is completed,
>> the destination hypervisor sets the MAC filter on the VF and plugs it back
>> to the guest to switch over to VF datapath.
>>
>> It uses the generic failover framework that provides 2 functions to create
>> and destroy a master failover netdev. When STANDBY feature is enabled, an
>> additional netdev(failover netdev) is created that acts as a master device
>> and tracks the state of the 2 lower netdevs. The original virtio_net netdev
>> is marked as 'standby' netdev and a passthru device with the same MAC is
>> registered as 'primary' netdev.
>>
>> This patch is based on the discussion initiated by Jesse on this thread.
>> https://marc.info/?l=linux-virtualization&m=151189725224231&w=2
>>
> When I enabled the standby feature (hardcoded), I have 2 netdevices now:
> 4: ens3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>      link/ether 52:54:00:b2:a7:f1 brd ff:ff:ff:ff:ff:ff
>      inet6 fe80::5054:ff:feb2:a7f1/64 scope link
>         valid_lft forever preferred_lft forever
> 5: ens3n_sby: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
>      link/ether 52:54:00:b2:a7:f1 brd ff:ff:ff:ff:ff:ff
>      inet6 fe80::5054:ff:feb2:a7f1/64 scope link
>         valid_lft forever preferred_lft forever
>
> However, it seems to confuse my initscripts on Fedora:
> [root@test1 ~]# ifup ens3
> ./network-functions: line 78: [: /etc/dhcp/dhclient-ens3: binary operator expected
> ./network-functions: line 80: [: /etc/dhclient-ens3: binary operator expected
> ./network-functions: line 69: [: /var/lib/dhclient/dhclient-ens3: binary operator expected
>
> Determining IP information for ens3
> ens3n_sby...Cannot find device "ens3n_sby.pid"
> Cannot find device "ens3n_sby.lease"
>   failed.
>
> I tried to change the standby device mac:
> ip link set ens3n_sby addr 52:54:00:b2:a7:f2
> [root@test1 ~]# ifup ens3
>
> Determining IP information for ens3... done.
> [root@test1 ~]#
>
> But now the network does not work. I think that the mac change on
> standby device should be probably refused, no?

Yes. we should block changing standby device mac.

> When I change the mac back, all works fine.

This is strange. So you had to change the standby device mac twice to
get dhcp working.

I do see NetworkManager trying to get dhcp address on standby device, but
i don't see any issue with connectivity.  To be totally transparent, we
need to only expose one netdev.

>
> Now I try to change mac of the failover master:
> [root@test1 ~]# ip link set ens3 addr 52:54:00:b2:a7:f3
> RTNETLINK answers: Operation not supported
>
> That I did expect to work. I would expect this would change the mac of
> the master and both standby and primary slaves.

If a VF is untrusted, a VM will not able to change its MAC and moreover
in this mode we are assuming that the hypervisor has assigned the MAC and
guest is not expected to change the MAC.

For the initial implementation, i would propose not allowing the guest to
change the MAC of failover or standby dev.


>
> Now I tried to add a primary pci device. I don't have any fancy VF on my
> test setup, but I expected the good old 8139cp to work:
> [root@test1 ~]# ethtool -i ens9
> driver: 8139cp
> ....
> [root@test1 ~]# ip link set ens9 addr 52:54:00:b2:a7:f1
>
> I see no message in dmesg, so I guess the failover module did not
> enslave this netdev. The mac change is not monitored. I would expect
> that it is and whenever a device changes mac to the failover one, it
> should be enslaved and whenever it changes mac back to something else,
> it should be released - the primary one ofcourse.

Sure. that may be the best way to handle the guest changing the primary
netdev's mac.

>
>
>
> [...]
>
>> +static int virtnet_get_phys_port_name(struct net_device *dev, char *buf,
>> +				      size_t len)
>> +{
>> +	struct virtnet_info *vi = netdev_priv(dev);
>> +	int ret;
>> +
>> +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_STANDBY))
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = snprintf(buf, len, "_sby");
> please avoid the "_".
>
> [...]


--------------69D41547C8B777D68912A203
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    On 4/28/2018 2:42 AM, Jiri Pirko wrote:<br>
    <blockquote type="cite"
      cite="mid:20180428094205.GM5632@nanopsycho.orion">
      <pre wrap="">Fri, Apr 27, 2018 at 07:06:59PM CEST, <a class="moz-txt-link-abbreviated" href="mailto:sridhar.samudrala@intel.com">sridhar.samudrala@intel.com</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">This patch enables virtio_net to switch over to a VF datapath when a VF
netdev is present with the same MAC address. It allows live migration
of a VM with a direct attached VF without the need to setup a bond/team
between a VF and virtio net device in the guest.

The hypervisor needs to enable only one datapath at any time so that
packets don't get looped back to the VM over the other datapath. When a VF
is plugged, the virtio datapath link state can be marked as down. The
hypervisor needs to unplug the VF device from the guest on the source host
and reset the MAC filter of the VF to initiate failover of datapath to
virtio before starting the migration. After the migration is completed,
the destination hypervisor sets the MAC filter on the VF and plugs it back
to the guest to switch over to VF datapath.

It uses the generic failover framework that provides 2 functions to create
and destroy a master failover netdev. When STANDBY feature is enabled, an
additional netdev(failover netdev) is created that acts as a master device
and tracks the state of the 2 lower netdevs. The original virtio_net netdev
is marked as 'standby' netdev and a passthru device with the same MAC is
registered as 'primary' netdev.

This patch is based on the discussion initiated by Jesse on this thread.
<a class="moz-txt-link-freetext" href="https://marc.info/?l=linux-virtualization&amp;m=151189725224231&amp;w=2">https://marc.info/?l=linux-virtualization&amp;m=151189725224231&amp;w=2</a>

</pre>
      </blockquote>
      <pre wrap="">When I enabled the standby feature (hardcoded), I have 2 netdevices now:
4: ens3: &lt;BROADCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 52:54:00:b2:a7:f1 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::5054:ff:feb2:a7f1/64 scope link 
       valid_lft forever preferred_lft forever
5: ens3n_sby: &lt;BROADCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 52:54:00:b2:a7:f1 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::5054:ff:feb2:a7f1/64 scope link 
       valid_lft forever preferred_lft forever

However, it seems to confuse my initscripts on Fedora:
[root@test1 ~]# ifup ens3
./network-functions: line 78: [: /etc/dhcp/dhclient-ens3: binary operator expected
./network-functions: line 80: [: /etc/dhclient-ens3: binary operator expected
./network-functions: line 69: [: /var/lib/dhclient/dhclient-ens3: binary operator expected

Determining IP information for ens3
ens3n_sby...Cannot find device "ens3n_sby.pid"
Cannot find device "ens3n_sby.lease"
 failed.

I tried to change the standby device mac:
ip link set ens3n_sby addr 52:54:00:b2:a7:f2
[root@test1 ~]# ifup ens3

Determining IP information for ens3... done.
[root@test1 ~]#

But now the network does not work. I think that the mac change on
standby device should be probably refused, no?</pre>
    </blockquote>
    <br>
    <pre>Yes. we should block changing standby device mac.</pre>
    <blockquote type="cite"
      cite="mid:20180428094205.GM5632@nanopsycho.orion">
      <pre wrap="">
When I change the mac back, all works fine.</pre>
    </blockquote>
    <br>
    <pre>This is strange. So you had to change the standby device mac twice to
get dhcp working.</pre>
    <pre>I do see NetworkManager trying to get dhcp address on standby device, but
i don't see any issue with connectivity.  To be totally transparent, we
need to only expose one netdev.

</pre>
    <blockquote type="cite"
      cite="mid:20180428094205.GM5632@nanopsycho.orion">
      <pre wrap="">

Now I try to change mac of the failover master:
[root@test1 ~]# ip link set ens3 addr 52:54:00:b2:a7:f3
RTNETLINK answers: Operation not supported

That I did expect to work. I would expect this would change the mac of
the master and both standby and primary slaves.</pre>
    </blockquote>
    <br>
    <pre>If a VF is untrusted, a VM will not able to change its MAC and moreover
in this mode we are assuming that the hypervisor has assigned the MAC and
guest is not expected to change the MAC.</pre>
    <pre>For the initial implementation, i would propose not allowing the guest to 
change the MAC of failover or standby dev.</pre>
    <br>
    <blockquote type="cite"
      cite="mid:20180428094205.GM5632@nanopsycho.orion">
      <pre wrap="">

Now I tried to add a primary pci device. I don't have any fancy VF on my
test setup, but I expected the good old 8139cp to work:
[root@test1 ~]# ethtool -i ens9
driver: 8139cp
....
[root@test1 ~]# ip link set ens9 addr 52:54:00:b2:a7:f1

I see no message in dmesg, so I guess the failover module did not
enslave this netdev. The mac change is not monitored. I would expect
that it is and whenever a device changes mac to the failover one, it
should be enslaved and whenever it changes mac back to something else,
it should be released - the primary one ofcourse.</pre>
    </blockquote>
    <pre>Sure. that may be the best way to handle the guest changing the primary
netdev's mac.
</pre>
    <blockquote type="cite"
      cite="mid:20180428094205.GM5632@nanopsycho.orion">
      <pre wrap="">



[...]

</pre>
      <blockquote type="cite">
        <pre wrap="">+static int virtnet_get_phys_port_name(struct net_device *dev, char *buf,
+				      size_t len)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	int ret;
+
+	if (!virtio_has_feature(vi-&gt;vdev, VIRTIO_NET_F_STANDBY))
+		return -EOPNOTSUPP;
+
+	ret = snprintf(buf, len, "_sby");
</pre>
      </blockquote>
      <pre wrap="">please avoid the "_".

[...]
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------69D41547C8B777D68912A203--
