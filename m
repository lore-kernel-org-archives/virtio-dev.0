Return-Path: virtio-dev-return-3028-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C116358191F7
	for <virtio-dev@lists.oasis-open.org>; Mon, 22 Jan 2018 21:54:21 -0800 (PST)
References: <1515736720-39368-2-git-send-email-sridhar.samudrala@intel.com>
 <CAKgT0Uc8bRoAsXYSr7k27gf5+vh7rF2Dd_kWNB1d38tpZAeRGg@mail.gmail.com>
 <20180117203757-mutt-send-email-mst@kernel.org>
 <058068e5-febd-92c8-e5a9-faf262b82335@intel.com>
 <20180117213527-mutt-send-email-mst@kernel.org>
 <CAKgT0UeyNvVQc11KXc3updJfa9p7a9NcfRC=gP6=ktkjrSkOag@mail.gmail.com>
 <20180122231713-mutt-send-email-mst@kernel.org>
 <7edf772b-627c-6121-3332-479caed524da@intel.com>
 <20180123020332-mutt-send-email-mst@kernel.org>
 <be3864b4-f108-6a7d-8628-204d4d4ae278@intel.com>
 <20180123035619-mutt-send-email-mst@kernel.org>
 <CAKgT0UfaKG7=E5ciarE3fSUp-Ke-oDNodGe_baEAGbZqWV4Qug@mail.gmail.com>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <acd5ab8e-c6e6-8c36-a6aa-b90fa7694349@intel.com>
Date: Mon, 22 Jan 2018 21:54:18 -0800
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfaKG7=E5ciarE3fSUp-Ke-oDNodGe_baEAGbZqWV4Qug@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------AC208C7C5FAEA2BBAD34ECA6"
Content-Language: en-US
Subject: Re: [virtio-dev] [RFC PATCH net-next v2 1/2] virtio_net: Introduce
 VIRTIO_NET_F_BACKUP feature bit
To: Alexander Duyck <alexander.duyck@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, achiad shochat <achiad.mellanox@gmail.com>, Achiad Shochat <achiad@mellanox.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--------------AC208C7C5FAEA2BBAD34ECA6
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit



On 1/22/2018 7:36 PM, Alexander Duyck wrote:
> On Mon, Jan 22, 2018 at 6:04 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Mon, Jan 22, 2018 at 05:34:37PM -0800, Samudrala, Sridhar wrote:
>>> On 1/22/2018 4:05 PM, Michael S. Tsirkin wrote:
>>>> On Mon, Jan 22, 2018 at 03:27:40PM -0800, Samudrala, Sridhar wrote:
>>>>>>> You could probably
>>>>>>> even handle the Tx queue selection via a simple eBPF program and map
>>>>>>> since the input for whatever is used to select Tx should be pretty
>>>>>>> simple, destination MAC, source NUMA node, etc, and the data-set
>>>>>>> shouldn't be too large.
>>>>>> That sounds interesting. A separate device might make this kind of setup
>>>>>> a bit easier.  Sridhar, did you look into creating a separate device for
>>>>>> the virtual bond device at all?  It does not have to be in a separate
>>>>>> module, that kind of refactoring can come later, but once we commit to
>>>>>> using the same single device as virtio, we can't change that.
>>>>> No. I haven't looked into creating a separate device. If we are going to
>>>>> create a new
>>>>> device, i guess it has to be of a new device type with its own driver.
>>>> Well not necessarily - just a separate netdev ops.
>>>> Kind of like e.g. vlans share a driver with the main driver.
>>> Not sure what you meant by vlans sharing a driver with the main driver.
>>> IIUC, vlans are supported via 802.1q driver and  creates a netdev of type
>>> 'vlan'
>>> with vlan_netdev_ops
>> But nothing prevents a single module from registering
>> multiple ops.
> Just to clarify, it seems like what you are suggesting is just adding
> the "master" as a separate set of netdev ops or netdevice and to have
> virtio spawn two network devices, one slave and one master, if the
> BACKUP bit is set. Do I have that right?
>
> I am good with the code still living in the virtio driver and
> consolidation with other similar implementations and further
> improvement could probably happen later as part of some refactor.
>
Here are the netdev_ops that are currently supported by virtio_net

    static const struct net_device_ops virtnet_netdev = {
             .ndo_open            = virtnet_open,
             .ndo_stop            = virtnet_close,
             .ndo_start_xmit      = start_xmit,
             .ndo_validate_addr   = eth_validate_addr,
             .ndo_set_mac_address = virtnet_set_mac_address,
             .ndo_set_rx_mode     = virtnet_set_rx_mode,
             .ndo_get_stats64     = virtnet_stats,
             .ndo_vlan_rx_add_vid = virtnet_vlan_rx_add_vid,
             .ndo_vlan_rx_kill_vid = virtnet_vlan_rx_kill_vid,
    #ifdef CONFIG_NET_POLL_CONTROLLER
             .ndo_poll_controller = virtnet_netpoll,
    #endif
             .ndo_bpf                = virtnet_xdp,
             .ndo_xdp_xmit           = virtnet_xdp_xmit,
             .ndo_xdp_flush          = virtnet_xdp_flush,
             .ndo_features_check     = passthru_features_check,
    };

Now if we want to create 2 netdevs associated with a single 
virtio_device, do we want these ops
supported by master or slave netdev? I guess these should be supported 
by the slave netdev.
So do we want the netdev_ops of master simply call the slave netdev_ops 
for most the the cases
except for the ndo_start_xmit() which will decide between virtio or vf 
datapath?

what about ethtool_ops? we need to sync up link state between master and 
slave netdevs and
the userspace needs to be aware of 2 type of virtio_net devices.

Is this complexity really required to support a feature that can only be 
supported/useful for
simple guest network configurations that can be controlled by 
hypervisor.   virtio_net device
that could be accelerated via a passthru device and support live migration.

If a guest admin needs to configure any complex network configurations 
in the guest, i think those
scenarios can be supported via bond/bridge/team setups and live 
migration may not be a requirement
for such usecases.

Thanks
Sridhar



--------------AC208C7C5FAEA2BBAD34ECA6
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 1/22/2018 7:36 PM, Alexander Duyck
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAKgT0UfaKG7=E5ciarE3fSUp-Ke-oDNodGe_baEAGbZqWV4Qug@mail.gmail.com">
      <pre wrap="">On Mon, Jan 22, 2018 at 6:04 PM, Michael S. Tsirkin <a class="moz-txt-link-rfc2396E" href="mailto:mst@redhat.com">&lt;mst@redhat.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">On Mon, Jan 22, 2018 at 05:34:37PM -0800, Samudrala, Sridhar wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="">On 1/22/2018 4:05 PM, Michael S. Tsirkin wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="">On Mon, Jan 22, 2018 at 03:27:40PM -0800, Samudrala, Sridhar wrote:
</pre>
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <pre wrap="">You could probably
even handle the Tx queue selection via a simple eBPF program and map
since the input for whatever is used to select Tx should be pretty
simple, destination MAC, source NUMA node, etc, and the data-set
shouldn't be too large.
</pre>
                </blockquote>
                <pre wrap="">That sounds interesting. A separate device might make this kind of setup
a bit easier.  Sridhar, did you look into creating a separate device for
the virtual bond device at all?  It does not have to be in a separate
module, that kind of refactoring can come later, but once we commit to
using the same single device as virtio, we can't change that.
</pre>
              </blockquote>
              <pre wrap="">No. I haven't looked into creating a separate device. If we are going to
create a new
device, i guess it has to be of a new device type with its own driver.
</pre>
            </blockquote>
            <pre wrap="">Well not necessarily - just a separate netdev ops.
Kind of like e.g. vlans share a driver with the main driver.
</pre>
          </blockquote>
          <pre wrap="">
Not sure what you meant by vlans sharing a driver with the main driver.
IIUC, vlans are supported via 802.1q driver and  creates a netdev of type
'vlan'
with vlan_netdev_ops
</pre>
        </blockquote>
        <pre wrap="">
But nothing prevents a single module from registering
multiple ops.
</pre>
      </blockquote>
      <pre wrap="">
Just to clarify, it seems like what you are suggesting is just adding
the "master" as a separate set of netdev ops or netdevice and to have
virtio spawn two network devices, one slave and one master, if the
BACKUP bit is set. Do I have that right?

I am good with the code still living in the virtio driver and
consolidation with other similar implementations and further
improvement could probably happen later as part of some refactor.

</pre>
    </blockquote>
    <tt>Here are the netdev_ops that are currently supported by
      virtio_net</tt><br>
    <blockquote>static const struct net_device_ops virtnet_netdev = {<br>
              .ndo_open            = virtnet_open,<br>
              .ndo_stop            = virtnet_close,<br>
              .ndo_start_xmit      = start_xmit,<br>
              .ndo_validate_addr   = eth_validate_addr,<br>
              .ndo_set_mac_address = virtnet_set_mac_address,<br>
              .ndo_set_rx_mode     = virtnet_set_rx_mode,<br>
              .ndo_get_stats64     = virtnet_stats,<br>
              .ndo_vlan_rx_add_vid = virtnet_vlan_rx_add_vid,<br>
              .ndo_vlan_rx_kill_vid = virtnet_vlan_rx_kill_vid,<br>
      #ifdef CONFIG_NET_POLL_CONTROLLER<br>
              .ndo_poll_controller = virtnet_netpoll,<br>
      #endif<br>
              .ndo_bpf                = virtnet_xdp,<br>
              .ndo_xdp_xmit           = virtnet_xdp_xmit,<br>
              .ndo_xdp_flush          = virtnet_xdp_flush,<br>
              .ndo_features_check     = passthru_features_check,<br>
      };<br>
    </blockquote>
    Now if we want to create 2 netdevs associated with a single
    virtio_device, do we want these ops <br>
    supported by master or slave netdev? I guess these should be
    supported by the slave netdev.<br>
    So do we want the netdev_ops of master simply call the slave
    netdev_ops for most the the cases<br>
    except for the ndo_start_xmit() which will decide between virtio or
    vf datapath?<br>
     <br>
    what about ethtool_ops? we need to sync up link state between master
    and slave netdevs and<br>
    the userspace needs to be aware of 2 type of virtio_net devices.<br>
    <br>
    Is this complexity really required to support a feature that can
    only be supported/useful for <br>
    simple guest network configurations that can be controlled by
    hypervisor.   virtio_net device<br>
    that could be accelerated via a passthru device and support live
    migration.<br>
    <br>
    If a guest admin needs to configure any complex network
    configurations in the guest, i think those<br>
    scenarios can be supported via bond/bridge/team setups and live
    migration may not be a requirement<br>
    for such usecases.<br>
    <br>
    Thanks<br>
    Sridhar<br>
    <br>
    <br>
  </body>
</html>

--------------AC208C7C5FAEA2BBAD34ECA6--
